
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Case study: gene expression in starvation"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        condition = "input.tabs == 'genetab'",
        selectizeInput(inputId = "gene",
                       label = "Select gene(s)",
                       choices = sort(unique(cleaned_data$name)),
                       selected = "LEU1",
                       multiple = TRUE)
      ),
      conditionalPanel(
        condition = "input.tabs == 'processtab'",
        selectizeInput(inputId = "process",
                       label = "Biological process",
                       choices = sort(unique(cleaned_data$BP)),
                       selected = "leucine biosynthesis")                                
      ),
      checkboxInput(inputId = "line",
                    label = "Add line of best fit?",
                    value = FALSE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(id = "tabs",
                  tabPanel("Gene", value = "genetab",
                           plotOutput("plot1")
                  ),
                  tabPanel("Process", value = "processtab",
                           plotOutput("plot2")
                  )
      )
    )
  )
))
