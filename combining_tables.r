library("tidyverse")
library("dslabs")

#create table 1
tab1 <- slice(murders,(1:6)) %>% select(state,population)

#create table 2
tab2 <- results_us_election_2016[order(results_us_election_2016$state),] %>%  slice( c(1:3,5,7:8)) %>% select(state,electoral_votes)
#
tab1
tab2
#
#LEFT JOIN -- ADD ELECTORAL VOTES TO TAB1
left_join(tab1,tab2)
left_join(tab2,tab1)
#
right_join(tab1,tab2)
right_join(tab2,tab1)
#
inner_join(tab1,tab2)
full_join(tab1,tab2)
#
semi_join(tab1,tab2)
anti_join(tab1,tab2)
#
############ binding
bind_cols(tab1,tab2)
bind_rows(tab1,tab2)
# for base R use cbind and rbind
#
#SET OPERATORS
