library("tidyverse")
# import data
path <- system.file("extdata", package = "dslabs")
filename <- file.path(path, "life-expectancy-and-fertility-two-countries-example.csv")
raw_dat <- read_csv(filename)
select(raw_dat, 1:5)
#gather all columns except country
#use 'key' since column contains more than one variable
dat <- raw_dat %>% gather(key, fertility,-country)
#
head(dat)
#not tidy since two rows are associated with each obs
#
dat$key[1:5]
#

#separate( 1-name of the column to be separated
#          2-name to be used for the new columns
#          3-character that separates the variables
#
dat %>% separate(key,c("year","variable_name"),"_")
#
#1960_life_expectancy  has TWO underscores
# split on all underscores, pad empty cells with NA
dat %>% separate(key, c("year", "first_variable_name", "second_variable_name"),
                 fill = "right")
#
#probably best to use MERGE
#
# split on first underscore but keep life_expectancy merged
dat %>% separate(key, c("year", "variable_name"), sep = "_", extra = "merge")
#
#now SPREAD the data
#
dat %>% separate(key, c("year", "variable_name"), sep = "_", extra = "merge") %>% spread(variable_name,fertility)
#
#
ASSESSMENT
# check if the file exists
filename <- "race_times.txt"
file.exists(filename)
#read csv data
path <- getwd()
fullpath <- file.path(path, filename) #figures / or \ automatically
fullpath
dat <- read_csv(fullpath)
#
head(dat)
dat %>% gather(year,time,"2015":"2017")
#
#spread it back
#
dat %>% gather(year,time,"2015":"2017") %>% spread(year,time)
#
#
filename <- "race_times2.txt"
file.exists(filename)
#read csv data
path <- getwd()
fullpath <- file.path(path, filename) #figures / or \ automatically
fullpath
dat <- read_csv(fullpath)
head(dat)
#
dat %>% gather(key ='key', value = 'value', -age_group) %>%
  separate(col = key, into = c('year','variable_name'), sep = '_') %>%
  spread(key = variable_name, value = value)
#
#
filename <- "basketball.txt"
file.exists(filename)
#read csv data
path <- getwd()
fullpath <- file.path(path, filename) #figures / or \ automatically
fullpath
dat <- read_csv(fullpath)
head(dat)
#
 dat %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_", extra = "merge") %>%
  spread(key = variable_name, value = value)
#
 dat %>%
   separate(col = key, into = c("player", "variable_name"), sep = "_") %>%
   spread(key = variable_name, value = value)

#
#
head(co2)
co2
#put into data frame (wide format)
co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>%
  setNames(1:12) %>%
  mutate(year = as.character(1959:1997))
#
#
co2_tidy <- co2_wide %>% gather(month,co2,-year)
co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()

#
#
library(dslabs)
data(admissions)
dat <- admissions %>% select(-applicants)
#
head(dat)
dat_tidy <- dat %>% spread(gender, admitted)

tmp <- gather(admissions, key, value, admitted:applicants)
tmp
tmp2 <- unite(tmp, column_name, c(key,gender))
head(tmp2)
tmp2
