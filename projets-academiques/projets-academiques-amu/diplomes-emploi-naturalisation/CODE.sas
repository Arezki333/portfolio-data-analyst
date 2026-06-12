/*********************************************************************************************
/* M2 MASS POP Analyse des Populations 
/* Atelier de mod?lisation de donn?es socio-d?mographiques
/* Ann?e 2024-2025
/* Indrid Tucci et Nicolas Pech 

/* S?ance 1
/* Code SAS initial permettant de lire les donn?es : ? modifier et compl?ter selon vos besoins ! 
/**********************************************************************************************/


/* d?finition des biblioth?ques */
Libname teo     "C:\Users\MASS\Desktop\modelisation statistique\donnees\";  
libname mabase  "C:\Users\MASS\Documents\modelisation statistique\seance1\data";

/* contenu de la table data_teo_atelier fournie*/

proc contents data=teo.data_teo_atelier;
run;
proc means data=teo.data_teo_atelier sum ;
VAR poidsin;
run;

/* copie de travail plac?e dans la biblioth?que mabase*/
data mabase.teo;
set teo.data_teo_atelier;
run;
/* Filtrer pour ne garder que les immigrés */
data mabase.teo_immigres;
    set mabase.teo;
    where group1 = 1 & active = 1 ; 
run;

data mabase.teo_immigres;
    set mabase.teo_immigres;
    where n_frcmt = 3 or missing(n_frcmt); 
run;



data mabase.teo_immigres;
    set mabase.teo_immigres;
    if nmiss(installe) = 0;
run; 


data mabase.teo_immigres;
    set mabase.teo_immigres(keep=n_frcmt f_dip etudi p_statut p_typs active cs24_ego 
                         agenq arrivag sexee regionnaise2 l_auje l_aujl l_aujp installe  
                             m_carte m_partir inat  
                         poidsi poidsin);
run;


/* data mabase.teo_immigres;
    set mabase.teo_immigres;
    if nmiss(of _all_) = 0;
run; 
*/
proc contents data=mabase.teo_immigres;
run;


/* conversion d'une variable numerique en variable charactere*/
data mabase.teo_immigres;
set mabase.teo_immigres;
P_TYPS_c=put(P_TYPS,1.); /* d?finit la variable charactere toto ? partir de la variable num?rique active. 
                        1. signifie que le caractere consid?r? pour d?finir les modalit?s de toto aura une longueur de 1*/ 
/* Les fonctions put et input servent ? effectuer les conversion de type sous SAS, voir :
https://blogs.sas.com/content/sgf/2015/05/01/converting-variable-types-do-i-use-put-or-input/*/
label P_TYPS_c="Type d'emploi pour les salariés";
drop P_TYPS;
rename P_TYPS=P_TYPS_c;
run;


data mabase.teo_immigres;
set mabase.teo_immigres;
inat_c=put(inat,1.); /* d?finit la variable charactere toto ? partir de la variable num?rique active. 
                        1. signifie que le caractere consid?r? pour d?finir les modalit?s de toto aura une longueur de 1*/ 
/* Les fonctions put et input servent ? effectuer les conversion de type sous SAS, voir :
https://blogs.sas.com/content/sgf/2015/05/01/converting-variable-types-do-i-use-put-or-input/*/
label inat_c="Indicateur de nationnalite";
drop inat;
rename inat=inat_c;
run;

data mabase.teo_immigres;
set mabase.teo_immigres;
n_frcmt_c=put(n_frcmt,1.); /* d?finit la variable charactere toto ? partir de la variable num?rique active. 
                        1. signifie que le caractere consid?r? pour d?finir les modalit?s de toto aura une longueur de 1*/ 
/* Les fonctions put et input servent ? effectuer les conversion de type sous SAS, voir :
https://blogs.sas.com/content/sgf/2015/05/01/converting-variable-types-do-i-use-put-or-input/*/
label n_frcmt_c="Origine de la nationalité française";
drop n_frcmt;
rename n_frcmt=n_frcmt_c;
run;

