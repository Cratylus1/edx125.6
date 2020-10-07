library("tidyverse")

require("dslabs")
find.package("dslabs")
#
# set path to the location for raw data files in
#the dslabs package and list files
path <- system.file("extdata", package="dslabs")
list.files(path)
#
# generate a full path to a file
filename <- "murders.csv"
fullpath <- file.path(path, filename) #figures / or \ automatically
fullpath
#
# copy file from dslabs package to your working directory
file.copy(fullpath, getwd())
#
# check if the file exists
file.exists(filename)
#
#look at first few lines to see structure and existence of header
read_lines("murders.csv",n_max=5)
#
#read file -- screen shows the data type of each column as read
dat <- read_csv("murders.csv")
#
head(dat)
#
class(dat) #shows it is a tibble
#
dat2 <- read.csv(filename)
class(dat2)
dat3 <- read.csv(filename, stringsAsFactors=FALSE)
#
#
#times_2016 <- read_excel("times.xlsx", sheet = "2016") #or sheet =2
