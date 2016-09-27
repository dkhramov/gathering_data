#### Доступ к API портала открытых данных РФ.

library(RCurl)    # getURL
library(jsonlite) # fromJSON

## Параметры:
# базовый URL для доступа к API
URL_base     <- "http://data.gov.ru/api/"
# ключ для доступа к API (замените на свой)
access_token <- "ключ_для_доступа_к_API"

# Получить данные по заданным параметрам
getData <- function (x) {
  par <- paste(x, collapse = "/")
  url <- paste0(URL_base,par,"/?access_token=",access_token)
  fromJSON(getURL(url))
}

# Параметры запроса: получить перечень наборов открытых данных
params <- c("dataset")

# Выполняем запрос
datasets <- getData(params)

# Сколько всего наборов данных храниться на портале
nrow(datasets)

# Посмотрим заголовки первых пяти наборов
head(datasets$title, n = 5)

# Запросим описание набора данных с заданным id
dataset_id <- "7708234640-HDFU-1152110030001-2013-1-24-44-1"
params <- c("dataset", dataset_id)
dataset <- getData(params)
dataset$title
dataset$modified

# Сколько версий данного документа существует?
params <- c(params, "version")
versions <- getData(params)
nrow(versions)

# Запросим наиболее свежую версию документа:
mrv <- versions[nrow(versions),1]
params <- c(params, mrv)
# Получаем содержимое (content) документа
content <- c(params, "content")
doc <- getData(content)

head(doc)
