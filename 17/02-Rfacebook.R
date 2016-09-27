#### Пакет Rfacebook: использование маркера доступа и создание приложения.

## Использование маркера доступа

library(Rfacebook)

access_token <- "ваш маркер доступа"

me <- getUsers("me", access_token)
me$gender

## Создание приложения

# Создать маркер OAuth для сеанса работы в Facebook.
fb_oauth <- fbOAuth(app_id="ваш app_id", 
                    app_secret="ваш app_secret")
# Получить данные о пользователе me.
me <- getUsers("me", token=fb_oauth)
# Вывести имя пользователя
me$name

# Найдём 100 общедоступных страниц, упоминающих пользователя "wierer" 
# и выведем имя первой страницы.
pages <- searchPages( string="wierer", token=fb_oauth, n=100 )
doro <- as.vector(pages[1,"id"])

