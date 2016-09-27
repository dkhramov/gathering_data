#### Получаем ссылку и скачиваем файл с сайта ACLED (Armed Conflict Location & Event Data Project).

# 1.Получаем ссылку

library(rvest)

page <- read_html("http://www.acleddata.com/data/realtime-data-2016/")

link <- page %>%
  html_nodes("a") %>%             # находим все ссылки
  html_attr("href") %>%           # извлекаем из них URL  
  grep("\\.xlsx",. , value=T) %>% # выбираем те, что содержат ".xlsx"
  .[[1]]                          # и из них берём первую

# 2.Скачиваем файл

tmpfile <- "temp.xlsx"
download.file(link, tmpfile, mode = "wb")

# 3.Загружаем данные из файла в data.frame

library(XLConnect)

# Прочитать лист из файла и сохранить в таблице. 
df <- readWorksheetFromFile(tmpfile, sheet = 1)
# Удалить временный файл.
unlink(tmpfile)
