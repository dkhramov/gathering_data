# Доступ к Facebook по Graph API.

library(rvest)
access_token <- "ваш маркер доступа"
url <- sprintf("https://graph.facebook.com/me?access_token=%s",
               access_token)
fb_hdoc <- read_html(url)

# Получение информации о пользователе me.

# Извлекаем из HTML-документа данные в формате JSON.
fb_json <- fb_hdoc %>% html_text()
# Загружаем библиотеку для работы с JSON.
library(jsonlite)
# Преобразуем данные из JSON в список (list).
me <- fromJSON(fb_json)
# Извлекаем поля из списка.
me$last_name
me$gender

url <- sprintf("https://graph.facebook.com/me?fields=last_name,gender&access_token=%s",
               access_token)
me <- url %>% read_html() %>% html_text() %>%  fromJSON()
str(me)

# Объекты, которые пользователь me отметил лайком ("likes")

url <- sprintf("https://graph.facebook.com/me/likes?access_token=%s",
               access_token)
fb_hdoc <- read_html(url)
fb_json <- fb_hdoc %>% html_text()
fb_data <- fromJSON(fb_json)
likes <- fb_data$data
likes

# Пример поиска пользователей "Ivanov":
  
url <- sprintf("https://graph.facebook.com/search?q=ivanov&type=user&access_token=%s",
               access_token)
dat <- url %>% read_html() %>% html_text() %>%  fromJSON() %>% .$data
