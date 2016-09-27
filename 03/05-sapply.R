#### sapply

# lapply возвращает список
li <- lapply(c(1,2,4), function(x) x^2)
str(li)
# а sapply -- вектор
ve <- sapply(c(1,2,4), function(x) x^2)
str(ve)
# или матрицу
x <- list(1:4, 5:8)
sapply(x, function(x) x^2)

data = data.frame(frst=c("1","2","3"), scnd=c(4,5,6), thrd=c("7","8","9"), stringsAsFactors=F)    
str(data)
# Преобразуем 1-ю и 3-ю колонки таблицы data к числовому типу
data[, c(1,3)] <- sapply(data[, c(1,3)], as.numeric)
str(data)
