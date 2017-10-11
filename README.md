# fluxing
Some scripting to make it easier to read data into rSalvador and analyze fluctuation test data

# prerequisites
make sure you have the following R packages installed:

rSalvador
tidyverse
cowplot
optparse

#Usage

Rscript fluxxer.R -i inputfile.csv -o out_prefix

Additional options can be passed to change the calculation based on volume of cells plated, dilution factor, and original volume of culture

Script will generate a chart and data frame containing output from Rsalvador 
