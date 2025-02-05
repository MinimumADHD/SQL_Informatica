DROP DATABASE IF EXISTS CONAD;
CREATE DATABASE CONAD;
USE CONAD;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    referral_id INT
);

INSERT INTO customers (first_name, last_name, referral_id)
VALUES ("Mario", "Fratelli", NULL),
    ("Giovanni", "Garelli", 4),
    ("Davide", "Vessetti", 3),
    ("Fernando", "Procopio", 3),
    ("Federico", "LaPigna", 2),
    ("Giorgio", "Garelli", 1);

SELECT *
FROM customers;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(30) UNIQUE NOT NULL,
    price DECIMAL(6, 2),
    CONSTRAINT chk_price CHECK (price >= 0000.10)
);

INSERT INTO products (product_name, price)
VALUES ("Proteine", 5.23),
    ("Prime", 1.05),
    ("Panca", 1345.23),
    ("Creatina", 20.21);

SELECT *
FROM products;

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_date DATE DEFAULT CURRENT_DATE(),
    amount INT,
    customer_id INT,
    product_id INT,
    CONSTRAINT chk_amount CHECK (amount >= 1),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE SET NULL
);

INSERT INTO transactions (customer_id, product_id, amount)
VALUES (1, 2, 6),
    (2, 2, 6),
    (1, 3, 1),
    (3, 4, 2);

INSERT INTO transactions (transaction_date, customer_id, product_id, amount)
VALUES ("2023-08-11", 4, 3, 2);

SELECT *
FROM transactions;

SELECT customer_id
FROM transactions
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- INNER JOIN PERMETTE DI USARE SIA LA TABLE A SINISTRA CHE QUELLA A DESTRA, MENTRE LEFT/RIGHT PERMETTONO DI SELECTARE SOLO QUELLI A DESTRA/SINISTRA
SELECT customers.first_name "Nome Cliente", customers.last_name "Cognome Cliente", transactions.product_id "ID Prodotto", products.product_name "Nome Prodotto", transactions.transaction_date "Data Transizione"
FROM transactions
INNER JOIN customers
ON transactions.customer_id = customers.customer_id
INNER JOIN products
ON transactions.product_id = products.product_id;

-- FUNCTIONS sono COUNT (conta la quantità di colonne dato una condizione), MAX e MIN (ritornano il valore MASSIMO/MINIMO di una colonna INT/FLOAT/DECIMAL)
-- AVG (ritorna la media di una colonna INT/FLOAT/DECIMAL), SUM (ritorna la somma dei valori di una colonna)
-- CONCAT (unisce due valori TEXT/VARCHAR (concatenazione parola1 + parola2), di default NON aggiunge spazi, quindi aggiungere spazi con " ")

SELECT CONCAT(customers.first_name, " ", customers.last_name) AS "Generalità Cliente"
FROM transactions
INNER JOIN customers
ON transactions.customer_id = customers.customer_id;

-- NOT è usato per definire il contrario di una condizione (e.s AND NOT transactions.transaction_id = 1), però noi abbiamo <> che fa lo stesso
SELECT *
FROM transactions
WHERE transactions.amount > 1 AND transactions.transaction_id <> 1;

SELECT *
FROM transactions
WHERE transactions.amount > 1 AND NOT transactions.transaction_id = 1;

-- BETWEEN si usa per ricevere un valore in mezzo a due valori (sia numerici che date)
SELECT *
FROM customers
WHERE customer_id BETWEEN 2 AND 4;

-- Le wildcard servono a trovare valori nelle stringhe contenenti un certo pattern
-- % STA PER "Resto della stringa"
-- _ STA PER "Un carattere a caso" tipo "_ahd", Che ritornera qualsiasi parola possa avere un carattere qualsasi seguito da AHD.
SELECT *
FROM customers
WHERE first_name LIKE "f%";

SELECT *
FROM customers
WHERE last_name LIKE "%Garelli%";

SELECT *
FROM transactions
WHERE transaction_date LIKE "____-08-__";

-- ORDER BY ordina in ordine crescente o decrescente
SELECT *
FROM transactions
ORDER BY amount ASC; -- ASC non deve per forza essere specificato, dato che è implicito quando si usa ORDER BY

SELECT *
FROM transactions
ORDER BY amount DESC;

