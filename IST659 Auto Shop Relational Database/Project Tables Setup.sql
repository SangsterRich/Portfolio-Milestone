/*
Author : Richard Sangster
Course : IST659 M407
Term   : Spring 2022
Name   : Project J&J
*/

--Begin by dropping all tables from database
DROP TABLE IF EXISTS CustomerCar
DROP TABLE IF EXISTS CarCarService
DROP TABLE IF EXISTS Customer
DROP TABLE IF EXISTS CustomerAddress
DROP TABLE IF EXISTS CarService
DROP TABLE IF EXISTS Car

-- Creating Tables
Create Table CustomerAddress (
-- Placing in columns
	CustomerAddressID int identity primary key,
	StreetNumber int not null,
	StreetName varchar(50) not null,
	City varchar(50) not null,
	AddressState varchar(50) not null, --Name changed due to State being a system term
	Zipcode char(5) not null,
)
GO


Create Table CarService (
	CarServiceID int identity primary key,
	ServiceDone varchar(50) not null,
	EstimatedDays int not null,
	EstimatedServiceCost int not null,
)
GO

Create Table Car (
	CarID int identity primary key,
	Make varchar(30) not null,
	Model varchar(30) not null,
	CarTrim varchar(20) not null,
	CarYear char(4) not null,
	Color varchar(20),
	VinNumber varchar(20) not null Unique,
)
GO

Create Table Customer (
	CustomerID int identity primary key,
	CustomerFirstName varchar(50) not null,
	CustomerLastName varchar(50) not null,
	CustomerEmailAddress varchar(100),
	PhoneNumber char(10) not null,
	CustomerAddressID int not null,
	Constraint F1_Customer Foreign Key (CustomerAddressID) References CustomerAddress(CustomerAddressID),
)
GO

Create Table CarCarService (
	ServiceCarID int identity primary key,
	ServiceID int not null Foreign Key References CarService(CarServiceID),
	CarID int not null Foreign Key References Car(CarID),
	DateReceived datetime not null,
	DateReturned datetime,
	ActualCost int,
)
GO

