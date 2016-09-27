#### Фильтрация результатов поиска. 
#### Выделение твитов, содержащих географические координаты пользователя.

library(twitteR)

api_key <- "ваш_api_key"
api_secret <- "ваш_api_secret"
access_token <- "ваш_access_token"
access_token_secret <- "ваш_access_token_secret"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

# Составим строку поиска из запросов, разделённых знаками "+"
search_string <- paste0(c("новый год","#новыйгод"),collapse = "+")

# Для поиска на русском языке желательно указывать язык в параметре lang
tweets <- searchTwitter(search_string, n=10, lang="ru")

# Получим текст из найденных твитов
text <- sapply(tweets, function(x) x$getText())

# Отфильтруем из полученных твитов те, что содержат непустые значения долготы или широты
nonzero_geocode <- sapply(tweets, 
                          function(x) as.logical(length(x$getLatitude())) )

# Сохраним тексты твитов, имена и расположение авторов, 
# а также время создания твита в таблице `df`
data <- sapply( tweets[nonzero_geocode], 
                function(x) list(ScreenName=x$getScreenName(),
                                 Text=x$getText(),
                                 Lat=x$getLatitude(),
                                 Lon=x$getLongitude(),
                                 Date=x$getCreated())
              )

col_names <- row.names(data)
num_cols <- length(col_names)
num_rows <- round(length(data)/num_cols)

df <- data.frame( matrix(data, ncol=num_cols, nrow=num_rows, byrow=TRUE), 
                  stringsAsFactors = FALSE )
names(df) <- col_names
