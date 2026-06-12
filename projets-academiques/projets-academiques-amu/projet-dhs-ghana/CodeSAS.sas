LIBNAME prj"\\salsa.univ-amu.fr\dfs\myhome_etud\DOSSIERS_WINDOWS\Documents\Miniprojet";
		
options fmtsearch=(prj);

PROC SORT DATA=prj.Ghir72fl;
	 BY V002;
	 RUN;

	 DATA prj.Ghir72fl;
	 SET prj.Ghir72fl;
	 RENAME V002=HV002;
	 RUN;
	 
	 PROC SORT DATA=prj.Ghpr72fl;
	 BY HV002;
	 RUN;

	 DATA prj.BASE;
	 MERGE prj.Ghir72fl prj.Ghpr72fl;
	 BY HV002;
	 RUN;

	 /* Création de la table ménage contenant les variables imposées et les variables qui nous intéressent */

DATA prj.menage; 
set prj.base
(keep=HHID HV005 HV009 HV012 HV013 HV014 HV024 HV025 HV201 HV204 HV205 HV206 HV207 HV208 HV209 HV210 HV211 HV212 HV213 HV214 HV215 HV216 
		HV217 HV218 HV219 HV220 HV221 HV225 HV226 HV227 HV228 HV230B HV241 HV243A SH110D SH110L SH110P SH110Q SH110R SH110S V013 V190 V750 V751 V754CP V754DP V754JP V754WP V756 V106 V155 V157 V158 V159 V761 V855 V823);
run;


/* Formats des variables imposées */

