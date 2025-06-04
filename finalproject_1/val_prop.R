# val_prop: número de viajes válidos vs inválidos
# para un gráfico con los valores numéricos en vez de porcentajes, ver val_perc.R
# se necesita la librería forcats (en tidyverse) para tratar al eje x como vector

library(tidyverse)
library(ggplot2)

# se genera set de datos
meses <- c(rep("Ene",2), rep("Feb",2), rep("Mar",2), rep("Abr",2), rep("May",2), rep("Jun",2), 
           rep("Jul",2), rep("Ago",2), rep("Sep",2), rep("Oct",2), rep("Nov",2), rep("Dic",2))
mes_fac <- factor(meses, levels=unique(meses))
condicion <- rep(c("Válido", "Inválido"), 12)
valores <- c(c(112242,32631), c(183258,39906), c(228106, 73581), c(294803, 120222), c(437644, 171849), c(492377, 218344),
             c(538936,210026), c(539158,216481), c(535011,286265), c(447745, 168536), c(245255,89820), c(130336, 48036))
datos <- data.frame(mes_fac,condicion,valores)

# Grouped
ggplot(datos, aes(x=mes_fac, y=valores, fill=factor(condicion))) + 
  geom_bar(position="fill", stat="identity") +
  ggtitle("Proporción de Viajes Válidos por Mes, año 2024") +
  xlab("Meses del Año") +
  ylab("Porcentaje del Total de Viajes") +
  labs(fill= "Condición") +
  geom_text(label=valores, size=3, position = position_fill(vjust = 0.5))+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.background = element_rect(colour="gray"))

