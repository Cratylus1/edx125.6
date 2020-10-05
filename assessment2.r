library("tidyverse")
install.packages("readr")
library("readr")

url <- "https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/datasets/wdbc/wdbc.data"

tempfile()
tmp_filename <- tempfile()
download.file(url, tmp_filename)

#read_lines("murders.csv",n_max=5)
read_lines(tmp_filename, n_max=5)

dta <- read_csv(tmp_filename, col_names=FALSE)
head(dta)
nrow(dta)
