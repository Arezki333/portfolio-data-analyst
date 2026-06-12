import cx_Oracle
import random
from faker import Faker
from datetime import datetime, timedelta

# Initialisation de Faker pour générer des données réalistes
fake = Faker()

# Connexion à Oracle
dsn = cx_Oracle.makedsn("localhost", "1521", service_name="FREEPDB1")  # Remplacez par vos informations
connection = cx_Oracle.connect(user="SYSTEM", password="333", dsn=dsn)
cursor = connection.cursor()

def generate_random_date(start_date, end_date):
    """ Génère une date aléatoire entre start_date et end_date """
    delta_days = (end_date - start_date).days
    if delta_days < 0:
        raise ValueError("La date de fin doit être après la date de début.")
    
    # Si la différence est 0, il n'y a pas de jours disponibles pour générer une date aléatoire
    if delta_days == 0:
        return start_date  # Retourner la même date, ou vous pouvez gérer cela autrement
    
    random_days = random.randint(0, delta_days)
    return start_date + timedelta(days=random_days)

try:
    # 1. Insérer des données dans la table Patients
    print("Insertion des données dans la table Patients...")
    for i in range(1000):  # Insérer 1000 lignes dans la table Patients
        id_patient = i + 1
        nom_p = fake.last_name()
        prenom_p = fake.first_name()
        date_naiss = fake.date_of_birth(minimum_age=18, maximum_age=100).strftime('%Y-%m-%d')
        sexe_p = random.choice(['M', 'F'])
        adresse = fake.address().replace("\n", " ")

        cursor.execute("""
            INSERT INTO Patients (id_patient, nom_p, prenom_p, date_naiss, sexe_p, adresse)
            VALUES (:id_patient, :nom_p, :prenom_p, TO_DATE(:date_naiss, 'YYYY-MM-DD'), :sexe_p, :adresse)
        """, id_patient=id_patient, nom_p=nom_p, prenom_p=prenom_p, date_naiss=date_naiss, sexe_p=sexe_p, adresse=adresse)

    # 2. Insérer des données dans la table Medecins
    print("Insertion des données dans la table Medecins...")
    for i in range(100):  # Insérer 100 lignes dans la table Medecins
        id_medecin = i + 1
        nom_m = fake.last_name()
        prenom_m = fake.first_name()
        specialite = random.choice(['Cardiologie', 'Neurologie', 'Pédiatrie', 'Gastro-entérologie', 'Gynécologie'])

        cursor.execute("""
            INSERT INTO Medecins (id_medecin, nom_M, prenom_m, specialite)
            VALUES (:id_medecin, :nom_m, :prenom_m, :specialite)
        """, id_medecin=id_medecin, nom_m=nom_m, prenom_m=prenom_m, specialite=specialite)

    # 3. Insérer des données dans la table Consultations
    print("Insertion des données dans la table Consultations...")
    for i in range(5000):  # Insérer 5000 lignes dans la table Consultations
        id_consultation = i + 1
        date_consultation = generate_random_date(datetime.today() - timedelta(days=365*7), datetime.today())
        date_consultation_str = date_consultation.strftime('%Y-%m-%d')  # Format YYYY-MM-DD
        prix = round(random.uniform(50, 500), 2)
        id_patient = random.randint(1, 1000)
        id_medecin = random.randint(1, 100)

        cursor.execute("""
            INSERT INTO Consultations (id_conslt, date_conslt, Heure_Conslt, prix, id_patient, id_medecin)
            VALUES (:id_consultation, TO_DATE(:date_consultation, 'YYYY-MM-DD'), SYSDATE, :prix, :id_patient, :id_medecin)
        """, id_consultation=id_consultation, date_consultation=date_consultation_str,
            prix=prix, id_patient=id_patient, id_medecin=id_medecin)

    # 4. Insérer des données dans la table Medicaments
    print("Insertion des données dans la table Medicaments...")
    for i in range(50):  # Insérer 50 lignes dans la table Medicaments
        id_medicament = i + 1
        nom_medoc = fake.word()
        type_medoc = random.choice(['Analgesique', 'Antibiotique', 'Antidouleur', 'Anti-inflammatoire', 'Vitamine'])

        cursor.execute("""
            INSERT INTO Medicaments (id_medicament, nom_medoc, type_medoc)
            VALUES (:id_medicament, :nom_medoc, :type_medoc)
        """, id_medicament=id_medicament, nom_medoc=nom_medoc, type_medoc=type_medoc)

    # 5. Insérer des données dans la table Traitements
    # Liste des types de traitements disponibles
    types_de_traitements = [
        'Traitement Antibiotique',
        'Chimiothérapie',
        'Physiothérapie',
        'Traitement Hormonal',
        'Traitement Cardiologique',
        'Traitement Dermatologique',
        'Traitement Neurologique'
    ]
    print("Insertion des données dans la table Traitements...")
    for i in range(3000):  # Insérer 3000 lignes dans la table Traitements
        id_traitement = i + 1
        id_consultation = random.randint(1, 5000)
        id_medicament = random.randint(1, 50)
        
        # Sélectionner un type de traitement aléatoire
        type_traitmt = random.choice(types_de_traitements)
        # Générer une date de début aléatoire dans les 7 dernières années
        date_debut = generate_random_date(datetime.today() - timedelta(days=365*7), datetime.today()).strftime('%Y-%m-%d')
        
        # Décider si nous devons laisser la date de fin NULL ou générer une date valide
        if random.choice([True, False]):  # Parfois laisser la date_fin NULL
            date_fin = None  # Indique que le traitement est en cours
        else:
            # Générer une date de fin strictement après la date_debut
            date_debut_obj = datetime.strptime(date_debut, '%Y-%m-%d')
            date_fin = generate_random_date(date_debut_obj + timedelta(days=1), datetime.today()).strftime('%Y-%m-%d')

        # Insérer les données dans la table Traitements
        cursor.execute("""
            INSERT INTO Traitements (id_traitement, date_debut, date_fin, type_traitmt)
            VALUES (:id_traitement, TO_DATE(:date_debut, 'YYYY-MM-DD'), 
                    CASE WHEN :date_fin IS NULL THEN NULL ELSE TO_DATE(:date_fin, 'YYYY-MM-DD') END, 
                    :type_traitmt)
        """, id_traitement=id_traitement, date_debut=date_debut, date_fin=date_fin)

    # 6. Insérer des données dans la table Maladie
    print("Insertion des données dans la table Maladie...")
    for i in range(10):  # Insérer 10 lignes dans la table Maladie
        Maladie_ID = i + 1
        Nom_maladie = random.choice(['Diabète', 'Hypertension', 'Cancer', 'Asthme', 'Covid-19','cardiomyopathie'])

        cursor.execute("""
            INSERT INTO Maladie (Maladie_ID, Nom_maladie)
            VALUES (:Maladie_ID, :Nom_maladie)
        """, Maladie_ID=Maladie_ID, Nom_maladie=Nom_maladie)

        