data mabase.teo_immigres;
set mabase.teo_immigres;
F_dip_c=put(F_dip,1.); /* d?finit la variable charactere toto ? partir de la variable num?rique active. 
    1. signifie que le caractere consid?r? pour d?finir les modalit?s de toto aura une longueur de 1*/ 
/* Les fonctions put et input servent ? effectuer les conversion de type sous SAS, voir :
https://blogs.sas.com/content/sgf/2015/05/01/converting-variable-types-do-i-use-put-or-input/*/
label F_dip_c="Diplome le plus eleve obtenu";
drop F_dip;
rename F_dip=F_dip_c;
run;

proc contents data=mabase.teo_immigres;
run;

/*nouvelle variable*/
data mabase.teo_immigres;
set mabase.teo_immigres;
IF n_frcmt_c="3" THEN Orig_Nationalite="1"; ELSE Orig_Nationalite="0";
LABEL Orig_Nationalite="Nationalité";
RUN;

data mabase.teo_immigres;
set mabase.teo_immigres;
IF F_dip_c="." THEN diplome="0"; 
ELSE IF F_dip_c="1" THEN diplome="1";
ELSE IF F_dip_c="2" THEN diplome="2";
ELSE IF F_dip_c="3" THEN diplome="3";
ELSE IF F_dip_c="4" THEN diplome="4";
ELSE IF F_dip_c="5" THEN diplome="5";
ELSE IF F_dip_c="6" THEN diplome="6";
ELSE diplome="7";

LABEL diplome="diplome le plus élevé";
RUN;

data mabase.teo_immigres;
set mabase.teo_immigres;
IF P_TYPS_c="." THEN contrat="0";
ELSE IF P_TYPS_c="1" THEN contrat="1";
ELSE IF P_TYPS_c="2" THEN contrat="2";
ELSE IF P_TYPS_c="3" THEN contrat="3";
ELSE IF P_TYPS_c="4" THEN contrat="4";
ELSE IF P_TYPS_c="5" THEN contrat="5";
ELSE  contrat="6";
LABEL contrat="type de contrat";
RUN;

/* Création de la variable Region*/
data mabase.teo_immigres;
set mabase.teo_immigres;
IF regionnaise2>2100 & regionnaise2<3000 THEN Region="1";
ELSE IF regionnaise2>3000 & regionnaise2<3600 THEN Region="2";
ELSE IF regionnaise2>4000 & regionnaise2<4900 THEN Region="3";
ELSE IF regionnaise2>5000  THEN Region="4";
LABEL Region="Région d'origine";
RUN;

/* Création de la variable duree de sejour */
data mabase.teo_immigres;
set mabase.teo_immigres;
NbAnnees=2008-installe;
IF NbAnnees<5 THEN  duree_sejour="1";
ELSE IF NbAnnees>=5 THEN  duree_sejour ="2";
LABEL duree_sejour="duree de sejour en france";
RUN;

/* Création de la variable NiveauLangue */
data mabase.teo_immigres;
set mabase.teo_immigres;
score_langue = l_aujp + l_aujl + l_auje;
IF score_langue='.' THEN NiveauLangue="1";
ELSE IF score_langue<6 THEN NiveauLangue="2";
ELSE IF score_langue<10 THEN NiveauLangue="3";
ELSE NiveauLangue="4";
LABEL NiveauLangue="Maîtrise du français";
RUN;

/* d?finition des formats  */

PROC FORMAT LIB=mabase;
	 VALUE $P_TYPS_f
	 '0'="Contrat non renseigné"
     '1'="Contrat d'apprentissage ou de professionnalisation"
     '2'="Placement par une agence d'intérim "
	 '3'="Stage rémunéré en entreprise"
	 '4'="Emploi aidé "
	 '5'="Contrat CDD"
	 '6'="Contrat CDI";

	 VALUE $F_dip_ff
	 '0'="diplôme non renseigné"
     '1'="aucun diplome"
     '2'="CEP ou équivalent"
	 '3'="Brevet des collèges ou équivalent"
	 '4'="CAP, BEP ou équivalent"
	 '5'="Bac pro ou équivalent"
	 '6'="Bac ou équivalent"
	 '7'="Diplôme de niveau BAC + 2 ou plus" ;

