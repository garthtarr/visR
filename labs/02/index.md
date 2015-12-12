---
title    : "Data visualisation, interactive data analysis, statistical programming"
author   : Garth Tarr
framework   : minimal
url      : {lib: "../../libraries", assets: "../../assets"}
mode     : selfcontained # {standalone, draft}
hitheme     : solarized_light
lecnum   : "01"
widgets  : [mathjax]
github      : {user: garthtarr, repo: visR, branch: gh-pages, name: Garth Tarr}
---



## Case study: Characterizing mutation-expression networks in multiple cancers

- <a href="https://twitter.com/shazanfar">Shila Ghazanfar's</a>  [BIS2015 poster](http://f1000research.com/posters/4-1046) has an accompanying Shiny app.
- 4,443 tumours analysed over 19 cancers from TCGA
- R Shiny app to explore results among different parameters is available to download at [www.maths.usyd.edu.au/u/sheilag/pacmen.zip](http://www.maths.usyd.edu.au/u/sheilag/pacmen.zip)

### Instructions

- Check out Shila's fast forward poster session slide <a href="https://github.com/garthtarr/visR/blob/gh-pages/labs/02/BIS2015FF_Ghazanfar.pdf"><i class="fa fa-link"></i></a>
- Download and unzip from [www.maths.usyd.edu.au/u/sheilag/pacmen.zip](http://www.maths.usyd.edu.au/u/sheilag/pacmen.zip)
- Install a few R packages including customised version of `networkD3` using:


```r
install.packages(c("shiny", "igraph", "WGCNA", "devtools"))
source("http://bioconductor.org/biocLite.R")
biocLite(c("impute", "GO.db", "preprocessCore"))
devtools::install_github("garthtarr/networkD3", ref = "color")
```

- Run the app using a command like (replace `~/Downloads/` with the path to the `pacmen` unzipped folder):


```r
shiny::runApp("~/Downloads/pacmen")
```

- Alternatively you can run the app by opening either the `server.R` or the `ui.R` files in RStudio and then clicking the `Run App` button in the top right of the code editor window.
- Explore the app to get a feel for the sorts of things you can do with Shiny.
- Check out Shila's twitter account <a href="https://twitter.com/shazanfar"><i class="fa fa-twitter"></i></a>

### Common issues

- It may take a little while for the app to load, be patient!  Serious computations are in progress.
- If the linkages are missing in the interactive graph, but you can see them in the static graph, you need to install a customised version of `networkD3`:


```r
devtools::install_github("garthtarr/networkD3", ref = "color")
```



### References

- Ghazanfar S and Yang JYH (2015). Characterizing mutation-expression network relationships in multiple cancers. F1000Research 2015, 4:1046 (poster) (doi: [10.7490/f1000research.1110789.1](http://dx.doi.org/10.7490/f1000research.1110789.1))
- Ghazanfar S and Yang JYH (2016). Characterizing mutation-expression network relationships in multiple cancers. _Computational Biology and Chemistry Special Issue for [APBC2016](http://www.sfasa.org/apbc2016/apbc2016.html)_ (in press).

