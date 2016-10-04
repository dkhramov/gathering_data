#### Анализ популярности пакетов R для работы с форматом JSON.

## Шаг 1: Скачаем файлы логов.
# ВНИМАНИЕ! Размер скачиваемых файлов - около 360 Мб.

# Составим вектор дат от начальной до конечной.
from <- as.Date('2016-07-01')
to   <- as.Date('2016-07-30')

days <- seq(from, to, by = 'day')

# Выделим из даты год (годы отсчитываются от 1900 г.).
year <- as.POSIXlt(days)$year + 1900

# Получим список файлов, которые нужно скачать.
urls <- paste0('http://cran-logs.rstudio.com/', year, '/', days, '.csv.gz')

# Создадим каталог для хранения данных
dir.name <- "CRANlogs"
dir.create(dir.name)

# Скачаем файлы и сложим их в созданный каталог
for (i in 1:length(urls)) {
  download.file(urls[i], paste0(dir.name,'/', days[i], '.csv.gz'))
}

## Шаг 2: Объединим данные из логов в одну большую таблицу (data.table).

# Составим список имён файлов из каталога CRANlogs.
file_list <- list.files(dir.name, full.names=TRUE)

# Считаем данные из файлов логов и составим из них список таблиц (data.frame).
logs <- list()
for (file in file_list) {
  print(paste("Reading", file, "..."))
  logs[[file]] <- read.table(file, header=TRUE, sep=",", quote ="\"",
                             dec=".", fill=TRUE, comment.char="", 
                             as.is=TRUE)
}

# Загрузим пакет data.table для работы с большими таблицами
library(data.table)

# Объединим все таблицы списка logs в одну большую таблицу 
# (data.table) по строкам
dt <- rbindlist(logs)

# Посмотрим, что у нас получилось.
str(dt)

# Список таблиц больше не нужен - удалим его.
rm(logs)

# Преобразуем типы данных в некоторых колонках.
dt <- dt[, date:=as.Date(date)]
dt <- dt[, package:=factor(package)]
dt <- dt[, country:=factor(country)]

# Посмотрим, как выглядит таблица теперь.
str(dt)

# Необходимо для работы с data.table 
setkey(dt, package, date, country)

# Сохраним данные для последующего анализа
save(dt, file="CRANlogs/CRANlogs.RData")
# rm(dt)
# load("CRANlogs/CRANlogs.RData")

## Шаг 3: Строим графики.

# Выберем данные по пакетам rjson, RJSONIO и jsonlite
packages <- dt[J(c("rjson", "RJSONIO", "jsonlite")), 
               length(unique(ip_id)), by=c("date", "package")]

# Загрузим графическую библиотеку ggplot2
library(ggplot2)

# Построим график зависимости числа скачиваний от даты 
# для выбранных пакетов
ggplot(packages, aes(x=date, y=V1, color=package, group=package)) + 
  geom_line() + ylab("Downloads") + theme_bw()

# Сохраним последний график в файле.
# ggsave("json_pacs.png", device = "png")