VALUE $inat_f
      '0'= "Français de naissance"
	  '1'="Français par réintégration"
	  '2'="Français par acquisition"
	  '3'="Étranger";

VALUE $n_frcmt_c_f
	  '1'="depuis votre naissance"
	  '2'="par réintegration"
	  '3'="par naturalisation (y compris par effet collectif"
      '4'="par mariage"
	  '5'="par declaration ou option a votre majorite ou avant"
	  '9'="ne sait pas"
	  '.'="sans objet"
;

VALUE $n_fr_f
      '0'="immigrés non francais"
	  '1'="par naturalisation (y compris par effet collectif)"
;
	 

VALUE $REGIONF
"1"="Afrique"
"2"="Asie"
"3"="Europe"
"4"="autres(Amérique/Océanie...)";


VALUE $duree_sejour_f
"1"="Moins de 5 ans"
"2"=" 5 ans ou plus";

VALUE $niveau_lang_f
"1"="Natif/maîtrise"
"2"="Bon"
"3"="Correct"
"4"="Faible";

RUN;

/* Attachement permanent des formats */
option fmtsearch=(mabase);
proc datasets lib=mabase nolist;
modify teo_immigres;
format inat_c $inat_f.;
format n_frcmt_c $n_frcmt_c_f.;
format Orig_Nationalite $n_fr_f.;
format contrat $P_TYPS_f.;
format diplome $F_dip_ff.;
format region $REGIONF.;
format duree_sejour $duree_sejour_f.;
format NiveauLangue $niveau_lang_f.;
run;
/* Tris à plat */
ODS pdf FILE="C:\Users\MASS\Documents\modelisation statistique\seance1\data\tris a plat.pdf"; 

/* tris a plat de la variable Orig_Nationalite,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,  */
/* Titre et tableau de fréquence de la variable Orig_Nationalite sans lignes cumulées */
title "Tableau de fréquence pour la variable Orig_Nationalite sans cumul";
PROC FREQ DATA=mabase.teo_immigres;
    TABLES Orig_Nationalite / norow nocol nocum;
RUN;

/* Fréquences pondérées pour Orig_Nationalite */
title "Tableau de fréquence pondéré pour Orig_Nationalite";
proc SURVEYFREQ data=mabase.teo_immigres;
    tables Orig_Nationalite;
    weight poidsi;
run;

/* Fréquences sans pondération pour la comparaison graphique */
proc freq data=mabase.teo_immigres noprint;
    tables Orig_Nationalite / out=FreqOut_NoWeight; /* Données sans pondération */
run;

/* Fréquences avec pondération pour la comparaison graphique */
proc freq data=mabase.teo_immigres noprint;
    tables Orig_Nationalite / out=FreqOut_Weight;
    weight poidsi; /* Données avec pondération */
run;

/* Indiquer la pondération dans chaque jeu de données et les combiner */
data FreqOut_NoWeight;
    set FreqOut_NoWeight;
    Ponderation = "Sans pondération";
run;

data FreqOut_Weight;
    set FreqOut_Weight;
    Ponderation = "Avec pondération";
run;

data FreqOut_Combined;
    set FreqOut_NoWeight FreqOut_Weight;
    pct_label = cats(put(percent, 8.1), '%'); /* Étiquette pourcentage avec % */
run;

/* Comparaison des fréquences pondérées et non pondérées avec un graphique */
title "Comparaison des pourcentages pondérés et non pondérés pour Orig_Nationalite";
proc sgplot data=FreqOut_Combined;
    vbarparm category=Orig_Nationalite response=percent / group=Ponderation groupdisplay=cluster datalabel=pct_label;
    xaxis label="Origine Nationalité" grid;
    yaxis label="Pourcentage";
    keylegend / title="Type de Pondération";
