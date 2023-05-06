/*
Author : Richard Sangster
Course : IST659 M407
Term   : Spring 2022
Name   : Project J&J
*/



IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.views WHERE TABLE_NAME = 'CustomerInfo')
BEGIN
	DROP VIEW CustomerInfo
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.views WHERE TABLE_NAME = 'CustomerCars')
BEGIN
	DROP VIEW CustomerCars
END
GO


CREATE or ALTER VIEW CustomerInfo as
SELECT 
	CustomerFirstName
	, CustomerLastName
	, PhoneNumber
	, Concat(CustomerAddress.StreetNumber, ' ', CustomerAddress.StreetName, ' ', CustomerAddress.City, ', ', CustomerAddress.AddressState, ', ' , CustomerAddress.Zipcode) as CustomerAddress
FROM Customer
JOIN CustomerAddress on Customer.CustomerAddressID = CustomerAddress.CustomerAddressID
GO

SELECT * FROM CustomerInfo
ORDER BY CustomerLastName
GO

CREATE or ALTER VIEW CustomersCars as
SELECT
	Concat (Customer.CustomerFirstName, ' ', Customer.CustomerLastName) As CustomerName
	, Concat(Car.CarYear, ' ', Car.Make, ' ', Car.Model) As CustomersCar
FROM CustomerCar
JOIN Customer on CustomerCar.CustomerID = Customer.CustomerID
JOIN Car on Car.CarID = CustomerCar.CarID
GO

SELECT * FROM CustomersCars
ORDER BY CustomersCar DESC
GO

CREATE or ALTER VIEW ServicesProvided as
SELECT
	ServiceDone
	,EstimatedDays
	,EstimatedServiceCost
FROM CarService
GO

SELECT * FROM ServicesProvided
ORDER BY EstimatedDays 
GO

CREATE OR ALTER FUNCTION dbo.deadlines(@CarCarServiceID int)
RETURNS INT AS
BEGIN
	DECLARE @returnvalue varchar(20)
	DECLARE @received datetime
	DECLARE @returned datetime
	SELECT  @received = DateReceived, @returned = DateReturned
	FROM CarCarService
	JOIN Car on Car.CarID = CarCarService.CarID
	JOIN CarService on CarServiceID = CarCarService.ServiceID
	WHERE CarCarService.ServiceCarID = @CarCarServiceID
	SET @returnvalue = datediff(dd,@received,@returned)	
	RETURN @returnvalue
END
GO

SELECT 
	ServiceCarID
	,Make
	,Model
	,ServiceDone
	,dbo.deadlines(ServiceCarID) as DaysToComplete
	FROM CarCarService
	JOIN Car on Car.CarID = CarCarService.CarID
	JOIN CarService on CarServiceID = CarCarService.ServiceID
	Order by Make, Model, ServiceDone
GO


CREATE or ALTER VIEW CompareCosts as
SELECT 
	CarService.ServiceDone
	,CarService.EstimatedServiceCost
	,Avg(CarCarService.Actualcost) As AverageActualCost
FROM CarCarService
	Join CarService on CarService.CarServiceID = CarCarService.ServiceID
Group by ServiceDone, EstimatedServiceCost
GO

SELECT * FROM CompareCosts
GO


CREATE Or ALTER PROCEDURE FinishJob(@ServiceCarID int, @cost as int) AS
BEGIN
	UPDATE CarCarService SET DateReturned = GETDATE(), ActualCost = @cost
	WHERE ServiceCarID = @ServiceCarID
END
GO	 

DECLARE @new int
SET @new = 17
EXEC FinishJob @new, 400
SELECT * FROM CarCarService where ServiceCarID = @new
