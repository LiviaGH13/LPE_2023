# SCRIPT + STUDENT INFO ---------------------------------------------------
# NOMBRE: LIVIA GAMERO HAMMERER
# EXP: 22062293
# TEMA: HANDS_ON_01


# LOADING LIBS ------------------------------------------------------------
install.packages(c("tidyverse", "dplyr", "janitor"))
library("dplyr","janitor","readr")


# LOADING DATA ------------------------------------------------------------
exp_22062293 <- jsonlite::fromJSON("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")


# SHORTCUTS ---------------------------------------------------------------

# limpiar consola = CTRL + l
# %>% pipe operator = SHIFT + CTRL + M
# CTRL + ENTER = ejecutar
# SHIFT + CTRL + R = Indice

# GIT COMMANDS ------------------------------------------------------------

# pwd = current location
# git status = info about a repo
# git commit = Add a comment
# git add . = Add the current dir to the entire repo
# git push -u origin main = send to the remote repo (Github)
# %>% para pasar el flijo entre diferentes códigos que voy a utilizar

# CLI COMMANDS ------------------------------------------------------------

# pwd = shows the current dir
# ls = list terminal 
# mkdir = create a dir
# cd = change dir
# clear = limpiar terminal

# BASIC INSTRUCTIONS ------------------------------------------------------

isa <- 8 # assigning values


# TIDYVERSE COMMANDS ------------------------------------------------------


# 27 SEPTIEMBRE -----------------------------------------------------------

str(exp_22062293) #get datatype
df <- exp_22062293$ListaEESSPrecio #get readable data
df %>% glimpse()
df %>% janitor::clean_names() %>% glimpse()
# fin de la clase de hoy. Siguiente hacemos la entrega


# WORKING W PIPE (OPT. MODE) ----------------------------------------------
clean_data <- df %>% janitor::clean_names() %>% glimpse()
cd <- df %>% readr::type_convert(locale = readr::locale(decimal_mark=",")) %>% janitor::clean_names()
cd %>% glimpse()


# DEALING W DATA ----------------------------------------------------------

villa_boa_gas <- cd %>% select(precio_gasoleo_a, rotulo, direccion, localidad) %>% 
  filter(localidad=="VILLAVICIOSA DE ODON" | localidad== "BOADILLA DEL MONTE") %>% 
  arrange(precio_gasoleo_a) %>% View()
MIN <- cd %>% select(min(precio_gasoleo_a, na.rm = FALSE))
gas_max <- cd %>% select(precio_gasoleo_a, rotulo, direccion, provincia) %>% filter(provincia == "MADRID") %>% arrange(precio_gasoleo_a) 
  
  