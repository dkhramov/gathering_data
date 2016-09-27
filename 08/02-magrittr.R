# Пакет magrittr

library(magrittr)

x <- seq(-pi,pi,.1)
y <- x %>% sin       # эквивалентно y <- sin(x) 

Sys.Date() %>% 
  as.POSIXct %>%
  seq(by = "15 mins", length.out = 9) %>%
  data.frame(timestamp = .)  
