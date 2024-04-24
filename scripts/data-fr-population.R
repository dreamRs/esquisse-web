#  ------------------------------------------------------------------------
#
# french population by sex and age
# https://www.insee.fr/fr/statistiques/2012692#tableau-TCRD_021_tab1_departements
#
#  ------------------------------------------------------------------------


# Packages ----------------------------------------------------------------

library(dplyr)
library(readxl)
library(janitor)
library(sf)
library(CARTElette) # remotes::install_github("antuki/CARTElette/CARTElette@RPackage")



# Data pop --------------------------------------------------------------------------

population <- read_excel("inputs/TCRD_021.xlsx", skip = 3)
population <- clean_names(population)
names(population)[1:2] <- c("code_dep", "lib_dep")

dep_sf <- charger_carte(COG = 2021, nivsupra = "DEP", geometrie_simplifiee = TRUE)

population_fr <- left_join(
  x = dep_sf %>% select(-nom),
  y = population,
  by = c("DEP" = "code_dep")
)


saveRDS(population_fr, "datas/population_fr.rds")

