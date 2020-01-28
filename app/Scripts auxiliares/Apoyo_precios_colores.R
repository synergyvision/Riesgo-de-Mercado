library(flextable)
library(magrittr)
library(dplyr)
library(tidyverse)


col_palette <- c("#D73027", "#F46D43", "#FDAE61", "#FEE08B", 
                 "#D9EF8B", "#A6D96A", "#66BD63", "#1A9850")

cor_matrix <- cor(mtcars)

mycut <- cut(
  cor_matrix, 
  breaks = c(-1, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1), 
  include.lowest = TRUE, label = FALSE)

mycolors <- col_palette[mycut]

df <- data.frame(rowname = row.names(cor_matrix), stringsAsFactors = FALSE) %>%
  cbind(cor_matrix) 

flextable(df) %>%
  bg(j = colnames(cor_matrix), bg = mycolors) %>%
  align(align = "center", part = "all") %>%
  compose(i = 1, j = 1, value = as_paragraph(""), part = "header")



###########
Historico <- read.csv("~/Riesgo-de-Mercado/app/data/Historico_act.txt", sep="")

tif <- Historico[Historico$Tipo.Instrumento=="TIF",]

tit_tif <- as.factor(as.character(tif$Nombre))
  
pre_tif <- as.data.frame(matrix(0,nrow = length(levels(as.factor(as.character(tif$Fecha.op)))),ncol = length(levels(tit_tif))))
names(pre_tif) <- levels(tit_tif)
row.names(pre_tif) <- levels(as.factor(as.character(tif$Fecha.op)))

#pre_tif <- rownames_to_column(pre_tif,"Fechas")

#RELLENO INFORMACION CON HISTORICO 0-22
for(i in 1:nrow(pre_tif)){

a <- c()

for(j in 1:ncol(pre_tif)){
  a1 <- which(row.names(pre_tif)[i]==tif$Fecha.op & names(pre_tif)[j]==tif$Nombre) 
  
  if(length(a1)!=0){
    a[j] <- a1
  }else{
    a[j] <- 0
  }
  
}

pre_tif[i,which(a!=0)] <- tif$Pre.prom[a]

}


#PONGO COLOR
#NO NULOS
z <- pre_tif

for(i in 1:nrow(pre_tif)){
  z1 <- which(pre_tif[i,]!=0)
  z[i,z1] <- 1
}

#

co <- c()

for(i in 1:ncol(z)){
c1 <- as.numeric(z[,i])
co <- c(co,c1)
}

co[co==0] <- 2

co <- c(rep(3,nrow(pre_tif)),co)

col_palette <- c("blue","white","red")


mycolors <- col_palette[co]

flextable(rownames_to_column(pre_tif,"Fechas")) %>%
  bg(bg = mycolors)

#CREO FUNCION 
tabla_color <- function(Historico,tipo_tit,colores){
  
  tif <- Historico[Historico$Tipo.Instrumento==tipo_tit,]
  
  tit_tif <- as.factor(as.character(tif$Nombre))
  
  pre_tif <- as.data.frame(matrix(0,nrow = length(levels(as.factor(as.character(tif$Fecha.op)))),ncol = length(levels(tit_tif))))
  names(pre_tif) <- levels(tit_tif)
  row.names(pre_tif) <- levels(as.factor(as.character(tif$Fecha.op)))
  
  #RELLENO INFORMACION CON HISTORICO 0-22
  for(i in 1:nrow(pre_tif)){
    
    a <- c()
    
    for(j in 1:ncol(pre_tif)){
      a1 <- which(row.names(pre_tif)[i]==tif$Fecha.op & names(pre_tif)[j]==tif$Nombre) 
      
      if(length(a1)!=0){
        a[j] <- a1
      }else{
        a[j] <- 0
      }
      
    }
    
    pre_tif[i,which(a!=0)] <- tif$Pre.prom[a]
    
  }
  
  
  #PONGO COLOR
  #NO NULOS
  z <- pre_tif
  
  for(i in 1:nrow(pre_tif)){
    z1 <- which(pre_tif[i,]!=0)
    z[i,z1] <- 1
  }
  
  #
  
  co <- c()
  
  for(i in 1:ncol(z)){
    c1 <- as.numeric(z[,i])
    co <- c(co,c1)
  }
  
  co[co==0] <- 2
  
  co <- c(rep(3,nrow(pre_tif)),co)
  
  col_palette <- colores
  
  
  mycolors <- col_palette[co]
  
  a <- flextable(rownames_to_column(pre_tif,"Fechas")) %>%
    bg(bg = mycolors)
  
  return(a)
}

