#### Данные о биржевых инвестиционных фондах с сайта Лондонской фондовой биржи.

library(rvest)

## 1. Получить таблицу (тело цикла).

# Получить страницу
url <- "http://www.londonstockexchange.com/exchange/prices-and-markets/ETFs/ETFs.html"
page <- read_html(url)

# Функция для извлечения колонок 1:6 таблицы ETF
get_table <- function(doc) { 
  doc %>% html_node("table") %>% html_table() %>% .[1:6] 
}

# Получить таблицу
table <- get_table(page)

head(table)

## 2. Определить число связанных страниц (счетчик цикла).

# Найти число страниц
s <- page %>% html_node("p.floatsx") %>% html_text()
s <- strsplit(s,"of") %>% unlist()
num_pages <- s[length(s)] %>% as.numeric

num_pages

## 3. Обработать таблицы на связанных страницах (цикл обработки).
#
# http://www.londonstockexchange.com/.../ETFs.html (уже обработана)
# http://www.londonstockexchange.com/.../ETFs.html?&page=2
# http://www.londonstockexchange.com/.../ETFs.html?&page=3
#                       ...
#
# Пример составления ссылки (на страницу 2):
# c("http://www.londonstockexchange.com/.../ETFs.html",
#  "?&page=", 2)

# Цикл обработки ссылок
for (p in 2:num_pages) {
  cur_url <- paste0(url,"?&page=",p)
  cur_page <- read_html(cur_url)
  cur_table <- get_table(cur_page)
  table <- rbind(table,cur_table)
}
