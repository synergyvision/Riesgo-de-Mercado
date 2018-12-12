#exponencial
curve(exp,0.5,3.5,lwd=2,axes=FALSE,xlab = "",ylab = "")
axis(1)
t <- seq(1,3,by = 0.01)
x <- c(1,t,3)
y <- c(0,exp(t),0)
polygon(x,y,col="grey")
abline(h=0,lwd=2)
rect(1,0,3,exp(3),border = "red",lwd=2)
n <- 2000
x1 <- runif(n,1,3)
y1 <- runif(n,0,exp(3))
ab <- as.factor((y1<=exp(x1))*1)
points(x1,y1,col=c(1,2)[ab],pch=c(19,19)[ab])

#valor a aproximar
exp(3)-exp(1)
#resultado de simulaciones
(table(ab)/n)*2*exp(3)
text(2,exp(3.2),"y=f(x)=exp(x)")


#distribucion normal
curve(dnorm,-3,3,axes=FALSE,xlab = "",ylab = "",lwd=2.5)
axis(1)
abline(h=0,lwd=2.5)

#programacion
rect(0,0,1,dnorm(0),border = "blue",lwd = 2.5)
contador <- 0
n <- 2000
for(i in 1:n){
  x <- runif(n,0,1)
  y <- runif(n,0,dnorm(0))
  if(y[i]<=dnorm(x[i]))
    contador <- contador+1 
}
prob <- (contador/n)*1*dnorm(0)
#area aproximada
prob

#area real
pnorm(1)-pnorm(0)

#funcion montecarlo
f <- function(x)  exp(-0.5*x^2)/sqrt(2*pi)
 
  x2 <- seq(-3,3,by = 0.01)
  plot(x2,f(x2),type = "l",lwd=2,axes=F,xlab = "",ylab = "")
  axis(1)
  abline(h=0,lwd=2)
  polygon(c(0,seq(0,1,by=0.01),1),c(0,dnorm(seq(0,1,by=0.01)),0),col="grey90")
  rect(0,0,1,dnorm(0),border = "blue")
  n2 <- 2000
  x3 <- runif(n2,0,1)
  y3 <- runif(n2,0,dnorm(0))
  colour <- ifelse(y3<=dnorm(x3),"red","black")
  points(x3,y3,col=colour,pch=c(19,19))

  prob3 <- (table(colour)/n2)*1*dnorm(0)
  prob3
  
  pnorm(1)-pnorm(0)
  
  
  
  
    