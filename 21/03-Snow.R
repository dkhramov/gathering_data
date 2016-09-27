#### Работа с шейп-файлами. Карта Джона Сноу.
# Источник данных для карты: http://rtwilson.com/downloads/SnowGIS_SHP.zip
# (содержимое архива помещаем в подкаталог snow рабочего каталога 
# пользователя)

# Автоматическая установка пакетов из списка
list.of.packages <- c("maptools", "rgdal", "leaflet")
new.packages <- list.of.packages[!(list.of.packages %in% 
                                     installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

suppressMessages(library('maptools'))   # readShapePoints
suppressMessages(library('rgdal'))      # spTransform
library('leaflet')                      # leaflet

setwd('snow/') # папка для хранения shp-файлов

deaths <- readShapePoints("Cholera_Deaths")
pumps <- readShapePoints("Pumps")

snow_coords = function(obj) {
  obj_coords <- data.frame(obj@coords)
  coordinates(obj_coords) <- ~coords.x1+coords.x2
  proj4string(obj_coords) <- CRS("+init=epsg:27700")
  obj_coords = spTransform(obj_coords,CRS("+proj=longlat +datum=WGS84"))
  df_coords = data.frame(obj_coords@coords)
  coords = data.frame(lon=df_coords$coords.x1, lat=df_coords$coords.x2)
  return(coords)
}

dec <- snow_coords(deaths)
puc <- snow_coords(pumps)

op <- .8

# Размещаем данные на карте Hydda.Full
m <- leaflet() %>% addProviderTiles("Hydda.Full") %>%
  addCircles(dec$lon, dec$lat, 
             radius = deaths$Count, opacity = op, col = "red") %>%
  addCircles(puc$lon, puc$lat, radius = 3., opacity = op, col = "blue")
m
