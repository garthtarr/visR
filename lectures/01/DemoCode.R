#### googleVis ####

require(googleVis)
require(WDI)
# inds <- c('SP.DYN.TFRT.IN','SP.DYN.LE00.IN', 'SP.POP.TOTL',
#           'NY.GDP.PCAP.CD', 'SE.ADT.1524.LT.FE.ZS')
# indnams <- c("fertility.rate", "life.expectancy", "population",
#              "GDP.per.capita.Current.USD", "15.to.25.yr.female.literacy")
# wdiData <- WDI(country="all", indicator=inds,
#                start=1960, end=format(Sys.Date(), "%Y"), extra=TRUE)
# colnum <- match(inds, names(wdiData))
# names(wdiData)[colnum] <- indnams
# WorldBank <- droplevels(subset(wdiData, !region %in% "Aggregates"))
# M <- gvisMotionChart(WorldBank,
#                      idvar="country", timevar="year",
#                      xvar="life.expectancy", yvar="fertility.rate",
#                      colorvar="region", sizevar="population",
#                      options=list(width=700, height=600),
#                      chartid="WorldBank")
# save(M,file="worldbankdata.RData")
load("lectures/01/worldbankdata.RData")
plot(M)



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
mtcars %>% ggvis(x = ~wt, y = ~mpg) %>% 
  layer_points() %>% 
  add_tooltip(function(x) paste("wt:", x$wt,"\nmpg:",x$mpg))
faithful %>% ggvis(~eruptions) %>% layer_histograms() 
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()
# interactivity
mtcars %>%
  ggvis(~wt, ~mpg) %>%
  layer_smooths(span = input_slider(0.5, 1, value = 1)) %>%
  layer_points(opacity := input_slider(0, 1))

#### shiny ####

shinypairs(swiss)
shinyedge(ws_graph)

mplot()