proc formats library=prj;
    value Region 
     1 = "Western"
     2 = "Central"
     3 = "Greater Accra"
     4 = "Volta"
     5 = "Eastern"
     6 = "Ashanti"
     7 = "Brong Ahafo"
     8 = "Northern"
     9 = "Upper East"
    10 = "Upper West"	
	 ;
     value typres
     1 = "Urban"
     2 = "Rural"
     ;
     value eaupota
    10 = "PIPED WATER"
    11 = "Piped into dwelling"
    12 = "Piped to yard/plot"
    13 = "Public tap/standpipe"
    20 = "TUBE WELL WATER"
    21 = "Tube well or borehole"
    30 = "DUG WELL (OPEN/PROTECTED)"
    31 = "Protected well"
    32 = "Unprotected well"
    40 = "SURFACE WATER"
    41 = "Protected spring"
    42 = "Unprotected spring"
    43 = "River/dam/lake/ponds/stream/canal/irrigation channel"
    51 = "Rainwater"
    61 = "Tanker truck"
    62 = "Cart with small tank"
    71 = "Bottled water"
    72 = "Sachet water"
    96 = "Other"
     ;
     value timesou
   996 = "On premises"
   998 = "Don't know"
     ;
    
     value typewc
    10 = "FLUSH TOILET"
    11 = "Flush to piped sewer system"
    12 = "Flush to septic tank"
    13 = "Flush to pit latrine"
    14 = "Flush to somewhere else"
    15 = "Flush, don't know where"
    20 = "PIT TOILET LATRINE"
    21 = "Ventilated Improved Pit latrine (VIP)"
    22 = "Pit latrine with slab"
    23 = "Pit latrine without slab/open pit"
    30 = "NO FACILITY"
    31 = "No facility/bush/field"
    41 = "Composting toilet"
    42 = "Bucket toilet"
    43 = "Hanging toilet/latrine"
    96 = "Other"
     ;
  value elec
     0 = "No"
     1 = "Yes"
     ;
  value radio
     0 = "No"
     1 = "Yes"
     ;
  value coltv
     0 = "No"
     1 = "Yes"
     ;
  value refrig
     0 = "No"
     1 = "Yes"
     ;
  value bicy
     0 = "No"
     1 = "Yes"
     ;
  value moto
     0 = "No"
     1 = "Yes"
     ;
  value voit
     0 = "No"
     1 = "Yes"
     ;
   value materrdc
    11 = "Earth, sand"
    12 = "Dung"
    21 = "Wood planks"
    31 = "Parquet, polished wood"
    32 = "Vinyl, asphalt strips"
    33 = "Ceramic/marble/porcelain tiles / terrazo"
    34 = "Cement"
    35 = "Woolen carpets/ synthetic carpet"
    36 = "Linoleum/rubber carpet"
    96 = "Other"
     ;
  value matemur
    11 = "No walls"
    12 = "Cane / palm / trunks"
    13 = "Dirt"
    21 = "Bamboo with mud"
    22 = "Stone with mud"
    23 = "Uncovered adobe"
    24 = "Plywood"
    25 = "Cardboard"
    26 = "Reused wood"
    31 = "Cement"
    32 = "Stone with lime / cement"
    33 = "Bricks"
    34 = "Cement blocks"
    35 = "Covered adobe"
    36 = "Wood planks / shingles"
    96 = "Other"
     ;
  value matetoit
    11 = "No roof"
    12 = "Thatch / palm leaf"
    13 = "Sod"
    21 = "Rustic mat"
    22 = "Palm / bamboo"
    23 = "Wood planks"
    24 = "Cardboard"
    31 = "Metal"
    32 = "Wood"
    33 = "Calamine / cement fiber"
    34 = "Ceramic tiles"
    35 = "Cement"
    36 = "Roofing shingles"
    37 = "Asbestos/slate roofing sheets"
    96 = "Other"
     ;
  value structrelati
     0 = "No adults"
     1 = "One adult"
     2 = "Two adults, opposite sex"
     3 = "Two adults, same sex"
     4 = "Three+ related adults"
     5 = "Unrelated adults"
     ;
  value sexchef
     1 = "Male"
     2 = "Female"
     ;
  value agechef
    97 = "97+"
    98 = "Don't know"
     ;
  value teleph
     0 = "No"
     1 = "Yes"
     ;
  value partagwc
     0 = "No"
     1 = "Yes, other household only"
     2 = "Yes, public"
     ;
  value typefuel
     1 = "Electricity"
     2 = "LPG"
     3 = "Natural gas"
     4 = "Biogas"
     5 = "Kerosene"
     6 = "Coal, lignite"
     7 = "Charcoal"
     8 = "Wood"
     9 = "Straw/shrubs/grass"
    10 = "Agricultural crop"
    11 = "Animal dung"
    95 = "No food cooked in house"
    96 = "Other"
     ;
  value sleepmousti
     0 = "No"
     1 = "Yes"
     ;
  value enfanmousti
     0 = "No"
     1 = "All children"
     2 = "Some children"
     3 = "No net in household"
     ;
                     
  value locsoureau
     1 = "In own dwelling"
     2 = "In own yard/plot"
     3 = "Elsewhere"
	 ;

   value telephmob
     0 = "No"
     1 = "Yes"
     ;

   value orditablet
     0 = "No"
     1 = "Yes"
     ;
  
   value lit
     0 = "No"
     1 = "Yes"
     ;
  value table
     0 = "No"
     1 = "Yes"
     ;
  value placard
     0 = "No"
     1 = "Yes"
     ;
  value accesweb
     0 = "No"
     1 = "Yes"
     ;


 /* Création des formats des variables intéressantes */



	 value cateage
     1 = "15-19"
     2 = "20-24"
     3 = "25-29"
     4 = "30-34"
     5 = "35-39"
     6 = "40-44"
     7 = "45-49"
     ;

    value alphab
     0 = "Cannot read at all"
     1 = "Able to read only parts of sentence"
     2 = "Able to read whole sentence"
     3 = "No card with required language"
     4 = "Blind/visually impaired"
     ;

     value eaulavmains
     0 = "Water not available"
     1 = "Water is available"
	 ;
    value blawhitv
     0 = "No"
     1 = "Yes"
     ;
	value hearinfesex
     0 = "No"
     1 = "Yes"
     8 = "Don't know"
     ;
     value heardsida
     0 = "No"
     1 = "Yes"
     ;
	 
	 value preservatif
     0 = "No"
     1 = "Yes"
     8 = "Don't know"
     ;
	 value partsex
     0 = "No"
     1 = "Yes"
     8 = "Don't know"
     ;
	 value partagnourrvih
     0 = "No"
     1 = "Yes"
     8 = "Don't know"
     ;
	 value santevih
     0 = "No"
     1 = "Yes"
     8 = "Don't know"
     ;
	 value freqmagaz
     0 = "Not at all"
     1 = "Less than once a week"
     2 = "At least once a week"
     3 = "Almost every day"
     ;

      value freqradio
     0 = "Not at all"
     1 = "Less than once a week"
     2 = "At least once a week"
     3 = "Almost every day"
     ;

      value freqtv
     0 = "Not at all"
     1 = "Less than once a week"
     2 = "At least once a week"
     3 = "Almost every day"
      ;
     value educamore
	 0 = "No education"
     1 = "Primary"
     2 = "Secondary"
     3 = "Higher"
     8 = "Don't know"
     ;

    value mosqhiv
     0 = "No"
     1 = "Yes"
     8 = "Don't know"
     ;

	 value rich
     1 = "Poorest"
     2 = "Poorer"
     3 = "Middle"
     4 = "Richer"
     5 = "Richest"
     ;

	 value condom
     0 = "No"
     1 = "Yes"
     8 = "Don't know"
     ;

	 value infsida

	 0 = "No"
     1 = "Yes"
     8 = "Don't know"
     ;

	 value witchcraft

	 0 = "No"
     1 = "Yes"
     8 = "Don't know"
     ;

	RUN;

