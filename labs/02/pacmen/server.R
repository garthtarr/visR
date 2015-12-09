# if (!require("pacman")) install.packages("pacman")
#pacman::p_load(shiny,igraph,WGCNA,networkD3)
library(shiny)
library(igraph)
library(WGCNA)
if (!require(impute)){
  source("http://bioconductor.org/biocLite.R") 
  biocLite("impute") 
}

if (!require(networkD3)) source("installRequiredPackages.R")
library(networkD3)

# load UPPI information
load("UPPI.RData")
load("rSums.RData")
source("functions.R")
# longmat = read.delim("UPPI_single.txt",header=FALSE)
# longmatsplit = split.data.frame(longmat[,2:5],longmat[,1])

cgc = scan(file="cancer_gene_census_20150721.txt",what="character")
ncg = as.matrix(read.delim("cancergenes.txt"),header=TRUE)
ncg = ncg[,2]
drug = scan(file="drug_target_convertedtoGeneSymbols.txt",what="character")
none = c()

shinyServer(function(input, output) {
  
  
  longmatsplit = reactive({
    
    longmat = read.delim(paste0(input$PPItype,"_single_incMutatedGene.txt"),header=FALSE)
    longmatsplit = split.data.frame(longmat[,2:5],longmat[,1])
    
    return(longmatsplit)
  })
  
  net = reactive({
    
    longmatsplit=longmatsplit()
    
    # get testableGenes based on both testableQuantile and interactomeConnectivity
    testableGenes = getTestableGenesIncHubsFromrSums(get(paste0(tolower(input$name),"_rSums")),
                                                     quantile=input$testableQuantile,
                                                     PPI=UPPIasIgraph,
                                                     PPIdegree=input$interactomeConnectivity)
    
    mat = as.matrix(longmatsplit[[toupper(input$name)]])
    
    mat = mat[mat[,1] %in% testableGenes,]
    
    mat = cbind(mat,unlist(tapply(mat[,3],mat[,1],p.adjust,method="BH")))
    
    mat = mat[as.numeric(mat[,5])<input$significanceThreshold,] # fdr corrected now
    
    # mat = mat[as.numeric(mat[,3])<input$significanceThreshold,] # unadjusted
    
    net <- graph.edgelist(mat[,1:2])
    
    print(net)
    
    V(net)$size <- 0.0001
    V(net)$label.cex <- ifelse(V(net)$name %in% get(input$database),1.8,1.5) # previously 1.1,0.9
    E(net)$color <- ifelse(mat[,4]==-1,"red","blue")
    V(net)$label.color <- ifelse(V(net)$name %in% get(input$database),"blue","black")
    
    return(net)
  })
  
  plotIgraphNetwork = function() {
    net = net()
    if (input$removePairs) {
      net = removePairsNotInDB(net,get(input$database))
    }
    plot(net,edge.curved=TRUE)
  }
  
  output$forcePlot <- renderForceNetwork({
    net = net()
    if (input$removePairs) {
      net = removePairsNotInDB(net,get(input$database))
    }
    forceNetworkFromIgraph(net,get(input$database))
  })
  
  output$netPlot <- renderPlot({
    plotIgraphNetwork()
  })
  
  output$networkInfo <- renderText({
    net = net()
    
    igraphMetrics = data.frame(
      assortativity_degree = assortativity_degree(net),
      authority_score = authority_score(net)$value,
      diameter = diameter(net),
      edge_density = edge_density(net),
      transitivity = transitivity(net)
    )
    
    adj = as.matrix(get.adjacency(as.undirected(net)))
    f = fundamentalNetworkConcepts(adj)
    f = unlist(lapply(f,mean)[-c(1,4)])
    rbind(c(names(f),names(igraphMetrics)),round(c(f,as.numeric(igraphMetrics)),4),"\n")
  })
  
  output$topologyPlot <- renderPlot({
    net = net()
    plot(sort(degree(net),decreasing = TRUE),type="h",
         main="Degree distribution",ylab="Degree")
  })
  
  output$topGenesTable <- renderText({
    net = net()
    rbind(c("Node",names(sort(degree(net),decreasing=TRUE)[1:5])),
          c("Degree",sort(degree(net),decreasing=TRUE)[1:5]),
          "\n")
  })
  
  output$downloadIgraph = downloadHandler(
    filename = "networkGraph.png",
    content = function(file) {
      png(filename=file,width=12,height=12,units="in",res=300)
      plotIgraphNetwork()
      dev.off()
    })
  
  output$downloadSubnetwork = downloadHandler(
    filename = function() paste0("subnetwork-", Sys.Date(), ".txt"),
    content = function(file) {
      net = net()
      if (input$removePairs) {
        net = removePairsNotInDB(net,get(input$database))
      }
      tab = cbind(get.edgelist(net),ifelse(E(net)$color=="red","down","up"))
      write.table(tab,file=paste0(input$name,"_",input$PPItype,"_net.txt"),sep="\t",quote=FALSE,
                  row.names=FALSE,col.names=c("node1","node2","direction"))
    },
    contentType="text/csv")
  
})