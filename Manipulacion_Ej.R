# Ejemplo práctico manipulacion de datos en R usando dplyr y tidyr
# Instalar y cargar el tidyverse
if (!require("tidyverse")) install.packages("tidyverse")

# Crear un data frame de ejemplo
datos <- data.frame(
  nombre = c("Juan", "Ana", "Luis", "María"),
  edad = c(18, 22, 20, 19),
  peso = c(70, 55, 80, 60),
  altura = c(1.75, 1.60, 1.80, 1.65)
)

# Filtrar estudiantes con peso mayor a 65 kg
estudiantes_pesados <- datos %>% 
  filter(peso > 65)

# Seleccionar columnas específicas (nombre y edad)
datos_reducidos <- datos %>%
  select(nombre, edad)

# Crear nuevas columnas (calcular el IMC)
datos <- datos %>%
  mutate(IMC = peso / (altura^2)).

# Agrupar y resumir datos (calcular peso promedio por grupo de edad)
peso_promedio <- datos %>%
  mutate(grupo_edad = ifelse(edad >= 20, "Mayor o igual a 20", "Menor a 20")) %>%
  group_by(grupo_edad) %>%
  summarize(peso_promedio = mean(peso))

# Uso de pipes para facilitar la manipulacion de datos
# Crear columna grupo_edad usando mutate
datos <- datos %>%
  mutate(grupo_edad = ifelse(edad >= 20, "Mayor o igual a 20", "Menor a 20")) 
# Agrupar y resumir los datos sin pipes
resultado <- summarize(group_by(datos, grupo_edad), peso_promedio = mean(peso))

# Agrupar y resumir los datos con pipes
resultado <- datos %>%   
  group_by(grupo_edad) %>%   
  summarize(peso_promedio = mean(peso))

# Explicacion de tidyr
# Data frame de ejemplo
calificaciones <- data.frame(
  nombre = c("Juan", "Ana", "Luis"),
  matematicas = c(85, 90, 78),
  ciencias = c(88, 92, 80)
)

# Transformar a formato largo
library(tidyr)
calificaciones_largo <- calificaciones %>%
  pivot_longer(cols = c(matematicas, ciencias), 
               names_to = "materia", 
               values_to = "calificacion")
calificaciones_largo

# Transformar de vuelta a formato ancho
calificaciones_ancho <- calificaciones_largo %>%
  pivot_wider(names_from = "materia", values_from = "calificacion")
calificaciones_ancho
