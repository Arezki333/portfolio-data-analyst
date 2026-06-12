
library(readxl)

chemin_fichier<-"K:/myhome_etud/DOSSIERS_WINDOWS/Documents/TER/Landes.xlsx"
Landes<-read_excel(chemin_fichier)





# Boîte à moustache du solde du nombre d'emplois sur la période 2009-2020 pour chaque typologie d'aire d'attraction des villes  
boxplot(Landes$soldemp0920~Landes$aav2020_typo,las=3,cex.axis=0.7,col=c(col = c("green", "red", "blue","orange","yellow","purple","brown")),main="Boîte à moustache pour chaque typologie d'aire d'attraction des villes")

# Boîte à moustache du solde du nombre d'emplois sur la période 2018-2020 pour chaque typologie d'aire d'attraction des villes  
boxplot(Landes$soldemp1820~Landes$aav2020_typo,las=3,cex.axis=0.7,col=c(col = c("green", "red", "blue","orange","yellow","purple","brown")),main="Boîte à moustache pour chaque typologie d'aire d'attraction des villes")

     

# Analyse entre 2009 et 2020

# Méthode 1 : Solde d'emploi




# Identification de la commune qui a connu la plus forte augmentation du nombre d'emplois sur la période 2009 et 2020
empmax1<- Landes[Landes$soldemp0920==max(Landes$soldemp0920),]
# On observe que c'est la commune de Saint-Pierre-du-Mont qui a connu la plus forte augmentation du nombre d'emplois sur la période 2009 et 2020


# On sélectionne les colonnes emp18 et emp20 en les incluant dans une nouvelle table
emp20092020<-Landes[,c(32,33)]



              # Saint-Pierre-du-Mont


# On sélectionne la ligne de la commune Saint-Pierre-du-Mont, dans la table Landes, qui connait la plus forte augmentation du nombre d'emplois sur la période 2009-2020
St_Pierre_emp<-emp20092020[Landes$idcomtxt=="Saint-Pierre-du-Mont",]

# On transpose la table St_Pierre_emp pour avoir les colonnes emp09 et emp20 en lignes
newSt_Pierre_emp<-as.data.frame(t(St_Pierre_emp))
names(newSt_Pierre_emp)[1]="nombre_emplois"









# On sélectionne les colonnes emp18 et emp20 en les incluant dans une nouvelle table
emp20092020<-Landes[,c(32,33)]



                    # Siest


# On sélectionne la ligne de la commune Siest, dans la table Landes, qui connait la plus forte augmentation du nombre d'emplois sur la période 2009-2020
Siest_emp<-emp20092020[Landes$idcomtxt=="Siest",]

# On transpose la table Siest_emp pour avoir les colonnes emp09 et emp20 en lignes
newSiest_emp<-as.data.frame(t(Siest_emp))
names(newSiest_emp)[1]="nombre_emplois"











# Affichage des 2 graphiques pour les 2 méthodes
par(mfrow = c(2, 1))
barplot(newSt_Pierre_emp$nombre_emplois,xlab="Emplois par année",names.arg=c("emp09","emp20"),ylab="Nombre d'emplois",ylim=c(0,5000),col=c("red","blue"),main="Evolution du nombre d'emplois sur la période 2009-2020 dans la commune de Saint-Pierre-du-Mont")
barplot(newSiest_emp$nombre_emplois,xlab="Emplois par année",names.arg=c("emp09","emp20"),ylab="Nombre d'emplois",ylim=c(0,50),col=c("red","blue"),main="Evolution du nombre d'emplois sur la période 2009-2020 dans la commune de Siest" )










    # Analyse entre 2018 et 2020


    # Méthode 1: Solde emploi


# Identification de la commune qui a connu la plus forte augmentation du nombre d'emplois sur la période 2018 et 2020
empmax3<- Landes[Landes$soldemp1820==max(Landes$soldemp1820),]
  # On observe que c'est la commune de Mont-de-Marsan qui a connu la plus forte augmentation du nombre d'emplois sur la période 2018 et 2020


 


# On sélectionne les colonnes emp18 et emp20 en les incluant dans une nouvelle table
emp20182020<-Landes[,c(38,33)]






                 # Mont-de-Marsan




# On sélectionne la ligne de la commune Mont-de-Marsan, dans la table Landes, qui connait la plus forte augmentation du nombre d'emplois sur la période 2018-2020
Mont_de_Marsan_emp<-emp20182020[Landes$idcomtxt=="Mont-de-Marsan",]