Create Table CustomerCar (
	CustomerCarID int identity primary key,
	CustomerID int not null,
	CarID int not null,
	Constraint F1_CustomerCar Foreign Key (CustomerID) References Customer(CustomerID),
	Constraint F2_CustomerCar Foreign Key (CarID) References Car(CarID),
)
GO

Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('58', 'Tennyson', 'Detroit', 'Michigan', '48267');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('860', 'Cambridge', 'Galveston', 'Texas', '77554');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('211', 'Del Sol', 'Iowa City', 'Iowa', '52245');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('17', 'Reindahl', 'New Haven', 'Connecticut', '06533');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('9', 'Florence', 'Philadelphia', 'Pennsylvania', '19151');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('456', 'Bartelt', 'Milwaukee', 'Wisconsin', '53277');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('39', 'Forest Run', 'Little Rock', 'Arkansas', '72215');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('6', 'Sage', 'Amarillo', 'Texas', '79159');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('9', 'Westridge', 'Waterbury', 'Connecticut', '06721');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('74', 'Fordem', 'Ogden', 'Utah', '84403');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('86', 'Walton', 'Ogden', 'Utah', '84403');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('69', 'Riverside', 'Baton Rouge', 'Louisiana', '70883');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('829', 'Cody', 'Vienna', 'Virginia', '22184');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('597', 'Thackeray', 'New York City', 'New York', '10280');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('875', 'Morrow', 'Chicago', 'Illinois', '60691');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('5265', 'Marquette', 'Concord', 'California', '94522');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('302', 'Forster', 'San Antonio', 'Texas', '78210');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('5', 'Paget', 'Rochester', 'New York', '14609');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('92', 'Bluestem', 'Dallas', 'Texas', '75226');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('152', 'Cascade', 'Terre Haute', 'Indiana', '47812');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('418', 'School', 'Fort Wayne', 'Indiana', '46805');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('843', 'Weeping Birch', 'Vienna', 'Virginia', '22184');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('73', 'Veith', 'Charlotte', 'North Carolina', '28230');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('55', 'Northfield', 'Bethesda', 'Maryland', '20892');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('35', 'Ryan', 'Raleigh', 'North Carolina', '27626');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('28', 'Waxwing', 'Topeka', 'Kansas', '66667');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('8', 'Mandrake', 'Fort Lauderdale', 'Florida', '33315');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('729', 'Warbler', 'Charlotte', 'North Carolina', '28289');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('621', 'Sullivan', 'Pensacola', 'Florida', '32595');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('96', 'Pierstorff', 'Long Beach', 'California', '90840');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('51', 'Jay', 'Little Rock', 'Arkansas', '72231');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('871', 'Gerald', 'Boston', 'Massachusetts', '02208');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('773', 'Del Mar', 'Washington', 'District of Columbia', '20580');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('445', 'Lerdahl', 'San Jose', 'California', '95113');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('30', 'Bunting', 'Miami', 'Florida', '33147');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('196', 'Vera', 'Miami Beach', 'Florida', '33141');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('74', 'Miller', 'San Diego', 'California', '92176');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('542', 'Larry', 'Pompano Beach', 'Florida', '33064');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('2', 'Elgar', 'Aurora', 'Colorado', '80045');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('232', 'Schiller', 'Winston Salem', 'North Carolina', '27110');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('407', 'Union', 'Fresno', 'California', '93786');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('247', 'Independence', 'Indianapolis', 'Indiana', '46278');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('45', 'Brentwood', 'Colorado Springs', 'Colorado', '80951');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('24', 'Hovde', 'Palmdale', 'California', '93591');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('70', 'Garrison', 'Maple Plain', 'Minnesota', '55579');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('60', 'Chinook', 'New York City', 'New York', '10024');
Insert Into CustomerAddress (StreetNumber, StreetName, City, AddressState, Zipcode) values ('17803', 'Green Ridge', 'Columbus', 'Ohio', '43210');


Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Lorita', 'Tuddenham', 'ltuddenham0@washington.edu', '9683710281', 31);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Frederich', 'Elgood', 'felgood1@jimdo.com', '1753172547', 2);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Mata', 'Iwanczyk', 'miwanczyk2@wsj.com', '6944503384', 3);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Melloney', 'Whitehair', 'mwhitehair3@opensource.org', '6646238251', 23);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Hakim', 'Bottom', 'hbottom4@nytimes.com', '8169651334', 44);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Lennie', 'Father', 'lfather5@smugmug.com', '2107370996', 4);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Cati', 'Beatey', 'cbeatey6@virginia.edu', '2269382816', 33);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Karita', 'Semiras', 'ksemiras7@biblegateway.com', '5009857037', 11);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Berthe', 'Easby', 'beasby8@seesaa.net', '7463532177', 43);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Vick', 'Menlove', 'vmenlove9@google.pl', '5913930493', 24);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Thorstein', 'Bastock', 'tbastocka@storify.com', '3786184306', 42);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Lesya', 'Perrin', 'lperrinb@delicious.com', '9114887653', 32);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Byron', 'Kingston', 'bkingstonc@lycos.com', '4993406337', 9);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Helenelizabeth', 'Realy', 'hrealyd@accuweather.com', '6811138596', 18);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Kirby', 'Flatley', 'kflatleye@twitpic.com', '8004426870', 35);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Ryan', 'Connow', 'rconnowf@quantcast.com', '4974151252', 8);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Trent', 'Bexley', 'tbexleyg@twitpic.com', '4301620478', 21);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Darsie', 'Whyteman', 'dwhyteman@jiathis.com', '4171325245', 16);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Lorrin', 'Furney', 'lfurneyi@wiley.com', '7347404913', 34);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Gabbey', 'Cleever', 'gcleeverj@google.cn', '7775802664', 20);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Harrietta', 'Caddell', 'hcaddellk@miibeian.gov.cn', '1236395389', 17);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Rodie', 'Fishpoole', 'rfishpoole@hostgator.com', '1682555210', 7);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Appolonia', 'Monery', 'amonerym@kickstarter.com', '1838013486', 46);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Norma', 'Stiegars', 'nstiegarsn@sphinn.com', '8014871494', 25);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Naoma', 'Basnett', 'nbasnetto@blogger.com', '9178684207', 6);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Jaclyn', 'Vorley', 'jvorleyp@123-reg.co.uk', '5432384464', 40);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Hashim', 'Whyteman', 'hwhytemanq@marketwatch.com', '6538574526', 16);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Shandy', 'Trounce', 'strouncer@virginia.edu', '3755801197', 26);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Elva', 'Oboy', 'eoboys@google.de', '8323873554', 28);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Brooke', 'Breslau', 'bbreslaut@fastcompany.com', '8933984985', 39);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Rowney', 'O'' Scallan', 'roscallanu@kickstarter.com', '6403950054', 12);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Eba', 'Knibb', 'eknibbv@hexun.com', '2138442270', 46);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Angelia', 'Jobson', 'ajobsonw@theatlantic.com', '2607884337', 38);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Dottie', 'Kolinsky', 'dkolinskyx@facebook.com', '1858273306', 1);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Phillipe', 'Guerreru', 'pguerreruy@marriott.com', '6898223859', 10);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Prescott', 'Berrygun', 'pberrygunz@live.com', '8164111734', 47);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Emmott', 'Casacchia', 'ecasacchia10@smh.com.au', '4557830453', 27);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Jamaal', 'Coupe', 'jcoupe11@ibm.com', '4028398599', 15);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Eda', 'Meaden', 'emeaden12@rakuten.co.jp', '3499024598', 36);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Levy', 'Guerin', 'lguerin13@elegantthemes.com', '8562188613', 13);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Korry', 'Folder', 'kfolder14@techcrunch.com', '3954932855', 30);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Che', 'Whitney', 'cwhitney15@vkontakte.ru', '5367667414', 45);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Kleon', 'Moughtin', 'kmoughtin16@nytimes.com', '7405242073', 41);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Guenevere', 'Kenton', 'gkenton17@ted.com', '5195601270', 22);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Cully', 'Pinches', 'cpinches18@eventbrite.com', '7078586585', 14);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Patten', 'Paulig', 'ppaulig19@360.cn', '3581776688', 37);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Zolly', 'Veall', 'zveall1a@4shared.com', '4411406918', 5);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Vivien', 'Hoffner', 'vhoffner1b@cloudflare.com', '4342136990', 19);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Lucy', 'Rosier', 'lrosier1c@deviantart.com', '2109460721', 29);
Insert Into Customer (CustomerFirstName, CustomerLastName, CustomerEmailAddress, PhoneNumber, CustomerAddressID) values ('Chloe', 'Fishpoole', 'cfishpoole1d@ftc.gov', '8215530219', 7);

Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Volvo', 'S40', 'GR', 2001, 'Mauv', 'JHMZE2H59AS022197');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Plymouth', 'Horizon', 'RU', 1978, null, 'JHMZF1C41BS266286');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Ford', 'Flex', 'PE', 2010, 'Red', '1C3BC7EG4BN912462');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Oldsmobile', 'Silhouette', 'AF', 1999, 'Teal', 'JN8AF5MR6ET803317');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Land Rover', 'Freelander', 'DO', 2010, 'Pink', '1FTEW1C86AK106466');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Lexus', 'GX', 'CF', 2006, 'Pink', 'JTDKN3DU9B0983871');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Porsche', 'Cayenne', 'RU', 2004, 'Maroon', 'JH4CL96917C039167');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Honda', 'Prelude', 'ID', 2001, 'Orange', 'WDDDJ7CB2BA322579');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Ford', 'LTD Crown Victoria', 'FI', 1988, 'Maroon', 'ML32A3HJ4FH601896');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Buick', 'LaCrosse', 'FR', 2007, 'Red', 'WAUHF98P27A375784');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('GMC', 'Yukon XL 1500', 'US', 2001, 'Blue', '1FMJU1F5XAE727483');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Audi', 'riolet', 'CN', 1998, 'Green', 'WAUPN94EX9N528992');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Ford', 'Crown Victoria', 'TD', 1999, 'Crimson', '1N6AD0CW8FN643407');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Toyota', 'Celica', 'PH', 1978, 'Orange', 'WAULC58E15A093059');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Isuzu', 'Trooper', 'FR', 1993, 'Crimson', 'WAUET48H65K757895');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Ford', 'F250', 'CN', 2004, 'Green', '1GYS3HEF1BR195014');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Chevrolet', 'Lumina', 'JP', 1996, 'Green', 'SALSF2D49AA969798');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Aston Martin', 'V8 Vantage S', 'CN', 2011, 'Teal', '3C3CFFBR7DT673522');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Toyota', 'Camry', 'CN', 1996, 'Crimson', 'SCFAD02E59G325136');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Mercury', 'Monterey', 'ID', 2007, 'Blue', '1G6KY549X1U141842');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Mercedes-Benz', 'C-Class', 'PL', 2011, 'Turquoise', 'WBAEB53598C353090');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Ferrari', '612 Scaglietti', 'CU', 2007, null, '3GYFK22259G411458');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Daewoo', 'Nubira', 'PL', 2002, 'Green', 'TRUSC28N931908284');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('BMW', '530', 'AL', 2003, 'Mauv', 'JTEBU5JR1E5786985');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Mercedes-Benz', 'S-Class', 'CN', 2005, 'Blue', '1G6AX5S39F0560941');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Mazda', '626', 'PL', 1993, 'Yellow', 'WAUAH94F16N311042');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('GMC', 'Rally Wagon 2500', 'US', 1994, 'Teal', 'WBALL5C54EE237171');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Mercury', 'Villager', 'RS', 1996, 'Teal', '5GAKRDKD3DJ882336');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Lamborghini', 'Murciélago', 'AL', 2007, null, '1N6AF0LY0FN572909');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Lexus', 'IS', 'SE', 2006, null, 'WBAVT13536A634042');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Lamborghini', 'Gallardo', 'MN', 2003, 'Crimson', '5NPDH4AE0CH098207');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Kia', 'Sportage', 'JP', 2000, 'Purple', '3C63D2GL9CG086770');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Ford', 'Windstar', 'PT', 1998, 'Red', '1N6AD0CW2EN274638');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Cadillac', 'Allante', 'CN', 1992, null, 'SCBGH3ZA3FC263775');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Mercedes-Benz', 'SL-Class', 'IE', 1986, 'Violet', 'WAUFFAFM4CA189109');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('MINI', 'Cooper', 'RU', 2009, 'Red', 'JH4KB16517C951312');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Mazda', '929', 'RU', 1992, 'Maroon', 'WBA3B9C54DF362187');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Honda', 'CR-X', 'PL', 1988, 'Puce', 'WAUCVAFR0CA223788');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Toyota', 'Venza', 'BR', 2011, 'Indigo', '1G6AR5S35E0982360');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Ford', 'E350', 'NP', 2006, null, '5N1AA0NC5FN347965');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Mazda', 'MPV', 'KZ', 1992, 'Turquoise', 'WBAWV53539P404282');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Pontiac', 'Monterey', 'CN', 2005, 'Mauv', 'WA1LGAFE5FD644901');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Lincoln', 'Mark LT', 'US', 2006, 'Mauv', 'WP1AE2A23DL247403');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Saturn', 'Aura', 'GM', 2008, 'Red', 'WBAUU33529A245174');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Nissan', 'Pathfinder', 'CO', 1995, 'Yellow', '1GKKRNED8BJ274393');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Plymouth', 'Grand Voyager', 'LY', 2000, 'Purple', 'WAUEFAFL3AN019882');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Saab', '9000', 'CN', 1994, null, 'WBAEH13476C493442');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Dodge', 'Stratus', 'GT', 2006, 'Aquamarine', 'WAUCD64B94N859268');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Cadillac', 'Seville', 'TD', 1997, null, 'JM1NC2MF1E0706697');
Insert Into Car (Make, Model, CarTrim, CarYear, Color, VinNumber) values ('Chevrolet', 'Classic', 'SE', 2005, 'Fuscia', '1G6AE5SX5E0176615');

