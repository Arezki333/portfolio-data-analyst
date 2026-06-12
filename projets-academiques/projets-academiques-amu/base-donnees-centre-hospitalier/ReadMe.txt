### Hypothèses et Justifications pour la Création des Tables SQL ###

#Contexte:
L'objectif du projet est de modéliser un système de gestion de consultations médicales. Ce système doit permettre la gestion des médecins, des patients, des médicaments, des traitements, des consultations et des prescriptions. Les hypothèses de conception et les choix faits pour chaque table sont décrits ci-dessous.

#Hypothèses Générales
1.Modularité : Les données sont divisées en entités distinctes (médecins, patients, médicaments, consultations, traitements) pour assurer une structure claire et éviter la redondance.
2.Relations Claires : Chaque table est liée par des clés primaires et étrangères pour refléter les relations réelles entre les entités dans un contexte médical.
3.Intégrité Référentielle : Les clés étrangères sont utilisées pour garantir que chaque donnée référencée existe dans la table correspondante.

#Explications par Table

1. Table Medecins
Hypothèse : Chaque médecin est identifié par un matricule unique.
Colonnes :
matricule : Clé primaire qui garantit l'identité unique du médecin.
nom_medecin et specialite : Informations descriptives essentielles.
Raison : La spécialité est incluse pour différencier les médecins par domaine d'expertise.
2. Table Patient
Hypothèse : Chaque patient est identifié par un numéro unique.
Colonnes :
num_p : Clé primaire pour identifier un patient.
nom_p, prenom_p, date_nais, sexe, adresse : Données personnelles pour la gestion médicale.
antecedant_medical : Permet de conserver des informations sur l'historique médical.
Raison : L'adresse et l'historique médical sont pertinents pour fournir un soin de qualité.
3. Table Medicament
Hypothèse : Chaque médicament est identifié par un code unique.
Colonnes :
code : Clé primaire pour identifier un médicament.
libelle : Nom ou description du médicament.
Raison : Une table dédiée aux médicaments évite la duplication d'informations dans les prescriptions et traitements.
4. Table Traitement
Hypothèse : Un traitement est une unité distincte avec une durée définie.
Colonnes :
id_traitement : Clé primaire unique pour chaque traitement.
date_debut et date_fin : Définissent la durée du traitement.
Raison : Cette table centralise la gestion des périodes de traitement pour les patients.
5. Table Consultation
Hypothèse : Une consultation est un événement unique entre un patient et un médecin.
Colonnes :
num_consultation : Clé primaire pour identifier une consultation.
date_consu, prix, motif : Données descriptives de la consultation.
num_p : Clé étrangère vers Patient.
matricule : Clé étrangère vers Medecins.
Raison : Cette table capture l'interaction entre un patient et un médecin, incluant le motif et le coût.
6. Table prescrit
Hypothèse : Une prescription lie un médicament à une consultation.
Colonnes :
code et num_consultation : Clé primaire composite pour assurer l'unicité.
nb_prise : Nombre de prises prescrites pour un médicament.
Raison : Cette structure évite la duplication et assure la traçabilité des prescriptions.
7. Table traite
Hypothèse : Un traitement peut inclure plusieurs médicaments.
Colonnes :
code et id_traitement : Clé primaire composite pour garantir l'unicité.
Raison : Cette table établit une relation n:m entre les traitements et les médicaments.
Points Clés sur les Relations
Consultation ↔ Patient / Médecin : Liées par des clés étrangères pour relier chaque consultation à un médecin et un patient.
Prescription et Traitement : prescrit et traite utilisent des clés primaires composites pour gérer les relations n:m entre médicaments, consultations et traitements.

##Conclusion
Les hypothèses présentées permettent de concevoir une base de données relationnelle cohérente et normalisée. Cette structure facilite la gestion des données médicales tout en assurant l'intégrité et l'exactitude des informations.