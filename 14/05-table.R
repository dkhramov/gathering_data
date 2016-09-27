# Обработка таблиц.

library(rvest)

table <- "<table>
          <tr><td>a</td><td>10</td></tr>
          <tr><td>b</td><td>20</td></tr>
          "
doc <- read_html(table)
doc %>% html_table()