/* Format des variables imposées */
DATA prj.menage;
SET prj.menage;

    cHV024=put(HV024, Region.);
	cHV025=put(HV025, typres.);
	cHV201=put(HV201, eaupota.);
	cHV204=put(HV204, timesou.);
	cHV205=put(HV205, typewc.);
	cHV206=put(HV206, elec.);
	cHV207=put(HV207, radio.);
	cHV208=put(HV208, coltv.);
	cHV209=put(HV209, refrig.);
	cHV210=put(HV210, bicy.);
	cHV211=put(HV211, moto.);
	cHV212=put(HV212, voit.);
	cHV213=put(HV213, materrdc.);
	cHV214=put(HV214, matemur.);
	cHV215=put(HV215, matetoit.);
	cHV217=put(HV217, structrelati.);
	cHV219=put(HV219, sexchef.);
	cHV220=put(HV220, agechef.);
	cHV221=put(HV221, teleph.);
	cHV225=put(HV225, partagwc.);
	cHV226=put(HV226, typefuel.);
	cHV227=put(HV227, sleepmousti.);
	cHV228=put(HV228, enfanmousti.);
	cHV243A=put(HV243A,telephmob.);
	cSH110L=put(SH110L,orditablet.);
	cSH110P=put(SH110P,lit.);
	cSH110Q=put(SH110Q,table.);
	cSH110R=put(SH110R,placard.);
	cSH110S=put(SH110S,accesweb.);

	/* Format des variables intéressantes */

    cSH110D=put(SH110D,blawhitv.);
	cHV230B=put(HV230B,locsoureau.);
	cV013=put(V013,cateage.);
	cV750=put(V750,hearinfesex.);
	cV751=put(V751,heardsida.);
	cV754CP=put(V754CP,preservatif.);
	cV754DP=put(V754DP,partsex.);
	cV754JP=put(V754JP,mosqhiv.);
	cV754WP=put(V754WP,partagnourrvih.);
	cV756=put(V756,santevih.);
    cV106=put(V106,educamore.);
	cV190=put(V190,rich.);
	cV155=put(V155,alphab.);
    cV157=put(V157,freqmagaz.);
    cV158=put(V158,freqradio.);
    cV159=put(V159,freqtv.);
	cV761=put(V761,condom.);
	cV855=put(V855,infsida.);
	cV823=put(V823,witchcraft.);
  run;