run;

title; /* Réinitialisation des titres */


/* tris a plat de la variable contrat sans ponderation ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,  */
title "tris a plat contrat sans ponderation ";
  PROC FREQ DATA=mabase.teo_immigres;
    TABLES  contrat  / norow nocol nocum ;
RUN; 

title;
  /* avec ponderation*/
title "tris a plat contrat avec ponderation ";
proc SURVEYFREQ data=mabase.teo_immigres;
    tables contrat;
    weight poidsi;
run;

/* Étape 1 : Fréquences sans pondération */
proc freq data=mabase.teo_immigres noprint;
    tables contrat / out=FreqOut_NoWeight; /* Données sans pondération */
run;

/* Étape 2 : Fréquences avec pondération */
proc freq data=mabase.teo_immigres noprint;
    tables contrat / out=FreqOut_Weight;
    weight poidsi; /* Données avec pondération */
run;

/* Étape 3 : Ajouter une indication de pondération et combiner les données */
data FreqOut_NoWeight;
    set FreqOut_NoWeight;
    Ponderation = "Sans pondération";
run;

data FreqOut_Weight;
    set FreqOut_Weight;
    Ponderation = "Avec pondération";
run;

/* Combinez les deux jeux de données */
data FreqOut_Combined;
    set FreqOut_NoWeight FreqOut_Weight;
    pct_label = cats(put(percent, 8.1), '%'); /* Créer l'étiquette pourcentage avec % */
run;
title;
title "Comparaison des pourcentages pondérés et non pondérés pour Contrat";
/* Étape 4 : Créer le graphique comparatif */
proc sgplot data=FreqOut_Combined;
    vbarparm category=contrat response=percent / group=Ponderation groupdisplay=cluster datalabel=pct_label;
    yaxis label="Pourcentage" grid;
    xaxis label="Contrat";
    keylegend / title="Type de Pondération";
run;
title;

/*tris a plat de la variable diplome le plus elevé,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, ,,,,,,,,,,,,,,,,,,,,,,,,,,  */
title"tris a plat de la variable diplome le plus élevé sans ponderation";

PROC FREQ DATA=mabase.teo_immigres;
    TABLES diplome  / norow nocol nocum ;
RUN; 
title;

title"tris a plat de la variable diplome le plus elevé avec ponderation";
proc SURVEYFREQ data=mabase.teo_immigres;
    tables diplome;
    weight poidsi;
   
/* Étape 1 : Fréquences sans pondération */
proc freq data=mabase.teo_immigres noprint;
    tables diplome / out=FreqOut_NoWeight; /* Données sans pondération */
run;

/* Étape 2 : Fréquences avec pondération */
proc freq data=mabase.teo_immigres noprint;
    tables diplome / out=FreqOut_Weight;
    weight poidsi; /* Données avec pondération */
run;

/* Étape 3 : Ajouter une indication de pondération et combiner les données */
data FreqOut_NoWeight;
    set FreqOut_NoWeight;
    Ponderation = "Sans pondération";
run;

data FreqOut_Weight;
    set FreqOut_Weight;
    Ponderation = "Avec pondération";
run;

/* Combinez les deux jeux de données */
data FreqOut_Combined;
    set FreqOut_NoWeight FreqOut_Weight;
    pct_label = cats(put(percent, 8.1), '%'); /* Créer l'étiquette pourcentage avec % */
run;
title;
title "Comparaison des pourcentages pondérés et non pondérés pour diplome";
/* Étape 4 : Créer le graphique comparatif */
proc sgplot data=FreqOut_Combined;
    hbarparm category=diplome response=percent / group=Ponderation groupdisplay=cluster datalabel=pct_label;
    yaxis label="diplome" grid;
    xaxis label=" Pourcentage";
    keylegend / title="Type de Pondération";
run;

