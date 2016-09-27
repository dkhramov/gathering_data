#### Построение простейших карт в пакете leaflet.

library(leaflet)

# Отметим на карте расположение статистического факультета Оклендского университета 
# в Новой Зеландии
m <- leaflet()  %>%
      addTiles() %>%  # добавим листы карт OpenStreetMap
      addMarkers(lng=174.768, lat=-36.852,
                 popup="The birthplace of R")
# Выведем карту на экран
m

# # Те же операции, без использования `%>%`
# m <- leaflet()
# m <- addTiles(m)
# m <- addMarkers(m,
#                 lng=174.768, lat=-36.852,
#                 popup="The birthplace of R")
# m

# Установим координаты центра карты и масштаб отображения (zoom)
m %>% setView(lng=174.768, lat=-36.852, zoom=10)

# Зададим границы отображаемой области
m %>% fitBounds(174.767,-36.853,174.769,-36.851)

# Построим карту на подложке 'Esri.WorldTopoMap'
m %>% addProviderTiles("Esri.WorldTopoMap")
