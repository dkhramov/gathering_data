# Работа с кодировками.

library(rvest)

url <- "https://ru.wikipedia.org/wiki/Ершов,_Андрей_Петрович"
ershov <- read_html(url)

text <- ershov %>%
  html_nodes(".note") %>%
  html_text()

# Определение и исправление кодировки страницы
text %>% guess_encoding()
text %>% repair_encoding() %>% cat()

# Хорошей практикой является указывать кодировку при обработке веб-страницы
ershov <- read_html(url, encoding = "UTF-8")
ershov %>% html_nodes(".note") %>%  html_text() %>% cat()
