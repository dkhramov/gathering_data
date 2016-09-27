# Числовые типы данных.

# Создадим numeric
a <- 1 # или a <- 1.0
class(a)
str(a)

# Преобразуем в integer
b <- as.integer(a)
class(b)

# Проверка типов
is.integer(b)
is.integer(a)
is.numeric(a)

# Комплексные числа
c <- sqrt(-1)     # так не пойдёт!
str(c)
c <- sqrt(-1+0i)  # правильный способ
class(c)
str(c)
is.numeric(c)
is.complex(c)

# Неявное приведение числовых типов: integer -> numeric -> complex
ab <- a+b
class(ab)
abc <- ab/c
class(abc)

# Явное приведение типов
as.numeric(1.5+1i) # при потере мнимой части выдаётся предупреждение
dn <- as.numeric(1.5+0i)
str(dn)
di <- as.integer(1.5+0i)
str(di)
as.complex(di)
