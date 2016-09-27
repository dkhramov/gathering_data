#### Пакет httr.

# Установка необходимых пакетов
list.of.packages <- c("httr","RCurl","jsonlite","sp")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos="http://cran.us.r-project.org")

library(httr)

# Запрос GET
res <- GET("https://curl.haxx.se")

# Ответ на запрос
res

# Заголовки ответа
headers(res)

# Содержимое страницы
page <- content(res, as = "text", encoding = "UTF-8") 
cat(page)

# Сохраним полученную страницу диск
writeLines(page, con = "curl.html")

# Посылка GET-запроса с параметрами возможна двумя способами:
# 1) сделать GET-запрос, добавив параметры к URL самостоятельно
res1 <- GET("https://www.google.com/search?&q=RCurl&btnG=Search")
# 2) объединить параметры (поля формы) и их значения в список, предоставив пакету
#    создать на этой основе URL
res2 <- GET("https://www.google.com/search", 
            query = list(q="RCurl", btnG="Search"))
