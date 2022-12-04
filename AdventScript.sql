CREATE TABLE Owners (
	OwnerId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Pin VARCHAR(11),
	Birth TIMESTAMP
)
ALTER TABLE Owners
	ADD CONSTRAINT PinLength CHECK(LENGTH(Pin) = 11)

CREATE TABLE Cities (
	CityId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE,
	GeoLocation POINT
)

CREATE TABLE Stands(
	StandId SERIAL PRIMARY KEY,
	Name VARCHAR(20) NOT NULL,
	CityId INT REFERENCES Cities(CityId),
	OwnerId INT REFERENCES Owners(OwnerId)
)
ALTER TABLE Stands
	ADD CONSTRAINT UniqueNamePerCity UNIQUE(Name, CityId)
ALTER TABLE Stands
	ADD COLUMN Size VARCHAR(1) CHECK(Size IN ('S', 'M', 'L'))

CREATE TABLE Products (
	ProductId SERIAL PRIMARY KEY,
	Name VARCHAR(40),
	Mass FLOAT
)

CREATE TABLE StandProducts(
	ProductId INT REFERENCES Products(ProductId),
	StandId INT REFERENCES Stands(StandId),
	Price FLOAT,
	PRIMARY KEY(ProductId, StandId)
)
ALTER TABLE StandProducts
	ADD CONSTRAINT PriceIsPositive CHECK(Price > 0)
	
--CRUD

INSERT INTO Cities(Name, GeoLocation) VALUES
('Zagreb', POINT(22,23)),
('Osijek', POINT(22.1,23.2)),
('Rijeku', POINT(22.8,26.7)),
('Split', POINT(11,12))

INSERT INTO Owners(OwnerId, Name, Pin, Birth) VALUES
(DEFAULT, 'Stiv', '12345678901', '1953-11-23'),
(DEFAULT, 'Maria', '12345678901', '1970-9-23')

SELECT * FROM Cities
SELECT * FROM Stands
SELECT * FROM Owners
SELECT * FROM Products
SELECT * FROM StandProducts

SELECT Name as Ime FROM Cities
	WHERE LOWER(Name) LIKE '%s%' OR LOWER(Name) LIKE '%z%'
	
SELECT * FROM Products
	WHERE Mass BETWEEN 3 AND 5
	
SELECT * FROM Products pr
	WHERE (SELECT COUNT(*) FROM StandProducts WHERE ProductId = pr.ProductId) >= 2

SELECT COUNT(*) AS BrojProdaja
	FROM StandProducts WHERE ProductId = 3

UPDATE StandProducts
	SET Price = 30
	WHERE ProductId = 3 AND StandId = 3

DELETE FROM Cities
	WHERE CityId = 4

UPDATE Owners
	SET Name = CONCAT(Name, 'ov')




