#load necessary libraries
library(rsalvador)
library(tidyverse)
library(cowplot)

#setwd("~/Dropbox/code/fluc_test_script/")

#confidence interval function
confind <- function(x, y){
  S <- as.vector(x)
  NS <- as.vector(y)
  return(confint.LD(S, alpha=0.05)/NS[1])
}

#golden.benchmark.LD function for calculating mutation rate
golden <- function(x, y){
  #S <- as.vector(x)
  #NS <- as.vector(y)
  return(golden.benchmark.LD(x, y, tol = 1e-09, max.iter = 100, show.iter = FALSE))
}


calculateMutRate <- function(filename, dilution_factor, out_pfx ){


  #read in file specified. Must be in same directory
  data <- read_csv("test_input.csv") 

  #extract sample names
  strains <- colnames(data)
  
  #identify # of strains, use to build empty data frame
  num_strains <- length(strains)
  data_output <- tibble(strain = rep("", num_strains), MLE = rep(0, num_strains), confint.lower = rep(0, num_strains), confint.higher = rep(0, num_strains))

#cycle through each column to calculate mutatation rate and confidence  
for(i in 1:length(strains)){
  #locate Non_selective separator
  sep <- which(data[,i] == "Non_Selective")
  
  #extract selective values
  selective <- as.numeric(data[1:sep-1, i][[1]])
  
  #extract non selective values
  raw_non_selective <- as.numeric(data[-(1:sep), i][[1]])
  
  #calculate non selective based on dilution factor (placeholder till correct calculation implemented)
  non_selective <- raw_non_selective * dilution_factor
  #calculate average of non_selective values NOT IMPLEMENTED
  
  #match length of nonselective to selective values
  print(selective)
  print(non_selective)
  print(strains[i])
  values <- c(strains[i], golden(selective, non_selective), confind(selective, non_selective))
  data_output[i,] <- values
}
##write data frame to output csv
data_output$MLE <- as.numeric(data_output$MLE)
data_output$confint.lower <- as.numeric(data_output$confint.lower)
data_output$confint.higher <- as.numeric(data_output$confint.higher)

print(data_output)
write_csv(data_output, paste0(out_pfx,"_output.csv"))
##make chart for pretty values
plot <- ggplot(data_output, aes(x = strain, y = MLE)) +
  geom_point() +
  geom_linerange(aes(ymin = confint.lower, ymax = confint.higher)) +
  scale_y_log10() + 
  ggtitle("Mutation Rates") + 
  xlab("Strains") +
  ylab("Mutation rate MLE") 

save_plot(paste0(out_pfx, "_chart.pdf"), plot)

}

##parse command line arguments
Args <- commandArgs(TRUE)

##pass arguments to function
calculateMutRate(Args[1], as.numeric(Args[2]), Args[3])
