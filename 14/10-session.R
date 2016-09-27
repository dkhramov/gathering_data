## Аутентификация на форуме.

library(rvest)

# Создаём сессию
session <- html_session("http://login.rutracker.org/forum/login.php")
# Получаем форму для аутентификации пользователя
login_form <- html_form(session)[[2]]
# Заполняем форму
filled_form <- set_values(login_form,
                          "login_username" = "вашлогин",
                          "login_password" = "вашпароль")
# Отправляем её
submit_form(session,filled_form)
