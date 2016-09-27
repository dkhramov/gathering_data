#### Импорт и распаковка zip-архивов функцией Hmisc::getZip. 

library(Hmisc)

urlUN <- "http://data.un.org/Handlers/DownloadHandler.ashx?DataFilter=group_code:101;country_code:826&DataMartId=SNA&Format=csv&c=2,3,4,6,7,8,9,10,11,12,13&s=_cr_engNameOrderBy:asc,fiscal_year:desc,_grIt_code:asc"

# Файл скачивается, распаковывается и хранящиеся в нём данные формата CSV 
# сохраняются в таблице unData.
unData <- read.csv(getZip(urlUN))
