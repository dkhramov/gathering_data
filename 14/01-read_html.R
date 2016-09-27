library(rvest)

# Считываем и обрабатываем файл sample.html (он должен находиться в рабочем каталоге)
hdoc <- read_html("sample.html")
class(hdoc)

# Считываем и обрабатываем строку с HTML-разметкой
read_html("<h1>Hi!</h1>")

# Считываем и обрабатываем URL
read_html("http://www.google.com")

# Вывод текста HTML-документа
hdoc <- read_html("sample.html", encoding = "UTF-8")
cat(as.character(hdoc))

# Вывод структуры HTML-документа
html_structure(hdoc)
