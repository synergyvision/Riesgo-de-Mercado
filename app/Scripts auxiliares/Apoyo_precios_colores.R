library(flextable)
library(magrittr)

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

for(i in 1:nrow(z)){
c1 <- as.numeric(z[i,])
co <- c(co,c1)
}

co[co==0] <- 2

col_palette <- c("red","blue")


mycolors <- col_palette[co]

flextable(pre_tif) %>%
  bg(bg = mycolors)
