# Перевод с помощью Yandex.Translate.

library(RSelenium)

startServer()
rd <- remoteDriver(remoteServerAddr = "localhost",
                   port = 4444,
                   browserName="firefox")
rd$open()
rd$navigate("https://translate.yandex.com/")

in_text <- rd$findElement(using = "xpath", 
                          value = "//div[@class='item item_left']
                          //textarea[@id='textarea']")

# Переведём названия городов на английский
in_text$sendKeysToElement(list("Москва, Санкт-Петербург, Саратов",
                               "\uE007"))

out_text <- rd$findElement(using = "xpath", 
                           value = ".//*[@id='translation']")

out <- out_text$getElementText()
out
