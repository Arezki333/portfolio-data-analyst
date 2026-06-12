########## Importation de la table OECD_IMDB ###########

# Définir le chemin des données
data_path <- "C:/Users/MASS/Desktop/M2 MASS POP/Projet_migration_ined/abims-master/abims-master/Datas_Out"

# Importer les fichiers RData
load(file.path(data_path, "OECD_IMDB.RData"))   # Données OCDE 

# Supprimer les lignes où les pays de départ et d'arrivée sont identiques
OECD_IMDB <- OECD_IMDB %>%
  filter(from != to)

# Supprimer les les lignes où il y n'a pas de format iso3 
OECD_IMDB <- OECD_IMDB %>%
  filter(nchar(from) == 3 & nchar(to) == 3)


# Supprimer les doublons en privilégiant "Country of birth"
OECD_IMDB <- OECD_IMDB %>%
  group_by(from, to) %>%
  filter(type == "Birth_Country" | !("Birth_Country" %in% type)) %>%
  ungroup()

# Réorganiser, renommer et supprimer les colonnes
OECD_IMDB <- OECD_IMDB %>%
  rename(
    year = Year,   
    source = Source
    
  ) %>%
  select(
    year,         # Placer YEAR en premier
    from,         # Colonne "from"
    to,           # Colonne "to"
    value,        # Colonne "value"
    type,         # Colonne "type"
    source
  ) 

OECD_IMDB$value <- as.numeric(OECD_IMDB$value)
################importation DIOC_2000 #################################


# Définir le dossier contenant les fichiers
folder_path <- "C:/Users/MASS/Desktop/M2 MASS POP/Projet_migration_ined/Données/OECD/DIOC/2000_2001"

# Lister les fichiers CSV
file_names <- list.files(folder_path, pattern = "\\.csv$", full.names = TRUE)

# Fonction pour charger et traiter un fichier CSV
process_file <- function(file) {
  df <- read_csv(file, show_col_types = FALSE)  # Charger les données
  file_name <- tools::file_path_sans_ext(basename(file))  # Extraire le nom du fichier sans extension
  
  print(paste("Traitement du fichier :", file_name))
  print(names(df))  # Vérifier les colonnes disponibles

  # Mettre les noms de colonnes en majuscules pour standardiser
  colnames(df) <- toupper(colnames(df))

  # Vérifier la présence des colonnes essentielles
  required_columns <- c("COUB", "COUNTRY", "NUMBER")
  if (!all(required_columns %in% names(df))) {
    print(paste(" Colonnes manquantes dans", file_name, "=> Ignoré"))
    return(NULL)
  }
  
  # Sélectionner uniquement les colonnes d’intérêt (si présentes)
  df <- df %>% select(all_of(required_columns))

  # Renommer les colonnes
  df <- df %>%
    rename(
      from = COUB,
      to = COUNTRY,
      value = NUMBER
    )

  # Ajouter les colonnes manquantes
  df <- df %>%
    mutate(
      year = 2000,
      type = "Birth_Country",
      source = "DIOC"
    )

  # Filtrer les migrations internes
  df <- df %>% filter(from != to)
  
  # Supprimer les les lignes où il y n'a pas de format iso3 
df <- df %>%
  filter(nchar(from) == 3 & nchar(to) == 3)

  # Agréger les valeurs
  df <- df %>%
    group_by(from, to, year, type, source) %>%
    summarise(value = sum(value, na.rm = TRUE), .groups = "drop")

  return(df)
}

# Appliquer la fonction à tous les fichiers et combiner les résultats
processed_files <- lapply(file_names, process_file)
final_data_2000 <- bind_rows(processed_files, .id = "source_file")


# Réorganiser, renommer et supprimer les colonnes
DIOC_2000 <- final_data_2000 %>%
  select(
    year,         # Placer YEAR en premier
    from,         # Colonne "from"
    to,           # Colonne "to"
    value,        # Colonne "value"
    type,         # Colonne "type"
    source
  ) 

################importation DIOC_2005 #################################

library(tidyverse)

# Définir le dossier contenant les fichiers
folder_path <- "C:/Users/MASS/Desktop/M2 MASS POP/Projet_migration_ined/Données/OECD/DIOC/2005_2006"

file_names <- list.files(folder_path, pattern = "\\.CSV$", full.names = TRUE, ignore.case = TRUE)
print(file_names)

