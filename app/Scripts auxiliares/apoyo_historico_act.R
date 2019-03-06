
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

H <- rbind.data.frame(Historico_act1,data)


#prueba marzo
mar19 <- Preciosbcv(ruta = "~/resumersec_0319.xls")

mar19 <- formatop(ca,mar19)
