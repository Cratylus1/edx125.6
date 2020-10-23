#install.packages("gutenbengr")

#
library("tidyverse")
library("gutenbergr")
library("tidytext")
options(digits=3)
#
ids<- filter(gutenberg_metadata, str_detect(gutenberg_metadata$title,"Pride and Prejudice"))
ids$gutenberg_id
nrow(ids)
#
?gutenberg_works()
gutenberg_works(title=="Pride and Prejudice")
#
?gutenberg_download()
text1 <- gutenberg_download(1342)

#convert each word to a token and store in tibble
words <- unnest_tokens(text1,word,text)
str(words)
nrow(words)
#
#remove the stop words listed in stop_words
#
str(stop_words)
words1 <- words %>% anti_join(stop_words, by = ("word" = "word"))
nrow(words1)
str(words1)
words2 <- as.tibble(words1)
str(words2)
words2 %>% rename(.cols="word")
#
str(words2)
pattern <- "\\d+"
str_detect(words2$word,pattern)
words3<- filter(words2,"pride")
words4 <- words2 %>% filter(str_detect(words2$word,pattern)==FALSE)
str(words4)

nrow(words4)

#
test1 <- words4 %>% count(words4$word,sort=TRUE)
test2 <- test1 %>% filter(n>100)
test2

afinn <- get_sentiments("afinn")
str(afinn)
#
keep only P&P words that are in afinn
test5 <- inner_join(afinn,words4,by = ("word"))
afinn_sentiments <- data.frame(test5)
str(afinn_sentiments)
test6 <- filter(afinn_sentiments,afinn_sentiments$value==4)
nrow(test6)
3414/6065