title;
title "tris a plat de la variable region sans ponderation";
/* Titre et tableau de fréquence de la variable region sans lignes cumulées */
title "Tableau de fréquence pour la variable region sans cumul";
PROC FREQ DATA=mabase.teo_immigres;
    TABLES region / norow nocol nocum;
RUN;

/* Fréquences pondérées pour region */
title "Tableau de fréquence pondéré pour region";
proc SURVEYFREQ data=mabase.teo_immigres;
    tables region;
    weight poidsi;
run;

/* Fréquences sans pondération pour la comparaison graphique */
proc freq data=mabase.teo_immigres noprint;
    tables region / out=FreqOut_NoWeight; /* Données sans pondération */
run;

/* Fréquences avec pondération pour la comparaison graphique */
proc freq data=mabase.teo_immigres noprint;
    tables region / out=FreqOut_Weight;
    weight poidsi; /* Données avec pondération */
run;

/* Indiquer la pondération dans chaque jeu de données et les combiner */
data FreqOut_NoWeight;
    set FreqOut_NoWeight;
    Ponderation = "Sans pondération";
run;

data FreqOut_Weight;
    set FreqOut_Weight;
    Ponderation = "Avec pondération";
run;

data FreqOut_Combined;
    set FreqOut_NoWeight FreqOut_Weight;
    pct_label = cats(put(percent, 8.1), '%'); /* Étiquette pourcentage avec % */
run;

/* Comparaison des fréquences pondérées et non pondérées avec un graphique */
title "Comparaison des pourcentages pondérés et non pondérés pour region";
proc sgplot data=FreqOut_Combined;
    vbarparm category=region response=percent / group=Ponderation groupdisplay=cluster datalabel=pct_label;
    xaxis label="Région" grid;
    yaxis label="Pourcentage";
    keylegend / title="Type de Pondération";
run;

title; /* Réinitialisation des titres */
 title"tris a plat de la variable duree de sejours sans ponderation";
  /* Titre et tableau de fréquence de la variable duree_sejour sans lignes cumulées */
title "Tableau de fréquence pour la variable duree_sejour sans cumul";
PROC FREQ DATA=mabase.teo_immigres;
    TABLES duree_sejour / norow nocol nocum;
RUN;

/* Fréquences pondérées pour duree_sejour */
title "Tableau de fréquence pondéré pour duree_sejour";
proc SURVEYFREQ data=mabase.teo_immigres;
    tables duree_sejour;
    weight poidsi;
run;

/* Fréquences sans pondération pour la comparaison graphique */
proc freq data=mabase.teo_immigres noprint;
    tables duree_sejour / out=FreqOut_NoWeight; /* Données sans pondération */
run;

/* Fréquences avec pondération pour la comparaison graphique */
proc freq data=mabase.teo_immigres noprint;
    tables duree_sejour / out=FreqOut_Weight;
    weight poidsi; /* Données avec pondération */
run;

/* Indiquer la pondération dans chaque jeu de données et les combiner */
data FreqOut_NoWeight;
    set FreqOut_NoWeight;
    Ponderation = "Sans pondération";
run;

data FreqOut_Weight;
    set FreqOut_Weight;
    Ponderation = "Avec pondération";
run;

data FreqOut_Combined;
    set FreqOut_NoWeight FreqOut_Weight;
    pct_label = cats(put(percent, 8.1), '%'); /* Étiquette pourcentage avec % */
run;

/* Comparaison des fréquences pondérées et non pondérées avec un graphique */
title "Comparaison des pourcentages pondérés et non pondérés pour duree_sejour";
proc sgplot data=FreqOut_Combined;
    vbarparm category=duree_sejour response=percent / group=Ponderation groupdisplay=cluster datalabel=pct_label;
    xaxis label="Durée de séjour" grid;
    yaxis label="Pourcentage";
    keylegend / title="Type de Pondération";
run;

title;

/* tris a plat de la variable niveau de langue,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,  */
  /* Titre et tableau de fréquence de la variable NiveauLangue sans lignes cumulées */
