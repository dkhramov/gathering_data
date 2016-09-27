# Цвета и их номера.
plot.new()
plot.window(xlim=c(0,1.1), ylim=c(.8,1.2), yaxs="i")
n <- 8
x <- seq(0.1,1,length=n)
points(x,rep(1,length(x)),pch=19,col=1:n,cex=2)
text(x,rep(.9,length(x)),1:n)
