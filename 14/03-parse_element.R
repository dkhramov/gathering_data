# Разбор элемента.

library(rvest)

simple_doc <- read_html('<a href="http://google.com" rel="nofollow">
                        Link to the <b>Google</b></a>')
link <- html_nodes(simple_doc, xpath="//a")
link

# Имя элемента
html_name(link)
# Его атрибуты
html_attrs(link)
# Обращение к отдельному атрибуту по его имени
html_attr(link, "href")
# Текст внутри элемента, "как есть"
html_text(link)
# Текст с удалёнными пробелами в начале и в конце текста
html_text(link, trim = TRUE)
# Список дочерних элементов
html_children(link)
