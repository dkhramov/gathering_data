#### Кириллица и кодирование URL.

library(httr)
library(RCurl)
library(magrittr)

## Перекодировка кириллицы в URL (RCurl)

search <- "Микрокредит"

# Если текущая локаль не UTF-8
if ( !l10n_info()$`UTF-8` ) {
  # ...перекодируем текст запроса в UTF-8
  codepage <- as.character(l10n_info()$codepage)
  search <- iconv(search, from = codepage, to = "UTF-8")
}

# Кодируем URL
curlEscape(search)

## Функция кодировки URL из кириллицы в US-ASCII (RCurl)
cnvURL <- function(x) {
  s1 <- dirname(x)
  s2 <- curlEscape( basename(x) )
  paste(s1, s2, sep="/")
}
# Пример применения:
cnvURL("https://ru.wikipedia.org/wiki/Геоинформационная_система")

## Запрос на кириллице в пакете httr
res <- GET("https://www.google.com.ua",
           path = "search",
           query = list(q="веб-скрапинг", btnG="Search"))

## функция для извлечения кодировки из ответа сервера
charset <- function(response) {
  ct <- headers(response)$`content-type` %>% 
    strsplit(split="=") %>% unlist()
  ct[length(ct)]
}

# Текущая кодировка:
chs <- charset(res)
chs

# Укажем найденную кодировку при получении содержимого страницы 
# и выведем результаты на экран
page <- content(res, as = "text", encoding = chs)
cat(page, "\n") # Вывод текста на экран	   
