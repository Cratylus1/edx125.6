#
install.packages("pdftools")

library(dslabs)
library("tidyverse")
library("pdftools")

#data we want to end up with!!!
data("research_funding_rates")
research_funding_rates
#

temp_file <- tempfile()
url <- "http://www.pnas.org/content/suppl/2015/09/16/1510159112.DCSupplemental/pnas.201510159SI.pdf"
download.file(url, temp_file)
txt <- pdf_text(temp_file)
file.remove(temp_file)

txt
length(txt)
#
#
raw_data_research_funding_rates <- txt[2]
raw_data_research_funding_rates

data("raw_data_research_funding_rates")
raw_data_research_funding_rates %>% head

tab <- str_split(raw_data_research_funding_rates, "\n")
tab[[1]]
tab %>% head


#############################
schedule


str_split(schedule$staff, ",|and")
str_split(schedule$staff, ", | and ")
str_split(schedule$staff, ",\\s|\\sand\\s")
str_split(schedule$staff, "\\s?(,|and)\\s?")




tidy <- separate(schedule, staff, into = c("s1","s2","s3"), sep = “,”) %>%
  gather(key = s, value = staff, s1:s3)

tidy
tidy <- schedule %>%
  mutate(staff = str_split(staff, ", | and ")) %>%
  unnest()

tidy <- separate(schedule, staff, into = c("s1","s2","s3"), sep = “,”) %>%
  gather(key = s, value = staff, s1:s3)

######################################pdf#####################
library(rvest)
library(tidyverse)
library(stringr)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
polls <- tab[[5]] %>% html_table(fill = TRUE)
tab %>% head
polls
str(polls)
#change column names
col_names <- c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes")
colnames(polls) <- col_names
str(polls)

test<- c("4.0%", "2%", "5", "zxy","58.2%")
str_detect(test,"%")


new_polls <- polls %>% filter(str_detect(remain, "%"))
str(new_polls)
'
#convert remain from a percentage 52%' to a decimal percent, .52
#
polls <- new_polls
str_remove(polls$remain, "%")/100
as.numeric(str_replace(polls$remain, "%", ""))/100

#find and replace N/A in the undecided column

test <- c("N/A", 3,2)
test1 <- str_replace(test,"N/A","0")
test1

polls$undecided <- str_replace(polls$undecided, "N/A","0")
polls
polls[125,4]
##dates
polls[1:5,1]

pattern<- "[0-9]+\\s[a-zA-Z]+"
pattern<- "\\d{1,2}\\s[a-zA-Z]+"
pattern <- "\\d+\\s[a-zA-Z]{3,5}"
temp <- str_extract_all(polls$dates,pattern, simplify=F)
temp
?str_extract_all
