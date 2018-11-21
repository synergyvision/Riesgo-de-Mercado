rm(list = ls())

#cargo librerias a usar
library(shiny)
library(readr)

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

options(OutDec = ",")


#TIF iniciales
tit=c("TIF082018","TIF042019","TIF082019",
      "TIF112019","TIF102020","TIF112020","TIF022021","TIF032022","TIF042023",
      "TIF012024","TIF062025","TIF012026","TIF112027","TIF032028","TIF052028",
      "TIF022029","TIF032029","TIF022030","TIF102030","TIF022031","TIF032031",
      "TIF022032","TIF032032","TIF032033","TIF052034")

#VEBONOS iniciales
tit1=c("VEBONO072018","VEBONO022019","VEBONO032019","VEBONO042019","VEBONO102019","VEBONO012020",
       "VEBONO062020","VEBONO092020","VEBONO112020","VEBONO012021","VEBONO052021",
       "VEBONO122021","VEBONO022022","VEBONO012023","VEBONO022024","VEBONO042024",
       "VEBONO012025","VEBONO022025","VEBONO062026","VEBONO032027","VEBONO042028",
       "VEBONO102028","VEBONO052029","VEBONO102029","VEBONO072030","VEBONO032031",
       "VEBONO062032","VEBONO072033","VEBONO022034")

#Precios promedio
#precios 11-08 - tif
pr=c(101,112,110,121.0234,116.5251,130.0234,
     129.0156,125.0626,128.1000,120,124,122,126.5234,128.5235,128.1913,
     129,132.0391,128.5235,129.8875,130.1,128.5313,127,128.5235,127.0156,
     127.0156)

#names(pr) <- tit

#defino vector de precios donde tengo nombre de titulo
p_t <- cbind.data.frame(tit,pr)
#p_t <- t(pr)

#precios 11-08 - veb
pr1=c(100.4,106,110,111,118,121,
      127.8376,102.2,117,130.3269,127,129.45,129,129.9627,128,129,129.1875,
      128.5,102,129.9469,129.6807,130.0156,125.0313,125.75,130.5,129.5235,
      128.5313,130,128.0235)

#defino vector de precios donde tengo nombre de titulo
p_v <- cbind.data.frame(tit1,pr1)

#Defino funcion para extraer precios promedios segun tit considerados
pos <- function(t,ind){
p1 <- c()
#caso tif
if(ind==0){
for(i in 1:length(t)){
  p1[i] <- pr[which(t[i]==p_t$tit)]
}
}#final caso tif
#caso veb
if(ind==1){
  for(i in 1:length(t)){
    p1[i] <- pr1[which(t[i]==p_v$tit1)]
  }
}#final caso veb
names(p1) <- t
return(p1)
}#final funcion pos


#Defino función para extraer precios promedio del archivo en la carpeta data
pos1 <- function(t,ind){
  #caso tif
  if(ind==0){
    tif <- read.csv(paste(getwd(),"data","Precio_prom_tif.txt",sep = "/"),sep="")
    tif$Títulos <- as.character(tif$Títulos)
    p <- c()
    
    #condicional de existencia
    for(i in 1:length(t)){
      if(length(which(t[i]==tif$Títulos))!=0){
           p[i] <- tif$Precio.Promedio[which(t[i]==tif$Títulos)]
      }else{
        #print("Titulo no encontrado")
        p[i] <- 0
      }
    }
    
    names(p) <- t
    return(p)
    
    
    } #final if tif
    
  
  #caso veb
  if(ind==1){
    veb <- read.csv(paste(getwd(),"data","Precio_prom_veb.txt",sep = "/"),sep="")
    veb$Títulos <- as.character(veb$Títulos)
    
    p <- c()
    #condicional de existencia
    for(i in 1:length(t)){
      if(length(which(t[i]==veb$Títulos))!=0){
        p[i] <- veb$Precio.Promedio[which(t[i]==veb$Títulos)]
      }else{
        #print("Titulo no encontrado")
        p[i] <- 0
      }
    } 
    
    names(p) <- t
    return(p)
    
  }
  
  
  
}#final funcion pos1


#Parametros iniciales
#tif
pa_sven=c(0.133799434790145,-0.01,-0.307885339616438,-0.134075672659356,
    0.545398124008073,0.350692201663154)

names(pa_sven) <- c("B0","B1","B2","B3","T1","T2")
#names(pa) <- c("$$\beta_{0}$$","$$\\beta_{1}$$","$$\\beta_{2}$$","$$\\beta_{3}$$","$$\\tau_{1}$$","$$\\tau_{2}$$")

