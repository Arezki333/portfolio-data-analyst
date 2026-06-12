REM   Script: TP_note_final
REM   TPSQL_note

CREATE TABLE Medecins( 
        matricule   Int NOT NULL , 
        nom_medecin Varchar (50) NOT NULL , 
        specialite  Varchar (50) NOT NULL 
	,CONSTRAINT Medecins_PK PRIMARY KEY (matricule) 
);

CREATE TABLE Patient( 
        num_p     Int NOT NULL , 
        nom_p     Varchar (50) NOT NULL , 
        prenom_p  Varchar (50) NOT NULL , 
        date_nais Date NOT NULL , 
        sexe      Varchar (50) NOT NULL , 
        adresse   Varchar (50) NOT NULL, 
      antecedant_medical Varchar (50)  NULL 
	,CONSTRAINT Patient_PK PRIMARY KEY (num_p) 
);

CREATE TABLE Medicament( 
        code    Int NOT NULL , 
        libelle Varchar (50) NOT NULL 
	,CONSTRAINT Medicament_PK PRIMARY KEY (code) 
);

CREATE TABLE Traitement( 
        id_traitement Int NOT NULL , 
        date_debut    Date NOT NULL , 
        date_fin      Date NOT NULL  
	,CONSTRAINT Traitement_PK PRIMARY KEY (id_traitement) 
);

CREATE TABLE Consultation( 
        num_consultation Int NOT NULL , 
        date_consu       Date NOT NULL , 
        prix             Float NOT NULL , 
        motif            Varchar (50) NOT NULL , 
        num_p            Int NOT NULL , 
        matricule        Int NOT NULL 
	,CONSTRAINT Consultation_PK PRIMARY KEY (num_consultation) 
 
	,CONSTRAINT Consultation_Patient_FK FOREIGN KEY (num_p) REFERENCES Patient(num_p) 
	,CONSTRAINT Consultation_Medecins0_FK FOREIGN KEY (matricule) REFERENCES Medecins(matricule) 
);

CREATE TABLE prescrit( 
        code             Int NOT NULL , 
        num_consultation Int NOT NULL , 
        nb_prise         Int NOT NULL 
	,CONSTRAINT prescrit_PK PRIMARY KEY (code,num_consultation) 
 
	,CONSTRAINT prescrit_Medicament_FK FOREIGN KEY (code) REFERENCES Medicament(code) 
	,CONSTRAINT prescrit_Consultation0_FK FOREIGN KEY (num_consultation) REFERENCES Consultation(num_consultation) 
);

CREATE TABLE traite( 
        code          Int NOT NULL , 
        id_traitement Int NOT NULL 
	,CONSTRAINT traite_PK PRIMARY KEY (code,id_traitement) 
 
	,CONSTRAINT traite_Medicament_FK FOREIGN KEY (code) REFERENCES Medicament(code) 
	,CONSTRAINT traite_Traitement0_FK FOREIGN KEY (id_traitement) REFERENCES Traitement(id_traitement) 
);

INSERT INTO Patient VALUES (1, 'Zoghlami', 'Hakim', '05-APR-2000', 'M', 'Marseille 15', 'Cardiomyopathie');

INSERT INTO Patient VALUES (2, 'Martin', 'Sophie', '22-MAR-1985', 'F', 'Marseille 13', 'Asthme');

INSERT INTO Patient VALUES (3, 'Bamcolo', 'Luqman', '01-DEC-1978', 'M', 'Marseille 15', 'Diabète');

INSERT INTO Patient VALUES (4, 'Boussoumart', 'Emma', '08-JUL-1995', 'F', 'Marseille 16', 'Allergie');

INSERT INTO Patient VALUES (5, 'Fasfat', 'Sophiane', '17-NOV-1982', 'M', 'Marseille 14', 'Migraine');

INSERT INTO Patient VALUES (6, 'Abou', 'Meredhit', '05-APR-1999', 'F', 'Marseille 07', NULL);

INSERT INTO Patient VALUES (7, 'Ali', 'Farid', '29-SEP-2000', 'M', 'Marseille 09', 'cardiomyopathie	');

INSERT INTO Patient VALUES (8, 'Petit', 'Claire', '15-JAN-1987', 'F', 'Marseille 10', 'Asthme');

INSERT INTO Patient VALUES (9, 'Lemoine', 'Julien', '10-OCT-1992', 'M', 'Marseille 11', NULL);

INSERT INTO Patient VALUES (10, 'Garcia', 'Lucie', '22-FEB-1995', 'F', 'Lille', 'Allergie');

