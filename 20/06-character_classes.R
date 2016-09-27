# Классы символов.

s <- c("12ab", "ad", "34", ",,", "\n")

grep("[[:digit:]]", s, value=T)
grep("\\d", s, value=T)
grep("[[:alpha:]]", s, value=T)
grep("[[:alnum:]]", s, value=T)
grep("[[:alpha:][:digit:]]", s, value=T)
grep("[[:punct:]]", s, value=T)
grep("\\s", s, value=T)
grep("\\S", s, value=T)
