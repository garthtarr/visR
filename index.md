---
title       : Data visualisation, interactive data analysis, statistical programming
author      : Garth Tarr
framework   : minimal
hitheme     : solarized_light
mode        : selfcontained
github      : {user: garthtarr, repo: visR, branch: gh-pages, name: Garth Tarr}
widgets     : [mathjax]
---




### Introduction

In recent years, the power of R has been unleashed through the Shiny package which enables users to interact with complex analyses without needing to know any R programming.  A Shiny application is a web interface to an underlying R instance.  It is remarkably easy to develop both simple and complex Shiny apps using R and importantly, it requires no special knowledge of HTML, CSS or JavaScript.  This workshop outlines the basics of developing a Shiny app and showcases some more advanced examples.  One of the advantages of moving to a web-based approach is that it enables richer interactivity in data visualisation.  There is a large, and ever increasing, pool of **R** packages that allow researchers to go beyond static plots.  

As part of this workshop we will introduce the htmlwidgets framework that joins the raw statistical power of R with beautiful visualisations powered by JavaScript.  The `networkD3` and `edgebundleR` packages will be highlighted as examples that enable interactive visualisations of networks.  It can be a full time job keeping up with all the new features R has to offer statisticians and bioinformaticians – the aim of this workshop is to familiarise you with some of the latest and greatest tools available for data visualisation and interactive data analysis.

### Relevance

This workshop is relevant to all practising bioinformaticians who use R as part of their research and development pipeline. It will be particularly useful for people who are interested in better communicating their research through interactive graphics or enabling their analyses to be replicated within a user-friendly web interface.

#### Assumed knowledge

A working understanding of R will be assumed.

### Preparation

#### Computing requirements

- Latest version of [R](http://cran.r-project.org/) (v3.2.2 or later)
- Latest version of [Rstudio](http://www.rstudio.com/products/rstudio/download/) 
- Install the following packages (or ensure you have the latest versions):

```r
install.packages("networkD3")
install.packages("mplot")
install.packages("pairsD3")
install.packages("d3heatmap")
install.packages("edgebundleR")
install.packages("readr")
```

### Resources

1. [Lecture](lectures/01/index.html)
2. [Lab](labs/01/index.html)
3. [Markdown tips](labs/Markdown%20Tips/index.html)
4. [Suggested lab solutions](labs/01/solutions.html)

#### Recommended further reading

- Tarr G, Müller S, and Welsh AH (2015). mplot: An R package for graphical model stability and variable selection. <a href="http://arxiv.org/abs/1509.07583">arXiv:1509.07583 [stat.ME]</a>

### Feedback

At the end of the course, please provide your feedback <a href="https://docs.google.com/forms/UPDATE">here</a>.
