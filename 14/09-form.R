# Обработка формы.

library(rvest)

form <- '<form name="myform" action="textinput" method="GET">
          Введите текст: <br>
          <input type="text"   name="inputbox" value=""><br>
          <input type="button" name="btn1"     value="Read">
          <input type="button" name="btn2"     value="Write">
         </form>'
hdoc <- read_html(form)
myform <- html_form(hdoc)
myform

# Введём в форму строку "Hello!"
filled_form <- set_values(myform[[1]], inputbox = "Hello!")
filled_form
