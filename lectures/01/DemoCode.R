#### googleVis ####

install.packages("googleVis")
install.packages("WDI")
require(googleVis)
require(WDI)
demo(WorldBank, package = "googleVis")
# load("lectures/01/worldbankdata.RData")
# plot(M)

#### pairsD3 ####

# install.packages("pairsD3")
require(pairsD3)
pairsD3(swiss)

#### networkD3 ####

# install.packages("networkD3")
require(networkD3)
data(MisLinks)
data(MisNodes)
forceNetwork(Links = MisLinks, Nodes = MisNodes,
             Source = "source", Target = "target",
             Value = "value", NodeID = "name",
             Group = "group", opacity = 0.8,linkColour = gray(0.8))

#### edgebundleR ####

# install.packages("edgebundleR")
require(edgebundleR)
# symmetric matrix
require(MASS)
sig = kronecker(diag(4),matrix(2,5,5)) + 3*diag(20)
X = MASS::mvrnorm(n=100,mu=rep(0,20),Sigma = sig)
colnames(X) = paste(rep(c("A.A","B.B","C.C","D.D"),each=5),1:5,sep="")
edgebundle(cor(X),cutoff=0.2,tension=0.8,fontsize = 14)
# igraph object
require(igraph)
ws_graph <- watts.strogatz.game(1, 50, 4, 0.05)
edgebundle(ws_graph,tension = 0.1,fontsize = 18,padding=40)

### dygraphs ####

# install.packages(c("dygraphs","huge"))
require(dygraphs)
require(huge)
data(stockdata)
X = log(stockdata$data[2:1258,]/stockdata$data[1:1257,])
colnames(X) = stockdata$info[,3]
load(url("http://garthtarr.com/stockdatatimes.Rdata"))
require(xts)
xts.fn = function(x){
  xts(x,order.by=times[-1],frequency=365)
}
dygraph(xts.fn(X[,1:2])) %>% 
  dyRangeSelector()

### d3heatmaps ###

# optional: visualise the correlation matrix
# install.packages("d3heatmap")
# I've submitted a pull request to add minVal and maxVal options
devtools::install_github("garthtarr/d3heatmap")
require(d3heatmap)
cmat = cor(X[,1:100])
d3heatmap(cmat, minVal = -1, maxVal = 1)

### rcharts ###

# require(devtools)
# install_github('ramnathv/rCharts')
require(rCharts)
## Example 1 Facetted Scatterplot
names(iris) = gsub("\\.", "", names(iris))
rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')
## Example 2 Facetted Barplot
hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")
nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, 
            type = 'multiBarChart')

#### ggvis ####

# install.packages("ggvis")
require(ggvis)
faithful %>% ggvis(~eruptions) %>% layer_histograms() 
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()
# tooltips
mtcars %>% ggvis(x = ~wt, y = ~mpg) %>% 
  layer_points() %>% 
  add_tooltip(function(x) paste("wt:", x$wt," mpg:",x$mpg))
# interactivity
mtcars %>%
  ggvis(~wt, ~mpg) %>%
  layer_smooths(span = input_slider(0.3, 1, value = 0.5,label="Smoothing")) %>%
  layer_points(opacity := input_slider(0, 1, label="Opacity"))

#### shiny ####

require(pairsD3)
shinypairs(swiss)
require(edgebundleR)
shinyedge(ws_graph)
require(mplot)
load(url("http://www.maths.usyd.edu.au/u/gartht/dbeg.RData"))
# makes available objects full.mod, af1, v1 and bgn1
mplot(full.mod,af1,v1,bgn1)
# Alternatively there's a version hosted here:
# http://garthtarr.com/apps/mplot

