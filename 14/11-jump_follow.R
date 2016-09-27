# Навигация.

library(rvest)

s <- html_session("http://hadley.nz")
s$url
s <- s %>% follow_link("github")
s$url
s <- s %>% back()
s$url
s <- s %>% jump_to("http://recipes.had.co.nz/")
s$url
session_history(s)
