library("lubridate")
library("tidyverse")
library("dslabs")
#
#
data(brexit_polls)
str(brexit_polls)
April_count <- brexit_polls %>% filter(month(brexit_polls$startdate) == 4)
nrow(April_count)
#
#
?round_date()
end_date <- data.frame( brexit_polls[,2])
end_date
names(end_date)[1] <- "end"

ans<- end_date %>% mutate(end,rounded = round_date(end,unit="week")) %>% filter(rounded=="2016-06-12")
ans
#
#
weekday<- end_date %>% mutate(end,day = wday(end,label=T))
 weekday

 table(weekday$day)
 nrow(brexit_polls)
 #
 #
 data(movielens)
str(movielens)
movie_data <- data.frame(as.POSIXct(movielens$timestamp,origin = "1970-01-01",tz = "GMT"))
head(movie_data)
names(movie_data)[1] <- "total"
table(movie_data$date)
head(movie_data)
class(movie_data)

# movie_data <- movie_data %>% mutate(date=format(movie_data$total, format="%Y"))
# head(movie_data)
#
# tt<- table(movie_data$date) %>% as.data.frame(.) %>% arrange(desc(Freq))
# head(tt)
# %>% arrange(desc(Freq))
# ?arrange()

movie_data <- movie_data %>% mutate(date=format(movie_data$total, format="%H"))
head(movie_data)

tt<- table(movie_data$date) %>% as.data.frame(.) %>% arrange(desc(Freq))
head(tt)
%>% arrange(desc(Freq))
