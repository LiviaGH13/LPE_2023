# SCRIPT + STUDENT INFO ---------------------------------------------------
# NOMBRE: LIVIA GAMERO HAMMERER
# EXP: 22062293
# TEMA: HANDS_ON_01


# LOADING LIBS ------------------------------------------------------------
install.packages(c("tidyverse", "dplyr", "janitor"))
library("dplyr","janitor")


# LOADING DATA ------------------------------------------------------------
exp_22062293 <- jsonlite::fromJSON("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")


# SHORTCUTS ---------------------------------------------------------------

# CLEAN CONSOLE = CTRL + l
# %>% pipe operator = SHIFT + CTRL + M
# CTRL + ENTER = run line
# SHIFT + CTRL + R = Indice

# GIT COMMANDS ------------------------------------------------------------

# pwd = current location
# git status = info about a repo
# git commit = Add a comment
# git add . = Add the current dir to the entire repo
# git push -u origin main = send to the remote repo (Github)


# CLI COMMANDS ------------------------------------------------------------

# pwd = shows the current dir
# ls = list terminal 
# mkdir = create a dir
# cd = change dir


# BASIC INSTRUCTIONS ------------------------------------------------------

isa <- 8 # assigning values


# TIDYVERSE COMMANDS ------------------------------------------------------


# 27 SEPTIEMBRE -----------------------------------------------------------

str(exp_22062293) #get datatype
df <- exp_22062293$ListaEESSPrecio #get readable data
df %>% glimpse()
df %>% janitor::clean_names() %>% glimpse()
