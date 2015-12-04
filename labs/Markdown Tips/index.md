---
title    : Markdown Tips
author   : Samuel Müller and Garth Tarr
framework   : minimal
url      : {lib: "../../libraries", assets: "../../assets"}
mode     : selfcontained # {standalone, draft}
hitheme     : solarized_light
lecnum   : "05"
widgets  : [mathjax]
github      : {user: garthtarr, repo: msR, branch: gh-pages, name: Garth Tarr}
---



## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.  A useful guide to help you get started can be found [here](http://shiny.rstudio.com/articles/rmarkdown.html).

Rmarkdown is a great way to do reproducible research and generate reports.

### Super brief overview

1. Create a new Rmd file.  In RStudio `File -> New File -> R Markdown...`
2. When you have a Rmd file open in RStudio there's a `Knit HTML` button up the top of the source window.  You click that button to turn the markdown into HTML (or PDF or Word).
3. Text and R code can be combined in the Rmd file.  Code chunks begin with three back ticks followed by `r`, the (optional) chunk name and any arugments: ` ```{r}` or ` ```{r chunk_name, tidy=TRUE}`.  The chunk also ends with three back ticks ` ``` `.  Examples can be seen in the template that opens along as a new file in RStudio.

### Including Plots

You can embed static plots in an rmarkdown document without doing anything special.  Important chunk options are `fig.width` and `fig.height` to set the figure width and height for example ` ```{r, fig.width=4, fig.height=6}`.


### Including interactive visalisations

If you're sticking with HTML (as opposed to PDF or Word), you might like to take advantage of the interactive visualisations that leverage web technologies such as JavaScript.  In this workshop we highlight `pairsD3` and `d3heatmap`.  To include these in a rmarkdown document, the chunk need to have the option `results='asis'` and it's safest to also set `cache=FALSE` (sometimes this is required).  For example, the below chunk begins with ` ```{r, results='asis', cache=FALSE}`



```r
data("artificialeg", package = "mplot")
d3heatmap::d3heatmap(cor(artificialeg))
```

<iframe src="D3hmap.html" width="600px" height="500px" frameborder=0> </iframe>


```r
data("diabetes", package = "mplot")
pairsD3::pairsD3(diabetes[, c("y", "tch", "hdl", "ldl", "tc")], group = diabetes$sex, 
    width = 600)
```

<iframe src="pairsD3.html" width="600px" height="600px" frameborder=0> </iframe>