Insert Into CarService (ServiceDone, EstimatedDays, EstimatedServiceCost) values ('Oil Change', 1, 100);
Insert Into CarService (ServiceDone, EstimatedDays, EstimatedServiceCost) values ('Transmission Flush', 2, 200);
Insert Into CarService (ServiceDone, EstimatedDays, EstimatedServiceCost) values ('Engine Rebuild', 15, 7500);
Insert Into CarService (ServiceDone, EstimatedDays, EstimatedServiceCost) values ('Tires Mounted and Balanced', 2, 50);
Insert Into CarService (ServiceDone, EstimatedDays, EstimatedServiceCost) values ('Replace Brakes', 1, 75);
Insert Into CarService (ServiceDone, EstimatedDays, EstimatedServiceCost) values ('Suspension Replacement', 7, 3000);


Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 1, '07/20/2021', '07/22/2021', 104);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 29, '12/29/2021', '12/30/2021', 83);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 3, '03/15/2022', '03/17/2022', 110);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 15, '02/23/2022', '02/23/2022', 87);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 8, '11/15/2021', '11/16/2021', 83);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 9, '03/31/2022', '04/01/2022', 95);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 13, '12/20/2021', '12/21/2021', 107);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 15, '11/16/2021', '11/16/2021', 87);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 5, '08/07/2021', '08/09/2021', 80);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 18, '01/02/2022', '01/05/2022', 119);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 24, '01/18/2022', '01/18/2022', 85);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 27, '12/20/2021', '12/21/2021', 73);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 29, '11/13/2021', '11/14/2021', 111);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 30, '09/10/2021', '09/11/2021', 96);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 32, '10/21/2021', '10/21/2021', 81);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 34, '02/05/2022', '02/07/2022', 97);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 37, getdate()-1, null, null);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 38, '12/02/2021', '12/06/2021', 113);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 40, '12/14/2021', '12/16/2021', 101);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 43, '05/07/2022', '05/07/2022', 93);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 44, '11/18/2021', '11/20/2021', 104);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 46, getdate()-2, null, null);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 47, '09/01/2021', '09/04/2021', 109);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (1, 50, '05/20/2022', '05/21/2022', 95);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (2, 13, '06/10/2021', '06/12/2021', 254);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (2, 17, '06/19/2021', '06/22/2021', 157);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (2, 28, '03/24/2022', '03/25/2022', 268);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (2, 33, '07/02/2021', '07/03/2021', 184);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (2, 37, '10/10/2021', '10/11/2021', 280);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (2, 48, '08/28/2021', '08/30/2021', 189);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (3, 35, '11/21/2021', '12/08/2021', 8200);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (3, 48, '10/10/2021', '11/04/2021', 7750);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 7, '11/01/2021', '11/01/2021', 60);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 16, '10/27/2021', '10/28/2021', 32);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 25, '06/11/2021', '06/12/2021', 35);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 28, '03/30/2022', '03/31/2022', 52);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 2, '12/26/2021', '12/27/2021', 44);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 36, '06/29/2021', '07/01/2021', 57);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 39, getdate()-1, null, null);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 41, '04/12/2022', '04/15/2022', 87);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 45, '11/22/2021', '11/23/2021', 43);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (4, 49, '03/04/2022', '03/05/2022', 56);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 3, '11/24/2021', '11/25/2021', 75);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 4, '05/01/2022', '05/02/2022', 54);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 6, '07/09/2021', '07/10/2021', 82);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 10, '06/26/2021', '06/27/2021', 47);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 11, '11/18/2021', '11/19/2021', 76);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 14, '02/13/2022', '02/14/2022', 66);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 19, '06/22/2021', '06/23/2021', 61);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 22, '10/23/2021', '10/23/2021', 88);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 23, '10/10/2021', '10/11/2021', 61);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 26, '03/03/2022', '03/04/2022', 90);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 36, '11/16/2021', '11/17/2021', 87);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 42, '06/18/2021', '06/20/2021', 77);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 47, '04/09/2022', '04/10/2022', 79);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 50, '05/01/2022', '05/02/2022', 93);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 33, '03/23/2022', '03/24/2022', 43);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 31, '07/17/2021', '07/17/2021', 91)
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (5, 5, '04/04/2022', '04/05/2022', 64);
Insert Into CarCarService (ServiceID, CarID, DateReceived, DateReturned, ActualCost) values (6, 12, '09/01/2021', '09/06/2021', 2641);

