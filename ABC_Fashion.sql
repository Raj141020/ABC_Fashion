/*
Tasks:

1. Insert a new record in your Orders table.

2. Add Primary key constraint for SalesmanId column in Salesman table. Add default
   constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
   column in Customer table. Add not null constraint in Customer_name column for the
   Customer table.

3. Fetch the data where the Customer’s name is ending with either ‘N’ also get the
   purchase amount value greater than 500.

4. Using SET operators, retrieve the first result with unique SalesmanId values from two
   tables, and the other result containing SalesmanId without duplicates from two tables.

5. Display the below columns which has the matching data.
   Orderdate, Salesman Name, Customer Name, Commission, and City which has the
   range of Purchase Amount between 1500 to 3000.

6. Using right join fetch all the results from Salesman and Orders table

*/



CREATE DATABASE ABC_Fashion;

USE ABC_Fashion;

CREATE TABLE Salesman (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);

INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);

SELECT * FROM Salesman

CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);

SELECT * FROM Customer

CREATE TABLE Orders (
OrderId int, 
CustomerId int, 
SalesmanId int, 
Orderdate Date, 
Amount money)

INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)

SELECT * FROM Orders;

--1:--------------->
INSERT INTO Orders Values
(5004, 3747, 104, '2023-09-11', 3500)

--2:--------------->
ALTER TABLE Salesman
ALTER COLUMN SalesmanId INT NOT NULL;

ALTER TABLE Salesman
ADD CONSTRAINT PK_SalesmanId PRIMARY KEY (SalesmanId);

ALTER TABLE Salesman
ADD CONSTRAINT DF_City DEFAULT 'Unknown' FOR City;

SELECT SalesmanId
FROM Customer
WHERE SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);

DELETE FROM Customer
WHERE SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);

ALTER TABLE Customer
ADD CONSTRAINT FK_SalesmanId FOREIGN KEY (SalesmanId)
REFERENCES Salesman(SalesmanId);

ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;

SELECT * FROM Customer

--3:------------------>

SELECT CustomerName, PurchaseAmount
FROM Customer
WHERE CustomerName LIKE '%N'
AND PurchaseAmount > 500;

---------------------- Extra ---------------------------

SELECT * FROM Orders;

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2001, 'Ethan', 600),    -- SalesmanId exists (Joe)
    (102, 2002, 'Megan', 700),    -- SalesmanId exists (Simon)
    (103, 2003, 'Olivia', 450),   -- SalesmanId exists (Jessie)
    (104, 2004, 'Jason', 1200),   -- SalesmanId exists (Danny)
    (105, 2005, 'Liam', 300),     -- SalesmanId exists (Lia)
    (101, 2006, 'Benjamin', 800), -- SalesmanId exists (Joe)
    (103, 2007, 'Aiden', 550),    -- SalesmanId exists (Jessie)
    (104, 2008, 'Sophia', 200),   -- SalesmanId exists (Danny)
    (105, 2009, 'Ryan', 400),     -- SalesmanId exists (Lia)
    (102, 2010, 'Evelyn', 750);   -- SalesmanId exists (Simon)

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES (105, 1234, 'Max', 2000);  

--------------------------------------------------------4:--------------------------------------->

SELECT SalesmanId FROM Salesman
UNION
SELECT SalesmanId FROM Customer;

SELECT SalesmanId FROM Salesman
INTERSECT
SELECT SalesmanId FROM Customer;

--5:------------------------------------>

SELECT * FROM Customer

SELECT O.OrderDate, 
       S.Name AS SalesmanName,
       C.CustomerName, 
       S.Commission, 
       S.City
FROM Orders O
JOIN Customer C ON O.CustomerId = C.CustomerId
JOIN Salesman S ON O.SalesmanId = S.SalesmanId
WHERE C.PurchaseAmount BETWEEN 1500 AND 3000;

--6:------------------------------------------->

SELECT S.SalesmanId, 
       S.Name AS SalesmanName, 
       S.Commission, 
       S.City, 
       O.OrderId, 
       O.CustomerId, 
       O.OrderDate, 
       O.Amount
FROM Salesman S
RIGHT JOIN Orders O ON S.SalesmanId = O.SalesmanId;








