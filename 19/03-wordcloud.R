#### Построение облака слов по данным Twitter.

library(twitteR)
library(tm)
library(wordcloud)

api_key <- "ваш_api_key"
api_secret <- "ваш_api_secret"
access_token <- "ваш_access_token"
access_token_secret <- "ваш_access_token_secret"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

# Получим твиты, содержащие "data mining" и выделим из них текст.
tweets <- searchTwitter("data mining", n=500, lang="en")
text <- sapply(tweets, function(x) x$getText())

# Построим лексический корпус и терм-документную матрицу
corpus <- Corpus(VectorSource(text))
tdm <- TermDocumentMatrix(corpus, 
                          control = list(removePunctuation = TRUE, 
                                         stopwords = c("data", "mining", stopwords("english")), 
                                         removeNumbers = TRUE, 
                                         tolower=TRUE)
                          )

# Отсортируем частоты в порядке убывания и сохраним в таблице 
m <- as.matrix(tdm)
word_freqs <- sort(rowSums(m), decreasing=TRUE)
dm <- data.frame(word=names(word_freqs), freq=word_freqs)

# Построим облако слов
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
