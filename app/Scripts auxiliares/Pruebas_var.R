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


















