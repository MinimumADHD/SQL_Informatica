DROP DATABASE IF EXISTS SECOND_INSTRUMENTS_SHOP;
CREATE DATABASE SECOND_INSTRUMENTS_SHOP;
USE SECOND_INSTRUMENTS_SHOP;
-- I USUALLY SHOW DBS BECAUSE I WANNA TROUBLESHOOT THINGS
-- SHOW DATABASES;
CREATE TABLE MERCH(
    merchId INT PRIMARY KEY AUTO_INCREMENT,
    merchName VARCHAR(35)
);
CREATE TABLE MARKET(
    marketId INT PRIMARY KEY AUTO_INCREMENT,
    marketName VARCHAR(35),
    marketCity VARCHAR(20)
);
CREATE TABLE SALE(
    saleId INT PRIMARY KEY AUTO_INCREMENT,
    merchId INT,
    marketId INT,
    FOREIGN KEY (merchId) REFERENCES MERCH(merchId),
    FOREIGN KEY (marketId) REFERENCES MARKET(marketId),
    saleDate DATE,
    saleQuantity INT,
    salePrice DECIMAL(4, 2)
);
-- SHOW TABLES;
-- FILLING STUFF INTO TABLES
INSERT INTO MERCH(merchName)
VALUES ("Mangos"),
    ("Pizza"),
    ("Still water"),
    ("Those who know");
INSERT INTO MARKET(marketName, marketCity)
VALUES ("SoloCrimini", "Rho"),
    ("AmmuNation", "Pogliano"),
    ("LadriPeSempre", "Rho");
INSERT INTO SALE(
        merchId,
        marketId,
        saleDate,
        saleQuantity,
        salePrice
    )
VALUES (2, 1, "2023-04-01", 5, 10.26),
    (3, 2, "2024-06-03", 1, 3.10),
    (1, 3, "2000-10-12", 4, 7.20),
    (4, 1, "2024-12-25", 1, 0.50);
-- QUERIES
SELECT *
FROM MERCH;
SELECT *
FROM MARKET;
SELECT *
FROM SALE;
-- ALL MARKETS FROM RHO
SELECT MARKET.marketName
FROM MARKET
WHERE marketCity = "Rho";
-- ALL MARKETS FROM RHO WHO SOLD AT LEAST ONE IN 1st feb 2024
