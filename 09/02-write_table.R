# Запись таблицы в файл.
height = c(180.5, 163.7, 177.2)
weight = c(75, 48, 72)
age = c(18, 17, 17)
df <- data.frame(height,weight,age)
names(df) <- c("Height","Weight","Age")
row.names(df) <- c("John","Mary","Sam")
write.table(df, file="myfile.txt") # разделитель данных - пробел

file.exists("myfile.txt")
