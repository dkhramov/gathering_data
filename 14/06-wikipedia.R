#### Извлечение таблицы из Википедии.

library(rvest)

## Извлечём таблицу со списком лондонских музеев 
## и сохраним в виде таблицы.

# Получить и обработать страницу
page <- read_html("https://en.wikipedia.org/wiki/List_of_museums_in_London")
# Извлечь таблицу музеев
tables <- page %>% html_nodes(xpath="//*[@id='mw-content-text']/table")
# Искомая таблица - 2-ая в списке
table <- tables[[2]]
lmu <- html_table(table)
# Выведем названия музеев (первые шесть)
head(lmu$Name)

## Данные таблицы позволяют узнать кое-что о Лондоне:
  
# Сколько среди них музеев искусств (Type = Art)?
lmu[lmu$Type=="Art",] %>% nrow()
# Какие музеи расположены на западе Лондона (Region = West)?
wlmu <- lmu$Name[lmu$Region=="West"]
head(wlmu)

## Извлечём адреса страниц музеев в Википедии. 

# Первая колонка таблицы (Name) состоит из ячеек <th>.
# Извлечём из неё ссылки.
links <- html_nodes(table, "tr th a")
# URL страниц музеев хранятся в href, а названия музеев - в title.
ref  <- links %>% html_attr("href")
name <- links %>% html_attr("title")
# В колонке Name записаны только относительные ссылки.
# paste0 это легко исправит.
full_ref <- paste0('https://www.wikipedia.org', ref)
# Сохраним результаты в таблице
lmu_pages <- data.frame(Name=name, Href=full_ref)
head(lmu_pages$Href)