Insert Into CustomerCar (CustomerID, CarID) values (1, 15);
Insert Into CustomerCar (CustomerID, CarID) values (2, 17);
Insert Into CustomerCar (CustomerID, CarID) values (3, 11);
Insert Into CustomerCar (CustomerID, CarID) values (4, 12);
Insert Into CustomerCar (CustomerID, CarID) values (5, 16);
Insert Into CustomerCar (CustomerID, CarID) values (6, 19);
Insert Into CustomerCar (CustomerID, CarID) values (7, 10);
Insert Into CustomerCar (CustomerID, CarID) values (8, 18);
Insert Into CustomerCar (CustomerID, CarID) values (9, 14);
Insert Into CustomerCar (CustomerID, CarID) values (10, 13);
Insert Into CustomerCar (CustomerID, CarID) values (11, 1);
Insert Into CustomerCar (CustomerID, CarID) values (12, 5);
Insert Into CustomerCar (CustomerID, CarID) values (13, 7);
Insert Into CustomerCar (CustomerID, CarID) values (14, 3);
Insert Into CustomerCar (CustomerID, CarID) values (15, 6);
Insert Into CustomerCar (CustomerID, CarID) values (16, 9);
Insert Into CustomerCar (CustomerID, CarID) values (17, 42);
Insert Into CustomerCar (CustomerID, CarID) values (18, 8);
Insert Into CustomerCar (CustomerID, CarID) values (18, 2);
Insert Into CustomerCar (CustomerID, CarID) values (19, 4);
Insert Into CustomerCar (CustomerID, CarID) values (20, 24);
Insert Into CustomerCar (CustomerID, CarID) values (21, 32);
Insert Into CustomerCar (CustomerID, CarID) values (22, 25);
Insert Into CustomerCar (CustomerID, CarID) values (22, 27);
Insert Into CustomerCar (CustomerID, CarID) values (23, 34);
Insert Into CustomerCar (CustomerID, CarID) values (23, 37);
Insert Into CustomerCar (CustomerID, CarID) values (24, 28);
Insert Into CustomerCar (CustomerID, CarID) values (25, 39);
Insert Into CustomerCar (CustomerID, CarID) values (26, 21);
Insert Into CustomerCar (CustomerID, CarID) values (27, 8);
Insert Into CustomerCar (CustomerID, CarID) values (27, 2);
Insert Into CustomerCar (CustomerID, CarID) values (28, 36);
Insert Into CustomerCar (CustomerID, CarID) values (29, 33);
Insert Into CustomerCar (CustomerID, CarID) values (30, 20);
Insert Into CustomerCar (CustomerID, CarID) values (31, 22);
Insert Into CustomerCar (CustomerID, CarID) values (32, 34);
Insert Into CustomerCar (CustomerID, CarID) values (33, 41);
Insert Into CustomerCar (CustomerID, CarID) values (35, 48);
Insert Into CustomerCar (CustomerID, CarID) values (36, 31);
Insert Into CustomerCar (CustomerID, CarID) values (37, 45);
Insert Into CustomerCar (CustomerID, CarID) values (38, 43);
Insert Into CustomerCar (CustomerID, CarID) values (39, 49);
Insert Into CustomerCar (CustomerID, CarID) values (40, 46);
Insert Into CustomerCar (CustomerID, CarID) values (41, 30);
Insert Into CustomerCar (CustomerID, CarID) values (42, 47);
Insert Into CustomerCar (CustomerID, CarID) values (43, 50);
Insert Into CustomerCar (CustomerID, CarID) values (44, 42);
Insert Into CustomerCar (CustomerID, CarID) values (45, 35);
Insert Into CustomerCar (CustomerID, CarID) values (46, 40);
Insert Into CustomerCar (CustomerID, CarID) values (47, 38);
Insert Into CustomerCar (CustomerID, CarID) values (48, 44);
Insert Into CustomerCar (CustomerID, CarID) values (50, 25);
Insert Into CustomerCar (CustomerID, CarID) values (50, 27);


