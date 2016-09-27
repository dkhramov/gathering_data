# Установим необходимые пакеты.

list.of.packages <- c("DBI", "RSQLite","sqldf")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos="http://cran.us.r-project.org")

#### DBI

# Загружаем общий интерфейс к БД...

library(DBI)

# и соединяемся с базой, используя её драйвер.
# Если базы не существует, то она будет создана.

db <- dbConnect(RSQLite::SQLite(), dbname="Test.sqlite")

# Скачиваем файл из репозитория и сохраняем в таблицу (iris)

fname <- "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
iris <- read.table(file=fname, sep=",", header=FALSE)

# Запишем таблицу в базу.

dbWriteTable(conn = db, name = "Iris", value = iris,
             row.names = FALSE)

# Просмотрим список существующих в базе таблиц.

dbListTables(db)

# Извлечём содержимое таблицы в data.frame.

df1 <- dbGetQuery(db, "SELECT * FROM iris")

# Теперь с таблицей df1 можно работать в R.

# Закрываем соединение.

dbDisconnect(db)

#### sqldf

library(sqldf) # загружает также DBI и RSQLite

# Создаём новую базу данных.

sqldf("attach 'Test1.sqlite' as new")

# Скачиваем файл данных и сохраняем его на диск.

download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data",
              "iris.csv")

# Создаём в базе таблицу и заполняем её данными из файла.

read.csv.sql(file   = "iris.csv",
             header = FALSE,
             sql    = "CREATE TABLE Iris AS SELECT * FROM file",
             dbname = "Test1.sqlite"
)

# Извлекаем содержимое таблицы базы данных для работы в R.

df2 <- sqldf("SELECT * FROM Iris", dbname = "Test1.sqlite")

# Проверим идентичность таблиц df1 и df2.

identical(df1,df2)

