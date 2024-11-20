-- TODO: REMOVE SLURS AND BAD WORDING (PRIORITY: LOW)
-- to run that shit with XAMPP (unsure why we're still using that shitass thing with all due respect to the Apache devs who puts effort and even made it open source) use the shell command mysql -u root (at least on Windows, on Linux should be easier)
-- use linux mint or arch btw
DROP DATABASE IF EXISTS INSTRUMENTS_SHOP;
CREATE DATABASE INSTRUMENTS_SHOP;
USE INSTRUMENTS_SHOP;
CREATE TABLE CUSTOMER_ (
    _CUSTOMER_ID INT AUTO_INCREMENT,
    _NAME VARCHAR(50),
    _LASTNAME VARCHAR(50),
    _USERNAME VARCHAR(50),
    _PASS VARCHAR(30),
    _REGISTRATION_DATE DATE,
    PRIMARY KEY (_CUSTOMER_ID)
);
CREATE TABLE INSTRUMENT_ (
    _INSTRUMENT_ID INT AUTO_INCREMENT,
    _NAME VARCHAR(30),
    _BRANDA VARCHAR(50),
    _MODEL VARCHAR(10),
    _IMAGE_URL VARCHAR(150),
    _PRICE DECIMAL(3, 2),
    -- ESEMPIO (298,22; 1,23, 1,00)
    _QUANTITY INT,
    PRIMARY KEY (_INSTRUMENT_ID)
);
CREATE TABLE ORDER_ (
    _ORDER_ID INT AUTO_INCREMENT,
    _CONTENT INT,
    _ORDER_DATE DATE,
    PRIMARY KEY (_ORDER_ID)
);
-- do not use rename table * to *
-- inserting rows and dates are international format YYMMDD
/* UNCONVENTIONAL / JUST STRAIGHT OUT SHIT PRACTICE (AT LEAST TO ME [FOR NOW])
 INSERT INTO CUSTOMER_ (
 _NAME,
 _LASTNAME,
 _USERNAME,
 _PASS,
 _REGISTRATION_DATE
 )
 VALUES (
 "Giorgio",
 "Astarita",
 "PATALFORN",
 "pwk10293",
 "2023-12-22"
 );
 */
-- better way, sql will understand anyhow... best practice with autoincrement
-- nvm i just learnt this one is called non-declarative or sum shit while the other one is declarative, and theoretically the other one takes less time to fiill up
-- if i dont want shit to fill up in the first one, i just dont write it and sql will automatically understand it as NULL (unless it's an auto-increment number), in the other one (as you can see), i MUST declare shit with "NULL" oitherwise fucking sql is going to complain for it
INSERT INTO CUSTOMER_
VALUES (
        NULL,
        "Keith",
        "Salamanca",
        "PATALFORN",
        "eoekkwj13",
        "2002-10-12"
    ),
    (
        NULL,
        "Rodha",
        "Viking",
        "Ole_Viking",
        "wqkwo24_w,e",
        NULL
    ),
    (
        NULL,
        "Marco",
        "Esplosivo",
        "Kirchoff",
        "kskfeok334",
        "1989-01-04"
    );
-- these searches are called queries
-- printing all the contents of the table CUSTOMER_
SELECT *
FROM CUSTOMER_;
-- printing all contents of the table customer BUT with conditions
SELECT *
FROM CUSTOMER_
WHERE _CUSTOMER_ID > 1;
-- if i wanna check for values with NULL (empty) use IS NULL
-- doing = null is notw valid and WON'T WORK!
SELECT *
FROM CUSTOMER_
WHERE _REGISTRATION_DATE IS NULL;
-- updating data on a table
UPDATE CUSTOMER_
SET _PASS = "RESET"
WHERE _CUSTOMER_ID = 3;
-- if I wanna change multiple columns, i will just add a , after the first set
UPDATE CUSTOMER_
SET _PASS = "RESET",
    _REGISTRATION_DATE = "0000-00-00"
WHERE _CUSTOMER_ID = 3;
-- if you just wanna edit a WHOLE column, just dont insert the where clause
-- DONT EVER USE "DELETE FROM TABLENAMEHERE" AS ITS GOING TO REMOVE ALL THE ROWS FROM YOUR TABLE.
DELETE FROM CUSTOMER_
WHERE _REGISTRATION_DATE IS NULL;
SELECT *
FROM CUSTOMER_;