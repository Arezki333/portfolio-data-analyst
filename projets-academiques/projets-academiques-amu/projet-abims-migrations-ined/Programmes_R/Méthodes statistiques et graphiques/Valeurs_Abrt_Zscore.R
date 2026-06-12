library(read_excel)
# CHEMIN VERS LES TABLES 
setwd("C:/Users/MASS/Desktop/M2 MASS POP/Projet_migration_ined/Données/Final_data")

# CHARGEMENT DES TABLES EXECEL
ABIMS = read_excel("ABIMS.xlsx")
Eurostat = read_excel("Eurostat.xlsx")
OECD = read_excel("OECD.xlsx")
UN_fin = read_excel("UN_fin.xlsx")
WB_fin = read_excel("WB_fin.xlsx")

# ====================================================================================
#========= Méthodes de détection de valeurs aberrant ============================
#=============================================================================     


#===============================Intra-sources======================================

library(dplyr)
library(ggplot2)

# Fonctions de détection des outliers 
# Zscore
zscore_outliers <- function(values) {
  if (length(values) >= 3) {
    z_scores <- (values - mean(values, na.rm = TRUE)) / sd(values, na.rm = TRUE)
    return(ifelse(abs(z_scores) > 3, "Outlier", "Normal"))
  }
  return(rep("Non testé", length(values)))
}
# Intervalle interquartile (IQR)
iqr_outliers <- function(values) {
  if (length(values) >= 3) {
    q1 <- quantile(values, 0.25, na.rm = TRUE)
    q3 <- quantile(values, 0.75, na.rm = TRUE)
    iqr_value <- q3 - q1
    lower_bound <- q1 - 1.5 * iqr_value
    upper_bound <- q3 + 1.5 * iqr_value
    return(ifelse(values < lower_bound | values > upper_bound, "Outlier", "Normal"))
  }
  return(rep("Non testé", length(values)))
}

#  Fonction pour appliquer les méthodes sur une table
detect_outliers <- function(data_table, table_name) {
  results <- data_table %>%
    group_by(from, to, year) %>%
    filter(n() >= 3) %>%  # Vérifier qu'il y a au moins 3 sources
    mutate(
      zscore_flag = zscore_outliers(value),
      iqr_flag = iqr_outliers(value),
      detected_outlier = ifelse(zscore_flag == "Outlier" | iqr_flag == "Outlier", "Oui", "Non")
    ) %>%
    ungroup()
  
  print(paste("Traitement terminé pour :", table_name))
  return(results)
}

#  Appliquer le traitement sur toutes les tables
OCDE_outliers <- detect_outliers(OECD, "OCDE")
WB_outliers <- detect_outliers(WB_fin, "Banque Mondiale")
Eurostat_outliers <- detect_outliers(Eurostat, "Eurostat")
UN_outliers <- detect_outliers(UN_fin, "Nations Unies")

#  Liste des colonnes à supprimer
cols_to_remove <- c("country_born", "Nationality", "Refugee", "Imputation")

# Fonction pour supprimer ces colonnes d'une table
remove_columns <- function(df) {
  df %>% select(-any_of(cols_to_remove))
}

#  Appliquer la suppression des colonnes aux 4 tables
OCDE_outliers <- remove_columns(OCDE_outliers)
WB_outliers <- remove_columns(WB_outliers)
Eurostat_outliers <- remove_columns(Eurostat_outliers)
UN_outliers <- remove_columns(UN_outliers)

#======================================================
# ============================
# Supprimer les valeurs manquantes dans la table UN_outliers
UN_outliers_clean <- UN_outliers %>%
  filter(!is.na(type), !is.na(source), !is.na(detected_outlier))

