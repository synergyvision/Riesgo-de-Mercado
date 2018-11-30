#Prueba VaR, usando paquete VaRES
#cargo la data
tif <- read.delim2("~/Downloads/tif.txt")
veb <- read.delim2("~/Downloads/vebono.txt")
data_montecarlo <- read.delim2("~/Downloads/Data-Montecarlo-Diario.txt")

#ordeno la data de fecha mas reciente a fecha mas antigua
tif$Fecha <- as.Date(tif$Fecha)
veb$Fecha <- as.Date(veb$Fecha)
data_montecarlo$Fecha <- as.Date(data_montecarlo$Fecha)

#quito tif vencidos
tif <- tif[order(tif$Fecha,decreasing = TRUE),-c(2,3)]
veb <- veb[order(veb$Fecha,decreasing = TRUE),]
data_montecarlo <- data_montecarlo[order(data_montecarlo$Fecha,decreasing = TRUE),]

#pruebo con TIF
#seleciono 252 obs
tif_252 <- tif[1:252,]

#calculo rendimientos
rend1 <- diff(tif_252$TIF082018)

#quito ceros
rend1 <- rend1[-which(rend1==0)]

#veo distribucion
a <- useFitdist(rend1)

#es posible q sea cauchy
#obtengo parametros cauchy
a$fit.list$Cauchy$estimate

#calculo VaR (sin posicion no horizonte temporal)
b <- varCauchy(0.95,mu =a$fit.list$Cauchy$estimate[1] ,sigma =a$fit.list$Cauchy$estimate[2])

#calculo VaR en terminos de la posicion y horizonte temporal
#posicion
valor1 <- 200000000

#horizonte, 7,15,23,30, 60 ,90, 180, 360, 720

valor1*b*sqrt(7)
valor1*b*sqrt(15)-valor1*b*sqrt(7)
valor1*b*sqrt(23)
valor1*b*sqrt(30)
valor1*b*sqrt(60)
valor1*b*sqrt(90)
valor1*b*sqrt(180)
valor1*b*sqrt(360)
valor1*b*sqrt(720)-valor1*b*sqrt(360)



#prueba con todos los titulos
dim(tif)

tif1 <- as.data.frame(matrix(0,nrow = 341,ncol = 27))
names(tif1) <- names(tif)[-1]


for(i in 1:(ncol(tif)-1)){
tif1[,i] <- diff(log(tif[,i+1]))
}


############
#PRUEBAS CALCULO DEL VAR- PROBLEMAS

#n <- which(input$inst==names(data()))
n <- 4
dat <- tif[,n]
dat1 <- diff(log(dat))
dat2 <- useFitdist(dat1)
#print(dat2)
#print(uFitdifflog(data1)$fit.list$Normal$estimate[1])
p <- 0.95
dist <- "Normal"

v<-VarR(p,dat2,dist)

#
dat3 <- uFitdifflog(dat)
v<-VarR(p,dat3,dist)


#creo txt de valores nominales
#tif
a <- as.data.frame(matrix(0,nrow = (ncol(tif)-1),ncol=2))
names(a) <- c("titulo","valor_nominal")
a[,1] <- names(tif)[-1]

vt <- c(1000000,3000000,2000000,10000000,5000000,7000000,1000000,
        2000000,4000000,3000000,20000000,6000000,8000000,2000000,
        10000000,30000000,6000000,10000000,5000000,9000000,5000000,
        5000000,9000000,4000000,70000000,5000000,7000000)

a[,2] <- vt

write.table(a,"posicion_tif.txt",row.names = FALSE,quote = FALSE,sep = ",")

#veb
a <- as.data.frame(matrix(0,nrow = (ncol(veb)-1),ncol=2))
names(a) <- c("titulo","valor nominal")
a[,1] <- names(veb)[-1]

vb <- c(1000000,3000000,2000000,10000000,5000000,7000000,1000000,
        2000000,4000000,3000000,20000000,6000000,8000000,2000000,
        10000000,30000000,6000000,10000000,5000000,9000000,5000000,
        5000000,9000000,4000000,70000000,5000000,7000000,7000000,
        4000000,8000000,9000000)

a[,2] <- vb

write.table(a,"posicion_veb.txt",row.names = FALSE,quote = FALSE,sep = ",")

#tif-veb
a <- as.data.frame(matrix(0,nrow = (ncol(data_montecarlo)-1),ncol=2))
names(a) <- c("titulo","valor nominal")
a[,1] <- names(data_montecarlo)[-1]

vb <- c(1000000,3000000,2000000,10000000,5000000,7000000,1000000,
        2000000,4000000,3000000,20000000,6000000,8000000,2000000,
        10000000,30000000,6000000,10000000,5000000,9000000,5000000,
        5000000,9000000,4000000,70000000,5000000,7000000,7000000,
        4000000,8000000,9000000,5000000,3000000)

a[,2] <- c(vt,vb)

write.table(a,"posicion_montec.txt",row.names = FALSE,quote = FALSE,sep = ",")







