# Загрузка данных wine quality из репозитория данных для машинного обучения
datafile <- "http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv"
df <- read.table(file = datafile, sep=";", header=TRUE)
View(head(df))