# On transpose la table Mont-de-Marsan_emp pour avoir les colonnes emp18 et emp20 en lignes
newMont_de_Marsan_emp<-as.data.frame(t(Mont_de_Marsan_emp))
names(newMont_de_Marsan_emp)[1]="nombre_emplois"












# Méthode 2: Taux d'évolution

# Identification de la commune qui a connu la plus forte augmentation du nombre d'emplois sur la période 2018 et 2020
empmax4<- Landes[Landes$txemp1820==max(Landes$txemp1820),]
# On observe que c'est la commune de Villenave qui a connu la plus forte augmentation du nombre d'emplois sur la période 2018 et 2020


# On sélectionne les colonnes emp18 et emp20 en les incluant dans une nouvelle table
emp20182020<-Landes[,c(38,33)]







     # Villenave



# On sélectionne la ligne de la commune Villenave, dans la table Landes, qui connait la plus forte augmentation du nombre d'emplois sur la période 2018-2020
Villenave_emp<-emp20182020[Landes$idcomtxt=="Villenave",]

# On transpose la table Villenave_emp pour avoir les colonnes emp18 et emp20 en lignes
newVillenave_emp<-as.data.frame(t(Villenave_emp))
names(newVillenave_emp)[1]="nombre_emplois"








# Affichage des 2 graphiques pour les 2 méthodes
par(mfrow = c(2, 1))
barplot(newVillenave_emp$nombre_emplois,xlab="Emplois par année",names.arg=c("emp18","emp20"),ylab="Nombre d'emplois",ylim=c(0,100), col=c("red","blue"),main="Evolution du nombre d'emplois sur la période 2018-2020 dans la commune de Mont-de-Marsan")
barplot(newMont_de_Marsan_emp$nombre_emplois,xlab="Emplois par année",names.arg=c("emp18","emp20"),ylab="Nombre d'emplois",ylim=c(0,25000), col=c("red","blue"),main="Evolution du nombre d'emplois sur la période 2018-2020 dans la commune de Villenave")




# Identification de la commune qui a connu la plus forte augmentation du flux d'artificialisation des sols par rapport à sa superficie.
artmax<-Landes[Landes$rap_art_com1820==max(Landes$rap_art_com1820),]
# On observe que c'est la commune de Gouts qui a connu la plus forte augmentation du flux d'artificialisation des sols par rapport à sa superficie.

# On sélectionne la ligne de la commune de Gouts qui connait la plus forte augmentation de surfaces artificialisées par rapport à sa superficie sur la période 2018-2020
Gouts_emp<-emp20182020[Landes$idcomtxt=="Gouts",]

# On transpose la table Gouts_emp pour avoir les colonnes emp18  et emp20 en lignes
newGouts_emp<-as.data.frame(t(Gouts_emp))
names(newGouts_emp)[1]="nombre_emplois"

write.csv2(newGouts_emp,file="K:/myhome_etud/DOSSIERS_WINDOWS/Documents/TER/newGouts_emp.csv")





# Comparaison du nuage de points entre l'artificialisation en fonction de la surface communale et le taux d'évolution  du nombre d'emplois entre 2009 et 2020, et du nuage de points entre l'artificialisation en fonction de la surface communale et le solde du nombre d'emplois entre 2009 et 2020
par(mfrow = c(2, 1))
plot(Landes$rap_art_0920,Landes$txemp0920,type = "n")
text(Landes$rap_art_0920,Landes$txemp0920, labels=Landes$idcomtxt)
plot(Landes$rap_art_0920,Landes$soldemp0920, type = "n")
text(Landes$rap_art_0920,Landes$soldemp0920, labels=Landes$idcomtxt)

# Comparaison du nuage de points entre l'artificialisation en fonction de la surface communale et le taux d'évolution du nombre d'emplois entre 2018 et 2020, et du nuage de points entre l'artificialisation en fonction de la surface communale et le solde du nombre d'emplois entre 2018 et 2020
par(mfrow = c(2, 1))
plot(Landes$rap_art_0920,Landes$txemp1820,type = "n")
text(Landes$rap_art_0920,Landes$txemp1820, labels=Landes$idcomtxt)
plot(Landes$rap_art_0920,Landes$soldemp1820, type = "n")
text(Landes$rap_art_0920,Landes$soldemp1820, labels=Landes$idcomtxt)




