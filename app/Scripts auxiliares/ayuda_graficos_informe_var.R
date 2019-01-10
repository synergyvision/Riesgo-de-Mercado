mydata <- data.frame(group=c("A", "B", "0", "AB"), FR=c(20, 32, 32, 16)) 

s <- ggplot(mydata, aes(x ="", y=FR,fill=factor(group))) + geom_bar(width = 1,stat="identity")+coord_polar(theta = "y") 


pie <- cbind.data.frame(posicion_tif[,1],posicion_tif[,2])
names(pie) <- c("Titulo","nominal")

p <- plot_ly(pie, labels = ~Titulo, values = ~nominal, type = 'pie') %>%
  layout(title = 'Valor nominal',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))


#ejemplo
df <- data.frame(
  group = c("Male", "Female", "Child"),
  value = c(25, 25, 50)
)
head(df)

library(ggplot2)
# Barplot
bp<- ggplot(df, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
bp

pie <- bp + coord_polar("y", start=0)
pie

library(scales)
pie + scale_fill_grey()  +
  theme(axis.text.x=element_blank()) +
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), 
                label = percent(value/100)), size=5)


#mi caso

# Barplot
bp<- ggplot(posicion_tif, aes(x="", y=valor_nominal, fill=titulo))+
  geom_bar(width = 1, stat = "identity")
bp

pie <- bp + coord_polar("y", start=0)
pie

pie + scale_fill_grey()  +
  theme(axis.text.x=element_blank()) +
  geom_text(aes(label = percent(valor_nominal/100)), size=3)



#alternativa
# Load dataset from github
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/7_OneCatOneNum.csv", header=TRUE, sep=",")

# plot
data %>%
  filter(!is.na(Value)) %>%
  arrange(Value) %>%
  mutate(Country=factor(Country, Country)) %>%
  ggplot( aes(x=Country, y=Value) ) +
  geom_segment( aes(x=Country ,xend=Country, y=0, yend=Value), color="grey") +
  geom_point(size=3, color="#69b3a2") +
  coord_flip() +
  theme(
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_blank(),
    legend.position="none"
  ) +
  xlab("")


#mi caso

posicion_tif  %>%
  arrange(valor_nominal) %>%
  mutate(Titulo=factor(titulo, titulo)) %>%
  ggplot( aes(x=Titulo, y=valor_nominal) ) +
  geom_segment( aes(x=Titulo ,xend=Titulo, y=0, yend=valor_nominal), color="grey") +
  geom_point(size=3, color="#69b3a2") +
  coord_flip() +
  theme(
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_blank(),
    legend.position="none"
  ) +
  xlab("")


