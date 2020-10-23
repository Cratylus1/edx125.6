#web scraping
library(rvest)
library(tidyverse)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)
#
#get a list of all 'table' type nodes
nodes <- html_nodes(h, "table")
#
length(nodes)
#look at one to see what it contains
html_text(nodes[[8]])
#
#convert that table into a data.frame
df_test <- html_table(nodes[[8]])
str(df_test)
head(df_test)
#
?assign

for (i in 10:11) {
  #assign(paste0("DF", i), data.frame(A=rnorm(10), B=rnorm(10)))
  assign(paste0("DF", i),html_table(nodes[[i]]))
}
DF19
DF10
DF10x<- DF10[,-1]
DF10x
df19 <- DF19[-1,]
df19
df10 <- DF10x[-1,]
colnames(df10) <- c("Team", "Payroll", "Average")
df10
colnames(df19) <- c("Team", "Payroll", "Average")
df19
tot <- full_join(df10,df19, by= "Team")
tot
nrow(tot)
#
#
#

url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"


h <- read_html(url)
#
#get a list of all 'table' type nodes
nodes <- html_nodes(h, "table")
#
length(nodes)
for (i in 1:8) {
  assign(paste0("df", i),html_table(nodes[[i]],fill=TRUE))
  #
}
#
#
str(df5)

#
#STRING FUNCTION ............................................
#
url <- "https://en.wikipedia.org/w/index.php?title=Gun_violence_in_the_United_States_by_state&direction=prev&oldid=810166167"
murders_raw <- read_html(url) %>%
  html_nodes("table") %>%
  html_table() %>%
  .[[1]] %>%
  setNames(c("state", "population", "total", "murder_rate"))

# inspect data and column classes
head(murders_raw)
class(murders_raw$population)
class(murders_raw$total)
#
library("stringr")
#
murders_new <- murders_raw %>% mutate_at(2:3,parce_number)
murders_new(head)


cat(" LeBron James is 6’8\" ")
cat(' LeBron James is 6'8" ')
cat(` LeBron James is 6'8" `)
cat(" LeBron James is 6\’8" ")


dat <- as_tibble(c("$100,000", "$250,000", "$500,000"))
dat
dat %>% mutate_at(1:1, funs(str_replace_all(., c("\\$|,"), ""))) %>%  mutate_at(1:1, as.numeric)
#
#

library(dslabs)
data(reported_heights)
class(reported_heights$height)

# convert to numeric, inspect, count NAs
x <- as.numeric(reported_heights$height)
head(x)

sum(is.na(x))

reported_heights %>% mutate(new_height = as.numeric(height)) %>%
  filter(is.na(new_height)) %>%
  head(n=10)

# keep only entries that either result in NAs or are outside the plausible range of heights
not_inches <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}

# number of problematic entries
problems <- reported_heights %>%
  filter(not_inches(height)) %>%
  .$height
length(problems)

head(problems)

pattern <- "^\\d\\s*'\\s*\\d{1,2}\\.*\\d*'*\"*$"
str_subset(problems, pattern) %>% head(n=10) %>% cat

pattern <- "^\\d{1,3}\\s*\"$"
str_subset(problems, pattern) %>% head(n=10) %>% cat


# 10 examples of x'y or x'y" or x'y\"
pattern <- "^\\d\\s*'\\s*\\d{1,2}\\.*\\d*'*\"*$"
str_subset(problems, pattern) %>% head(n=10) %>% cat

# 10 examples of x.y or x,y
pattern <- "^[4-6]\\s*[\\.|,]\\s*([0-9]|10|11)$"
str_subset(problems, pattern) %>% head(n=10) %>% cat

# 10 examples of entries in cm rather than inches
ind <- which(between(suppressWarnings(as.numeric(problems))/2.54, 54, 81) )
ind <- ind[!is.na(ind)]
problems[ind] %>% head(n=10) %>% cat
#
# detect whether a comma is present
pattern <- ","
str_detect(murders_raw$total, pattern)

# show the subset of strings including "cm"
str_subset(reported_heights$height, "cm")

yes <- c("5", "6", "5'10", "5 feet", "4'11")
no <- c("", ".", "Five", "six")
s <- c(yes, no)
pattern <- "\\d"
str_detect(s, pattern)
#
#[56] means 5 or 6
str_view(s, "[56]")

problems


###
# function to detect entries with problems
not_inches_or_cm <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- !is.na(inches) &
    ((inches >= smallest & inches <= tallest) |
       (inches/2.54 >= smallest & inches/2.54 <= tallest))
  !ind
}
yes <- c("5 feet 7inches", “5 7")
no <- c("5ft 9 inches", "5 ft 9 inches")
s <- c(yes, no)

converted <- s %>%
  str_replace("feet|foot|ft", "'") %>%
  str_replace("inches|in|''|\"", "") %>%
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)






















