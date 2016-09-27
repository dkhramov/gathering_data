#### Пакет RCurl.

suppressPackageStartupMessages(library(RCurl))

# Запрос GET с header = TRUE возвращает, помимо содержимого страницы,
# заголовки ответа сервера
page = getURL("https://curl.haxx.se", header = TRUE)
cat(page)

# Способы работы с формой запроса:
# 1) Сделать GET-запрос, сформировав URL самостоятельно.
res1 <- getURL("https://www.google.com.ua/search?&q=RCurl&btnG=Search")
# 2) getForm поможет составить запрос в виде: поле=значение.
res2 <- getForm("https://www.google.com.ua/search", q="RCurl", btnG="Search")
# 3) Все параметры можно объединить в вектор или список.
res3 <- getForm("https://www.google.com.ua/search", 
                .params = c(q="RCurl", btnG="Search"))
