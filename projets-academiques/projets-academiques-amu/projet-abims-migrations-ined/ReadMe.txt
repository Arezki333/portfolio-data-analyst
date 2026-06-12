# README du Projet de Migration

---

## 1. Structure du rendu de projet

Le projet est divisé en deux parties principales : **données** et **codes R**.

### 1.1. Dossier **données**
Le dossier **données** contient les tables nécessaires à l'analyse. Les tables sont organisées comme suit :
- **Tables des organismes** : Ces tables contiennent les données brutes des différents organismes (OCDE, Banque Mondiale, Eurostat, Nations Unies).
- **Tables fusionnées** : Ce sont les tables résultant de la fusion des différentes sources pour permettre une analyse comparative.

### 1.2. Dossier **programme**
Le dossier **programme** contient les scripts en langage R utilisés pour le traitement et l'analyse des données. Il est subdivisé en deux sous-dossiers :
  
#### 1.2.1. **Sous-dossier 1 : Construction des tables**
Ce sous-dossier contient les programmes ayant permis de traiter, nettoyer et fusionner les différentes bases de données (OCDE, Banque Mondiale, Eurostat, Nations Unies). Les tâches incluent :
- Chargement des données des différentes sources.
- Nettoyage et prétraitement des données (suppression des valeurs manquantes, gestion des doublons, etc.).
- Fusion des tables provenant des différents organismes pour faciliter une analyse globale.

#### 1.2.2. **Sous-dossier 2 : Méthodes statistiques et détection des valeurs aberrantes**
Ce sous-dossier contient les programmes utilisés pour appliquer les méthodes statistiques sur les données :
- Application des méthodes **Z-score** et **Intervalle Interquartile (IQR)** pour détecter les valeurs aberrantes dans les données migratoires.
- Génération de graphiques permettant de visualiser les résultats des analyses.

---

## 2. Rapport de 23 pages du projet.
---

## 5. Contact

Pour toute question ou commentaire concernant ce projet, veuillez nous contacter à l'adresse suivante : **[mathieu.grondin@etu.univ-amu.fr]**.