INSERT INTO Patient VALUES (11, 'Ben Amar', 'Yacine', '15-MAY-1995', 'M', 'Marseille 14', 'Diabète');

INSERT INTO Patient VALUES (12, 'Bensalem', 'Khadija', '22-APR-1980', 'F', 'Marseille 13', 'Hypertension');

INSERT INTO Patient VALUES (13, 'Benkacem', 'Mounir', '01-JAN-2002', 'M', 'Marseille 15', 'Cardiomyopathie');

INSERT INTO Patient VALUES (14, 'Saidi', 'Fatima', '08-MAR-1990', 'F', 'Marseille 10', NULL);

INSERT INTO Patient VALUES (15, 'Zeroual', 'Ahmed', '25-DEC-1978', 'M', 'Marseille 16', 'Cardiomyopathie');

INSERT INTO Patient VALUES (16, 'Bouchaib', 'Imane', '05-SEP-1988', 'F', 'Marseille 14', 'Migraine');

INSERT INTO Patient VALUES (17, 'Cherif', 'Nassim', '12-OCT-1997', 'M', 'Marseille 13', 'Allergie');

INSERT INTO Patient VALUES (18, 'Khelifi', 'Salma', '18-AUG-1985', 'F', 'Marseille 11', 'Asthme');

INSERT INTO Patient VALUES (19, 'Mokhtar', 'Anis', '30-JUL-1992', 'M', 'Marseille 9', NULL);

INSERT INTO Patient VALUES (20, 'Boumediene', 'Lina', '10-NOV-2000', 'F', 'Marseille 12', 'Cardiomyopathie');

SELECT * FROM Patient;

INSERT INTO Medecins VALUES (101, 'Leclerc', 'Cardiologie');

INSERT INTO Medecins VALUES (102, 'Moreau', 'Dermatologie');

INSERT INTO Medecins VALUES (103, 'Bernard', 'Pédiatrie');

INSERT INTO Medecins VALUES (104, 'Simon', 'Gastroentérologie');

INSERT INTO Medecins VALUES (105, 'Giraud', 'Neurologie');

INSERT INTO Medecins VALUES (106, 'Perrin', 'Oncologie');

INSERT INTO Medecins VALUES (107, 'Dubois', 'Psychiatrie');

SELECT * FROM Medecins;

INSERT INTO Consultation VALUES (1001, '15-JUN-2024', 50.00, 'Suivi général', 1, 101);

INSERT INTO Consultation VALUES (1002, '20-JUN-2024', 70.00, 'Contrôle cardiaque', 2, 101);

INSERT INTO Consultation VALUES (1003, '10-JUL-2024', 40.00, 'Consultation dermatologique', 3, 102);

INSERT INTO Consultation VALUES (1004, '25-JUL-2024', 60.00, 'Consultation pédiatrique', 4, 103);

INSERT INTO Consultation VALUES (1005, '05-AUG-2024', 90.00, 'Problèmes digestifs', 6, 104);

INSERT INTO Consultation VALUES (1006, '10-AUG-2024', 80.00, 'Migraines récurrentes', 5, 105);

INSERT INTO Consultation VALUES (1007, '15-JUN-2024', 45.00, 'Suivi général', 1, 101);

INSERT INTO Consultation VALUES (1008, '25-JUL-2024', 55.00, 'Contrôle annuel', 4, 103);

INSERT INTO Consultation VALUES (1009, '01-JUL-2024', 75.00, 'Diagnostic oncologique', 8, 106);

INSERT INTO Consultation VALUES (1010, '12-JUL-2024', 65.00, 'Évaluation psychiatrique', 9, 107);

INSERT INTO Consultation VALUES (1011, '15-JUN-2024', 50.00, 'Contrôle général', 11, 101);

INSERT INTO Consultation VALUES (1012, '18-JUN-2024', 60.00, 'Évaluation dermatologique', 12, 102);

INSERT INTO Consultation VALUES (1013, '20-JUN-2024', 70.00, 'Consultation pédiatrique', 13, 103);

INSERT INTO Consultation VALUES (1014, '22-JUN-2024', 80.00, 'Suivi diabète', 15, 105);

INSERT INTO Consultation VALUES (1015, '25-JUN-2024', 55.00, 'Problèmes respiratoires', 16, 104);

INSERT INTO Consultation VALUES (1016, '28-JUN-2024', 65.00, 'Consultation cardiaque', 17, 101);

INSERT INTO Consultation VALUES (1017, '01-JUL-2024', 75.00, 'Diagnostic neurologique', 18, 106);

