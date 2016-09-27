#### do.call

do.call(sum, list(1,2,4,1,2))
# Без do.call понадобилось бы избавится от списка:
# li <- list(1,2,4,1,2)
# sum(unlist(li))

# Преобразование списка
A <- list(1:3,4:6,7:9)
str(A)
B <- do.call(rbind,A)
str(B)
class(B)
