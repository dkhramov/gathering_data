library()   # вывод списка установленных пакетов
search()    # вывод списка пакетов, загруженных в память
.libPaths() # возвращает каталог, в который установлены пакеты

# Установлен ли пакет rvest?
any(grepl("rvest", installed.packages()))

# Автоматическая установка пакетов из вектора list.of.packages
list.of.packages <- c("rvest")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos="http://cran.us.r-project.org")
