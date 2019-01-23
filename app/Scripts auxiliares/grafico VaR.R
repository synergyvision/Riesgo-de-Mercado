#instrucciones para realizar grafico excepciones Var 252 obs
#install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
setwd("T:/Riesgos/Intercambio/Coordinacion de Riesgo de Mercado, Liquidez y Tasas de Interes/RIESGO DE MERCADO/Valoracion Riesgo/Backtesting")
#leo la data ubicada en el escritorio, debe esta compuesta por dos col una con la fecha (no importa si esta en orden)
#y la otra los rendimientos de los precios de los tituulos
#ren <- read.delim("C:/Users/ftapia/Desktop/ren.txt", header=FALSE)

#ren.grafico.Ene17 <- read.delim("T:/Riesgos/Intercambio/Coordinacion de Riesgo de Mercado, Liquidez y Tasas de Interes/RIESGO DE MERCADO/Valoracion Riesgo/Backtesting/ren-grafico-Ene17.txt", header=FALSE)
#ren.grafico.Jul17 <- read.delim2("C:/Users/ftapia/Desktop/Pdf backtesting y C. Svenson y otros/data Kupiec/ren-grafico-Jul17.txt", header=FALSE)
#ren.grafico.sep17 <- read.delim2("C:/Users/ftapia/Desktop/Pdf backtesting y C. Svenson y otros/data Kupiec/ren-grafico-Sep17.txt", header=FALSE)

ren<- read.delim("T:/Riesgos/Intercambio/Coordinacion de Riesgo de Mercado, Liquidez y Tasas de Interes/SCRIPTS R/ren-grafico-dic17.txt", header=FALSE)



#convierto la columna 1 de la data en fechas
ren$V1=as.Date(ren$V1)

#uso la funcion zoo para "fijar la fecha" y le paso los rendimientos de la col 2
ren1=zoo(ren$V2,ren$V1)

#finalmente aplico la funcion xts para obtener la data a usar en la funcion chart.BarVaR
ren2=xts(ren1)

#realiza el grafico pedido y utiliza la data rend2, da el var por tres metodos
#chart.BarVaR(ren2,methods=c("HistoricalVaR", "ModifiedVaR", "GaussianVaR"),main="Comparaci?n de Excepciones", xlab="Date")

#Grafica mostrando una linea ideal para ver expcepciones
#chart.BarVaR(ren2,methods=c("HistoricalVaR", "ModifiedVaR", "GaussianVaR"),main="Comparaci?n de Excepciones", xlab="Date",show.horizontal = TRUE)

#realiza el grafico pedido y utiliza la data rend2, da el var por metodo Gaussiano
chart.BarVaR(ren2,methods=c("GaussianVaR"),main="Comparación de Excepciones", xlab="Date")
