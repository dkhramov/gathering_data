#### Сохранение файла по динамически генерируемой ссылке.

# Получим список вакансий, размещённых на сайте Министерства труда и социальной защиты 
# Республики Беларусь в виде файла MS Excel. 

library('RSelenium')

startServer()
rd <- remoteDriver(remoteServerAddr = "localhost",
                   port = 4444,
                   browserName="firefox")

rd$open()
rd$navigate("http://vacancy.mintrud.by/user/Pages/
            Public/VacancySearchResults.aspx?")
rd$screenshot(display = TRUE) # делаем снимок экрана

webElem <- rd$findElement(using = 'id', 
                          value = "ctl00_cphMain_lnkVacancyExportXLS")
webElem$clickElement()

rd$close()
