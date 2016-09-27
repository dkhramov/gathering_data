list.of.packages <- c("RSelenium")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos="http://cran.us.r-project.org")

library("RSelenium")

# Установка/проверка установки Selenium Server
checkForServer()
# Запуск Selenium Server
startServer()
# Создадим объект-браузер
rd <- remoteDriver(remoteServerAddr = "localhost",
                   port = 4444,
                   browserName="firefox")
# Запустим браузер
rd$open()
# Переместимся теперь на страницу Google
rd$navigate("http://google.com")
# Найдём на странице форму запроса
webElem <- rd$findElement(using = "name", "q")
# Запишем в неё строку "R Project" и "нажмём" Enter
webElem$sendKeysToElement( list("R Project","\uE007") )
