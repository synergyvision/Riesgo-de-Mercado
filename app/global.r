rm(list = ls())

library(shiny)
library(shinydashboard)
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

#los precios promedio se deberan buscar internamente

#Parametros iniciales
#tif
pa=c(0.133799434790145,-0.01,-0.307885339616438,-0.134075672659356,
     0.545398124008073,0.350692201663154)

#vebono
pa1=c(0.135872169451391,0.1,-0.503768911829894,-0.288755056029301,
      0.11951691203874,0.501729233062216)

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