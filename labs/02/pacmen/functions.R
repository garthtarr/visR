forceNetworkFromIgraph = function(graph,dat=c()){
  
  require(igraph)
  require(networkD3)
  
  graphEdges = get.edgelist(graph)
  
  map = 0:(length(unique(c(graphEdges)))-1)
  names(map) = unique(c(graphEdges))
  
  Links = data.frame(cbind(map[graphEdges[,1]],map[graphEdges[,2]]),1)
  colnames(Links) <- c("source","target","value")
  
  Nodes = data.frame(name=unique(c(graphEdges)),group = ifelse(!unique(c(graphEdges))%in%dat,"notInDatabase","inDatabase"))
  
  cols = ifelse(E(graph)$color=="blue","#0000FF","#FF0000")
  
  forceNetwork(Links = Links, Nodes = Nodes,
               Source = "source", Target = "target",
               Value = "value", NodeID = "name",
               Group = "group", opacity = 0.8,
			   colourScale="d3.scale.category10()",
			   linkColour=cols, zoom = TRUE, legend=TRUE, bounded=FALSE)
  }

getTestableGenesIncHubsFromrSums = function(rSums,quantile=0.9,PPI,PPIdegree=250) {
  testableThresh <- quantile(rSums,quantile)
  testableGenes <- names(rSums)[rSums>testableThresh]
  xtragenes = names(which(degree(PPI)>=PPIdegree))
  xtragenes = intersect(xtragenes,names(rSums))
  testableGenes = sort(union(testableGenes,xtragenes))
  return(testableGenes)
}

removePairsNotInDB = function(net,dat) {
  
  edges = get.edgelist(net)
  Dnet = degree(net,loops=FALSE)
  LonePairEdges = apply(edges,1,function(x)all(Dnet[x]<=1 & !x%in% dat))
  nodesToKeep = unique(c(edges[-which(LonePairEdges),]))
  # degreeNot1orInDat = union(names(which(degree(net)>1)),dat)
  # edgesToKeep = apply(edges,1,function(x)all(x %in% deg1andNotinDat))
  # nodesToKeep = unique(c(edges[-edgesToRemove,]))
  newNet = induced.subgraph(net,nodesToKeep)
  return(newNet)
  
}