#PROCESO PARA ACTUALIZAR HISTORICO 0-22
#SCRPIT A EJECUTAR
#cargo funciones
#cargo librerias a usar
library(shiny)
library(readr)
library(rriskDistributions)
library(fitdistrplus)
library(shinydashboard)
library(dplyr)
library(lubridate)
library(ggplot2)
library(reshape2)
library(jrvFinance)
library(plotly)
library(rbokeh)
#library(reshape2)
#library(xlsx)
library(nloptr)
library(alabama)
library(DT)
library(xtable)
library(webshot)
library(readxl)
library(xml2)
library(rvest)
library(VaRES)
library(lmomco)


source(paste(getwd(),".Trash/Riesgo-de-Mercado",'app/funciones.R',sep="/"))


#descargo archivos
a <- ruta_bcv("caracteristicas")
print(a)
print(ruta_bcv("0-22"))


#a <-  "http://www.bcv.org.ve/sites/default/files/3_1_2.xls"
download.file(url=a,destfile=paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("Caracteristicas.",extension(a)),sep = "/"),method = "internal",mode="wb")
download.file(url=ruta_bcv("0-22"),destfile=paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("0-22.",extension(ruta_bcv("0-22"))),sep = "/"),method = "internal",mode="wb")


#ca <- try(Preciosbcv(paste(getwd(),"data","0-22.xls",sep = "/")))
ca <- try(Preciosbcv(paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("0-22.",extension(ruta_bcv("0-22"))),sep = "/")))
#ca1 <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
#ca1 <- try(Carac(paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("Caracteristicas.",extension(ruta_bcv("caracteristicas"))),sep = "/")))
ca1 <- try(Carac(paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("Caracteristicas.","xls"),sep = "/")))



ca2 <- formatop(ca1,ca)
  #convierto fecha de op y venc en fechas
  ca2$`Fecha op` <- as.Date(as.character(ca2$`Fecha op`),format="%d/%m/%Y")
  ca2$F.Vencimiento <- as.Date(as.character(ca2$F.Vencimiento),format="%d/%m/%Y")

  #este data frame es el que utiliza la metodologia Spline para los calculos
  ca3 <- dplyr::arrange(ca2,(`Fecha op`))

  #guardo historico_actualizado
  hist <- read.csv(paste(getwd(),".Trash/Riesgo-de-Mercado","app","data","Historico.txt",sep = "/"),sep="")
  hist[,3] <- as.Date(as.character(hist[,3]))
  hist[,6] <- as.Date(as.character(hist[,6]))


  names(ca3)=names(hist)
  #print(str(ca3))
  #print(str(hist))

  hist_act <- rbind.data.frame(hist,ca3)


  write.table(hist_act,paste(getwd(),".Trash/Riesgo-de-Mercado","app","data","Historico_act.txt",sep = "/"),row.names = FALSE)

 # return(ca3)
  