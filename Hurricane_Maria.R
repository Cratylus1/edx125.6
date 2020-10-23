

library(tidyverse)
library(pdftools)
options(digits = 3)
#
fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
system('open "C:/Users/Support/Documents/R/win-library/4.0/dslabs/extdata/RD-Mortality-Report_2015-18-180531.pdf"')
#
txt <- pdf_text("C:/Users/Support/Documents/R/win-library/4.0/dslabs/extdata/RD-Mortality-Report_2015-18-180531.pdf")
str(txt)
txt[9]
?str_split
x <- str_split(txt[9],"\\n",simplify = FALSE)
class(x)
#as a list
x
nrow(x)
str(x)
#
x[[1]]
s <- x[[1]]
str(s)
class(s)
nrow(s)
length(s)
#trim white spaces
s[2]
?str_trim
z<- str_trim(s[], side="both")
q<- str_squish(z)
q
z
z[1]
#find the row with the 'headers' you need
header_index<- str_which(q,"2015")
header_index[1]
#extract numbers in the strings
#1-get the first row, numnber= header_index{1]
header<- q[header_index[1]]
header
?str_split
extract1<- str_split(header,pattern=" ",simplify=TRUE)
extract1
#
month<- extract1[1,1]
month
header <- extract1[1,2:5]
header
#
tail_index <-35
q[tail_index]
#couint the number of numbers in each row of q
b<- str_count(q,pattern="\\d+")
b
table(b)
#now remove all rows before and including header_index
d<- q
header_index
class(q)
str(q)
library("dplyr")
d<- q[-c(1:header_index[1])]
d<- d[-c(33)]
d
?sliceq
b<- str_count(d,pattern="\\d+")
b
table(b)
b
d <- d[-c(31)]
length(d)
d
########################
#remove everything that is not a number or space
e<- str_remove_all(d,"[^\\d\\s]")
e
########################
#convert into a data matrix with just the day and death count data
s1 <- str_split_fixed(e, "\\s+", n = 6)[,1:5]
str(s1)
#########################
s1 <- s1 %>% as.numeric()
s1 <- s1 %>% matrix(nrow=30,ncol=5)
s1
name1 <- c("day", header)
name1
?colnames()
colnames(s1) <-name1
s1
mean4<- mean(s1[20:30,4])
mean1
mean2
mean3
mean4
#convert to tidy format
s2 <- data.frame(s1)
s2
tab<- s2 %>% gather(year, deaths, -day) %>%  mutate(deaths = as.numeric(deaths),year = as.character(year))
tab
#
#
p <- tab %>% filter(year != "X2018") %>% ggplot(aes(x=day,y=deaths, group=year)) +
  geom_line(aes(linetype=year)) + geom_point() + geom_vline(xintercept=20, color="blue")
p
