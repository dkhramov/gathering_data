list.of.packages <- c("maptools", "rgdal", "leaflet", "KernSmooth")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

suppressMessages(library('maptools'))   # readShapePoints
suppressMessages(library('rgdal'))      # spTransform
library('leaflet')                      # leaflet
suppressMessages(library('KernSmooth')) # bkde2D

setwd('snow/')

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

m <- leaflet() %>% addProviderTiles("Hydda.Full") %>%
     addCircles(dec$lon, dec$lat, radius = deaths$Count, opacity = op, col = "red") %>% 
	 addCircles(puc$lon, puc$lat, radius = 3., opacity = op, col = "blue")
m	 
	 
X <- cbind(dec$lon,dec$lat)

kde2d <- bkde2D(X, bandwidth=c(bw.ucv(X[,1]),bw.ucv(X[,2])))

x <- kde2d$x1
y <- kde2d$x2
z <- kde2d$fhat
CL <- contourLines(x, y, z)

m %>% addPolygons(CL[[1]]$x, CL[[1]]$y, fillColor = "yellow", stroke = FALSE) %>%
      addPolygons(CL[[3]]$x, CL[[3]]$y, fillColor = "yellow", stroke = FALSE) %>%
      addPolygons(CL[[5]]$x, CL[[5]]$y, fillColor = "yellow", stroke = FALSE) %>%
      addPolygons(CL[[7]]$x, CL[[7]]$y, fillColor = "yellow", stroke = FALSE) %>%
      addPolygons(CL[[9]]$x, CL[[9]]$y, fillColor = "yellow", stroke = FALSE)
	  
m %>% addPolylines(CL[[1]]$x, CL[[1]]$y, color = "black") %>%
      addPolylines(CL[[5]]$x, CL[[5]]$y, color = "black") %>%
      addPolylines(CL[[8]]$x, CL[[8]]$y, color = "black")  
