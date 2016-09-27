#### Поиск в Twitter и сохранение его результатов в базе данных.

library(twitteR)

# Ключи доступа.
api_key <- "ваш_api_key"
api_secret <- "ваш_api_secret"
access_token <- "ваш_access_token"
access_token_secret <- "ваш_access_token_secret"

# Авторизация.
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

# Создадим базу в текущем каталоге.
# (потребуется установить пакет RSQLite, если он не установлен)
register_sqlite_backend("data_mining.sqlite")
# Получим твиты по заданным ключевым словам.
tweets = searchTwitter("data mining")
# Сохраним твиты в базе. 
store_tweets_db(tweets)
# Загрузим твиты из базы в таблицу R.
from_db = load_tweets_db(as.data.frame = TRUE)
