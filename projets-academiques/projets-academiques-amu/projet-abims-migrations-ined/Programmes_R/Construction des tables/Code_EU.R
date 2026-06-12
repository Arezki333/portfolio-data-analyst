
# Définir le chemin des données
data_path <- "C:/Users/MASS/Desktop/M2 MASS POP/Projet_migration_ined/abims-master/abims-master/Datas_Out"

# Importer les fichiers RData
load(file.path(data_path, "Eurostat.RData"))   # Données Eurostat

########### Création des variables indicatrices ##################""

library(dplyr)

# Ajouter les variables binaires à la table Eurostat
Eurostat <- Eurostat %>%
  mutate(
    country_Born = ifelse(type == "Country of birth", 1, 0), # 1 si "Country of birth", sinon 0
    Nationality = ifelse(type == "Citizenship", 1, 0),# 1 si "Citizenship", sinon 0
    Refugee = 0,        # Ajouter une colonne Refugee avec des zéros
    Imputation = 0      # Ajouter une colonne Imputation avec des zéros
  )

#################### importation des données jeu graphique des pays ###################

X = select(codelist,continent,country.name.en,country.name.fr,eurostat,
           iso2c,iso3n,iso3c,region23,un.name.en) %>%
  filter(!is.na(iso3c)) %>%
  arrange(country.name.en)

kable(X,caption="Geographic code and nomenclature file") %>%
  kable_styling(bootstrap_options = c("striped"),
                full_width = T, font_size = 12) %>%
  scroll_box(height = "400px")

#########################  Jointure pour la creation de ISO3C ####################
# Charger les packages nécessaires
library(dplyr)

# Étape 1 : Ajouter la colonne `from.iso3` en fonction de `from`
Eurostat <- Eurostat %>%
  left_join(X %>% select(eurostat, iso3c), by = c("from" = "eurostat")) %>%
  rename(from.iso3 = iso3c)  # Renommer la colonne pour `from`

# Étape 2 : Ajouter la colonne `to.iso3` en fonction de `to`
Eurostat <- Eurostat %>%
  left_join(X %>% select(eurostat, iso3c), by = c("to" = "eurostat")) %>%
  rename(to.iso3 = iso3c)  # Renommer la colonne pour `to`

############  Réorganisation et filtres #######################


# Réorganiser les colonnes
Eurostat <- Eurostat %>%
  select(
    everything(),       # Conserve toutes les colonnes
    from.iso3,          # Place from.iso3 en 2e position
    to.iso3             # Ajoute to.iso3 en 4e position
  ) %>%
  relocate(from.iso3, .after = from) %>%  # Place from.iso3 après la 1ère colonne
  relocate(to.iso3, .after = to)          # Place to.iso3 après la colonne "to"


# Supprimer les lignes où `from` ou `to` ont plus de 3 caractères
Eurostat_clean <- Eurostat %>%
  filter(nchar(from) <= 2 & nchar(to) <= 2)

# Supprimer les lignes où les pays de départ et d'arrivée sont identiques
Eurostat_clean <- Eurostat_clean %>%
  filter(from.iso3 != to.iso3)

# Supprimer les doublons en privilégiant "Country of birth"
Eurostat_clean <- Eurostat_clean %>%
  group_by(from.iso3, to.iso3) %>% 
  filter(type == "Country of birth" | !("Country of birth" %in% type)) %>% 
  ungroup()

Eurostat_clean <- Eurostat_clean %>%
  select(-from, -to)

# Réorganiser, renommer et supprimer les colonnes
Eurostat_clean <- Eurostat_clean %>%
  rename(
    year = Year,   
    from = from.iso3,  
    to = to.iso3,
    country_born = country_Born
    
  ) %>%
  select(
    year,         # Placer YEAR en premier
    from,         # Colonne "from"
    to,           # Colonne "to"
    value,        # Colonne "value"
    type,         # Colonne "type"
    source,
    country_born,
    Nationality,
    Refugee,
    Imputation
  ) 
####################### Exportation de la table en xlsx ########################
library(openxlsx)
write.xlsx(Eurostat_clean, "C:/Users/MASS/Desktop/Eurostat.xlsx")


