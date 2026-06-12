library(dplyr)

#Création indicatrice de la variable country_born
UN$country_born<-NA
UN$country_born[UN$to.Type=="B"|UN$to.Type=="B R"]<-1
UN$country_born[is.na(UN$country_born)] <- 0

#Création indicatrice de la variable Nationality
UN$Nationality<-NA
UN$Nationality[UN$to.Type=="C"|UN$to.Type=="C R"]<-1
UN$Nationality[is.na(UN$Nationality)] <- 0

#Création indicatrice de la variable Refugee
UN$Refugee<-NA
UN$Refugee[UN$to.Type=="R"|UN$to.Type=="B R"|UN$to.Type=="C R"]<-1
UN$Refugee[is.na(UN$Refugee)] <- 0

#Création indicatrice de la variable Imputation
UN$Imputation<-NA
UN$Imputation[UN$to.Type=="I"]<-1
UN$Imputation[is.na(UN$Imputation)] <- 0

#Renommer les variables
names(UN)[2]<-"from"
names(UN)[3]<-"to"
names(UN)[5]<-"type"

#Suppression de la variable notes to.
UN<-UN[,-c(0,6)]

# Suppression des lignes où "from" et "to" sont identiques
UN <- UN[UN$from != UN$to, ]


# Renommer la modalité UN.2017 et UN.2019
UN <- UN %>%
  mutate(source = recode(source, 
                           "UN.2017" = "UN_2017", 
                           "UN.2019" = "UN_2019"))



      # graphique pour Brésil-France

# Filtrer les données pour la période souhaitée
filtre_pays <- filter(UN, from == "BRA", to == "FRA")
fil_fin <- filter(filtre_pays, year %in% 1990:2020)

# Créer le graphique avec des améliorations
ggplot(data = fil_fin, aes(x = year, y = value, color = source, group = source, linetype = source)) +
  geom_line(size = 1.2) +  # Tracer les lignes avec une épaisseur plus visible
  geom_point(size = 3, alpha = 0.7) +  # Ajouter des points avec transparence pour lisibilité
  scale_x_continuous(breaks = seq(1990, 2020, by = 5)) +  # Ajuster l'axe X
  scale_color_manual(values = c("blue", "red", "green", "purple")) +  # Personnaliser les couleurs
  labs(title = "Le nombre de Brésiliens en France (1990-2020) ",
       subtitle = "Données issues des Nations Unies",
       x = "Année",
       y = "Stock de migrants internationaux",
       color = "source intra",
       linetype = "Source") +  
  theme_minimal() +  # Appliquer un thème propre
  guides(linetype = "none") +
  theme(legend.position = "bottom")  # Placer la légende en bas pour lisibilité












          #  graphique pour Brésil-Guyane

# Filtrer les données pour la période souhaitée
filtre1_pays <- filter(UN, from == "BRA", to == "GUF")
fil1_fin <- filter(filtre1_pays, year %in% 1990:2020)

# Créer le graphique avec des améliorations
ggplot(data = fil1_fin, aes(x = year, y = value, color = source, group = source, linetype = source)) +
  geom_line(size = 1.2) +  # Tracer les lignes avec une épaisseur plus visible
  geom_point(size = 3, alpha = 0.7) +  # Ajouter des points avec transparence pour lisibilité
  scale_x_continuous(breaks = seq(1990, 2020, by = 5)) +  # Ajuster l'axe X
  scale_color_manual(values = c("blue", "red", "green", "purple")) +  # Personnaliser les couleurs
  labs(title = "Le nombre de Brésiliens en Guyane française (1990-2020) ",
       subtitle = "Données issues des Nations Unies",
       x = "Année",
       y = "Stock de migrants internationaux",
       color = "source intra",
       linetype = "Source") +  
  theme_minimal() +  # Appliquer un thème propre
  guides(linetype = "none") +
  theme(legend.position = "bottom")  # Placer la légende en bas pour lisibilité




library(writexl)

# Exporter une table vers un fichier Excel
write_xlsx(UN, "C:/Users/MASS/Documents/Gestion de projet/R/UN_fin.xlsx")






#  graphique pour Brésil-France

# Filtrer les données pour la période souhaitée
filtre1_pays <- filter(UN, from == "VEN", to == "USA")
fil1_fin <- filter(filtre1_pays, year %in% 1990:2020)

