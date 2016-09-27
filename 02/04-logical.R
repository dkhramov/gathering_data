# Логический тип данных.

x = 2; y = 5
z = x > y      # x больше y? 
z              # напечатаем полученное логическое значение
class(z)

# Основные логические операции
a = TRUE; b = FALSE # Запись можно сократить: a = T; b = F
a & b               # u И v 
a | b               # u ИЛИ v 
!a                  # НЕ-u

# Неявное приведение типов (logical -> числовые типы -> character)
str(1 + FALSE)
str(1 + TRUE)
class(as.integer(1) + TRUE)
str(paste(FALSE, 1.0, "test"))
