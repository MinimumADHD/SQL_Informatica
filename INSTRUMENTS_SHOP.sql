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
 ),
 (
 "Jiajia",
 "Hu",
 "Sora_SkyLight",
 "swkjej2444_",
 "1986-09-22"
 );
 */
-- better way, sql will understand anyhow... best practice with autoincrement
-- nvm i just learnt this one is called non-declarative or sum shit while the other one is declarative, and theoretically the other one takes less time to fiill up
INSERT INTO CUSTOMER_
VALUES (
        NULL,
        "Giorgio",
        "Astarita",
        "PATALFORN",
        "eoekkwj13",
        "2002-10-12"
    ),
    (
        NULL,
        "Marco",
        "Esplosivo",
        "Kirchoff",
        "kskfeok334",
        "1989-01-04"
    );
-- printing all the contents of the table CUSTOMER_
SELECT *
FROM CUSTOMER_;