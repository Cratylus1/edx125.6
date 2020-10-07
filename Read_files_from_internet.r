#reading files from the net
#
#read data directly from internet files
url <- "https://raw.githubusercontent.com/rafalab/dslabs/master/inst/extdata/murders.csv"
dat <- read_csv(url)
#
#download a local copy for use
download.file(url, "murders.csv")
#
#downloads into a temp file, reads it temp file, then delete the tempfile!
tempfile()
tmp_filename <- tempfile()
download.file(url, tmp_filename)
dat <- read_csv(tmp_filename)
file.remove(tmp_filename)
#
#IMPOrting Data