# ============================
# Premier histogramme : Répartition des types de valeurs aberrantes
# ============================
ggplot(UN_outliers_clean, aes(x = type, fill = detected_outlier)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("Non" = "blue", "Oui" = "red")) +
  labs(title = "Distribution des Types de Valeurs Aberrantes (UN)",
       x = "Type", y = "Nombre de Cas",
       fill = "Valeurs Aberrantes") +
  scale_x_discrete(labels = c("B" = "Population Née à l’Étranger (B)", 
                              "C" = "Citoyens Étrangers (C)", 
                              "R" = "Réfugiés et Assimilés (R)", 
                              "I" = "Imputations (I)")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# ============================
# Deuxième histogramme : Répartition des sources des valeurs aberrantes
# ============================
ggplot(UN_outliers_clean, aes(x = source, fill = detected_outlier)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("Non" = "blue", "Oui" = "red")) +
  labs(title = "Répartition des Sources des Valeurs Aberrantes (UN)",
       x = "Source", y = "Nombre de Cas",
       fill = "Valeurs Aberrantes") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#===============================Inter-sources======================================


# Charger les bibliothèques nécessaires
library(dplyr)
library(ggplot2)

#  Filtrer la table ABIMS pour garder les sources spécifiques
ABIMS_filtered <- ABIMS %>%
  filter(source %in% c("OECD", "Eurostat", "UN_2020", "WDR_2023"))

#  Fonction pour détecter les valeurs aberrantes avec IQR
iqr_outliers <- function(values) {
  if (length(values) >= 3) {
    q1 <- quantile(values, 0.25, na.rm = TRUE)
    q3 <- quantile(values, 0.75, na.rm = TRUE)
    iqr_value <- q3 - q1
    lower_bound <- q1 - 1.5 * iqr_value
    upper_bound <- q3 + 1.5 * iqr_value
    return(ifelse(values < lower_bound | values > upper_bound, "Outlier", "Normal"))
  }
  return(rep("Non testé", length(values)))
}

#  Fonction pour détecter les valeurs aberrantes avec Z-Score
zscore_outliers <- function(values) {
  if (length(values) >= 3) {
    z_scores <- (values - mean(values, na.rm = TRUE)) / sd(values, na.rm = TRUE)
    return(ifelse(abs(z_scores) > 3, "Outlier", "Normal"))
  }
  return(rep("Non testé", length(values)))
}

#  Appliquer les méthodes sur les groupes (from, to, year)
ABIMS_outliers <- ABIMS_filtered %>%
  group_by(from, to, year) %>%
  filter(n() >= 3) %>%  # Vérifier qu'il y a au moins 3 sources
  mutate(
    iqr_flag = iqr_outliers(value),
    zscore_flag = zscore_outliers(value),
    detected_outlier = ifelse(iqr_flag == "Outlier" | zscore_flag == "Outlier", "Oui", "Non")
  ) %>%
  ungroup()

# Supprimer les valeurs NA
ABIMS_outliers <- ABIMS_outliers %>%
  filter(!is.na(value))


# Suppression des valeurs NA dans la variable detected_outlier directement dans la table
ABIMS_outliers <- ABIMS_outliers %>% filter(!is.na(detected_outlier))

# Histogramme 1 : Distribution des types touchés par des outliers
ggplot(ABIMS_outliers, aes(x = type, fill = detected_outlier)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("Oui" = "red", "Non" = "blue")) +  # Même palette de couleurs
  scale_x_discrete(labels = c("B" = "Population née à l’étranger",
                              "C" = "Citoyens étrangers",
                              "R" = "Réfugiés et assimilés",
                              "I" = "Imputations")) +  # Légende corrigée
  labs(title = "Distribution des types selon la présence d'outliers",
       x = "Type",
       y = "Nombre d'observations",
       fill = "Valeur aberrante") +
  theme_minimal()

# Histogramme 2 : Distribution des sources touchées par des outliers
ggplot(ABIMS_outliers, aes(x = source, fill = detected_outlier)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("Oui" = "red", "Non" = "blue")) +  # Même palette de couleurs
  labs(title = "Distribution des sources selon la présence d'outliers",
       x = "Source",
       y = "Nombre d'observations",
       fill = "Valeur aberrante") +
  theme_minimal()


# Tableau croisé entre Type et Outlier
table_type_outlier <- table(ABIMS_outliers$type, ABIMS_outliers$detected_outlier)
print("Tableau croisé entre Type et Outlier :")
print(table_type_outlier)

# Tableau croisé entre Source et Outlier
table_source_outlier <- table(ABIMS_outliers$source, ABIMS_outliers$detected_outlier)
print("Tableau croisé entre Source et Outlier :")
print(table_source_outlier)


#====================================================================================
# Code Graphiques des stocks des migrant des couples de pays par années. 

# Filtrer les données pour la période souhaitée
filtre_pays <- filter(ABIMS_filtered , from == "AGO", to == "DNK")
filtre3_fin <- filter(filtre_pays, year %in% 1990:2020)

# Créer le graphique avec des améliorations
ggplot(data = filtre3_fin, aes(x = year, y = value, color = source, group = source, linetype = source)) +
  geom_line(size = 1.2) +  # Tracer les lignes avec une épaisseur plus visible
  geom_point(size = 3, alpha = 0.7) +  # Ajouter des points avec transparence pour lisibilité
  scale_x_continuous(breaks = seq(1995, 2023, by = 5)) +  # Ajuster l'axe X
  scale_color_manual(values = c("blue", "red", "green", "purple", "orange", "pink", "brown")) +  # Personnaliser les couleurs
  labs(title = "",
       subtitle = "",
       x = "Année",
       y = "Immigrants",
       color = "Source",
       linetype = "Source") +  
  theme_minimal() +  # Appliquer un thème propre
  guides(linetype = "none") +
  theme(legend.position = "bottom")  # Placer la légende en bas pour lisibilité   


