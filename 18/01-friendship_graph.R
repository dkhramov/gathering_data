#### Построение графа дружеских связей пользователя ВКонтакте.

library(RCurl)
library(rjson)

access_token <- "ключ_доступа_вашего_приложения"
ver <- "5.53"

# Функция запроса к API. Принимает имя метода и его параметры, 
# возвращает список с результатами запроса.
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

# Введём идентификатор интересующего пользователя

uid <- "идентификатор_пользователя"

# Получим список идентификаторов друзей пользователя с идентификатором uid

params <- list(user_id = uid)
friendList <- vk( "friends.get", params )

# Получим идентификатор, имя, фамилию и контактные данные (contacts) пользователя uid

params <- list(user_id = uid, fields = "contacts")
friendList <- vk( "friends.get", params )

## Составим список друзей для каждого из друзей пользователя и 
## добавим в этот список его самого
  
count <- friendList$count
ids   <- sapply(friendList$items, function(x) x$id)

# Список друзей для каждого из друзей.

friendLists <- vector(length = count)

for (i in 1:count) {
  params <- list(user_id = ids[i])
  list <- vk( "friends.get", params )
  friendLists[i] <- list(list$items)
}

# Добавим пользователя в списки собственных друзей.

friendLists <- c(friendLists, list(ids))

## Построим матрицу инцидентности графа дружеских связей.
  
n <- length(friendLists)

mutuals <- matrix(nrow = n, ncol = n)

for (i in 1:n) {
  for (j in 1:n) {
    # NA нет.
    mutuals[i,j] <- sum(friendLists[[i]] %in% friendLists[[j]])
  }
}

## Построение графа связей

library(igraph)

# Построим граф по матрице инцидентности mutuals

g <- graph_from_adjacency_matrix(mutuals, 
                                 weighted=T, 
                                 mode = "undirected", 
                                 diag = FALSE)

# Имена вершин графа равны их номерам в списке friendLists

V(g)$name <- as.character(1:n)

# Удалим из графа изолированные вершины (вершины, степень которых равна нулю)
  
isolated <- V(g)[degree(g)==0]
g <- g - vertices(isolated)

# Для представления графа используем алгоритм Kamada-Kawai
# (http://igraph.org/r/doc/layout_with_kk.html). 
# В нём большим значениям весов (weights) соответствуют более длинные рёбра.
# В качестве весов возьмём величины, обратно пропорциональные весам 
# из матрицы инцидентности (с небольшим смещением).
  
egam <- max(E(g)$weight+.5) / (E(g)$weight+.5)
coords <- layout_with_kk(g, weights=egam)

# Строим граф и сохраняем его в файле
  
png(file = "graph.png")
plot(g, layout=coords, vertex.size=15)
dev.off()