-- Possiamo anche aggiungere altri valori da valutare, nel caso ci sono valori con più dati uguali

SELECT *
FROM transactions
ORDER BY amount ASC, transaction_id ASC;

-- LIMIT limita il numero di righe che verranno mostrate (paginazione)
SELECT *
FROM customers
ORDER BY first_name ASC
LIMIT 3; -- mostrerà solo i primi 3

-- PER AVERE GLI ALTRI 3 DEVO AGGIUNGERE UN OFFSET
SELECT *
FROM customers
ORDER BY first_name ASC
LIMIT 3, 3;

-- UNION combina i risultati di due SELECT
-- IL NUMERO DI COLONNE IN UN UNION DEVE ESSERE UGUALE
-- UNION ALL accetta anche i duplicati
SELECT transactions.amount, transactions.transaction_id
FROM transactions
UNION ALL
SELECT customers.first_name, customers.last_name
FROM customers;

-- LE SELF JOIN aiutano a unire copie di una tabella insieme
-- Utile per gerarchie
SELECT CONCAT(table_a.first_name, " ", table_a.last_name) AS "Referred By", table_a.customer_id, table_b.referral_id
FROM customers AS table_a
INNER JOIN customers AS table_b
ON table_b.referral_id = table_a.customer_id;

-- VIEWS tabelle virtuali
-- Le view si aggiornano in tempo reale in base a i cambiamenti della tabella originale
-- Le view sono delle tabelle NON modificabili, se non modificando le tabelle originali da cui prendono i dati
CREATE VIEW customer_entries AS
SELECT first_name, last_name
FROM customers;

SELECT *
FROM customer_entries;

-- Index o Indici
-- Operare con ricerche in maniera veloce e non dispendiosa
-- Aggiornare invece prenderà più tempo
CREATE INDEX idx_last_name
ON customers (last_name);

SHOW INDEXES FROM customers;

SELECT *
FROM customers
WHERE customers.last_name = "Garelli";

-- Subqueries sono delle query all'interno di un'altra query
SELECT transactions.transaction_id, transactions.amount,
    (SELECT AVG(amount) FROM transactions) AS "avg_amount"
FROM transactions;

-- Un modo utile per usare le subquery è ricevere tutti i clienti che hanno fatto ALMENO un'acquisto
SELECT first_name, last_name
FROM customers
WHERE customer_id IN
    (SELECT DISTINCT customer_id
    FROM transactions
    WHERE customer_id IS NOT NULL);

SELECT first_name, last_name
FROM customers
WHERE customer_id NOT IN
    (SELECT DISTINCT customer_id
    FROM transactions
    WHERE customer_id IS NOT NULL);

-- GROUP BY serve a unire dei valori dove (nel mio caso) transaction_date è uguale
-- SE si usa GROUP BY, non si può usare WHERE, ma invece si dovrà usare HAVING
SELECT SUM(amount) AS "Quantità venduta", transaction_date
FROM transactions
GROUP BY transactions.transaction_date;

-- UTILE per trovare quante volte una persona ha avuto interazioni
SELECT COUNT(amount), customer_id
FROM transactions
GROUP BY customer_id
HAVING COUNT(amount) > 1;

-- ROLLUP produce il totale dei valori specificati
SELECT SUM(amount), customer_id
FROM transactions
GROUP BY customer_id WITH ROLLUP;

-- ON DELETE SET NULL (costraint), quando la chiave esterna è eliminata, viene rimpiazzata con NULL
-- ON DELETE CASCADE (constraint), quando la chiave esterna è eliminata, l'intera riga viene ELIMINATA

-- ON UPDATE SET NULL Se il valore della tabella originale cambia, la row della tabella che lo richiama tramite FK diventerà NULL
-- ON UPDATE CASCADE Se il valore della tabella originale cambia, cambia anche dove viene richiamata (FK)

-- PROCEDURE SALVATE (sono come funzioni/API che possiamo riusare in futuro)
-- Utili per quando si ripetono delle query più volte
-- Delimiter è un modo per cambiare il ; alla fine di uno statement

DELIMITER //
CREATE PROCEDURE get_customers_with_id(IN id INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customers.customer_id = id;
END//
DELIMITER ;

CALL get_customers_with_id(3);

-- TRIGGER servono a controllare quando succedono degli eventi