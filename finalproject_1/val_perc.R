# val_perc: proporcion de viajes válidos vs inválidos
# formato gráfico de barras apilado: una barra contiene ambas condiciones de datos
# la etiqueta describe el porcentaje de la condición
# para una etiqueta con valores numéricos, ver val_prop.R
# codigo extraido desde https://r-graph-gallery.com/48-grouped-barplot-with-ggplot2.html
# se añade la libreria forcats porque se necesita tratar a los meses como un factor, no vector

library(tidyverse)
library(ggplot2)

# se genera set de datos
meses <- c(rep("Ene",2), rep("Feb",2), rep("Mar",2), rep("Abr",2), rep("May",2), rep("Jun",2), 
           rep("Jul",2), rep("Ago",2), rep("Sep",2), rep("Oct",2), rep("Nov",2), rep("Dic",2))
mes_fac <- factor(meses, levels=unique(meses))
condicion <- rep(c("Válido", "Inválido"), 12)
porcentajes <- c(c(77.476,22.524), c(82.118,17.882), c(75.61,24.39), c(71.033,28.967), c(71.805,28.195),
                 c(69.279,30.721), c(71.958,28.042), c(71.351,28.649), c(65.144,34.856), c(72.653,27.347), 
                 c(73.194, 26.806),c(73.07,26.93))
datos <- data.frame(mes_fac,condicion,porcentajes)

# Grouped
ggplot(datos, aes(x=mes_fac, y=porcentajes, fill=factor(condicion))) + 
  geom_bar(position="fill", stat="identity") +
  ggtitle("Proporción de Viajes Válidos por Mes, año 2024",
          subtitle="Porcentaje de datos válidos vs inválidos") +
  xlab("Meses del Año") +
  ylab("Porcentaje del Total de Viajes") +
  labs(fill= "Condición") +
  geom_text(label=porcentajes, size=3, position = position_fill(vjust = 0.5))+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        legend.background = element_rect(colour="gray"))

