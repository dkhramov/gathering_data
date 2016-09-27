# Поиск элемента HTML.

library(rvest)

# Считываем и обрабатываем файл sample.html (он должен находиться в рабочем каталоге)
hdoc <- read_html("sample.html")

## Найдём элемент с id="date" при помощи пути, заданном
#  CSS-селекторами (по умолчанию)
html_nodes(hdoc, "#date")
# XPath
html_nodes(hdoc, xpath="//span[@id='date']")

# Сравним работу html_nodes() и html_node()
html_nodes(hdoc, ".example")
html_node(hdoc,  ".example")

