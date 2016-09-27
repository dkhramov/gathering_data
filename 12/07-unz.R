#### Извлечение данных из zip-архивов.

# По ВЫДУМАННОМУ адресу http://www.xyz.org/data/data.zip находится архив,
# содержащий файл data.dat. Необходимо извлечь данные из этого файла.

# Создать временный файл
temp <- tempfile()
# Скачать данные и поместить их во временный файл
download.file("http://www.xyz.org/data/data.zip", temp, mode="wb")
# С помощью unz() извлечь данные из временного файла и поместить в таблицу
data <- read.table(unz(temp, "data.dat"))
# Удалить временный файл
unlink(temp)
