#if (!require("pacman")) install.packages("pacman")
#pacman::p_load(shiny,igraph,WGCNA,networkD3)

 library(shiny)
 if (!require(networkD3)) source("installRequiredPackages.R")
 library(networkD3)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("PACMEN: PAn Cancer Mutation Expression Networks"),
  
  # Sidebar with a slider input
  sidebarLayout(
    sidebarPanel(
      
      selectInput("PPItype", "Select PPI:", 
                  choices = c("UPPI"="UPPI",
                           #"UPPI2"="UPPI2",
                              "HIPPIE"="HIPPIE")),
      
      selectInput("name", "Select cancer dataset:", 
                  choices = c("BLCA"="blca",
                              "BRCA"="brca",
                              "COAD"="coad",
                              "GBM"="gbm",
                              "HNSC"="hnsc",
                              "KICH"="kich",
                              "KIRC"="kirc",
                              "KIRP"="kirp",
                              "LAML"="laml",
                              "LGG"="lgg",
                              "LIHC"="lihc",
                              "LUAD"="luad",
                              "LUSC"="lusc",
                              "OV"="ov",
                              "PRAD"="prad",
                              "READ"="read",
                              "SKCM"="skcm",
                              "STAD"="stad",
                              "UCEC"="ucec")),
      
      sliderInput("testableQuantile",
                  "Quantile threshold for mutated genes:",
                  min = 0,
                  max = 1,
                  value = 0.9),
      
      sliderInput("interactomeConnectivity",
                  "Degree threshold for including highly connected proteins in UPPI:",
                  min = 5,
                  max = 1000,
                  value = 250),
      
      sliderInput("significanceThreshold",
                  "Significance threshold (FDR-controlled) for drawing edges:",
                  min = 0,
                  max = 1,
                  value = 0.1),
      
      selectInput("database", "Select database to highlight nodes:", 
                  choices = c("none"="none",
                              "CGC"="cgc",
                              "DrugBank"="drug",
                              "NCG 4.0"="ncg"
                  )),
      
      checkboxInput("removePairs", 
                    label = "Remove pairs not in database from display", 
                    value = FALSE),
      
      downloadButton('downloadIgraph',label="Download static graph"),
      
      downloadButton('downloadSubnetwork',label="Download subnetwork table")
      
      # checkboxInput("static", label = "Draw a static graph", value = TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      tabsetPanel(
        
        tabPanel(
          "D3 Network Graph",
          forceNetworkOutput("forcePlot",width="800",height="800")
        ),
        
        tabPanel(
          "Static Network Graph",
          plotOutput("netPlot",width="800",height="800")
        ),        
        
        tabPanel(
          "Network topology",
          verbatimTextOutput("networkInfo"),
          plotOutput("topologyPlot",width="100%"),
          verbatimTextOutput("topGenesTable")
        )
      )
    )
  )
))