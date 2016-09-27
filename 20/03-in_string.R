# Положение образца внутри строки.

s <- c("abcd", "cdab", "cabd", "c abd")

grep("ab", s, value=T)    # возвращает все элементы
grep("^ab", s, value=T)   # 1-й элемент
grep("ab$", s, value=T)   # 2-й элемент
grep("\\bab", s, value=T) # 1-й и 4-й элементы
grep("\\Bab", s, value=T) # 2-й и 3-й элементы
