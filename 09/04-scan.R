# Создадим файл ex.data, в каждой строке которого хранится
# пара чисел
cat("24 1991", "21 1993", "53 1962", file = "ex.data", sep = "\n")

# Чтобы считать из файла таблицу, нужно, помимо scan(), 
# воспользоваться функцией matrix
data <- matrix(scan("ex.data"), nrow=3, byrow=TRUE)

data

# Считаем данные из файла ex.data, 
# пропустив первую строку и сохранив результат в виде списка, 
# состоящего из двух числовых векторов
data.list <- scan("ex.data",
                  what = list(Age = 0,
                              Birthyear = 0),
                  skip=1,
                  quiet=TRUE)

# Считаем таблицу из файла myfile.txt (02-write_table.R) 
# в список data
data <- scan("myfile.txt",
             what = list(Name= "",
                         Heigth = 0,
                         Weight = 0,
                         Age = 0),
             skip=1,
             quiet=TRUE)

# Преобразуем список в таблицу
df <- data.frame(data)
