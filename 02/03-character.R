# Символьный (строковый) тип данных.

# Конкатенация строк
s1 <- "Text string."
s2 <- 'Another string.'
s12 <- paste(s1,s2)
str(s12)

# Внутренние и внешние кавычки
s1 <- "First 'attempt'"
s2 <- 'Second "attempt"'
s3 <- "Third \"attempt\""
s123 <- paste(s1,s2,s3,sep=". ")
str(s123)

# Создание строки с помощью sprintf()
sprintf("%s was founded in AD %d.", "London", 43) 

# Выделение подстроки
substr("abcdefg",3,5) # выделить подстроку с 3-го по 5-й элемент

# Замена подстроки
#     что менять # на что заменить  # где искать
# sub("a",        "A",               "rama")
sub("a","A","rama")  # sub = substitute
gsub("a","A","rama") # gsub = global substitute
sub("a","A",c("mama","rama","banana"))

# Приведение данных других типов в строковый и обратно
paste("the value of PI is", 3.14)
as.numeric("3.14")
as.numeric("a")      # будет выдано предупреждение
as.character(3.14)

# Преобразование числа с десятичной запятой из символьной формы записи
# в числовую 9.1
r <- "9,1"
as.numeric( gsub(",", ".", r) )

