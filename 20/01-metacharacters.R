# Метасимволы.

# Определим, в какой строке содержится слово "text"
s <- c("a letter", "a word", "first paragraph", "some text")
grep("text", s)

# Выведем текст строки, которая содержит шаблон "text"
grep("text", s, value = TRUE)
# Или так:
s[grep("text", s)]

# Сравним результаты поиска с учётом регистра и без него
s <- c("a letter", "a word", "first paragraph", "some Text")
grep("text", s)
grep("text", s, ignore.case = TRUE)

# "." означает один любой символ
s <- c("a", "ab", "abc", "a.")
grep("a.", s)

# "\\" отменяет специальное значение точки и превращает её в обычный символ
grep("a\\.", s)
