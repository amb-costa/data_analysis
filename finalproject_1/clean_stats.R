# clean_stats: grafico para resumir el proceso de limpieza
# formato grafico de barras apilado: el area dentro de las barras representa la proporcion entre viajes validos e invalidos
# codigo extraido desde https://r-graph-gallery.com/48-grouped-barplot-with-ggplot2.html
# se añade la libreria forcats porque se necesita tratar a los meses como un factor, no vector

library(tidyverse)
library(ggplot2)

# se genera set de datos
meses <- c(rep("Ene",2), rep("Feb",2), rep("Mar",2), rep("Abr",2), rep("May",2), rep("Jun",2), 
         rep("Jul",2), rep("Ago",2), rep("Sep",2), rep("Oct",2), rep("Nov",2), rep("Dic",2))
fc <- c("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic")
mes_fac <- factor(meses, levels=fc)
condicion <- rep(c("Valido", "Invalido"), 12)
valores <- c(c(112242,32631), c(183258,39906), c(228106, 73581), c(294803, 120222), c(437644, 171849), c(492377, 218344),
           c(538936,210026), c(539158,216481), c(535011,286265), c(447745, 168536), c(245255,89820), c(130336, 48036))
datos <- data.frame(mes,condicion,valores)

# Grouped
ggplot(datos, aes(fill=condicion, y=valores, x=mes_fac)) + 
  geom_bar(position="stack", stat="identity") +
  ggtitle("Total de viajes por mes, año 2024") +
  xlab("Meses del Año")+
  ylab("Número de Viajes") +
  geom_text(label=valores, size=3, position = position_stack(vjust = 0.5))+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = c(0.92,0.8),
        legend.background = element_rect(colour="gray"))