INSERT INTO Consultation VALUES (1018, '04-JUL-2024', 90.00, 'Migraine aiguë', 19, 107);

INSERT INTO Consultation VALUES (1019, '07-JUL-2024', 85.00, 'Consultation annuelle', 20, 103);

INSERT INTO Consultation VALUES (1020, '10-JUL-2024', 100.00, 'Problème digestif', 14, 104);

SELECT * FROM Consultation;

INSERT INTO Medicament VALUES (201, 'Doliprane');

INSERT INTO Medicament VALUES (202, 'Ibuprofène');

INSERT INTO Medicament VALUES (203, 'Amoxicilline');

INSERT INTO Medicament VALUES (204, 'Paracétamol');

INSERT INTO Medicament VALUES (205, 'Oméprazole');

INSERT INTO Medicament VALUES (206, 'Aspirine');

INSERT INTO Medicament VALUES (207, 'Cortisone');

INSERT INTO Medicament VALUES (208, 'Morphine');

INSERT INTO Medicament VALUES (209, 'Paracétamol');

INSERT INTO Medicament VALUES (210, 'Doliprane');

SELECT * FROM Medicament;

INSERT INTO Traitement VALUES (301, '16-JUN-2024', '26-JUL-2024');

INSERT INTO Traitement VALUES (302, '21-JUN-2024', '30-JUL-2024');

INSERT INTO Traitement VALUES (303, '11-JUL-2024', '01-AUG-2024');

INSERT INTO Traitement VALUES (304, '02-JUL-2024', '16-JUL-2024');

INSERT INTO Traitement VALUES (305, '06-AUG-2024', '06-SEP-2024');

INSERT INTO Traitement VALUES (306, '11-AUG-2024', '11-SEP-2024');

INSERT INTO Traitement VALUES (307, '16-AUG-2024', '20-AUG-2024');

INSERT INTO Traitement VALUES (308, '01-JUL-2024', '30-DEC-2024');

INSERT INTO Traitement VALUES (309, '15-JUL-2024', '15-DEC-2024');

INSERT INTO Traitement VALUES (310, '01-JUL-2024', '01-SEP-2024');

INSERT INTO Traitement VALUES (311, '05-JUL-2024', '05-OCT-2024');

INSERT INTO Traitement VALUES (312, '10-JUL-2024', '10-JAN-2025');

INSERT INTO Traitement VALUES (313, '15-JUL-2024', '15-NOV-2024');

INSERT INTO Traitement VALUES (314, '20-JUL-2024', '20-AUG-2024');

INSERT INTO Traitement VALUES (315, '25-JUL-2024', '25-DEC-2024');

INSERT INTO Traitement VALUES (316, '01-AUG-2024', '01-NOV-2024');

INSERT INTO Traitement VALUES (317, '05-AUG-2024', '05-OCT-2024');

INSERT INTO Traitement VALUES (318, '10-AUG-2024', '10-JAN-2025');

INSERT INTO Traitement VALUES (319, '15-AUG-2024', '15-FEB-2025');

SELECT * FROM Traitement;

INSERT INTO prescrit VALUES (201, 1001, 3);

INSERT INTO prescrit VALUES (202, 1002, 2);

INSERT INTO prescrit VALUES (203, 1003, 1);

INSERT INTO prescrit VALUES (204, 1004, 3);

INSERT INTO prescrit VALUES (205, 1005, 2);

INSERT INTO prescrit VALUES (206, 1006, 1);

INSERT INTO prescrit VALUES (207, 1009, 2);

INSERT INTO prescrit VALUES (208, 1010, 1);

INSERT INTO prescrit VALUES (201, 1011, 2);

INSERT INTO prescrit VALUES (202, 1012, 3);

INSERT INTO prescrit VALUES (203, 1013, 1);

INSERT INTO prescrit VALUES (204, 1014, 2);

INSERT INTO prescrit VALUES (205, 1015, 1);

INSERT INTO prescrit VALUES (206, 1016, 2);

INSERT INTO prescrit VALUES (207, 1017, 3);

INSERT INTO prescrit VALUES (208, 1018, 1);

INSERT INTO prescrit VALUES (209, 1019, 2);

INSERT INTO prescrit VALUES (210, 1020, 3);

SELECT * FROM prescrit;

INSERT INTO traite VALUES (201, 301);

INSERT INTO traite VALUES (202, 302);

INSERT INTO traite VALUES (203, 303);

INSERT INTO traite VALUES (204, 304);

INSERT INTO traite VALUES (205, 305);

INSERT INTO traite VALUES (206, 306);

