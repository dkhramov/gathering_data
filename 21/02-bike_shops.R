#### Построение карты по данным, извлечённым из веб-страницы.

## 1. Извлечение адресов и названий магазинов

# Извлечём содержимое страницы
library(rvest)	# для извлечения данных
url <-  "http://metrowarszawa.gazeta.pl/metrowarszawa/1,141635,17512272.html"
web_page <- read_html(url)

# Выделим из веб-страницы текст, а затем подстроки, 
# соответствующие шаблону адреса.
library(stringr)	# для текстового поиска в строке
address.list <- web_page %>% html_text() %>% str_extract_all(pattern = "ul.\\s[A-Z].+?\\s[0-9]+")
# Преобразуем полученный список в вектор
address <- unlist(address.list)

# В адресах нужно указать, что все они относятся к Варшаве:
address <- paste0(address, ", Warszawa")
address

# Названия магазинов находятся внутри элементов <b>.
tmp <- web_page  %>%  html_nodes("b") %>% html_text()

# Выделим среди найденных фрагментов названия магазинов
tmp <- tmp %>% str_match("(.+)\\s-") %>% .[,2]

# Выделим все элементы tmp, кроме NA
name <- tmp[!is.na(tmp)]

name

## 2. Геокодирование

# Объединим адреса и названия магазинов в таблицу. 
# Добавим в эту таблицу координаты магазина -- долготу и широту. 

library(ggmap)
locations <- data.frame(address = address,  	# адрес магазина
                        geocode(address),   	# долгота и широта магазина
                        stores = name,      	# название
                        stringsAsFactors = F) # сохранить символьный формат	

## 3. Отображение на карте

library(leaflet)
# Текст пояснений: в первой строке жирным шрифтом - название магазина, 
# во второй -- его адрес.
store_popup <- paste0("<b>", locations$stores, "</b>", "<br>", 
                      locations$address)
# Построим карту
m <- leaflet(data = locations) %>% 
  addProviderTiles("Esri.WorldTopoMap") %>% 
  addMarkers(locations$lon, locations$lat, popup = store_popup)
m
