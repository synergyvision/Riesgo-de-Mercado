
#caracteristicas
ca <- Carac("~/Caracteristicas.xls")

#sep
sep18 <- Preciosbcv(ruta = "~/resumersec0918.xls")

sep18 <- formatop(ca,sep18)

#oct
oct18 <- Preciosbcv(ruta = "~/resumersec1018-2.xls")

oct18 <- formatop(ca,oct18)

oct18$`Fecha op` <- as.Date(oct18$`Fecha op`,format="%d/%m/%Y")
oct18$F.Vencimiento <-   as.Date(oct18$F.Vencimiento,format="%d/%m/%Y")
oct18 <- oct18[order(oct18[,3]),]

#nov
nov18 <- Preciosbcv(ruta = "~/resumersec1118.xlsx")

nov18 <- formatop(ca,nov18)  

nov18$`Fecha op` <- as.Date(nov18$`Fecha op`,format="%d/%m/%Y")
nov18$F.Vencimiento <-   as.Date(nov18$F.Vencimiento,format="%d/%m/%Y")
nov18 <- nov18[order(nov18[,3]),]


  
#dic
dic18 <- Preciosbcv(ruta = "~/resumersec_1218.xls")

dic18 <- formatop(ca,dic18)

dic18$`Fecha op` <- as.Date(dic18$`Fecha op`,format="%d/%m/%Y")
dic18$F.Vencimiento <-   as.Date(dic18$F.Vencimiento,format="%d/%m/%Y")
dic18 <- dic18[order(dic18[,3]),]
  
  
#ene  
ene19 <- Preciosbcv(ruta = "~/resumersec_0119.xls")

ene19 <- formatop(ca,ene19)

ene19$`Fecha op` <- as.Date(ene19$`Fecha op`,format="%d/%m/%Y")
ene19$F.Vencimiento <-   as.Date(ene19$F.Vencimiento,format="%d/%m/%Y")
ene19 <- ene19[order(ene19[,3]),]

#feb 
feb19 <- Preciosbcv(ruta = "~/resumersec_0219.xls")

feb19 <- formatop(ca,feb19)

feb19$`Fecha op` <- as.Date(feb19$`Fecha op`,format="%d/%m/%Y")
feb19$F.Vencimiento <-   as.Date(feb19$F.Vencimiento,format="%d/%m/%Y")
feb19 <- feb19[order(feb19[,3]),]


#
data <- rbind.data.frame(oct18,nov18,dic18,ene19,feb19)
data$`Fecha op` <- as.character(data$`Fecha op`)
data$F.Vencimiento <- as.character(data$F.Vencimiento)


Historico_act1 <- Historico_act[-c(2848:2861),]
names(data) <- names(Historico_act)  
H <- rbind.data.frame(Historico_act1,data)

#EXPORTAR H!
write.table(H,paste(getwd(),"app","data","Historico_act.txt",sep = "/"),row.names = FALSE)


#caracteristicas
ca <- Carac("~/29-03-2019.xls")

#Marzo
mar19 <- Preciosbcv(ruta = "~/resumersec_0319.xls")

mar19 <- formatop(ca,mar19)

mar19$`Fecha op` <- as.Date(mar19$`Fecha op`,format="%d/%m/%Y")
mar19$F.Vencimiento <-   as.Date(mar19$F.Vencimiento,format="%d/%m/%Y")
mar19 <- mar19[order(mar19[,3]),]

#Abril
ca <- Carac("~/30-04-2019.xls")

abr19 <- Preciosbcv(ruta = "~/resumersec_0419.xls")

abr19 <- formatop(ca,abr19)

abr19$`Fecha op` <- as.Date(abr19$`Fecha op`,format="%d/%m/%Y")
abr19$F.Vencimiento <-   as.Date(abr19$F.Vencimiento,format="%d/%m/%Y")
abr19 <- abr19[order(abr19[,3]),]

#datalle con rendimiento en Letra del 08/04/19
#existe una operacion de Mayo de Abril, en especifico el 02 de Mayo

#Mayo
may19 <- Preciosbcv(ruta = "~/resumersec_0519.xlsx")

may19 <- formatop(ca,may19)

may19$`Fecha op` <- as.Date(may19$`Fecha op`,format="%d/%m/%Y")
may19$F.Vencimiento <-   as.Date(may19$F.Vencimiento,format="%d/%m/%Y")
may19 <- may19[order(may19[,3]),]

#uno data
data <- rbind.data.frame(mar19,abr19,may19)
data$`Fecha op` <- as.character(data$`Fecha op`)
data$F.Vencimiento <- as.character(data$F.Vencimiento)


#obs #8 con problemas se le asignara
#el problema radica en que la op se llevo a cabo luego de la fecha de venc
#se eliminara obs
#problema con VEBONO el dia 2019-04-11, no sale plazo, error en documento
#se calculo y es 2310 dias, se colocara a mano
data <- data[-c(8,nrow(data)),]
data[9,7]=2310

#Historico_act1 <- Historico_act[-c(2848:2861),]
Historico_act <- read.csv("~/.Trash/Riesgo-de-Mercado/app/data/Historico_act.txt", sep="")
names(data) <- names(Historico_act)  
H <- rbind.data.frame(Historico_act,data)

#EXPORTAR H!
write.table(H,paste(getwd(),"app","data","Historico_act.txt",sep = "/"),row.names = FALSE)


#Caracteristicas por pasos
ruta="~/30-04-2019.xls"



#---------------------------------#
#APOYO LECTURA DOCUMENTO 0-22 
#DETALLE EN ARCHIVO PUES LO TRAE EN FORMATO XLS Y NO EN XLSX COMO DEBERIA SER

#bajo archivo desde la pag del bcv
#ruta
ruta=ruta_bcv("0-22")

s <- unlist(gregexpr(pattern ='/',ruta))
s[length(s)]
nchar(ruta)

nombre <- substring(ruta,(s[length(s)]+1),nchar(ruta))
s1 <- unlist(gregexpr(pattern ="\\.",nombre))
ext <- substring(nombre,s1+1,nchar(ruta))
ext

#bajo archivo
download.file(url=ruta,destfile="/Users/freddytapia/Desktop/0-22.xlsx",method = "internal",mode="wb")

#leo archivo
a <- Preciosbcv("/Users/freddytapia/Desktop/0-22.xlsx")

#prueba con caracteristicas
ruta1=ruta_bcv("caracteristicas")

#bajo archivo
download.file(url=ruta1,destfile="/Users/freddytapia/Desktop/caracteristica.xls",method = "internal",mode="wb")

#leo archivo
a1 <- Carac("/Users/freddytapia/Desktop/caracteristica.xls")


#creo funcion
extension <- function(ruta){
  s <- unlist(gregexpr(pattern ='/',ruta))
  nombre <- substring(ruta,(s[length(s)]+1),nchar(ruta))
  s1 <- unlist(gregexpr(pattern ="\\.",nombre))
  ext <- substring(nombre,s1+1,nchar(ruta))
  return(ext)
}

extension(ruta)
extension(ruta1)
