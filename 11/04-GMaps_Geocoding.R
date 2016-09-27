# Определение координат объектов по их адресам
# с помощью сервиса Google Maps Geocoding.

library(httr)

## Определение координат штаб-квартиры Google Inc. 
## (адрес: 1600 Amphitheatre Parkway, Mountain View, CA)

# Адрес головного офиса Google Inc.
Google_address <- "1600 Amphitheatre Parkway, Mountain View, CA"
# Запрос, сформированный при помощи GET
res <- GET("https://maps.googleapis.com/maps/api/geocode/json", 
           query = list(address = Google_address))

result <- content(res)

# Широта
result$results[[1]]$geometry$location$lat

# Долгота
result$results[[1]]$geometry$location$lng

# Полный адрес штаб-квартиры (в нашем запросе не был указан индекс)
result$results[[1]]$formatted_address

## Определим координаты Эйфелевой башни

Eiffel_Tower_address <- "The Eiffel Tower, Paris, France"
res <- GET("https://maps.googleapis.com/maps/api/geocode/json", 
           query = list(address = Eiffel_Tower_address))
result <- content(res)

lat <- result$results[[1]]$geometry$location$lat
lon <- result$results[[1]]$geometry$location$lng

library(sp) # Классы и методы для работы с пространственными данными

# Широта
dd2dms(lat, NS = TRUE) # для получения долей градуса в минутах и секундах

# Долгота
dd2dms(lon)

# Адрес
result$results[[1]]$formatted_address
