library(tidyverse)
library(ggplot2)
library(lubridate)
library(tidyr)
library(scales)

library(tidytext)

#
set.seed(1)
#
# In general, we can extract data directly from Twitter using the rtweet package.
# However, in this case, a group has already compiled data for us
# and made it available at http://www.trumptwitterarchive.com External link.
#
# library(dslabs)
# data("trump_tweets")
# This is data frame with information about the tweet:

head(trump_tweets)

trump_tweets
names(trump_tweets)
trump_tweets %>% select(text) %>% head
trump_tweets %>% count(source) %>% arrange(desc(n))
trump_tweets %>%
  extract(source, "source", "Twitter for (.*)") %>%
  count(source)
#
campaign_tweets <- trump_tweets %>%
  extract(source, "source", "Twitter for (.*)") %>%
  filter(source %in% c("Android", "iPhone") &
           created_at >= ymd("2015-06-17") &
           created_at < ymd("2016-11-08")) %>%
  filter(!is_retweet) %>%
  arrange(created_at)
#######################################################ggplot
ds_theme_set()
campaign_tweets %>%
  mutate(hour = hour(with_tz(created_at, "EST"))) %>%
  count(source, hour) %>%
  group_by(source) %>%
  mutate(percent = n / sum(n)) %>%
  ungroup %>%
  ggplot(aes(hour, percent, color = source)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(labels = percent_format()) +
  labs(x = "Hour of day (EST)",
       y = "% of tweets",
       color = "")
#
example <- data_frame(line = c(1, 2, 3, 4),
                      text = c("Roses are red,", "Violets are blue,", "Sugar is sweet,", "And so are you."))
example
example %>% unnest_tokens(word, text)
#
#
i <- 3008
campaign_tweets$text[i]
campaign_tweets[i,] %>%
  unnest_tokens(word, text) %>%
  select(word)
#
#
pattern <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"
#We can now use the unnest_tokens() function with the regex option
#and appropriately extract the hashtags and mentions:

  campaign_tweets[i,] %>%
  unnest_tokens(word, text, token = "regex", pattern = pattern) %>%
  select(word)
#Another minor adjustment we want to make is remove the links to pictures:

  campaign_tweets[i,] %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", ""))  %>%
  unnest_tokens(word, text, token = "regex", pattern = pattern) %>%
  select(word)

#Now we are ready to extract the words for all our tweets.
  tweet_words <- campaign_tweets %>%
    mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", ""))  %>%
    unnest_tokens(word, text, token = "regex", pattern = pattern)

#And we can now answer questions such as "what are the most commonly used words?"

  tweet_words %>%
    count(word) %>%
    arrange(desc(n))
  #
#It is not surprising that these are the top words. The top words are not informative.
  #The tidytext package has database of these commonly used words, referred to as stop words, in text mining:

   # stop_words
 # If we filter out rows representing stop words with filter(!word %in% stop_words$word):

    tweet_words <- campaign_tweets %>%
    mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", ""))  %>%
    unnest_tokens(word, text, token = "regex", pattern = pattern) %>%
    filter(!word %in% stop_words$word )
  #We end up with a much more informative set of top 10 tweeted words:

    tweet_words %>%
    count(word) %>%
    top_n(10, n) %>%
    mutate(word = reorder(word, n)) %>%
    arrange(desc(n))
    #
  #Some exploration of the resulting words (not show here) reveals a couple of unwanted
    #characteristics in our tokens. First, some of our tokens are just numbers
    #(years for example). We want to remove these and we can find them using the regex ^\d+$.
    #Second, some of our tokens come from a quote and they start with '.
    #We want to remove the ' when it's at the start of a word, so we will use str_replace().
    #We add these two lines to the code above to generate our final table:

tweet_words <- campaign_tweets %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", ""))  %>%
  unnest_tokens(word, text, token = "regex", pattern = pattern) %>%
  filter(!word %in% stop_words$word &
           !str_detect(word, "^\\d+$")) %>%
  mutate(word = str_replace(word, "^'", ""))

#Now that we have all our words in a table, along with information about what
# device was used to compose the tweet they came from, we can start exploring which
# words are more common when comparing Android to iPhone.

#For each word we want to know if it is more likely to come from an Android tweet
# or an iPhone tweet. We previously introduced the odds ratio, a summary statistic
# useful for quantifying these differences. For each device and a given word,
# let's call it y, we compute the odds or the ratio between the proportion of words that
# are y and not y and compute the ratio of those odds. Here we will have many proportions
# that are 0 so we use the 0.5 correction.
# #
android_iphone_or <- tweet_words %>%
  count(word, source) %>%
  spread(source, n, fill = 0) %>%
  mutate(or = (Android + 0.5) / (sum(Android) - Android + 0.5) /
           ( (iPhone + 0.5) / (sum(iPhone) - iPhone + 0.5)))
android_iphone_or %>% arrange(desc(or))
android_iphone_or %>% arrange(or)

android_iphone_or %>% filter(Android+iPhone > 100) %>%
  arrange(desc(or))
#
android_iphone_or %>% filter(Android+iPhone > 100) %>%
  arrange(or)
#


