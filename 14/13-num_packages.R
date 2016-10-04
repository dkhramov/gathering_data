library(rvest)

getNumPackages <- function() {
  page <- read_html("http://cran.r-project.org/web/packages/available_packages_by_date.html")
  packages <- html_node(page, xpath="//table") %>% html_table()
  nrow(packages)
}

# В CRAN на
format(Sys.time(), '%d.%m.%Y')
# доступно для загрузки пакетов
getNumPackages()