# Créer le graphique avec des améliorations
ggplot(data = fil_fin, aes(x = year, y = value, color = source, group = source, linetype = source)) +
  geom_line(size = 1.2) +  # Tracer les lignes avec une épaisseur plus visible
  geom_point(size = 3, alpha = 0.7) +  # Ajouter des points avec transparence pour lisibilité
  scale_x_continuous(breaks = seq(1990, 2020, by = 5)) +  # Ajuster l'axe X
  scale_color_manual(values = c("blue", "red", "green", "purple")) +  # Personnaliser les couleurs
  labs(title = "Le nombre de Vénézueliens aux Etats-Unis (1990-2020) ",
       subtitle = "Données issues des Nations Unies",
       x = "Année",
       y = "Stock de migrants internationaux",
       color = "source intra",
       linetype = "Source") +  
  theme_minimal() +  # Appliquer un thème propre
  guides(linetype = "none") +
  theme(legend.position = "bottom")  # Placer la légende en bas pour lisibilité



# graphique pour Brésil-La Réunion

# Filtrer les données pour la période souhaitée
filtre2_pays <- filter(UN, from == "BRA", to == "REU")
fil2_fin <- filter(filtre2_pays, year %in% 1990:2020)

# Créer le graphique avec des améliorations
ggplot(data = fil2_fin, aes(x = year, y = value, color = source, group = source, linetype = source)) +
  geom_line(size = 1.2) +  # Tracer les lignes avec une épaisseur plus visible
  geom_point(size = 3, alpha = 0.7) +  # Ajouter des points avec transparence pour lisibilité
  scale_x_continuous(breaks = seq(1990, 2020, by = 5)) +  # Ajuster l'axe X
  scale_color_manual(values = c("blue", "red", "green", "purple")) +  # Personnaliser les couleurs
  labs(title = "Le nombre de Brésiliens à l'île de la Réunion(1990-2020) ",
       subtitle = "Données issues des Nations Unies",
       x = "Année",
       y = "Stock de migrants internationaux",
       color = "source intra",
       linetype = "Source") +  
  theme_minimal() +  # Appliquer un thème propre
  guides(linetype = "none") +
  theme(legend.position = "bottom")  # Placer la légende en bas pour lisibilité




# graphique pour Brésil-Guadeloupe

# Filtrer les données pour la période souhaitée
filtre3_pays <- filter(UN, from == "BRA", to == "GLP")
fil3_fin <- filter(filtre3_pays, year %in% 1990:2020)

# Créer le graphique avec des améliorations
ggplot(data = fil3_fin, aes(x = year, y = value, color = source, group = source, linetype = source)) +
  geom_line(size = 1.2) +  # Tracer les lignes avec une épaisseur plus visible
  geom_point(size = 3, alpha = 0.7) +  # Ajouter des points avec transparence pour lisibilité
  scale_x_continuous(breaks = seq(1990, 2020, by = 5)) +  # Ajuster l'axe X
  scale_color_manual(values = c("blue", "red", "green", "purple")) +  # Personnaliser les couleurs
  labs(title = "Le nombre de Brésiliens en Guadeloupe (1990-2020) ",
       subtitle = "Données issues des Nations Unies",
       x = "Année",
       y = "Stock de migrants internationaux",
       color = "source intra",
       linetype = "Source") +  
  theme_minimal() +  # Appliquer un thème propre
  guides(linetype = "none") +
  theme(legend.position = "bottom")  # Placer la légende en bas pour lisibilité




# graphique pour Brésil-La Martinique

# Filtrer les données pour la période souhaitée
filtre4_pays <- filter(UN, from == "BRA", to == "MTQ")
fil4_fin <- filter(filtre4_pays, year %in% 1990:2020)

# Créer le graphique avec des améliorations
ggplot(data = fil4_fin, aes(x = year, y = value, color = source, group = source, linetype = source)) +
  geom_line(size = 1.2) +  # Tracer les lignes avec une épaisseur plus visible
  geom_point(size = 3, alpha = 0.7) +  # Ajouter des points avec transparence pour lisibilité
  scale_x_continuous(breaks = seq(1990, 2020, by = 5)) +  # Ajuster l'axe X
  scale_color_manual(values = c("blue", "red", "green", "purple")) +  # Personnaliser les couleurs
  labs(title = "Le nombre de Brésiliens en Martinique (1990-2020) ",
       subtitle = "Données issues des Nations Unies",
       x = "Année",
       y = "Stock de migrants internationaux",
       color = "source intra",
       linetype = "Source") +  
  theme_minimal() +  # Appliquer un thème propre
  guides(linetype = "none") +
  theme(legend.position = "bottom")  # Placer la légende en bas pour lisibilité
