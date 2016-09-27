## Вывод матриц.

A <- matrix(1:10, ncol=5)
# Вывод матрицы в консоль
write(A, file="")
# Транспонируем A, чтобы записать её по столбцам, 
# и выводим в файл mymatrix.txt
write(t(A), file="mymatrix.txt", ncolumns=5)