DATA prj.menage;
set prj.menage;
drop HV024 HV025 HV201 HV204 HV205 HV206 HV207 HV208 HV209 HV210 HV211 HV212 HV213 HV214 HV215 HV217 HV219 HV220 HV221 HV225 HV226 HV227 
		HV228 HV243A SH110L SH110P SH110Q SH110R SH110S SH110D HV230B V013 V190 V501 V505 V750 V751 V754CP V754DP V754JP V754WP V756 V106 V155 V157 V158 V159 V761 V855 V823;
run;




/*attribution des formats des variables imposées à la table menage*/
data prj.menage; 
     set prj.menage;
     LABEL cHV024="Region"
  cHV025="Type of place of residence"
  cHV201="Source of drinking water"
  cHV204="Time to get to water source (minutes)"
  cHV205="Type of toilet facility"
  cHV206="Has electricity"
  cHV207="Has radio"
  cHV208="Has television"
  cHV209="Has refrigerator"
  cHV210="Has bicycle"
  cHV211="Has motorcycle/scooter"
  cHV212="Has car/truck"
  cHV213="Main floor material"
  cHV214="Main wall material"
  cHV215="Main roof material"
  cHV217="Relationship structure"
  cHV219="Sex of head of household"
  cHV220="Age of head of household"
  cHV221="Has telephone (land-line)"
  cHV225="Share toilet with other households"
  cHV226="Type of cooking fuel"
  cHV227="Has mosquito bed net for sleeping"
  cHV228="Children under 5 slept under mosquito bed net last night"
  cHV243A="Has mobile telephone"
  cSH110L="Has computer/tablet computer"
  cSH110P="Has bed"
  cSH110Q="Has table"
  cSH110R="Has cabinet/cupboard"
  cSH110S="Has access to the internet in any device"

  /*attribution des formats des variables intéressantes à la table menage*/

  cHV230B="Presence of water at hand washing place"
  cSH110D="Has a black/white television"
  cV013="Age in 5-year groups"
  cV750="Ever heard of a Sexually Transmitted Infection"
  cV751="Ever heard of AIDS"
  cV754CP="Reduce risk of getting HIV: always use condoms"
  cV754DP=" Reduce risk of getting HIV: have 1 sex partner"
  cV754JP="Can get HIV from mosquito bites"
  cV754WP="Can get HIV by sharing food with person who has infected with HIV"
  cV756="A healthy looking person can have HIV"
  cV106="Highest level of education"
  cV190="Wealth index"
  cV155="Literacy"
  cV157="Frequency of reading newspaper or magazine"
  cV158="Frequency of listening to radio"
  cV159="Frequency of watching television"
  cV761="Condom used during last sex with most recent partner"
  cV855="Received couseling after tested for AIDS during antenatal"
  cV823="Can get HIV by witchcraft or supernatural means"
   ;
  run;

  proc contents data=prj.menage;
  run;


  /* Tris à plat */

ODS RTF FILE="\\salsa.univ-amu.fr\dfs\myhome_etud\DOSSIERS_WINDOWS\Documents\Miniprojet\Tris à plat.rtf";


/* Âge par groupes de 5 ans */

PROC FREQ DATA=prj.menage;
    TABLE cV013;
	run;

PROC GCHART DATA=prj.menage;
	HBAR cV013;
run;

/* 1. Dimension géographique */
  /* 1.1. variable région */
title "Tri à plat";
FOOTNOTE "Données issues de la table menage";

PROC FREQ DATA=prj.menage;
    TABLES cHV024 / binomial;
run;

PROC GCHART DATA=prj.menage;
	PIE cHV024;
run;

  /* 1.2. variable type de lieu de résidence */

PROC FREQ DATA=prj.menage;
    TABLES cHV025 / binomial;
run;

PROC GCHART DATA=prj.menage;
	PIE cHV025;
run;

/* 2. Dimension educative */
  /* 2.1. variable niveau d'éducation le plus élevé */