title "Tableau de fréquence pour la variable NiveauLangue ";
PROC FREQ DATA=mabase.teo_immigres;
    TABLES NiveauLangue / norow nocol nocum;
RUN;

/* Fréquences pondérées pour NiveauLangue */
title "Tableau de fréquence pondéré pour NiveauLangue";
proc SURVEYFREQ data=mabase.teo_immigres;
    tables NiveauLangue;
    weight poidsi;
run;

/* Fréquences sans pondération pour la comparaison graphique */
proc freq data=mabase.teo_immigres noprint;
    tables NiveauLangue / out=FreqOut_NoWeight; /* Données sans pondération */
run;

/* Fréquences avec pondération pour la comparaison graphique */
proc freq data=mabase.teo_immigres noprint;
    tables NiveauLangue / out=FreqOut_Weight;
    weight poidsi; /* Données avec pondération */
run;

/* Indiquer la pondération dans chaque jeu de données et les combiner */
data FreqOut_NoWeight;
    set FreqOut_NoWeight;
    Ponderation = "Sans pondération";
run;

data FreqOut_Weight;
    set FreqOut_Weight;
    Ponderation = "Avec pondération";
run;

data FreqOut_Combined;
    set FreqOut_NoWeight FreqOut_Weight;
    pct_label = cats(put(percent, 8.1), '%'); /* Étiquette pourcentage avec % */
run;

/* Comparaison des fréquences pondérées et non pondérées avec un graphique */
title "Comparaison des pourcentages pondérés et non pondérés pour NiveauLangue";
proc sgplot data=FreqOut_Combined;
    vbarparm category=NiveauLangue response=percent / group=Ponderation groupdisplay=cluster datalabel=pct_label;
    xaxis label=" Niveau de Langue" grid;
    yaxis label="Pourcentage";
    keylegend / title="Type de Pondération";
run;

title;
ODS pdf CLOSE;
/* croisement*/ 
ODS pdf FILE="C:\Users\MASS\Documents\modelisation statistique\seance1\data\triscroisé.pdf";
proc SURVEYFREQ data=mabase.teo_immigres;
    tables Orig_Nationalite * contrat /  CL CHISQ EXPECTED;
 WEIGHT poidsi;  
run;
proc SURVEYFREQ  data=mabase.teo_immigres;
    tables Orig_Nationalite * diplome/  CL CHISQ EXPECTED ;
   WEIGHT poidsi;
run;

proc SURVEYFREQ data=mabase.teo_immigres;
    tables Orig_Nationalite * region / CL CHISQ EXPECTED ;
   WEIGHT poidsi;
run;

proc SURVEYFREQ data=mabase.teo_immigres;
    tables Orig_Nationalite * NiveauLangue / CL CHISQ EXPECTED;
   WEIGHT poidsi;
run;

 proc SURVEYFREQ data=mabase.teo_immigres;
    tables Orig_Nationalite * duree_sejour / CL CHISQ EXPECTED;
   WEIGHT poidsi;
run;
 
ODS pdf CLOSE;

/* modèle logistique */

/* Mise en oeuvre du modèle logistique pour la variable Orig_Nationalite */
ODS pdf FILE="C:\Users\MASS\Documents\modelisation statistique\seance1\data\modèle_logistique.pdf";
proc SURVEYLOGISTIC data=mabase.teo_immigres;
    /* Variables explicatives */
    class contrat (REF="Contrat CDI") 
          diplome (REF="Diplôme de niveau BAC + 2  ou supérieur à BAC + 2")
          region (REF="Afrique") 
          NiveauLangue (REF="Natif/maîtrise") 
          duree_sejour (REF="5 ans ou plus")
          / param=ref;  /* Utilisation des valeurs de référence */
    /* Définition du modèle avec Orig_Nationalite comme variable dépendante */
    model Orig_Nationalite(event="par naturalisation (y compris par effet collectif)") = 
          contrat diplome region NiveauLangue duree_sejour;
    weight poidsi;
	run;
ODS pdf CLOSE;



