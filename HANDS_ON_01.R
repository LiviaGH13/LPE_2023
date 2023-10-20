# SCRIPT + STUDENT INFO ---------------------------------------------------
# NOMBRE: LIVIA GAMERO HAMMERER
# EXP: 22062293
# TEMA: HANDS_ON_01



# LOADING LIBS ------------------------------------------------------------
install.packages(c("tidyverse", "dplyr", "janitor"))
install.packages(c("xlsx"))
install.packages(c("leaflet"))
library("dplyr","janitor","readr", "xlsx")
library("tidyverse")
library("leaflet")
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
gas_max <- cd %>% select(precio_gasoleo_a, rotulo, direccion, provincia) %>% filter(provincia == "MADRID") %>% arrange(precio_gasoleo_a) 

# STORING DATA ------------------------------------------------------------
write.csv(gas_max, "gas_max.csv")
xlsx::write.xlsx(gas_max, "gas_max.xlsx")


# GENERANDO REPORTES ------------------------------------------------------

gas_mad_1_55 <-cd %>%  select(rotulo,precio_gasoleo_a,direccion,provincia,municipio,latitud,longitud_wgs84) %>% 
  filter(provincia == "MADRID" & precio_gasoleo_a<1.55) %>% arrange(desc(precio_gasoleo_a)) %>% write_excel_csv2("gas_mad_1_55.xls")

gas_mad_1_55 %>% leaflet() %>% addTiles() %>% 
  addCircleMarkers(lat = ~latitud, lng = ~longitud_wgs84, popup = ~rotulo, label =~precio_gasoleo_a)

# FILTRO GASOLINERA -------------------------------------------------------

BALLENOIL_MADRID <- cd %>% select(precio_gasoleo_a,rotulo,direccion,localidad,municipio,provincia,latitud,longitud_wgs84) %>%  
  filter(provincia =="MADRID" & rotulo=="BALLENOIL") %>% 
  arrange(precio_gasoleo_a) %>% glimpse()  

low_cost <- cd %>% select(precio_gasoleo_a,rotulo,direccion,localidad,municipio,provincia) %>% 
  filter(provincia =="MADRID") %>% group_by(rotulo) %>% arrange(mean(precio_gasoleo_a)) %>% glimpse()

# DEALING W COLS ----------------------------------------------------------

cd %>% mutate(low_cost = !rotulo %in% c("REPSOL", "CEPSA","Q8","SHELL","CAMPSA","GALP","BP")) %>% view()

gas_stefan <-cd %>%  select(rotulo,precio_gasoleo_a,direccion,provincia,localidad) %>% 
  filter(provincia == "TOLEDO" & localidad == "CUERVA") 






media_por_rotulo <- aggregate(precio_gasoleo_a ~ rotulo, data = cd, FUN = mean)
media_por_rotulo <- media_por_rotulo %>% rename(media_por_rotulo = precio_gasoleo_a)
print(media_por_rotulo)
cd_nuevo <- cd %>% left_join(media_por_rotulo, by = "rotulo")

media <- cd %>% summarise(media = mean(precio_gasoleo_a,na.rm = TRUE))
print(media)
#cd_nuevo <- cd_nuevo %>% mutate(media_total = media)

cd_nuevo <- cd_nuevo %>% mutate(lowcost = precio_gasoleo_a < media_por_rotulo) 
#cd_nuevo <- subset(cd_nuevo, select = -precio_gasoleo_a.y)
cd_nuevo %>% glimpse()

cd_nuevo %>% write_excel_csv2("LOW_COST.xls")