# 7. Insérer des données dans la table Constater
    print("Insertion des données dans la table Constater...")
    for _ in range(500):  # Insérer 500 lignes dans la table Constater
        Maladie_ID = random.randint(1, 10)
        id_conslt = random.randint(1, 5000)

        cursor.execute("""
            INSERT INTO Constater (Maladie_ID, id_conslt)
            SELECT :Maladie_ID, :id_conslt
            FROM dual
            WHERE NOT EXISTS (
                SELECT 1 FROM Constater
                WHERE Maladie_ID = :Maladie_ID AND id_conslt = :id_conslt
            )
        """, Maladie_ID=Maladie_ID, id_conslt=id_conslt)

    # 8. Insérer des données dans la table Prescription
    print("Insertion des données dans la table Prescription...")
    for _ in range(3000):  # Insérer 3000 lignes dans la table Prescription
        id_medicament = random.randint(1, 50)
        id_conslt = random.randint(1, 5000)
        Nb_unitePjour = random.randint(1, 10)

        cursor.execute("""
            INSERT INTO Prescription (id_medicament, id_conslt, Nb_unitePjour)
            SELECT :id_medicament, :id_conslt, :Nb_unitePjour
            FROM dual
            WHERE NOT EXISTS (
                SELECT 1 FROM Prescription
                WHERE id_medicament = :id_medicament AND id_conslt = :id_conslt
            )
        """, id_medicament=id_medicament, id_conslt=id_conslt, Nb_unitePjour=Nb_unitePjour)

    # 9. Insérer des données dans la table PrescritPar
    print("Insertion des données dans la table PrescritPar...")
    for _ in range(3000):  # Insérer 3000 lignes dans la table PrescritPar
        id_traitement = random.randint(1, 3000)
        id_conslt = random.randint(1, 5000)

        cursor.execute("""
            INSERT INTO PrescritPar (id_traitement, id_conslt)
            SELECT :id_traitement, :id_conslt
            FROM dual
            WHERE NOT EXISTS (
                SELECT 1 FROM PrescritPar
                WHERE id_traitement = :id_traitement AND id_conslt = :id_conslt
            )
        """, id_traitement=id_traitement, id_conslt=id_conslt)

    # 10. Insérer des données dans la table Inclut
    print("Insertion des données dans la table Inclut...")
    for _ in range(3000):  # Insérer 3000 lignes dans la table Inclut
        id_medicament = random.randint(1, 50)
        id_traitement = random.randint(1, 3000)

        cursor.execute("""
            INSERT INTO Inclut (id_medicament, id_traitement)
            SELECT :id_medicament, :id_traitement
            FROM dual
            WHERE NOT EXISTS (
                SELECT 1 FROM Inclut
                WHERE id_medicament = :id_medicament AND id_traitement = :id_traitement
            )
        """, id_medicament=id_medicament, id_traitement=id_traitement)

    # 11. Insérer des données dans la table Cibler
    print("Insertion des données dans la table Cibler...")
    for _ in range(500):  # Insérer 500 lignes dans la table Cibler
        id_traitement = random.randint(1, 3000)
        Maladie_ID = random.randint(1, 10)

        cursor.execute("""
            INSERT INTO Cibler (id_traitement, Maladie_ID)
            SELECT :id_traitement, :Maladie_ID
            FROM dual
            WHERE NOT EXISTS (
                SELECT 1 FROM Cibler
                WHERE id_traitement = :id_traitement AND Maladie_ID = :Maladie_ID
            )
        """, id_traitement=id_traitement, Maladie_ID=Maladie_ID)

    # Validation des transactions
    connection.commit()
    print("Toutes les données ont été insérées avec succès !")

except cx_Oracle.DatabaseError as e:
    print("Erreur lors de l'insertion :", e)
    connection.rollback()

finally:
    # Fermer le curseur et la connexion
    cursor.close()
    connection.close()
