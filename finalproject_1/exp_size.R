# exp_size: total de filas en cada archivo .csv para Preparar
# se necesita la librería forcats (en tidyverse) para tratar al eje x como vector

library("tidyverse")
library("ggplot2")

# se copia el dataframe general de clean_table.R
# datos <- matriz de formato [filas,columnas] = [meses, totales]
datos <- data.frame (
  meses <- c("Ene", "Feb", "Mar", "Abr", "May", "Jun", 
             "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"),
  totales <- c(144873, 223164, 301687, 415025, 609493, 710721,
              748962, 755639, 821276, 616281, 335075, 178372)
)

# Ploteo de los datos: gráfico de barras clásico
ggplot(datos, aes(x = factor(meses, levels = unique(meses)), y = totales)) + 
  geom_bar(position = "dodge", stat = "identity", fill = "aquamarine4") +
  scale_y_continuous(limits = c(0,850000), n.breaks = 7) + 
  ggtitle("Viajes Registrados por Mes, año 2024",
          subtitle = "Total de Filas por archivo .csv") +
  xlab("Mes del Año") +
  ylab("Total de Filas") +
  geom_text(label = totales, size = 2, vjust = 2, color = "white")+
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
        )

