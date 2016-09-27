# Скачаем данные о заболеваемости ВИЧ из хранилища Gapminder 
# (https://www.gapminder.org/data/) и сохраним в таблице R.
  
suppressPackageStartupMessages(library('XLConnect'))

url_base <- "http://spreadsheets.google.com/pub"
key <- "pyj6tScZqmEfbZyl0qjbiRQ"
url <- paste0(url_base,"?key=",key,"&output=xls")

# Сохраним данные в файле hiv.xlsx
download.file(url, "hiv.xlsx", mode="wb")

# Загрузим эту рабочую книгу
wb = loadWorkbook("hiv.xlsx")
# Сохраним в таблице df содержимое листа data
df = readWorksheet(wb, sheet = "data")
