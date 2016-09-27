#### Google Spreadsheets

# Установка необходимых пакетов
list.of.packages <- c("googlesheets","httpuv")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos="http://cran.us.r-project.org")

library(googlesheets)

# Загрузка списка доступных таблиц
gs_ls()

# Далее открывается браузер, где вы проходите аутентификацию.
# В случае успеха появляется сообщение:
#   Authentication complete. Please close this page and return to R.
# после чего возвращаемся в R и выбираем интересующую таблицу
# по её названию (gs_title) или по ключу (gs_key).

# Список имён таблиц
gs_ls()$sheet_title

# Загрузим нужную таблицу по её названию
data <- gs_title("имяТаблицы")

# Прочитаем данные из таблицы
data.in.R <- gs_read(data)
