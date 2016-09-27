## Скачать веб-страницу cURL.

# адрес документа
url <- "http://curl.haxx.se/"
# каталог для сохранения файлов
downloads <- file.path(getwd(),"Downloads")
# если его нет, то создаём
if (!dir.exists(downloads)) dir.create(downloads)
# имя сохраняемого файла
dest_file <- file.path(downloads,"curl.html")
# скачать файл
download.file(url,dest_file)
