#### Данные Всемирного банка.

# Установим необходимые пакеты

list.of.packages <- c("wbstats","ggplot2","lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos="http://cran.us.r-project.org")

# Загрузим пакет wbstats для работы с данными Всемирного банка

library(wbstats)

# Структура wb_cachelist
str(wb_cachelist, max.level = 1)

# Число индикаторов Всемирного банка
nrow(wb_cachelist$indicators)
     
# Поиск индикатора по шаблону "GDP" в кэшированной версии
# описаний индикаторов
gdb_cached <- wbsearch(pattern = "GDP")
head(gdb_cached)

# Скачаем с сайта новые описания и укажем, 
# что поиск нужно выполнять именно в них
new <- wbcache()
gdb_new <- wbsearch(pattern = "GDP", cache = new)
head(gdb_new)

# Поиск данных по полям индикаторов, указанных в параметре `fields`
blmbrg_inds <- wbsearch(pattern = "Bloomberg", fields = "sourceOrg")
head(blmbrg_inds)

# Получение описаний индикаторов на испанском языке
new_es <- wbcache(lang = "es")

# Скачаем в хранилище Всемирного банка данные индикатора
# "SP.POP.TOTL" (численность населения) за период от 2000 г. до 2002 г. 
pop_data <- wb(indicator = "SP.POP.TOTL", startdate = 2000, enddate = 2002)
head(pop_data)

# Указать нужные страны или регионы можно 
# с помощью их кодов в параметре `country`. 
str(wb_cachelist$countries,  max.level = 1)

# Несколько стран (регионов) можно объединить в вектор.
# В нашем случае это: Беларусь, Казахстан и Украина.
bkru_pop_data <- wb(country = c("BY","KZ","UA"), 
                    indicator = "SP.POP.TOTL", 
                    startdate = 1991, enddate = 2015,
                    POSIXct = TRUE) # даты преобразуются в формат POSIXct
head(bkru_pop_data)
class(bkru_pop_data$date_ct)

# Загрузим графический пакет ggplot2 и построим график
library(ggplot2)
ggplot(bkru_pop_data, aes(x = date_ct, y = value, colour = country)) + 
  geom_line(size = 1) + 
  labs(title = "Population, total", x = "Date", y = "Value")

# Изменение численности населения Казахстана за последние 10 лет
kz10 <- wb(country = c("KZ"), indicator = 'SP.POP.TOTL', mrv = 10, POSIXct = TRUE)
ggplot(kz10, aes(x = date_ct, y = value)) +
  geom_line(size = 1) + 
  labs(title = "Kazakhstan population", x = "Date", y = "Value")

# freq = "M" означает, что будут получены ежемесячные значения индикатора
oil_data <- wb(indicator = "CRUDE_BRENT", mrv = 6, freq = "M")
head(oil_data)
