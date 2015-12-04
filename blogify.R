## This script updates all the html files with any changes that have
## been made.  Use this instead of the knit HTML button.

## blogify
# require(devtools)
# install_github('ramnathv/slidify') # , ref = 'dev')
# devtools::install_github('muschellij2/slidify') # stingr fix
# fixes the errror Error in if (body$content == "") { :
# install_github('ramnathv/poirot')
# install_github('ramnathv/slidifyLibraries')
# install_github("cboettig/knitcitations")
library(knitr)
library(knitcitations)
site = yaml::yaml.load_file("site.yml")
cwd = getwd()
rmdFiles = dir(".", recursive = TRUE, pattern = "*.Rmd")
pages = poirot:::parse_pages(rmdFiles)
tags = poirot:::get_tags(pages)
slidify:::render_pages(pages, site, tags)
setwd(cwd)