PROC FREQ DATA=prj.menage;
    TABLES cV106 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV106;
run;

   /* 2.2. variable alphabétisation */

PROC FREQ DATA=prj.menage;
    TABLES cV155/ binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV155;
run;

   /* 2.3. variable utilisation de la télévision */

PROC FREQ DATA=prj.menage;
    TABLES cV159/ binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV159;
run;

   /* 2.4. variable utilisation de la radio */

PROC FREQ DATA=prj.menage;
    TABLES cV158/ binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV158;
run;

  /* 2.5. variable utilisation du magazine */

PROC FREQ DATA=prj.menage;
    TABLES cV157/ binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV157;
run;



/* 3. Dimension économique */
   /* 3.1. variable électricité */

PROC FREQ DATA=prj.menage;
    TABLES cHV206 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cHV206;
run; 

  /* 3.2. La variable radio */

PROC FREQ DATA=prj.menage;
    TABLES cHV207 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cHV207;
run; 

  /* 3.3. La variable voiture */

PROC FREQ DATA=prj.menage;
    TABLES cHV212 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cHV212;
run; 

   /* 3.4. La variable réfrigérateur */

PROC FREQ DATA=prj.menage;
    TABLES cHV209 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cHV209;
run; 

  /* 3.5. La variable vélo */

PROC FREQ DATA=prj.menage;
    TABLES cHV210 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cHV210;
run;


 /* 3.6. La variable télévision en couleur */
 
PROC FREQ DATA=prj.menage;
    TABLES cHV208 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cHV208;
run;


   /* 3.7. La variable internet */

PROC FREQ DATA=prj.menage;
    TABLES cSH110S / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cSH110S;
run;

 /* 3.8. La variable indice de richesse */

PROC FREQ DATA=prj.menage;
    TABLES cV190 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV190;
run;

/* 3.9. La variable ordinateur */

PROC FREQ DATA=prj.menage;
    TABLES cSH110L/ binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cSH110L;
run;


   

/* 4. Dimension VIH
   /* 4.1. La variable information sur le VIH */

PROC FREQ DATA=prj.menage;
    TABLES cV750 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV750;
run;

   /* 4.2. La variable information sur le SIDA */

PROC FREQ DATA=prj.menage;
    TABLES cV751 / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV751;
run;

   /* 4.3. La variable méthode du préservatif */

PROC FREQ DATA=prj.menage;
    TABLES cV754CP / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV754CP;
run;

   /* 4.4. La variable transmission du VIH par la nourriture */

PROC FREQ DATA=prj.menage;
    TABLES cV754WP / binomial;
run;

PROC GCHART DATA=prj.menage;
	HBAR cV754WP;
run;

  /* 4.5. La variable contracter le VIH par des moustiques */

PROC FREQ DATA=prj.menage;
     TABLES cV754JP / binomial;
run;

PROC GCHART DATA=prj.menage;
     HBAR cV754JP;
run;

 /* 4.6. La variable personne en bonne santé contractant le VIH */

PROC FREQ DATA=prj.menage;
     TABLES cV756 / binomial;
run;

PROC GCHART DATA=prj.menage;
     HBAR cV756;
run;

/* 4.7. La variable utilisation du préservatif avec le partenaire le plus récent */

PROC FREQ DATA=prj.menage;
     TABLES cV761/ binomial;
run;

PROC GCHART DATA=prj.menage;
     HBAR cV761;
run;

/* 4.8. La variable contracter le VIH par sorcellerie ou moyens surnaturels */

PROC FREQ DATA=prj.menage;
     TABLES cV823/ binomial;
run;

PROC GCHART DATA=prj.menage;
     HBAR cV823;
run;
   
ODS RTF CLOSE;


  /* Tris croisés */

ODS RTF FILE="\\salsa.univ-amu.fr\dfs\myhome_etud\DOSSIERS_WINDOWS\Documents\miniprojet\tricrois.rtf";