# Fonction pour charger et traiter un fichier CSV
process_file <- function(file) {
  df <- read_csv(file, show_col_types = FALSE)  # Charger les données
  file_name <- tools::file_path_sans_ext(basename(file))  # Extraire le nom du fichier sans extension
  
  print(paste("Traitement du fichier :", file_name))
  print(names(df))  # Vérifier les colonnes disponibles
  
  # Mettre les noms de colonnes en majuscules pour standardiser
  colnames(df) <- toupper(colnames(df))
  
  # Vérifier la présence des colonnes essentielles
  required_columns <- c("COUB", "COUNTRY", "NUMBER")
  if (!all(required_columns %in% names(df))) {
    print(paste("Colonnes manquantes dans", file_name, "=> Ignoré"))
    return(NULL)
  }
  
  # Sélectionner uniquement les colonnes d’intérêt (si présentes)
  df <- df %>% select(all_of(required_columns))
  
  # Renommer les colonnes
  df <- df %>%
    rename(
      from = COUB,
      to= COUNTRY,
      value = NUMBER
    )
  
  # Ajouter les colonnes manquantes
  df <- df %>%
    mutate(
      year = 2005,
      type = "Birth_Country",
      source = "DIOC"
    )
  
  # Filtrer les migrations internes
  df <- df %>% filter(from != to)
  
  # Supprimer les les lignes où il y n'a pas de format iso3 
  df <- df %>%
    filter(nchar(from) == 3 & nchar(to) == 3)
  
  # Agréger les valeurs
  df <- df %>%
    group_by(from, to, year, type, source) %>%
    summarise(value = sum(value, na.rm = TRUE), .groups = "drop")
  
  return(df)
}

# Appliquer la fonction à tous les fichiers et combiner les résultats
processed_files <- lapply(file_names, process_file)
final_data_5 <- bind_rows(processed_files, .id = "source_file")

# Réorganiser, renommer et supprimer les colonnes
DIOC_2005 <- final_data_5 %>%
  select(
    year,         # Placer YEAR en premier
    from,         # Colonne "from"
    to,           # Colonne "to"
    value,        # Colonne "value"
    type,         # Colonne "type"
    source
  ) 


################importation DIOC_2010 #################################

library(tidyverse)

# Définir le dossier contenant les fichiers
folder_path <- "C:/Users/MASS/Desktop/M2 MASS POP/Projet_migration_ined/Données/OECD/DIOC/2010_2011"

file_names <- list.files(folder_path, pattern = "\\.CSV$", full.names = TRUE, ignore.case = TRUE)
print(file_names)

# Fonction pour charger et traiter un fichier CSV
process_file <- function(file) {
  df <- read_csv(file, show_col_types = FALSE)  # Charger les données
  file_name <- tools::file_path_sans_ext(basename(file))  # Extraire le nom du fichier sans extension
  
  print(paste("Traitement du fichier :", file_name))
  print(names(df))  # Vérifier les colonnes disponibles
  
  # Mettre les noms de colonnes en majuscules pour standardiser
  colnames(df) <- toupper(colnames(df))
  
  # Vérifier la présence des colonnes essentielles
  required_columns <- c("COUB", "COUNTRY", "NUMBER")
  if (!all(required_columns %in% names(df))) {
    print(paste("⚠️ Colonnes manquantes dans", file_name, "=> Ignoré"))
    return(NULL)
  }
  
  # Sélectionner uniquement les colonnes d’intérêt (si présentes)
  df <- df %>% select(all_of(required_columns))
  
  # Renommer les colonnes
  df <- df %>%
    rename(
      from = COUB,
      to = COUNTRY,
      value = NUMBER
    )
  
  # Ajouter les colonnes manquantes
  df <- df %>%
    mutate(
      year = 2010,
      type = "Birth_Country",
      source = "DIOC"
    )
  
  # Filtrer les migrations internes
  df <- df %>% filter(from != to)
  
  # Supprimer les les lignes où il y n'a pas de format iso3 
  df <- df %>%
    filter(nchar(from) == 3 & nchar(to) == 3)
  
  # Agréger les valeurs
  df <- df %>%
    group_by(from, to, year, type, source) %>%
    summarise(value = sum(value, na.rm = TRUE), .groups = "drop")
  
  return(df)
}

# Appliquer la fonction à tous les fichiers et combiner les résultats
processed_files <- lapply(file_names, process_file)
final_data_10 <- bind_rows(processed_files, .id = "source_file")

# Réorganiser, renommer et supprimer les colonnes
DIOC_2010 <- final_data_10 %>%
  select(
    year,         # Placer YEAR en premier
    from,         # Colonne "from"
    to,           # Colonne "to"
    value,        # Colonne "value"
    type,         # Colonne "type"
    source
  ) 


################importation DIOC_2020 #################################

library(tidyverse)
library(readxl)
library(openxlsx)  # Pour enregistrer les données Excel

#  1. Définir le dossier contenant les fichiers
folder_path <- "C:/Users/MASS/Desktop/M2 MASS POP/Projet_migration_ined/Données/OECD/DIOC/2020_2021"

#  2. Lister les fichiers Excel (.xlsx)
file_names <- list.files(folder_path, pattern = "\\.xlsx$", full.names = TRUE, ignore.case = TRUE)


