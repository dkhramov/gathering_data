#### Поиск пользователя.

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

## Определение id страны.

# Получим id страны.
# Код страны (code) - двухбуквенный, вида: RU, UA, BY и т.п.
params <- list(code = "RU")
countries <- vk( "database.getCountries", params )
id <- countries$items[[1]]$id

# id страны - обязательный параметр при поиске id города.
params <- list(country_id = id)
cities <- vk( "database.getCities", params )

## Определение id города.

# Введём фрагмент названия нужного города.
city_name <- "..."
# Список описаний найденных городов.
city <- cities$items[grep(city_name,cities$items)]
# Если городов найдено несколько, возвращается первый из них.
cid <- city[[1]]$id

## Поиск пользователя.

# Ищем конкретного пользователя, ограничив поиск заданным городом
name <- "..." # Возможно, придётся искать на английском языке.
params <- list(q = name, fields = "city", city = cid)
searched_users <- vk( "users.search", params )$items

# Введём фамилию так, как её записал пользователь.
user_last_name <- "..."
user <- searched_users[grep(user_last_name,searched_users)]
# Если пользователей найдено несколько, возвращается первый из них.
suid <- user[[1]]$id

# Получим более подробную информацию о пользователе.
params <- list(user_ids = suid, 
               fields = "photo_200_orig,education,universities,occupation")
searched <- vk( "users.get", params )