#pa <- xtable(as.data.frame(pa))

pa_ns=c(0.133799434790145,-0.01,-0.307885339616438,0.545398124008073)

names(pa_ns) <- c("B0","B1","B2","T1")

#vebono
pa1_sven=c(0.135872169451391,0.1,-0.503768911829894,-0.288755056029301,
      0.11951691203874,0.501729233062216)

names(pa1_sven) <- c("B0","B1","B2","B3","T1","T2")

pa1_ns <- c(0.135872169451391,0.1,-0.503768911829894,0.11951691203874)

names(pa1_ns) <- c("B0","B1","B2","T1")

#leo documento caracteristicas
#source('C:/Users/Freddy Tapia/Riesgo-de-Mercado/app/funciones.R')
source(paste(getwd(),"funciones.R",sep = "/"))
#C <- Carac("C:/Users/Freddy Tapia/Desktop/29-06-18.xls")
#C <- Carac(paste(getwd(),"data","29-06-18.xls",sep = "/"))
C <- read.csv(paste(getwd(),"data","C.txt",sep = "/"), sep="")
names(C) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
              "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
              "Pago cupon 2","Cupon")

#carateristica Splines
C_splines <- read.csv(paste(getwd(),"data","C_splines.txt",sep = "/"), sep="")
names(C_splines) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
              "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
              "Pago cupon 2","Cupon")

#cargo data de prueba 0-22
data_splines <- read.csv(paste(getwd(),"data","Data_splines.txt",sep = "/"), sep="")
data_splines$Fecha.op <- as.Date(as.character(data_splines$Fecha.op))

datatif <- data_splines[which(data_splines$Tipo.Instrumento=="TIF"),]
datatif <- arrange(datatif,desc(Fecha.op))
datatif$F.Vencimiento <- as.Date(datatif$F.Vencimiento,format="%d/%m/%Y")
datatif$year <- year(datatif$F.Vencimiento)
datatif$segmento <- cut(datatif$year,breaks = c(2015,2019,2030,2038),labels = c("Corto Plazo","Mediano Plazo","Largo Plazo"))
datatif$segmento1 <- cut(datatif$year,breaks = c(2015,2017,2019,2025,2030,2033,2035,2038),labels = c("C1","C2","M1","M2","L1","L2","L3"))

#TEXTOS
############################################# DATA ###############################################

UPLOADDATA_TEXT<-"Cargar el archivo con los datos"
SELECTFILE_TEXT<-'Seleccione el archivo'
FILESELEC_TEXT<-'Aun no seleccionas el archivo...'
BUTTSELEC_TEXT<-'Buscar'
WITHHEADER_TEXT<-"Con encabezado"
SEPARATOR_TEXT<-"Separador"
COMILLAS_TEXT<-"Comillas"
ENCABEZADO_TEXT<-"Encabezado de los datos"

UPLOADFILETYPE_CONF<-c('text/csv',
                       'text/comma-separated-values',
                       'text/tab-separated-values',
                       'text/plain',
                       '.csv',
                       '.tsv')

UPLOADFILESEP_CONF<-c('Coma'=',',
                      'Punto y coma'=';',
                      'Tab'='\t')

UPLOADCOMILLAS_CONF<-c('Ninguna'='',
                       'Comilla doble'='"',
                       'Comilla simple'="'")

# Encabezado Vision
VisionHeader <- function(){tags$head(
  tags$link(rel = "stylesheet", type = "text/css", href = "app.css"),
  tags$img(src="img/vision1.png" , id = "VisionLogo", width = 130 ),
  singleton(includeScript("www/js/d3.js")),
  singleton(includeScript("www/js/underscore.js")),
  singleton(includeScript("www/js/jquery-ui.js")),
  singleton(includeCSS("www/css/app.css"))
)}

ACERTITLE_TEXT<-"Acerca de VisionRisk™"
ACERSUBSV_TEXT<-"Tecnología para Especulación, Inversión, Economía, Finanzas y Riesgo"
ACERVER_TEXT<-"Versión: 0.0.0"
ACERRIF_TEXT<-"Rif: "
ACERRS_TEXT<-"Copyright © 2014-2018 Synergy Vision"
ACERRS_TEXT2 <- "All Rights Reserved"
ACERDIR_TEXT<-"Centro Gerencial Mohedano, La Castellana"
ACERTLF_TEXT<-"0212-2630808 / 0414-2769752"
ACERCORR_TEXT<-"contacto@synergy.vision"