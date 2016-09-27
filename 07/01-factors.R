# Факторы. 

fruits <- c("apple", "orange", "orange", "banana", "apple", "orange")
fruits <- as.factor(fruits)
# Число уровней фактора
levels(fruits)
# Количество фруктов каждого вида
table(fruits)
# Диаграмма "вид фруктов-количество"
plot(fruits)
# Уровень, встречающийся чаще всего
which.max(table(fruits))
