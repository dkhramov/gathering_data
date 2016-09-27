# Создадим каталог
dir.create("test")

# Сделаем его рабочим
setwd("test")

# Скачаем в него файл
url <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(url, destfile="./rows.csv", method="curl")

# Посмотрим список файлов в текущем каталоге
list.files(".")

# Удалим файл rows.csv
file.remove("rows.csv")

# Проверим, существует ли файл?
file.exists("rows.csv")

# Сделаем рабочим родительский каталог для test
setwd("..")

# Удалим каталог test
unlink("test", recursive = TRUE)