/* 1. On effectue les tris croisés des indicateurs de la communication préventive en fonction de l'âge */

/* age*information sur le VIH */

TITLE "Tris croisés de la variable age et l'information sur le VIH ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV750 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;


/* age*methode du préservatif */

TITLE "Tris croisés de la variable age et méthode du préservatif ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV754CP / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*partenaire sexuel */

TITLE "Tris croisés de la variable age et partenaire sexuel ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV754DP / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*infection par nourriture */

TITLE "Tris croisés de la variable age et infection par nourriture ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV754WP / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*infection par sorcellerie */

TITLE "Tris croisés de la variable age et infection par sorcellerie ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV823 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;


/* age*infection par piqures de moustiques */

TITLE "Tris croisés de la variable age et infection par piqures de moustiques ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV754JP / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;


/* age*préservatif utilisé recemment */

TITLE "Tris croisés de la variable age et preservatif utilisé récemment ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV761 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;



/* 2.On effectue les tris croisés des indicateurs du niveau de vie en fonction de l'age */

/* age*radio */

TITLE "Tris croisés de la variable age et radio ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cHV207 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*television */

TITLE "Tris croisés de la variable age et television ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cHV208 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*computer */

TITLE "Tris croisés de la variable age et computer ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cSH110L / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*internet */

TITLE "Tris croisés de la variable age et internet ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cSH110S / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*niveau d'éducation */

TITLE "Tris croisés de la variable age et niveau d'éducation ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV106 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*indice de richesse */

TITLE "Tris croisés de la variable age et indice de richesse ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV190 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*utilisation radio */

TITLE "Tris croisés de la variable age et utilisation radio ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV158 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*utilisation television */

TITLE "Tris croisés de la variable age et utilisation télévision ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV159 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*utilisation magazine */

TITLE "Tris croisés de la variable age et magazine ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cV157 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* age*electricité */

TITLE "Tris croisés de la variable age et électricité ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV013*cHV206 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;



/* 3. On effectue le croisement entre la variable indice de richesse et la communication préventive sur le VIH/Sida */

/* indice de richesse*information VIH */

TITLE "Tris croisés de la variable indice de richesse et information sur le VIH  ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV190*cV750 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;



/* indice de richesse*préservatif utilisé recemment */


TITLE "Tris croisés de la variable indice de richesse et préservatif utilisé recemment  ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV190*cV761 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;


/* indice de richesse*infection par moustiques */


TITLE "Tris croisés de la variable indice de richesse et infection par moustiques ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV190*cV754JP / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* indice de richesse*infection par sorcellerie */


TITLE "Tris croisés de la variable indice de richesse et infection par moustiques ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV190*cV823 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* indice de richesse*infection par nourriture */

TITLE "Tris croisés de la variable indice de richesse et infection par nourriture ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cV190*cV754WP / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;




/* 4. On effectue le croisement entre la variable type de lieu de résidence et la connaissance sur le VIH/Sida */

/* type de lieu de résidence*information VIH */

TITLE "Tris croisés de la variable type de lieu de résidence et information sur le VIH  ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cHV025*cV750 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;


/* type de lieu de résidence*préservatif utilisé recemment */


TITLE "Tris croisés de la variable type de lieu de résidence et préservatif utilisé recemment  ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cHV025*cV761 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;


/* type de lieu de résidence*infection par moustiques */


TITLE "Tris croisés de la variable type de lieu de résidence et infection par moustiques ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cHV025*cV754JP / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* type de lieu de résidence*infection par sorcellerie */


TITLE "Tris croisés de la variable type de lieu de résidence et infection par sorcellerie ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cHV025*cV823 / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;

/* type de lieu de résidence*infection par nourriture */

TITLE "Tris croisés de la variable type de lieu de résidence et infection par nourriture ?";
FOOTNOTE "Données de la table menage.";

PROC FREQ DATA=prj.menage;
	TABLE cHV025*cV754WP / EXPECTED DEVIATION CELLCHI2 CHISQ;
RUN;



ODS RTF CLOSE;




