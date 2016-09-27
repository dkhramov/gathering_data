#### Страница сериала «Светлячок» на IMDb.

library(rvest)

firefly <- read_html("http://www.imdb.com/title/tt0303461/")

# Рейтинг сериала
firefly %>% html_node("strong > span") %>% html_text() %>% as.numeric()
# Другой вариант: путь по XPath
firefly %>% html_node(xpath="//strong//span") %>% html_text() %>% as.numeric()

# Список актёров
firefly %>% html_nodes("#titleCast .itemprop span") %>% html_text()

# Последние по времени сообщения на досках объявлений (message boards)
# собраны в таблице .boards
firefly %>% html_nodes(".boards") %>% html_table()
