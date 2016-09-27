#### Получение информации о пользователе сети ВКонтакте.

library(RCurl)
library(rjson)

# Параметры доступа
access_token <- "ключ_доступа_вашего_приложения"
ver <- "5.53"
# Идентификатор пользователя
uid <- "идентификатор_пользователя"

# Функция запроса к API
vk <- function( method, params ) {
  
  if( !missing(params) ){
    params <- sprintf( "?%s", paste( names(params), "=", 
                                     unlist(params), collapse = "&", sep = "" ) )
  } else {
    params <- ""
  }
  
  url <- sprintf( "https://api.vk.com/method/%s%s&access_token=%s&v=%s", 
                  method, params, access_token, ver  )
  data <- getURL(url)
  
  tryCatch({
    list <- fromJSON( data )
  }, error = function (e) {
    print(data)
    stop(e)
  })
  
  list$response
}

# Список сообществ (групп и пабликов) с описанием.

params <- list(user_id = uid, extended = 1, fields = "description")
groups <- vk( "groups.get", params )

# Список подписок (пабликов и пользователей) с описанием.

params <- list(user_id = uid, extended = 1, fields = "description")
subscriptions <- vk( "users.getSubscriptions", params )

# Список подписчиков
# (часть из них может быть забанена или деактивирована)
params <- list(user_id = uid, fields = "last_name")
followers <- vk( "users.getFollowers", params )

