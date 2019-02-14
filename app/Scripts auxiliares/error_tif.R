#prueba NS TIF error
source('~/.Trash/Riesgo-de-Mercado/app/funciones.R')

#cargo imputs
pa_ns <-c(0.133799434790145,-0.01,-0.307885339616438,0.545398124008073)
Ca <- Carac(paste(getwd(),"app","data","Caracteristicas.xls",sep = "/"))
fv <- as.Date("2018-02-13")
tit <- c("TIF082019","TIF102020","TIF042019")
pr <- c(0,0,118.6156375)

precio <- Tabla.ns(fv = fv ,tit =tit,pr =pr ,pa = pa_ns,ind = 0,C = Ca ,fe2=0,fe3=0)[[1]] 
