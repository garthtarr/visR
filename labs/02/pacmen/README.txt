###########################################################################

Inside this folder is a set of files that will facilitate running an R 
Shiny application. This can be run on a laptop.

Last updated: 15 October 2015
By: Shila Ghazanfar
Email: s.ghazanfar@maths.usyd.edu.au

###########################################################################
How to run:
Open either server.R or ui.R in RStudio. Ensure that the R package shiny 
is installed (if not use `install.packages("shiny")').  Ensuring that 
the working directory is the same as where the aforementioned files are 
located, click on the Run App button; or enter the following commands:

library(shiny)
runApp()

A new window will open that can be used to explore the visualization tool.

###########################################################################
Required:
Local installation of R and RStudio
Installation of various R packages, including devtools

###########################################################################
Files in folder:

cancer_gene_census_20150721.txt - list of genes in Cancer Gene Census 
downloaded on 21 July 2015.

cancergenes.txt - list of genese in Network of Cancer Genes 4.0 
downloaded on 8 July 2015.

drug_target_convertedtoGeneSymbols.txt - list of proteins (converted to 
correspond Gene Symbols) downloaded on 21 July 2015.

functions.R - set of R functions to facilitate Shiny app running.

installRequiredPackages.R - set of R commands to download and install a 
customised version of NetworkD3 from Github (enables different colored 
edges in NetworkD3 object).

README.txt - this file.

rSums.RData - an RData object containing numbers of patients with 
non-silent mutations per cancer.

server.R - an R Shiny file required to run the application.

ui.R - an R Shiny file required to run the application.

UPPI.RData - an RData object containing the union protein-protein 
interaction network, as an igraph object and as an adjacency
matrix.

UPPI_single_incMutatedGene.txt - a text file containing results from the cancer 
analysis conducted, using UPPI, used as input for the Shiny application.

HIPPIE_single_incMutatedGene.txt - a text file containing results from the cancer 
analysis conducted, using HIPPIE, used as input for the Shiny application.

###########################################################################