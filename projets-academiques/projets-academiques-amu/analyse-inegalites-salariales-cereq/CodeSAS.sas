

/****************Analyse des residus du modèle linéaireé**************************/
title 'Analyse des résidus du modèle linéaire généralisé simple';
proc glm data=lib.table_new;
class  Q1 ;
model y = Q1  /ss3 solution ; ; means annee/hovtest;
output out=lib.residu r=residu p=predite student=resstu;
run;
quit;

data lib.residu;
set lib.residu;
 attrib
 resstu
 label="résidu studentisé";
 run;

ods graphics on;
proc univariate data= lib.residu normal plot;
var resstu ;
probplot  resstu;
run;
ods graphics off;

/* library */
libname lib "C:\Users\MASS\Desktop\M2 MASS POP\S1\données longitudinales\projet\Fichiers utiles-20241126";
Data lib.data ;
Set lib.g9810ansindividus (keep= region_INSEE DIPL92 REGION_INSEE IDENT  SALPRFIN_01  SALPRFIN_03  SALPRFIN_05  SALPRFIN_08  Q1  
 );
run;

/* Filtrer pour ne garder que les niveau bac+5 et plus et les individues de la region de l'ile de france */
data lib.data_filtrer;
    set lib.data;
    where DIPL92 = "23" and region_INSEE="11"; 
run;

/* SUPPRESSION DES INDIVIDUS QUI ONT AU MOINS UN SALAIRE NON RENSEIGNE */
DATA lib.data_filtrer;
set lib.data_filtrer; 
 if SALPRFIN_01=. or SALPRFIN_03=. or  SALPRFIN_05=. or  SALPRFIN_08=.  then delete; 
 run; 

Data lib.data_filtrer ;
Set lib.data_filtrer (keep=   IDENT  SALPRFIN_01  SALPRFIN_03  SALPRFIN_05  SALPRFIN_08  Q1  
 );
run;


/* Marco pour supprimer les individus atypiques */
%macro supp_atypique(table, var); /* on calcule d'abord q1 et q3*/
proc means data=&table. q1 q3 noprint;
var &var.;
output out=quart (drop=_type_ _freq_) q1(&var.)=q1 q3(&var.)=q3 ; /* renommage des variables */
run;

/*on récupère le premier et le troisième quartile et on calcule le seuil*/
data _NULL_;
set quart;
CALL SYMPUT("quart1",q1);
CALL SYMPUT("quart3",q3);
run;

%let seuil = %sysevalf(&quart1 + 1.5*(&quart3 - &quart1));

data &table.;
set &table.;
where &var. <= &seuil;
run;
%mend;

/* nouvelle table sans les individus atypiques : 2647 observations */
%supp_atypique(lib.data_filtrer, SALPRFIN_01);
%supp_atypique(lib.data_filtrer, SALPRFIN_03);
%supp_atypique(lib.data_filtrer, SALPRFIN_05);
%supp_atypique(lib.data_filtrer, SALPRFIN_08);

/* TRANSFORMATION DE LA TABLE INDIVIDUS EN TABLE TEMPS */
data lib.table_new;
set lib.data_filtrer;
y=SALPRFIN_01; annee= 2001; t="1";  output; 
y=SALPRFIN_03; annee= 2003; t="2";  output;
y=SALPRFIN_05; annee= 2005; t="3";  output;
y=SALPRFIN_08; annee= 2008; t="4";  output;
label y="salaire de l'individus";
label t="indice temps";
label annee="annees interrogée";
drop SALPRFIN_01 SALPRFIN_03 SALPRFIN_05 SALPRFIN_08 ;
run;

%include 'C:\Users\MASS\Desktop\M2 MASS POP\S1\données longitudinales\projet\Fichiers utiles-20241126/Formats_gene98a10ans.sas';
proc catalog catalog=work.formats;
contents;
run;

option fmtsearch=(work);

proc datasets library=lib nolist;
    modify table_new;
        format Q1 $Q1_F.;
        label Q1="Sexe";
run;
quit;

proc contents data=lib.table_new;
run;


ods rtf file="C:\Users\MASS\Desktop\M2 MASS POP\S1\données longitudinales\projet\Fichiers utiles-20241126\diagrammes spaghetti.rtf";
proc sgplot data=lib.table_new;
/*vline annee / response=y  group = person;*/  /*lineas rectas */
pbspline x=annee y=y / group = ident;		/* lineas suaves */
run;
quit;

/* Boîtes à moustaches de y (salaire) par année */
proc sgplot data=lib.table_new;
    vbox y / category=annee;
    title "Boîtes à moustaches des salaires par année";
    xaxis label="Année";
    yaxis label="Salaire";
run;

/*Moyennes de y en fonction du temps, pour chaque genre*/
proc sgplot data = lib.table_new;
 vline t / response =y group = Q1 stat = mean ;
 run;
 quit ;

ods rtf close;

/*********************************les modéles *********************************************/
/********************************* Modèle Linéaire Simple ********************************/
ods rtf file="C:\Users\MASS\Desktop\M2 MASS POP\S1\données longitudinales\projet\Fichiers utiles-20241126\regressuin_simple.rtf";
title 'modèle linéaire simple: proc GLM ';
proc glm data=lib.table_new;
class  Q1 ;
model y= Q1 /solution;
run;
ods rtf close;
/********************************* MODELE A EFFETS MIXTES ********************************/
ODS rtf file="C:\Users\MASS\Desktop\M2 MASS POP\S1\données longitudinales\projet\Fichiers utiles-20241126\effet_mixte.rtf";
ods graphics on ; 
title "Modèle à effet mixte";
proc mixed data=lib.table_new covtest plots =studentpanel(marginal)plots(maxpoints=30000);
class  IDENT Q1 ;
model y = annee Q1   / residual s;
repeated /type=UN  subject=IDENT r rcorr;
random  annee /type=UN  subject=IDENT g s;
run;
ODS rtf close;
/******************************* MODELE A EFFETS FIXES ***********************************/
ODS rtf file="C:\Users\MASS\Desktop\M2 MASS POP\S1\données longitudinales\projet\Fichiers utiles-20241126\effet_fixe.rtf";
ods graphics on ; 
title "Modèle à effet fixe ";
proc mixed data=lib.table_new  covtest plots =studentpanel(marginal)plots(maxpoints=30000);
class  t (ref="1") IDENT Q1 ;
model y = t Q1    / residual s;
repeated /type=UN  subject=IDENT r rcorr;
run;
ODS rtf CLOSE; 


/* PROCEDURE PROC SGPLOT */
/* Meilleures representations des diagrammes spaghetti avec sgplot et sgpanel */
ods rtf file="C:\Users\MASS\Desktop\M2 MASS POP\S1\données longitudinales\projet\Fichiers utiles-20241126\diagrammes spaghetti.rtf";
proc sgplot data=lib.table_new;
/*vline annee / response=y  group = person;*/  /*lineas rectas */
pbspline x=annee y=y / group = ident;		/* lineas suaves */
run;
quit;
ods rtf close;
 


