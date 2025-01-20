DROP DATABASE IF EXISTS STUDIO_VETERINARIO;
CREATE DATABASE STUDIO_VETERINARIO;
USE STUDIO_VETERINARIO;

CREATE TABLE owners
(
    tax_code VARCHAR(12) PRIMARY KEY NOT NULL,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(15) NOT NULL,
    token VARCHAR(20),
    mail_address VARCHAR(30) NOT NULL,
    login_password VARCHAR(12),
    phone_number VARCHAR(13)
);

CREATE TABLE animals
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    pet_name VARCHAR(30) NOT NULL,
    pet_status VARCHAR(8) NOT NULL, /* "salutare" "malato" */
    race VARCHAR(20) NOT NULL,
    specie VARCHAR(20) NOT NULL,
    age INT NOT NULL,
    owner_tax_code VARCHAR(12) NOT NULL,
    FOREIGN KEY (owner_tax_code) REFERENCES owners(tax_code)
);

INSERT INTO owners (tax_code, first_name, last_name, token, mail_address, login_password, phone_number)
VALUES
('POA45QVMKH34', 'Jovanna', 'Chiarelli', NULL, 'jo.chiarel@gmail.com', 'Gattto2025', '+393333333333'),
('QPW12RTYMH12', 'Mattia', 'Pasquale', 'WEEOEKR343PQOEAK', 'mattia.pasq@govit.com', 'jwkW133l_m', '+393839636353');

INSERT INTO animals (pet_name, pet_status, race, specie, age, owner_tax_code)
VALUES
('Malta', 'malato', 'golden retriever', 'cane', 6, 'POA45QVMKH34'),
('Koni', 'salutare', 'maine coon', 'gatto', 3, 'QPW12RTYMH12'),
('Mako', 'salutare', 'doberman', 'cane', 2, 'POA45QVMKH34');

SHOW TABLES;

SELECT * FROM animals;
SELECT * FROM owners;

SELECT owners.first_name "Nome Proprietario", owners.last_name "Cognome Proprietario", animals.pet_name "Nome Animale", animals.pet_status "Stato Medico", animals.id "ID Animale"
FROM animals, owners
WHERE animals.owner_tax_code LIKE '%POA45QVMKH34%' AND owners.tax_code LIKE '%POA45QVMKH34%';

-- ho scoperto che in SQL non posso semplicemente fare != NULL, ma devo per forza fare IS NOT NULL
SELECT owners.first_name "Nome", owners.token "Token Google"
FROM owners
WHERE owners.token IS NOT NULL;

SELECT *
FROM  owners
WHERE owners.mail_address LIKE "%@govit.com";