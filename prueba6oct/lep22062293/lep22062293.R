install.packages(c("tidyverse", "dplyr", "janitor","xlsx"))
library("janitor","readr","dplyr")
library("tidyverse")
library("xlsx")

data <- read.delim("archivo.tsv", sep = "\t")