#  3. Fonction pour charger et traiter un fichier Excel
process_file <- function(file) {
  # Charger la table
  df <- read_excel(file)
  
  # Vérifier si le fichier est vide
  if (nrow(df) == 0) {
    print(paste(" Fichier vide ignoré :", basename(file)))
    return(NULL)
  }
  
  
  
  # Standardiser les noms de colonnes (mettre en majuscules)
  colnames(df) <- toupper(colnames(df))
  
  # Colonnes requises
  required_columns <- c("COUB", "COUNTRY", "NUMBER")
  
  # Vérifier la présence des colonnes essentielles
  if (!all(required_columns %in% names(df))) {
    print(paste("Colonnes manquantes dans", file_name, "=> Ignoré"))
    return(NULL)
  }
  
  # Sélectionner uniquement les colonnes utiles
  df <- df %>% select(all_of(required_columns))
  
  # Renommer les colonnes
  df <- df %>%
    rename(
      from = COUB,
      to = COUNTRY,
      value = NUMBER
    )
  
  # Ajouter les nouvelles colonnes
  df <- df %>%
    mutate(
      year = 2020,
      type = "Birth_Country",
      source = "DIOC"
    )
  
  # Filtrer les migrations internes (éviter les doublons)
  df <- df %>% filter(from != to)
  
  # Supprimer les les lignes où il y n'a pas de format iso3 
  df <- df %>%
    filter(nchar(from) == 3 & nchar(to) == 3)
  
  # Agréger les données pour éviter les doublons
  df <- df %>%
    group_by(from, to, year, type, source) %>%
    summarise(value = sum(value, na.rm = TRUE), .groups = "drop")
  
  return(df)
}


#  4. Appliquer la fonction à tous les fichiers et combiner les résultats
processed_files <- lapply(file_names, process_file)

#  5. Fusionner toutes les tables en une seule
final_data_20 <- bind_rows(processed_files)


# Réorganiser, renommer et supprimer les colonnes
DIOC_2020 <- final_data_20 %>%
  select(
    year,         # Placer YEAR en premier
    from,         # Colonne "from"
    to,           # Colonne "to"
    value,        # Colonne "value"
    type,         # Colonne "type"
    source
  ) 





################importation DIOC-E_2010 #################################

library(tidyverse)

# Définir le dossier contenant les fichiers
folder_path <- "C:/Users/MASS/Desktop/M2 MASS POP/Projet_migration_ined/Données/OECD/DIOC-E"

file_names <- list.files(folder_path, pattern = "\\.CSV$", full.names = TRUE, ignore.case = TRUE)
print(file_names)

# Fonction pour charger et traiter un fichier CSV
process_file <- function(file) {
  df <- read_csv(file, show_col_types = FALSE)  # Charger les données
  file_name <- tools::file_path_sans_ext(basename(file))  # Extraire le nom du fichier sans extension
  
  print(paste("Traitement du fichier :", file_name))
  print(names(df))  # Vérifier les colonnes disponibles
  
  # Mettre les noms de colonnes en majuscules pour standardiser
  colnames(df) <- toupper(colnames(df))
  
  # Vérifier la présence des colonnes essentielles
  required_columns <- c("COUB", "COUNTRY", "NUMBER")
  if (!all(required_columns %in% names(df))) {
    print(paste(" Colonnes manquantes dans", file_name, "=> Ignoré"))
    return(NULL)
  }
  
  # Sélectionner uniquement les colonnes d’intérêt (si présentes)
  df <- df %>% select(all_of(required_columns))
  
  # Renommer les colonnes
  df <- df %>%
    rename(
      from = COUB,
      to = COUNTRY,
      value = NUMBER
    )
  
  # Ajouter les colonnes manquantes
  df <- df %>%
    mutate(
      year = 2010,
      type = "Birth_Country",
      source = "DIOC-E"
    )
  
  # Filtrer les migrations internes
  df <- df %>% filter(from != to)
  
  # Supprimer les les lignes où il y n'a pas de format iso3 
  df <- df %>%
    filter(nchar(from) == 3 & nchar(to) == 3)
  
  # Agréger les valeurs
  df <- df %>%
    group_by(from, to, year, type, source) %>%
    summarise(value = sum(value, na.rm = TRUE), .groups = "drop")
  
  return(df)
}

# Appliquer la fonction à tous les fichiers et combiner les résultats
processed_files <- lapply(file_names, process_file)
final_data_10 <- bind_rows(processed_files, .id = "source_file")

# Réorganiser, renommer et supprimer les colonnes
DIOC_E_10 <- final_data_10 %>%
  select(
    year,         # Placer YEAR en premier
    from,         # Colonne "from"
    to,           # Colonne "to"
    value,        # Colonne "value"
    type,         # Colonne "type"
    source
  ) 


################### Fusion de toutes les tables de OCDE ################################

OECD <- bind_rows(OECD_IMDB, DIOC_2000, DIOC_2005, DIOC_2010, DIOC_2020, DIOC_E_10)

# Ajouter les variables binaires pour les indicateurs
OECD <- OECD %>%
  mutate(
    country_Born =  as.character(ifelse(type == "Birth_Country", 1, 0))  , # 1 si "Country of birth", sinon 0
    Nationality = as.character(ifelse(type == "Citizenship", 1, 0)) ,# 1 si "Citizenship", sinon 0
    Refugee = 0 ,        # Ajouter une colonne Refugee avec des zéros
    Imputation = 0      # Ajouter une colonne Imputation avec des zéros
  )
# Exporter la table en Excel 
library(openxlsx)
write.xlsx(OECD, "C:/Users/MASS/Desktop/OECD.xlsx")