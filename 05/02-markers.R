# Виды маркеров.
plot.new()
plot.window(xlim=c(0,2.1), ylim=c(.8,1.1), yaxs="i")
n <- 20
x <- seq(0.1,2,length=n)
points(x,rep(1,length(x)),pch=1:n,cex=2)
text(x,rep(.9,length(x)),1:n)