#TIF
t <- tabla_color(Historico = Historico,tipo_tit = "TIF",colores = c("#1f77b4","#ff7f0e","#2ca02c"))
t

v <- tabla_color(Historico = Historico,tipo_tit = "VEBONO",colores = c("blue","white","#d62728"))
v



#COLORES USANDO DT
library(DT)
#options(DT.options = list(pageLength = 10))
df = as.data.frame(cbind(matrix(round(rnorm(50), 3), 10), sample(0:1, 10, TRUE)))
# style V6 based on values of V6
datatable(df) %>% formatStyle(
  'V6',
  backgroundColor = styleEqual(c(0, 1), c('gray', 'yellow'))
)


# create 19 breaks and 20 rgb color values ranging from white to red
brks <- quantile(df, probs = seq(.05, .95, .05), na.rm = TRUE)
clrs <- round(seq(255, 40, length.out = length(brks) + 1), 0) %>%
  {paste0("rgb(255,", ., ",", ., ")")}
datatable(df) %>% formatStyle(names(df), backgroundColor = styleInterval(brks, clrs))

#EJEMPLO TIF
a <- styleEqual("0", "orange")
a[1] <- "value != \"0\" ? \"orange\" : value"

#!ESTE FUNCIONA!!!!
datatable(pre_tif) %>% 
  formatStyle(names(pre_tif), backgroundColor = a)


datatable(pre_tif) %>% 
  formatStyle(names(pre_tif), backgroundColor = styleColorBar(co, "red"))

#COLOREAR UNA CELDA ESPECIFICA
datatable(iris) %>% formatStyle(
  .,
  columns = c(1),
  valueColumns = 0,
  target = 'cell',
  backgroundColor = styleEqual(c(1,3), c('red','blue'))
 )  %>% formatStyle(
   .,
   columns = c(2),
   valueColumns = 0,
   target = 'cell',
   backgroundColor = styleEqual(c(2), c('orange'))
 )

b <- formatStyle( datatable(iris)
  ,
  columns = c(1),
  valueColumns = 0,
  target = 'cell',
  backgroundColor = styleEqual(c(1,3), c('red','blue'))
)

b
#CREO FUNCION
colores <- function(i){
  if(i==1){
    return(styleEqual(c(1,3), rep("blue",2)))
  }else if(i==2){
    return(styleEqual(c(2), c('orange')))
  }
}

#INICIALIZO VARIABLE
a <- datatable(iris)

for(i in c(1,2)){
a <- formatStyle( a,
             columns = names(iris)[i],
             valueColumns = 0,
             target = 'cell',
             backgroundColor = colores(i)
)
}

a

#PRUEBA TIF
#INICIALIZO VARIABLE
a1 <- datatable(pre_tif)


#CREO FUNCION PARA OBTENER VALORES NO NULOS DE CADA COLUMNA
indice_col <- function(i){
  z1 <- which(pre_tif[,i]!=0)
  return(styleEqual(row.names(pre_tif)[z1], rep("red",length(z1))))
}



for(i in c(1,2)){
  a1 <- formatStyle(a1,
                    columns = i,
                    valueColumns = 0,
                    target = 'cell',
                    backgroundColor = indice_col(i)
  )
}

a1
#EJEMPLO VENBONOS