# Graphique : Classification des communes selon l'emploi et l'artificialisation



plot(Landes$rap_art_com1820,Landes$soldemp1820,main="Classification des communes selon leur solde d'emploi et leur taux d'artificialisation par rapport à leur superficie")
abline(v=0, h=0,lty=3)
legend(x="topright", legend=c("Forte augmentation du nombre d'emplois et Taux d'artificialisation","Diminution du nombre d'emplois et Taux d'artificialisation"), col=c("green","red"),pch=c(16,16))
points(Landes$rap_art_com1820[Landes$soldemp1820>0],Landes$soldemp1820[Landes$soldemp1820>0],pch=16,col="green")
points(Landes$rap_art_com1820[Landes$soldemp1820<=0],Landes$soldemp1820[Landes$soldemp1820<=0],pch=16,col="red")






   # Sorties QGIS

        # Commune

#importation de la table issue de QGIS
Mt_Marsan <- read_excel("K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/intersect_evol_artif_Mont_de_Marsan.xlsx")

# importation de la table zae issue de QGIS
Zaeco<- read_excel("K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/Mont_de_Marsan_Zones_d'activités.xlsx")

# Nombre total de surfaces utilisées par types d'activités économiques
ZonesEco<-aggregate(Zaeco[,18],by=setNames(list(Zaeco$activite),"Evolution artificialisation"),FUN=sum)
names(ZonesEco)[2] <- "Surfaces utilisées (en ha)" # On renomme la 2ème colonne de la table


# export de la table arteco en fichier csv
write.csv2(ZonesEco,file="K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/ZonesEco.csv",row.names=FALSE)


# Superficie totale pour chaque évolution d'artificialisation
suparti<-aggregate(Mt_Marsan[,26],by=setNames(list(Mt_Marsan$evol_artif),"Evolution"),FUN=sum)
names(suparti)[2] <- "Superficie totale en m^2" # On renomme la 2ème colonne de la table

# export de la table supart en fichier csv
write.csv2(suparti,file="K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/suparti.csv",row.names=FALSE)







         # EPCI



# importation de la table zae issue de QGIS
ZAE<- read_excel("K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/EPCI_Mont_de_Marsan_Zones_activités.xlsx")

# Nombre total de surfaces utilisées par types d'activités économiques
arteco<-aggregate(ZAE[,9],by=setNames(list(ZAE$activite),"activité"),FUN=sum)
names(arteco)[2] <- "Surfaces utilisées (en ha)" # On renomme la 2ème colonne de la table


# export de la table arteco en fichier csv
write.csv2(arteco,file="K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/arteco.csv",row.names=FALSE)





#importation de la table issue de QGIS
Mont_Marsan <- read_excel("K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/EPCI_intersect_evol_artif_Mont_de_Marsan.xlsx")

# Superficie totale pour chaque évolution d'artificialisation
supart<-aggregate(Mont_Marsan[,15],by=setNames(list(Mont_Marsan$evol_artif),"Evolution"),FUN=sum)
names(supart)[2] <- "Superficie totale en m^2" # On renomme la 2ème colonne de la table

# export de la table supart en fichier csv
write.csv2(supart,file="K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/supart.csv",row.names=FALSE)





# Mitage des zones construites sur EPCI
mitage<- read_excel("K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/Mitage_Type.xlsx")

# Liste des zones construites par indices 0 et 1
condhect<-aggregate(mitage[,8],by=setNames(list(mitage$indice),"Indice"),FUN=sum)
nbzones<-table(mitage$indice)
nbzones
condhect$nbzones<-nbzones
condhect<-condhect[,-2]
condhect$Indice <- as.factor(condhect$Indice)
levels(condhect$Indice)<-c("Aire>10ha","Aire<10ha")

# export de la table condhect en fichier csv
write.csv2(condhect,file="K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/condhect.csv",row.names=F)






# Liste des zones construites par type de résidence
levels(mitage$indice)<-c("Aire>10ha","Aire<10ha")
table(mitage$indice,mitage$`Type (ha)`)

# Superficie totale des zones construites par type de résidence
Typeaire<-aggregate(mitage[,7],by=setNames(list(mitage$`Type (ha)`),"Type de résidence"),FUN=sum)

# export de la table Typeaire en fichier csv
write.csv2(Typeaire,file="K:/myhome_etud/DOSSIERS_WINDOWS/Documents/Données et R_2.0/Typeaire.csv",row.names=F)



