# val_perc: proporcion de viajes válidos vs inválidos
# para un gráfico con los valores numéricos en vez de porcentajes, ver val_prop.R
# se necesita la librería forcats (en tidyverse) para tratar al eje x como vector

library(tidyverse)
library(ggplot2)

# se copia el dataframe general de clean_table.R
# con esto, se calculan porcentajes para graficar en formato (valido, invalido)
totales <- c(144873, 223164, 301687, 415025, 609493, 710721,
             748962, 755639, 821276, 616281, 335075, 178372)
validos <- c(112242, 183258, 228106, 294803, 437644, 492377,
             538936, 539158, 535011, 447745, 245255, 130336)
invalidos <- c(32631, 39906, 73581, 120222, 171849, 218344,
               210026, 216481, 286265, 168536, 89820, 48036)

# datos <- matriz de formato [meses, condicion, porcentajes]
# porcentajes es un vector traspuesto de un dataframe
# este df principal tiene formato [% válido, % inválido]
datos <- data.frame(
  meses <- c(rep("Ene",2), rep("Feb",2), rep("Mar",2), rep("Abr",2), rep("May",2), rep("Jun",2), 
             rep("Jul",2), rep("Ago",2), rep("Sep",2), rep("Oct",2), rep("Nov",2), rep("Dic",2)),
  condicion <- c("Válido", "Inválido"),
  porcentajes <- as.vector(t(data.frame(round(100 * validos/totales, digits = 3),
                                       round(100 *invalidos/totales, digits = 3))))
  )

# Ploteo de los datos = gráfico de barras proporcional
ggplot(datos, aes(x=factor(meses, levels=unique(meses)), y=porcentajes, fill=rep(condicion,12))) + 
  geom_bar(position="fill", stat="identity") +
  ggtitle("Gráfico de Validez de Viajes por Mes, año 2024",
          subtitle="Porcentaje de datos válidos contra inválidos") +
  xlab("Meses del Año") +
  ylab("Porcentaje del Total de Viajes") +
  labs(fill= "Condición \n(en %)") +
  geom_text(label=percentage, size=3, position = position_fill(vjust = 0.5))+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        legend.background = element_rect(colour="gray"))

