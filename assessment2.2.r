install.packages("Lahman")

library(Lahman)
top <- Batting %>%
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    # arrange by descending HR count
  slice(1:10)    # take entries 1-10
top %>% as_tibble()

Master %>% as_tibble()

top_names <- top %>% left_join(Master) %>%
  select(playerID, nameFirst, nameLast, HR)
top_names

top_salary <- Salaries %>% filter(yearID == 2016) %>%
  right_join(top_names)  %>%
  select(nameFirst, nameLast, teamID, HR, salary)
top_salary

AwardsPlayers %>% as_tibble

top_awards <- AwardsPlayers %>% filter(yearID == 2016)
%>%
  right_join(top_salary, by="nameLast")  %>%
  select(nameFirst, nameLast, teamID, HR, salary,awardID)
top_awards

intersect(top_names$playerID,top_awards$playerID)
length(setdiff(top_awards$playerID,top_names$playerID))