INSERT INTO traite VALUES (207, 307);

INSERT INTO traite VALUES (208, 308);

INSERT INTO traite VALUES (208, 309);

INSERT INTO traite VALUES (202, 310);

INSERT INTO traite VALUES (203, 311);

INSERT INTO traite VALUES (204, 312);

INSERT INTO traite VALUES (205, 313);

INSERT INTO traite VALUES (206, 314);

INSERT INTO traite VALUES (207, 315);

INSERT INTO traite VALUES (208, 316);

SELECT * FROM traite;

SELECT num_p , nom_p , prenom_p , 
COUNT(*) AS nombre_consultations 
FROM Patient 
NATURAL JOIN Consultation 
GROUP BY num_p, nom_p, prenom_p ;

SELECT num_p, nom_p, prenom_p 
FROM Patient 
NATURAL JOIN Consultation 
NATURAL JOIN prescrit 
WHERE code = 201;

SELECT DISTINCT num_p, nom_p, prenom_p 
FROM Patient 
NATURAL JOIN Consultation 
NATURAL JOIN Medecins 
WHERE specialite = 'Cardiologie';

SELECT AVG(prix) AS prix_moyen_cardiologie 
FROM Consultation 
NATURAL JOIN Medecins 
WHERE specialite = 'Cardiologie';

SELECT specialite,  
COUNT(num_consultation) AS nombre_consultations 
FROM Consultation 
NATURAL JOIN Medecins 
GROUP BY specialite;

SELECT antecedant_medical,  
COUNT(*) AS nombre_patients 
FROM Patient 
GROUP BY antecedant_medical 
ORDER BY nombre_patients DESC;

SELECT num_p, nom_p, prenom_p 
FROM Patient 
NATURAL JOIN Consultation 
NATURAL JOIN prescrit 
NATURAL JOIN traite 
NATURAL JOIN Traitement 
WHERE MONTHS_BETWEEN(date_fin, date_debut) > 3;

SELECT nom_medecin,  
COUNT(num_consultation) / COUNT(DISTINCT date_consu) AS moyenne_consultations_par_jour 
FROM Medecins 
NATURAL JOIN Consultation 
GROUP BY nom_medecin;

SELECT specialite,  
COUNT(num_consultation) AS nb_consultations 
FROM Consultation 
NATURAL JOIN Medecins 
WHERE date_consu BETWEEN TO_DATE('01-JUN-2024', 'DD-MON-YYYY') AND TO_DATE('31-AUG-2024', 'DD-MON-YYYY') 
GROUP BY specialite 
ORDER BY nb_consultations DESC;

SELECT num_p AS patient_id, nom_p AS nom, prenom_p AS prenom, id_traitement, date_debut, date_fin 
FROM Patient 
NATURAL JOIN Consultation 
NATURAL JOIN prescrit 
NATURAL JOIN traite 
NATURAL JOIN Traitement 
WHERE date_fin >= SYSDATE  
GROUP BY num_p, nom_p, prenom_p, id_traitement, date_debut, date_fin 
HAVING MAX(nb_prise) > 2 OR COUNT( num_consultation) > 2;

SELECT 
SUM(CASE WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, date_nais) / 12) BETWEEN 20 AND 30 THEN 1 ELSE 0 END) AS "20-30 ans", 
SUM(CASE WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, date_nais) / 12) BETWEEN 31 AND 40 THEN 1 ELSE 0 END) AS "31-40 ans", 
SUM(CASE WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, date_nais) / 12) BETWEEN 41 AND 50 THEN 1 ELSE 0 END) AS "41-50 ans", 
SUM(CASE WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, date_nais) / 12) > 50 THEN 1 ELSE 0 END) AS "50 ans et plus" 
FROM Patient;

INSERT INTO Traitement VALUES (320, '01-JUN-2024', '01-SEP-2024');

INSERT INTO traite VALUES (206, 320);

SELECT  
    code AS Type_de_traitement,  
    AVG(MONTHS_BETWEEN(date_fin, date_debut)) AS Duree_Moyenne 
FROM  
    Traitement 
NATURAL JOIN  
    traite 
NATURAL JOIN  
    prescrit 
NATURAL JOIN  
    Consultation 
NATURAL JOIN  
    Patient 
WHERE  
    sexe = 'M'  
    AND FLOOR(MONTHS_BETWEEN(SYSDATE, date_nais) / 12) < 25  
    AND antecedant_medical = 'Cardiomyopathie'  
    AND date_fin IS NOT NULL 
GROUP BY  
    code;

