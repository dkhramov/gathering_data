# Обработка HTML-документа в пакете rvest.

page <- "<!DOCTYPE html>
<html>
<body>

<table style=\"width:100%\">
  <tr>
    <th>Firstname</th>
    <th>Lastname</th> 
    <th>Age</th>
  </tr>
  <tr>
    <td>Jill</td>
    <td>Smith</td>
    <td>50</td>
  </tr>
  <tr>
    <td>Eve</td>
    <td>Jackson</td>
    <td>94</td>
  </tr>
  <tr>
    <td>John</td>
    <td>Doe</td>
    <td>80</td>
  </tr>
</table>

</body>
</html>"


library(rvest)

hdoc <- read_html(page)                            # Обработка HTML-разметки.
tnode <- html_node(hdoc, xpath="/html/body/table") # Поиск элемента.
df <- html_table(tnode)                            # Преобразование таблицы HTML
                                                   # в data.frame.
df

# Альтернативная реализация, использующая конвейер операций
df <- read_html(page) %>% html_node(xpath="/html/body/table") %>% html_table()

