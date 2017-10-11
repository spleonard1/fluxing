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

Script will generate a chart and data frame containing output from Rsalvador. Data file should be a standard .csv containing one row of data for each strain tested. First cell is the strain name, followed by selective counts. Insert a cell containing "Non_Selective", then continue with non-selective counts.  See example file. 
