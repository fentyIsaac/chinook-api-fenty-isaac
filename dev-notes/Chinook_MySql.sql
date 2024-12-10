--   Chinook Database - Version 1.4.5
--   Script: Chinook_MySql_AutoIncrementPKs.sql
--   Description: Creates and populates the Chinook database.
--   DB Server: MySql
--   Author: Luis Rocha
--   License: https://github.com/lerocha/chinook-database/blob/master/LICENSE.md

--   NOTE THAT THE ORIGINAL SQL HAS BEEN MODIFIED TO INCLUDE A user TABLE
--   AND A userrole TABLE

--   ALSO, SOME ROWS HAVE BEEN REMOVED FROM A FEW TABLES (mainly the track table)
--   TO KEEP THE DATABASE SMALL, WHICH WILL HELP WHEN RUNNING UNIT TESTS


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DROP DATABASE IF EXISTS `chinook`;
CREATE DATABASE `chinook`;
USE `chinook`;

--
-- Table structure for table `album`
--

CREATE TABLE `album` (
  `AlbumId` int(11) NOT NULL,
  `Title` varchar(160) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ArtistId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `album`
--

INSERT INTO `album` (`AlbumId`, `Title`, `ArtistId`) VALUES
(1, 'For Those About To Rock We Salute You', 1),
(2, 'Balls to the Wall', 2),
(3, 'Restless and Wild', 2),
(4, 'Let There Be Rock', 1),
(5, 'Big Ones', 3),
(6, 'Jagged Little Pill', 4),
(7, 'Facelift', 5),
(8, 'Warner 25 Anos', 6),
(9, 'Plays Metallica By Four Cellos', 7),
(10, 'Audioslave', 8);

-- --------------------------------------------------------

--
-- Table structure for table `artist`
--

CREATE TABLE `artist` (
  `ArtistId` int(11) NOT NULL,
  `Name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artist`
--

INSERT INTO `artist` (`ArtistId`, `Name`) VALUES
(1, 'AC/DC'),
(2, 'Accept'),
(3, 'Aerosmith'),
(4, 'Alanis Morissette'),
(5, 'Alice In Chains'),
(6, 'Antônio Carlos Jobim'),
(7, 'Apocalyptica'),
(8, 'Audioslave'),
(9, 'BackBeat'),
(10, 'Billy Cobham');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerId` int(11) NOT NULL,
  `FirstName` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LastName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Company` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Address` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `City` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `State` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Country` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `PostalCode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Phone` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Fax` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Email` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SupportRepId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerId`, `FirstName`, `LastName`, `Company`, `Address`, `City`, `State`, `Country`, `PostalCode`, `Phone`, `Fax`, `Email`, `SupportRepId`) VALUES
(1, 'Luís', 'Gonçalves', 'Embraer - Empresa Brasileira de Aeronáutica S.A.', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', '+55 (12) 3923-5555', '+55 (12) 3923-5566', 'luisg@embraer.com.br', 3),
(2, 'Leonie', 'Köhler', NULL, 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', '+49 0711 2842222', NULL, 'leonekohler@surfeu.de', 5),
(3, 'François', 'Tremblay', NULL, '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', '+1 (514) 721-4711', NULL, 'ftremblay@gmail.com', 3),
(4, 'Bjørn', 'Hansen', NULL, 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', '+47 22 44 22 22', NULL, 'bjorn.hansen@yahoo.no', 4),
(5, 'František', 'Wichterlová', 'JetBrains s.r.o.', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', '+420 2 4172 5555', '+420 2 4172 5555', 'frantisekw@jetbrains.com', 4),
(6, 'Helena', 'Holý', NULL, 'Rilská 3174/6', 'Prague', NULL, 'Czech Republic', '14300', '+420 2 4177 0449', NULL, 'hholy@gmail.com', 5),
(7, 'Astrid', 'Gruber', NULL, 'Rotenturmstraße 4, 1010 Innere Stadt', 'Vienne', NULL, 'Austria', '1010', '+43 01 5134505', NULL, 'astrid.gruber@apple.at', 5),
(8, 'Daan', 'Peeters', NULL, 'Grétrystraat 63', 'Brussels', NULL, 'Belgium', '1000', '+32 02 219 03 03', NULL, 'daan_peeters@apple.be', 4),
(9, 'Kara', 'Nielsen', NULL, 'Sønder Boulevard 51', 'Copenhagen', NULL, 'Denmark', '1720', '+453 3331 9991', NULL, 'kara.nielsen@jubii.dk', 4),
(10, 'Eduardo', 'Martins', 'Woodstock Discos', 'Rua Dr. Falcão Filho, 155', 'São Paulo', 'SP', 'Brazil', '01007-010', '+55 (11) 3033-5446', '+55 (11) 3033-4564', 'eduardo@woodstock.com.br', 4),
(11, 'Alexandre', 'Rocha', 'Banco do Brasil S.A.', 'Av. Paulista, 2022', 'São Paulo', 'SP', 'Brazil', '01310-200', '+55 (11) 3055-3278', '+55 (11) 3055-8131', 'alero@uol.com.br', 5),
(12, 'Roberto', 'Almeida', 'Riotur', 'Praça Pio X, 119', 'Rio de Janeiro', 'RJ', 'Brazil', '20040-020', '+55 (21) 2271-7000', '+55 (21) 2271-7070', 'roberto.almeida@riotur.gov.br', 3),
(13, 'Fernanda', 'Ramos', NULL, 'Qe 7 Bloco G', 'Brasília', 'DF', 'Brazil', '71020-677', '+55 (61) 3363-5547', '+55 (61) 3363-7855', 'fernadaramos4@uol.com.br', 4),
(14, 'Mark', 'Philips', 'Telus', '8210 111 ST NW', 'Edmonton', 'AB', 'Canada', 'T6G 2C7', '+1 (780) 434-4554', '+1 (780) 434-5565', 'mphilips12@shaw.ca', 5),
(15, 'Jennifer', 'Peterson', 'Rogers Canada', '700 W Pender Street', 'Vancouver', 'BC', 'Canada', 'V6C 1G8', '+1 (604) 688-2255', '+1 (604) 688-8756', 'jenniferp@rogers.ca', 3),
(16, 'Frank', 'Harris', 'Google Inc.', '1600 Amphitheatre Parkway', 'Mountain View', 'CA', 'USA', '94043-1351', '+1 (650) 253-0000', '+1 (650) 253-0000', 'fharris@google.com', 4),
(17, 'Jack', 'Smith', 'Microsoft Corporation', '1 Microsoft Way', 'Redmond', 'WA', 'USA', '98052-8300', '+1 (425) 882-8080', '+1 (425) 882-8081', 'jacksmith@microsoft.com', 5),
(18, 'Michelle', 'Brooks', NULL, '627 Broadway', 'New York', 'NY', 'USA', '10012-2612', '+1 (212) 221-3546', '+1 (212) 221-4679', 'michelleb@aol.com', 3),
(19, 'Tim', 'Goyer', 'Apple Inc.', '1 Infinite Loop', 'Cupertino', 'CA', 'USA', '95014', '+1 (408) 996-1010', '+1 (408) 996-1011', 'tgoyer@apple.com', 3),
(20, 'Dan', 'Miller', NULL, '541 Del Medio Avenue', 'Mountain View', 'CA', 'USA', '94040-111', '+1 (650) 644-3358', NULL, 'dmiller@comcast.com', 4),
(21, 'Kathy', 'Chase', NULL, '801 W 4th Street', 'Reno', 'NV', 'USA', '89503', '+1 (775) 223-7665', NULL, 'kachase@hotmail.com', 5),
(22, 'Heather', 'Leacock', NULL, '120 S Orange Ave', 'Orlando', 'FL', 'USA', '32801', '+1 (407) 999-7788', NULL, 'hleacock@gmail.com', 4),
(23, 'John', 'Gordon', NULL, '69 Salem Street', 'Boston', 'MA', 'USA', '2113', '+1 (617) 522-1333', NULL, 'johngordon22@yahoo.com', 4),
(24, 'Frank', 'Ralston', NULL, '162 E Superior Street', 'Chicago', 'IL', 'USA', '60611', '+1 (312) 332-3232', NULL, 'fralston@gmail.com', 3),
(25, 'Victor', 'Stevens', NULL, '319 N. Frances Street', 'Madison', 'WI', 'USA', '53703', '+1 (608) 257-0597', NULL, 'vstevens@yahoo.com', 5),
(26, 'Richard', 'Cunningham', NULL, '2211 W Berry Street', 'Fort Worth', 'TX', 'USA', '76110', '+1 (817) 924-7272', NULL, 'ricunningham@hotmail.com', 4),
(27, 'Patrick', 'Gray', NULL, '1033 N Park Ave', 'Tucson', 'AZ', 'USA', '85719', '+1 (520) 622-4200', NULL, 'patrick.gray@aol.com', 4),
(28, 'Julia', 'Barnett', NULL, '302 S 700 E', 'Salt Lake City', 'UT', 'USA', '84102', '+1 (801) 531-7272', NULL, 'jubarnett@gmail.com', 5),
(29, 'Robert', 'Brown', NULL, '796 Dundas Street West', 'Toronto', 'ON', 'Canada', 'M6J 1V1', '+1 (416) 363-8888', NULL, 'robbrown@shaw.ca', 3),
(30, 'Edward', 'Francis', NULL, '230 Elgin Street', 'Ottawa', 'ON', 'Canada', 'K2P 1L7', '+1 (613) 234-3322', NULL, 'edfrancis@yachoo.ca', 3),
(31, 'Martha', 'Silk', NULL, '194A Chain Lake Drive', 'Halifax', 'NS', 'Canada', 'B3S 1C5', '+1 (902) 450-0450', NULL, 'marthasilk@gmail.com', 5),
(32, 'Aaron', 'Mitchell', NULL, '696 Osborne Street', 'Winnipeg', 'MB', 'Canada', 'R3L 2B9', '+1 (204) 452-6452', NULL, 'aaronmitchell@yahoo.ca', 4),
(33, 'Ellie', 'Sullivan', NULL, '5112 48 Street', 'Yellowknife', 'NT', 'Canada', 'X1A 1N6', '+1 (867) 920-2233', NULL, 'ellie.sullivan@shaw.ca', 3),
(34, 'João', 'Fernandes', NULL, 'Rua da Assunção 53', 'Lisbon', NULL, 'Portugal', NULL, '+351 (213) 466-111', NULL, 'jfernandes@yahoo.pt', 4),
(35, 'Madalena', 'Sampaio', NULL, 'Rua dos Campeões Europeus de Viena, 4350', 'Porto', NULL, 'Portugal', NULL, '+351 (225) 022-448', NULL, 'masampaio@sapo.pt', 4),
(36, 'Hannah', 'Schneider', NULL, 'Tauentzienstraße 8', 'Berlin', NULL, 'Germany', '10789', '+49 030 26550280', NULL, 'hannah.schneider@yahoo.de', 5),
(37, 'Fynn', 'Zimmermann', NULL, 'Berger Straße 10', 'Frankfurt', NULL, 'Germany', '60316', '+49 069 40598889', NULL, 'fzimmermann@yahoo.de', 3),
(38, 'Niklas', 'Schröder', NULL, 'Barbarossastraße 19', 'Berlin', NULL, 'Germany', '10779', '+49 030 2141444', NULL, 'nschroder@surfeu.de', 3),
(39, 'Camille', 'Bernard', NULL, '4, Rue Milton', 'Paris', NULL, 'France', '75009', '+33 01 49 70 65 65', NULL, 'camille.bernard@yahoo.fr', 4),
(40, 'Dominique', 'Lefebvre', NULL, '8, Rue Hanovre', 'Paris', NULL, 'France', '75002', '+33 01 47 42 71 71', NULL, 'dominiquelefebvre@gmail.com', 4),
(41, 'Marc', 'Dubois', NULL, '11, Place Bellecour', 'Lyon', NULL, 'France', '69002', '+33 04 78 30 30 30', NULL, 'marc.dubois@hotmail.com', 5),
(42, 'Wyatt', 'Girard', NULL, '9, Place Louis Barthou', 'Bordeaux', NULL, 'France', '33000', '+33 05 56 96 96 96', NULL, 'wyatt.girard@yahoo.fr', 3),
(43, 'Isabelle', 'Mercier', NULL, '68, Rue Jouvence', 'Dijon', NULL, 'France', '21000', '+33 03 80 73 66 99', NULL, 'isabelle_mercier@apple.fr', 3),
(44, 'Terhi', 'Hämäläinen', NULL, 'Porthaninkatu 9', 'Helsinki', NULL, 'Finland', '00530', '+358 09 870 2000', NULL, 'terhi.hamalainen@apple.fi', 3),
(45, 'Ladislav', 'Kovács', NULL, 'Erzsébet krt. 58.', 'Budapest', NULL, 'Hungary', 'H-1073', NULL, NULL, 'ladislav_kovacs@apple.hu', 3),
(46, 'Hugh', 'O\'Reilly', NULL, '3 Chatham Street', 'Dublin', 'Dublin', 'Ireland', NULL, '+353 01 6792424', NULL, 'hughoreilly@apple.ie', 3),
(47, 'Lucas', 'Mancini', NULL, 'Via Degli Scipioni, 43', 'Rome', 'RM', 'Italy', '00192', '+39 06 39733434', NULL, 'lucas.mancini@yahoo.it', 5),
(48, 'Johannes', 'Van der Berg', NULL, 'Lijnbaansgracht 120bg', 'Amsterdam', 'VV', 'Netherlands', '1016', '+31 020 6223130', NULL, 'johavanderberg@yahoo.nl', 5),
(49, 'Stanisław', 'Wójcik', NULL, 'Ordynacka 10', 'Warsaw', NULL, 'Poland', '00-358', '+48 22 828 37 39', NULL, 'stanisław.wójcik@wp.pl', 4),
(50, 'Enrique', 'Muñoz', NULL, 'C/ San Bernardo 85', 'Madrid', NULL, 'Spain', '28015', '+34 914 454 454', NULL, 'enrique_munoz@yahoo.es', 5),
(51, 'Joakim', 'Johansson', NULL, 'Celsiusg. 9', 'Stockholm', NULL, 'Sweden', '11230', '+46 08-651 52 52', NULL, 'joakim.johansson@yahoo.se', 5),
(52, 'Emma', 'Jones', NULL, '202 Hoxton Street', 'London', NULL, 'United Kingdom', 'N1 5LH', '+44 020 7707 0707', NULL, 'emma_jones@hotmail.com', 3),
(53, 'Phil', 'Hughes', NULL, '113 Lupus St', 'London', NULL, 'United Kingdom', 'SW1V 3EN', '+44 020 7976 5722', NULL, 'phil.hughes@gmail.com', 3),
(54, 'Steve', 'Murray', NULL, '110 Raeburn Pl', 'Edinburgh ', NULL, 'United Kingdom', 'EH4 1HH', '+44 0131 315 3300', NULL, 'steve.murray@yahoo.uk', 5),
(55, 'Mark', 'Taylor', NULL, '421 Bourke Street', 'Sidney', 'NSW', 'Australia', '2010', '+61 (02) 9332 3633', NULL, 'mark.taylor@yahoo.au', 4),
(56, 'Diego', 'Gutiérrez', NULL, '307 Macacha Güemes', 'Buenos Aires', NULL, 'Argentina', '1106', '+54 (0)11 4311 4333', NULL, 'diego.gutierrez@yahoo.ar', 4),
(57, 'Luis', 'Rojas', NULL, 'Calle Lira, 198', 'Santiago', NULL, 'Chile', NULL, '+56 (0)2 635 4444', NULL, 'luisrojas@yahoo.cl', 5),
(58, 'Manoj', 'Pareek', NULL, '12,Community Centre', 'Delhi', NULL, 'India', '110017', '+91 0124 39883988', NULL, 'manoj.pareek@rediff.com', 3),
(59, 'Puja', 'Srivastava', NULL, '3,Raj Bhavan Road', 'Bangalore', NULL, 'India', '560001', '+91 080 22289999', NULL, 'puja_srivastava@yahoo.in', 3);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `EmployeeId` int(11) NOT NULL,
  `LastName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FirstName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ReportsTo` int(11) DEFAULT NULL,
  `BirthDate` datetime DEFAULT NULL,
  `HireDate` datetime DEFAULT NULL,
  `Address` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `City` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `State` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Country` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `PostalCode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Phone` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Fax` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Email` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`EmployeeId`, `LastName`, `FirstName`, `Title`, `ReportsTo`, `BirthDate`, `HireDate`, `Address`, `City`, `State`, `Country`, `PostalCode`, `Phone`, `Fax`, `Email`) VALUES
(1, 'Adams', 'Andrew', 'General Manager', NULL, '1962-02-18 00:00:00', '2002-08-14 00:00:00', '11120 Jasper Ave NW', 'Edmonton', 'AB', 'Canada', 'T5K 2N1', '+1 (780) 428-9482', '+1 (780) 428-3457', 'andrew@chinookcorp.com'),
(2, 'Edwards', 'Nancy', 'Sales Manager', 1, '1958-12-08 00:00:00', '2002-05-01 00:00:00', '825 8 Ave SW', 'Calgary', 'AB', 'Canada', 'T2P 2T3', '+1 (403) 262-3443', '+1 (403) 262-3322', 'nancy@chinookcorp.com'),
(3, 'Peacock', 'Jane', 'Sales Support Agent', 2, '1973-08-29 00:00:00', '2002-04-01 00:00:00', '1111 6 Ave SW', 'Calgary', 'AB', 'Canada', 'T2P 5M5', '+1 (403) 262-3443', '+1 (403) 262-6712', 'jane@chinookcorp.com'),
(4, 'Park', 'Margaret', 'Sales Support Agent', 2, '1947-09-19 00:00:00', '2003-05-03 00:00:00', '683 10 Street SW', 'Calgary', 'AB', 'Canada', 'T2P 5G3', '+1 (403) 263-4423', '+1 (403) 263-4289', 'margaret@chinookcorp.com'),
(5, 'Johnson', 'Steve', 'Sales Support Agent', 2, '1965-03-03 00:00:00', '2003-10-17 00:00:00', '7727B 41 Ave', 'Calgary', 'AB', 'Canada', 'T3B 1Y7', '1 (780) 836-9987', '1 (780) 836-9543', 'steve@chinookcorp.com'),
(6, 'Mitchell', 'Michael', 'IT Manager', 1, '1973-07-01 00:00:00', '2003-10-17 00:00:00', '5827 Bowness Road NW', 'Calgary', 'AB', 'Canada', 'T3B 0C5', '+1 (403) 246-9887', '+1 (403) 246-9899', 'michael@chinookcorp.com'),
(7, 'King', 'Robert', 'IT Staff', 6, '1970-05-29 00:00:00', '2004-01-02 00:00:00', '590 Columbia Boulevard West', 'Lethbridge', 'AB', 'Canada', 'T1K 5N8', '+1 (403) 456-9986', '+1 (403) 456-8485', 'robert@chinookcorp.com'),
(8, 'Callahan', 'Laura', 'IT Staff', 6, '1968-01-09 00:00:00', '2004-03-04 00:00:00', '923 7 ST NW', 'Lethbridge', 'AB', 'Canada', 'T1H 1Y8', '+1 (403) 467-3351', '+1 (403) 467-8772', 'laura@chinookcorp.com');

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `GenreId` int(11) NOT NULL,
  `Name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`GenreId`, `Name`) VALUES
(1, 'Rock'),
(2, 'Jazz'),
(3, 'Metal'),
(4, 'Alternative & Punk'),
(5, 'Rock And Roll'),
(6, 'Blues'),
(7, 'Latin'),
(8, 'Reggae'),
(9, 'Pop'),
(10, 'Soundtrack'),
(11, 'Bossa Nova'),
(12, 'Easy Listening'),
(13, 'Heavy Metal'),
(14, 'R&B/Soul'),
(15, 'Electronica/Dance'),
(16, 'World'),
(17, 'Hip Hop/Rap'),
(18, 'Science Fiction'),
(19, 'TV Shows'),
(20, 'Sci Fi & Fantasy'),
(21, 'Drama'),
(22, 'Comedy'),
(23, 'Alternative'),
(24, 'Classical'),
(25, 'Opera');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `InvoiceId` int(11) NOT NULL,
  `CustomerId` int(11) NOT NULL,
  `InvoiceDate` datetime NOT NULL,
  `BillingAddress` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `BillingCity` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `BillingState` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `BillingCountry` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `BillingPostalCode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`InvoiceId`, `CustomerId`, `InvoiceDate`, `BillingAddress`, `BillingCity`, `BillingState`, `BillingCountry`, `BillingPostalCode`, `Total`) VALUES
(1, 2, '2021-01-01 00:00:00', 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', 1.98),
(2, 4, '2021-01-02 00:00:00', 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', 3.96),
(3, 8, '2021-01-03 00:00:00', 'Grétrystraat 63', 'Brussels', NULL, 'Belgium', '1000', 5.94),
(4, 14, '2021-01-06 00:00:00', '8210 111 ST NW', 'Edmonton', 'AB', 'Canada', 'T6G 2C7', 8.91),
(5, 23, '2021-01-11 00:00:00', '69 Salem Street', 'Boston', 'MA', 'USA', '2113', 13.86),
(6, 37, '2021-01-19 00:00:00', 'Berger Straße 10', 'Frankfurt', NULL, 'Germany', '60316', 0.99),
(7, 38, '2021-02-01 00:00:00', 'Barbarossastraße 19', 'Berlin', NULL, 'Germany', '10779', 1.98),
(8, 40, '2021-02-01 00:00:00', '8, Rue Hanovre', 'Paris', NULL, 'France', '75002', 1.98),
(9, 42, '2021-02-02 00:00:00', '9, Place Louis Barthou', 'Bordeaux', NULL, 'France', '33000', 3.96),
(10, 46, '2021-02-03 00:00:00', '3 Chatham Street', 'Dublin', 'Dublin', 'Ireland', NULL, 5.94),
(11, 52, '2021-02-06 00:00:00', '202 Hoxton Street', 'London', NULL, 'United Kingdom', 'N1 5LH', 8.91),
(12, 2, '2021-02-11 00:00:00', 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', 13.86),
(13, 16, '2021-02-19 00:00:00', '1600 Amphitheatre Parkway', 'Mountain View', 'CA', 'USA', '94043-1351', 0.99),
(14, 17, '2021-03-04 00:00:00', '1 Microsoft Way', 'Redmond', 'WA', 'USA', '98052-8300', 1.98),
(15, 19, '2021-03-04 00:00:00', '1 Infinite Loop', 'Cupertino', 'CA', 'USA', '95014', 1.98),
(16, 21, '2021-03-05 00:00:00', '801 W 4th Street', 'Reno', 'NV', 'USA', '89503', 3.96),
(17, 25, '2021-03-06 00:00:00', '319 N. Frances Street', 'Madison', 'WI', 'USA', '53703', 5.94),
(18, 31, '2021-03-09 00:00:00', '194A Chain Lake Drive', 'Halifax', 'NS', 'Canada', 'B3S 1C5', 8.91),
(19, 40, '2021-03-14 00:00:00', '8, Rue Hanovre', 'Paris', NULL, 'France', '75002', 13.86),
(20, 54, '2021-03-22 00:00:00', '110 Raeburn Pl', 'Edinburgh ', NULL, 'United Kingdom', 'EH4 1HH', 0.99),
(21, 55, '2021-04-04 00:00:00', '421 Bourke Street', 'Sidney', 'NSW', 'Australia', '2010', 1.98),
(22, 57, '2021-04-04 00:00:00', 'Calle Lira, 198', 'Santiago', NULL, 'Chile', NULL, 1.98),
(23, 59, '2021-04-05 00:00:00', '3,Raj Bhavan Road', 'Bangalore', NULL, 'India', '560001', 3.96),
(24, 4, '2021-04-06 00:00:00', 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', 5.94),
(25, 10, '2021-04-09 00:00:00', 'Rua Dr. Falcão Filho, 155', 'São Paulo', 'SP', 'Brazil', '01007-010', 8.91),
(26, 19, '2021-04-14 00:00:00', '1 Infinite Loop', 'Cupertino', 'CA', 'USA', '95014', 13.86),
(27, 33, '2021-04-22 00:00:00', '5112 48 Street', 'Yellowknife', 'NT', 'Canada', 'X1A 1N6', 0.99),
(28, 34, '2021-05-05 00:00:00', 'Rua da Assunção 53', 'Lisbon', NULL, 'Portugal', NULL, 1.98),
(29, 36, '2021-05-05 00:00:00', 'Tauentzienstraße 8', 'Berlin', NULL, 'Germany', '10789', 1.98),
(30, 38, '2021-05-06 00:00:00', 'Barbarossastraße 19', 'Berlin', NULL, 'Germany', '10779', 3.96),
(31, 42, '2021-05-07 00:00:00', '9, Place Louis Barthou', 'Bordeaux', NULL, 'France', '33000', 5.94),
(32, 48, '2021-05-10 00:00:00', 'Lijnbaansgracht 120bg', 'Amsterdam', 'VV', 'Netherlands', '1016', 8.91),
(33, 57, '2021-05-15 00:00:00', 'Calle Lira, 198', 'Santiago', NULL, 'Chile', NULL, 13.86),
(34, 12, '2021-05-23 00:00:00', 'Praça Pio X, 119', 'Rio de Janeiro', 'RJ', 'Brazil', '20040-020', 0.99),
(35, 13, '2021-06-05 00:00:00', 'Qe 7 Bloco G', 'Brasília', 'DF', 'Brazil', '71020-677', 1.98),
(36, 15, '2021-06-05 00:00:00', '700 W Pender Street', 'Vancouver', 'BC', 'Canada', 'V6C 1G8', 1.98),
(37, 17, '2021-06-06 00:00:00', '1 Microsoft Way', 'Redmond', 'WA', 'USA', '98052-8300', 3.96),
(38, 21, '2021-06-07 00:00:00', '801 W 4th Street', 'Reno', 'NV', 'USA', '89503', 5.94),
(39, 27, '2021-06-10 00:00:00', '1033 N Park Ave', 'Tucson', 'AZ', 'USA', '85719', 8.91),
(40, 36, '2021-06-15 00:00:00', 'Tauentzienstraße 8', 'Berlin', NULL, 'Germany', '10789', 13.86),
(41, 50, '2021-06-23 00:00:00', 'C/ San Bernardo 85', 'Madrid', NULL, 'Spain', '28015', 0.99),
(42, 51, '2021-07-06 00:00:00', 'Celsiusg. 9', 'Stockholm', NULL, 'Sweden', '11230', 1.98),
(43, 53, '2021-07-06 00:00:00', '113 Lupus St', 'London', NULL, 'United Kingdom', 'SW1V 3EN', 1.98),
(44, 55, '2021-07-07 00:00:00', '421 Bourke Street', 'Sidney', 'NSW', 'Australia', '2010', 3.96),
(45, 59, '2021-07-08 00:00:00', '3,Raj Bhavan Road', 'Bangalore', NULL, 'India', '560001', 5.94),
(46, 6, '2021-07-11 00:00:00', 'Rilská 3174/6', 'Prague', NULL, 'Czech Republic', '14300', 8.91),
(47, 15, '2021-07-16 00:00:00', '700 W Pender Street', 'Vancouver', 'BC', 'Canada', 'V6C 1G8', 13.86),
(48, 29, '2021-07-24 00:00:00', '796 Dundas Street West', 'Toronto', 'ON', 'Canada', 'M6J 1V1', 0.99),
(49, 30, '2021-08-06 00:00:00', '230 Elgin Street', 'Ottawa', 'ON', 'Canada', 'K2P 1L7', 1.98),
(50, 32, '2021-08-06 00:00:00', '696 Osborne Street', 'Winnipeg', 'MB', 'Canada', 'R3L 2B9', 1.98),
(51, 34, '2021-08-07 00:00:00', 'Rua da Assunção 53', 'Lisbon', NULL, 'Portugal', NULL, 3.96),
(52, 38, '2021-08-08 00:00:00', 'Barbarossastraße 19', 'Berlin', NULL, 'Germany', '10779', 5.94),
(53, 44, '2021-08-11 00:00:00', 'Porthaninkatu 9', 'Helsinki', NULL, 'Finland', '00530', 8.91),
(54, 53, '2021-08-16 00:00:00', '113 Lupus St', 'London', NULL, 'United Kingdom', 'SW1V 3EN', 13.86),
(55, 8, '2021-08-24 00:00:00', 'Grétrystraat 63', 'Brussels', NULL, 'Belgium', '1000', 0.99),
(56, 9, '2021-09-06 00:00:00', 'Sønder Boulevard 51', 'Copenhagen', NULL, 'Denmark', '1720', 1.98),
(57, 11, '2021-09-06 00:00:00', 'Av. Paulista, 2022', 'São Paulo', 'SP', 'Brazil', '01310-200', 1.98),
(58, 13, '2021-09-07 00:00:00', 'Qe 7 Bloco G', 'Brasília', 'DF', 'Brazil', '71020-677', 3.96),
(59, 17, '2021-09-08 00:00:00', '1 Microsoft Way', 'Redmond', 'WA', 'USA', '98052-8300', 5.94),
(60, 23, '2021-09-11 00:00:00', '69 Salem Street', 'Boston', 'MA', 'USA', '2113', 8.91),
(61, 32, '2021-09-16 00:00:00', '696 Osborne Street', 'Winnipeg', 'MB', 'Canada', 'R3L 2B9', 13.86),
(62, 46, '2021-09-24 00:00:00', '3 Chatham Street', 'Dublin', 'Dublin', 'Ireland', NULL, 0.99),
(63, 47, '2021-10-07 00:00:00', 'Via Degli Scipioni, 43', 'Rome', 'RM', 'Italy', '00192', 1.98),
(64, 49, '2021-10-07 00:00:00', 'Ordynacka 10', 'Warsaw', NULL, 'Poland', '00-358', 1.98),
(65, 51, '2021-10-08 00:00:00', 'Celsiusg. 9', 'Stockholm', NULL, 'Sweden', '11230', 3.96),
(66, 55, '2021-10-09 00:00:00', '421 Bourke Street', 'Sidney', 'NSW', 'Australia', '2010', 5.94),
(67, 2, '2021-10-12 00:00:00', 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', 8.91),
(68, 11, '2021-10-17 00:00:00', 'Av. Paulista, 2022', 'São Paulo', 'SP', 'Brazil', '01310-200', 13.86),
(69, 25, '2021-10-25 00:00:00', '319 N. Frances Street', 'Madison', 'WI', 'USA', '53703', 0.99),
(70, 26, '2021-11-07 00:00:00', '2211 W Berry Street', 'Fort Worth', 'TX', 'USA', '76110', 1.98),
(71, 28, '2021-11-07 00:00:00', '302 S 700 E', 'Salt Lake City', 'UT', 'USA', '84102', 1.98),
(72, 30, '2021-11-08 00:00:00', '230 Elgin Street', 'Ottawa', 'ON', 'Canada', 'K2P 1L7', 3.96),
(73, 34, '2021-11-09 00:00:00', 'Rua da Assunção 53', 'Lisbon', NULL, 'Portugal', NULL, 5.94),
(74, 40, '2021-11-12 00:00:00', '8, Rue Hanovre', 'Paris', NULL, 'France', '75002', 8.91),
(75, 49, '2021-11-17 00:00:00', 'Ordynacka 10', 'Warsaw', NULL, 'Poland', '00-358', 13.86),
(76, 4, '2021-11-25 00:00:00', 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', 0.99),
(77, 5, '2021-12-08 00:00:00', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', 1.98),
(78, 7, '2021-12-08 00:00:00', 'Rotenturmstraße 4, 1010 Innere Stadt', 'Vienne', NULL, 'Austria', '1010', 1.98),
(79, 9, '2021-12-09 00:00:00', 'Sønder Boulevard 51', 'Copenhagen', NULL, 'Denmark', '1720', 3.96),
(80, 13, '2021-12-10 00:00:00', 'Qe 7 Bloco G', 'Brasília', 'DF', 'Brazil', '71020-677', 5.94),
(81, 19, '2021-12-13 00:00:00', '1 Infinite Loop', 'Cupertino', 'CA', 'USA', '95014', 8.91),
(82, 28, '2021-12-18 00:00:00', '302 S 700 E', 'Salt Lake City', 'UT', 'USA', '84102', 13.86),
(83, 42, '2021-12-26 00:00:00', '9, Place Louis Barthou', 'Bordeaux', NULL, 'France', '33000', 0.99),
(84, 43, '2022-01-08 00:00:00', '68, Rue Jouvence', 'Dijon', NULL, 'France', '21000', 1.98),
(85, 45, '2022-01-08 00:00:00', 'Erzsébet krt. 58.', 'Budapest', NULL, 'Hungary', 'H-1073', 1.98),
(86, 47, '2022-01-09 00:00:00', 'Via Degli Scipioni, 43', 'Rome', 'RM', 'Italy', '00192', 3.96),
(87, 51, '2022-01-10 00:00:00', 'Celsiusg. 9', 'Stockholm', NULL, 'Sweden', '11230', 6.94),
(88, 57, '2022-01-13 00:00:00', 'Calle Lira, 198', 'Santiago', NULL, 'Chile', NULL, 17.91),
(89, 7, '2022-01-18 00:00:00', 'Rotenturmstraße 4, 1010 Innere Stadt', 'Vienne', NULL, 'Austria', '1010', 18.86),
(90, 21, '2022-01-26 00:00:00', '801 W 4th Street', 'Reno', 'NV', 'USA', '89503', 0.99),
(91, 22, '2022-02-08 00:00:00', '120 S Orange Ave', 'Orlando', 'FL', 'USA', '32801', 1.98),
(92, 24, '2022-02-08 00:00:00', '162 E Superior Street', 'Chicago', 'IL', 'USA', '60611', 1.98),
(93, 26, '2022-02-09 00:00:00', '2211 W Berry Street', 'Fort Worth', 'TX', 'USA', '76110', 3.96),
(94, 30, '2022-02-10 00:00:00', '230 Elgin Street', 'Ottawa', 'ON', 'Canada', 'K2P 1L7', 5.94),
(95, 36, '2022-02-13 00:00:00', 'Tauentzienstraße 8', 'Berlin', NULL, 'Germany', '10789', 8.91),
(96, 45, '2022-02-18 00:00:00', 'Erzsébet krt. 58.', 'Budapest', NULL, 'Hungary', 'H-1073', 21.86),
(97, 59, '2022-02-26 00:00:00', '3,Raj Bhavan Road', 'Bangalore', NULL, 'India', '560001', 1.99),
(98, 1, '2022-03-11 00:00:00', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', 3.98),
(99, 3, '2022-03-11 00:00:00', '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', 3.98),
(100, 5, '2022-03-12 00:00:00', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', 3.96),
(101, 9, '2022-03-13 00:00:00', 'Sønder Boulevard 51', 'Copenhagen', NULL, 'Denmark', '1720', 5.94),
(102, 15, '2022-03-16 00:00:00', '700 W Pender Street', 'Vancouver', 'BC', 'Canada', 'V6C 1G8', 9.91),
(103, 24, '2022-03-21 00:00:00', '162 E Superior Street', 'Chicago', 'IL', 'USA', '60611', 15.86),
(104, 38, '2022-03-29 00:00:00', 'Barbarossastraße 19', 'Berlin', NULL, 'Germany', '10779', 0.99),
(105, 39, '2022-04-11 00:00:00', '4, Rue Milton', 'Paris', NULL, 'France', '75009', 1.98),
(106, 41, '2022-04-11 00:00:00', '11, Place Bellecour', 'Lyon', NULL, 'France', '69002', 1.98),
(107, 43, '2022-04-12 00:00:00', '68, Rue Jouvence', 'Dijon', NULL, 'France', '21000', 3.96),
(108, 47, '2022-04-13 00:00:00', 'Via Degli Scipioni, 43', 'Rome', 'RM', 'Italy', '00192', 5.94),
(109, 53, '2022-04-16 00:00:00', '113 Lupus St', 'London', NULL, 'United Kingdom', 'SW1V 3EN', 8.91),
(110, 3, '2022-04-21 00:00:00', '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', 13.86),
(111, 17, '2022-04-29 00:00:00', '1 Microsoft Way', 'Redmond', 'WA', 'USA', '98052-8300', 0.99),
(112, 18, '2022-05-12 00:00:00', '627 Broadway', 'New York', 'NY', 'USA', '10012-2612', 1.98),
(113, 20, '2022-05-12 00:00:00', '541 Del Medio Avenue', 'Mountain View', 'CA', 'USA', '94040-111', 1.98),
(114, 22, '2022-05-13 00:00:00', '120 S Orange Ave', 'Orlando', 'FL', 'USA', '32801', 3.96),
(115, 26, '2022-05-14 00:00:00', '2211 W Berry Street', 'Fort Worth', 'TX', 'USA', '76110', 5.94),
(116, 32, '2022-05-17 00:00:00', '696 Osborne Street', 'Winnipeg', 'MB', 'Canada', 'R3L 2B9', 8.91),
(117, 41, '2022-05-22 00:00:00', '11, Place Bellecour', 'Lyon', NULL, 'France', '69002', 13.86),
(118, 55, '2022-05-30 00:00:00', '421 Bourke Street', 'Sidney', 'NSW', 'Australia', '2010', 0.99),
(119, 56, '2022-06-12 00:00:00', '307 Macacha Güemes', 'Buenos Aires', NULL, 'Argentina', '1106', 1.98),
(120, 58, '2022-06-12 00:00:00', '12,Community Centre', 'Delhi', NULL, 'India', '110017', 1.98),
(121, 1, '2022-06-13 00:00:00', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', 3.96),
(122, 5, '2022-06-14 00:00:00', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', 5.94),
(123, 11, '2022-06-17 00:00:00', 'Av. Paulista, 2022', 'São Paulo', 'SP', 'Brazil', '01310-200', 8.91),
(124, 20, '2022-06-22 00:00:00', '541 Del Medio Avenue', 'Mountain View', 'CA', 'USA', '94040-111', 13.86),
(125, 34, '2022-06-30 00:00:00', 'Rua da Assunção 53', 'Lisbon', NULL, 'Portugal', NULL, 0.99),
(126, 35, '2022-07-13 00:00:00', 'Rua dos Campeões Europeus de Viena, 4350', 'Porto', NULL, 'Portugal', NULL, 1.98),
(127, 37, '2022-07-13 00:00:00', 'Berger Straße 10', 'Frankfurt', NULL, 'Germany', '60316', 1.98),
(128, 39, '2022-07-14 00:00:00', '4, Rue Milton', 'Paris', NULL, 'France', '75009', 3.96),
(129, 43, '2022-07-15 00:00:00', '68, Rue Jouvence', 'Dijon', NULL, 'France', '21000', 5.94),
(130, 49, '2022-07-18 00:00:00', 'Ordynacka 10', 'Warsaw', NULL, 'Poland', '00-358', 8.91),
(131, 58, '2022-07-23 00:00:00', '12,Community Centre', 'Delhi', NULL, 'India', '110017', 13.86),
(132, 13, '2022-07-31 00:00:00', 'Qe 7 Bloco G', 'Brasília', 'DF', 'Brazil', '71020-677', 0.99),
(133, 14, '2022-08-13 00:00:00', '8210 111 ST NW', 'Edmonton', 'AB', 'Canada', 'T6G 2C7', 1.98),
(134, 16, '2022-08-13 00:00:00', '1600 Amphitheatre Parkway', 'Mountain View', 'CA', 'USA', '94043-1351', 1.98),
(135, 18, '2022-08-14 00:00:00', '627 Broadway', 'New York', 'NY', 'USA', '10012-2612', 3.96),
(136, 22, '2022-08-15 00:00:00', '120 S Orange Ave', 'Orlando', 'FL', 'USA', '32801', 5.94),
(137, 28, '2022-08-18 00:00:00', '302 S 700 E', 'Salt Lake City', 'UT', 'USA', '84102', 8.91),
(138, 37, '2022-08-23 00:00:00', 'Berger Straße 10', 'Frankfurt', NULL, 'Germany', '60316', 13.86),
(139, 51, '2022-08-31 00:00:00', 'Celsiusg. 9', 'Stockholm', NULL, 'Sweden', '11230', 0.99),
(140, 52, '2022-09-13 00:00:00', '202 Hoxton Street', 'London', NULL, 'United Kingdom', 'N1 5LH', 1.98),
(141, 54, '2022-09-13 00:00:00', '110 Raeburn Pl', 'Edinburgh ', NULL, 'United Kingdom', 'EH4 1HH', 1.98),
(142, 56, '2022-09-14 00:00:00', '307 Macacha Güemes', 'Buenos Aires', NULL, 'Argentina', '1106', 3.96),
(143, 1, '2022-09-15 00:00:00', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', 5.94),
(144, 7, '2022-09-18 00:00:00', 'Rotenturmstraße 4, 1010 Innere Stadt', 'Vienne', NULL, 'Austria', '1010', 8.91),
(145, 16, '2022-09-23 00:00:00', '1600 Amphitheatre Parkway', 'Mountain View', 'CA', 'USA', '94043-1351', 13.86),
(146, 30, '2022-10-01 00:00:00', '230 Elgin Street', 'Ottawa', 'ON', 'Canada', 'K2P 1L7', 0.99),
(147, 31, '2022-10-14 00:00:00', '194A Chain Lake Drive', 'Halifax', 'NS', 'Canada', 'B3S 1C5', 1.98),
(148, 33, '2022-10-14 00:00:00', '5112 48 Street', 'Yellowknife', 'NT', 'Canada', 'X1A 1N6', 1.98),
(149, 35, '2022-10-15 00:00:00', 'Rua dos Campeões Europeus de Viena, 4350', 'Porto', NULL, 'Portugal', NULL, 3.96),
(150, 39, '2022-10-16 00:00:00', '4, Rue Milton', 'Paris', NULL, 'France', '75009', 5.94),
(151, 45, '2022-10-19 00:00:00', 'Erzsébet krt. 58.', 'Budapest', NULL, 'Hungary', 'H-1073', 8.91),
(152, 54, '2022-10-24 00:00:00', '110 Raeburn Pl', 'Edinburgh ', NULL, 'United Kingdom', 'EH4 1HH', 13.86),
(153, 9, '2022-11-01 00:00:00', 'Sønder Boulevard 51', 'Copenhagen', NULL, 'Denmark', '1720', 0.99),
(154, 10, '2022-11-14 00:00:00', 'Rua Dr. Falcão Filho, 155', 'São Paulo', 'SP', 'Brazil', '01007-010', 1.98),
(155, 12, '2022-11-14 00:00:00', 'Praça Pio X, 119', 'Rio de Janeiro', 'RJ', 'Brazil', '20040-020', 1.98),
(156, 14, '2022-11-15 00:00:00', '8210 111 ST NW', 'Edmonton', 'AB', 'Canada', 'T6G 2C7', 3.96),
(157, 18, '2022-11-16 00:00:00', '627 Broadway', 'New York', 'NY', 'USA', '10012-2612', 5.94),
(158, 24, '2022-11-19 00:00:00', '162 E Superior Street', 'Chicago', 'IL', 'USA', '60611', 8.91),
(159, 33, '2022-11-24 00:00:00', '5112 48 Street', 'Yellowknife', 'NT', 'Canada', 'X1A 1N6', 13.86),
(160, 47, '2022-12-02 00:00:00', 'Via Degli Scipioni, 43', 'Rome', 'RM', 'Italy', '00192', 0.99),
(161, 48, '2022-12-15 00:00:00', 'Lijnbaansgracht 120bg', 'Amsterdam', 'VV', 'Netherlands', '1016', 1.98),
(162, 50, '2022-12-15 00:00:00', 'C/ San Bernardo 85', 'Madrid', NULL, 'Spain', '28015', 1.98),
(163, 52, '2022-12-16 00:00:00', '202 Hoxton Street', 'London', NULL, 'United Kingdom', 'N1 5LH', 3.96),
(164, 56, '2022-12-17 00:00:00', '307 Macacha Güemes', 'Buenos Aires', NULL, 'Argentina', '1106', 5.94),
(165, 3, '2022-12-20 00:00:00', '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', 8.91),
(166, 12, '2022-12-25 00:00:00', 'Praça Pio X, 119', 'Rio de Janeiro', 'RJ', 'Brazil', '20040-020', 13.86),
(167, 26, '2023-01-02 00:00:00', '2211 W Berry Street', 'Fort Worth', 'TX', 'USA', '76110', 0.99),
(168, 27, '2023-01-15 00:00:00', '1033 N Park Ave', 'Tucson', 'AZ', 'USA', '85719', 1.98),
(169, 29, '2023-01-15 00:00:00', '796 Dundas Street West', 'Toronto', 'ON', 'Canada', 'M6J 1V1', 1.98),
(170, 31, '2023-01-16 00:00:00', '194A Chain Lake Drive', 'Halifax', 'NS', 'Canada', 'B3S 1C5', 3.96),
(171, 35, '2023-01-17 00:00:00', 'Rua dos Campeões Europeus de Viena, 4350', 'Porto', NULL, 'Portugal', NULL, 5.94),
(172, 41, '2023-01-20 00:00:00', '11, Place Bellecour', 'Lyon', NULL, 'France', '69002', 8.91),
(173, 50, '2023-01-25 00:00:00', 'C/ San Bernardo 85', 'Madrid', NULL, 'Spain', '28015', 13.86),
(174, 5, '2023-02-02 00:00:00', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', 0.99),
(175, 6, '2023-02-15 00:00:00', 'Rilská 3174/6', 'Prague', NULL, 'Czech Republic', '14300', 1.98),
(176, 8, '2023-02-15 00:00:00', 'Grétrystraat 63', 'Brussels', NULL, 'Belgium', '1000', 1.98),
(177, 10, '2023-02-16 00:00:00', 'Rua Dr. Falcão Filho, 155', 'São Paulo', 'SP', 'Brazil', '01007-010', 3.96),
(178, 14, '2023-02-17 00:00:00', '8210 111 ST NW', 'Edmonton', 'AB', 'Canada', 'T6G 2C7', 5.94),
(179, 20, '2023-02-20 00:00:00', '541 Del Medio Avenue', 'Mountain View', 'CA', 'USA', '94040-111', 8.91),
(180, 29, '2023-02-25 00:00:00', '796 Dundas Street West', 'Toronto', 'ON', 'Canada', 'M6J 1V1', 13.86),
(181, 43, '2023-03-05 00:00:00', '68, Rue Jouvence', 'Dijon', NULL, 'France', '21000', 0.99),
(182, 44, '2023-03-18 00:00:00', 'Porthaninkatu 9', 'Helsinki', NULL, 'Finland', '00530', 1.98),
(183, 46, '2023-03-18 00:00:00', '3 Chatham Street', 'Dublin', 'Dublin', 'Ireland', NULL, 1.98),
(184, 48, '2023-03-19 00:00:00', 'Lijnbaansgracht 120bg', 'Amsterdam', 'VV', 'Netherlands', '1016', 3.96),
(185, 52, '2023-03-20 00:00:00', '202 Hoxton Street', 'London', NULL, 'United Kingdom', 'N1 5LH', 5.94),
(186, 58, '2023-03-23 00:00:00', '12,Community Centre', 'Delhi', NULL, 'India', '110017', 8.91),
(187, 8, '2023-03-28 00:00:00', 'Grétrystraat 63', 'Brussels', NULL, 'Belgium', '1000', 13.86),
(188, 22, '2023-04-05 00:00:00', '120 S Orange Ave', 'Orlando', 'FL', 'USA', '32801', 0.99),
(189, 23, '2023-04-18 00:00:00', '69 Salem Street', 'Boston', 'MA', 'USA', '2113', 1.98),
(190, 25, '2023-04-18 00:00:00', '319 N. Frances Street', 'Madison', 'WI', 'USA', '53703', 1.98),
(191, 27, '2023-04-19 00:00:00', '1033 N Park Ave', 'Tucson', 'AZ', 'USA', '85719', 3.96),
(192, 31, '2023-04-20 00:00:00', '194A Chain Lake Drive', 'Halifax', 'NS', 'Canada', 'B3S 1C5', 5.94),
(193, 37, '2023-04-23 00:00:00', 'Berger Straße 10', 'Frankfurt', NULL, 'Germany', '60316', 14.91),
(194, 46, '2023-04-28 00:00:00', '3 Chatham Street', 'Dublin', 'Dublin', 'Ireland', NULL, 21.86),
(195, 1, '2023-05-06 00:00:00', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', 0.99),
(196, 2, '2023-05-19 00:00:00', 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', 1.98),
(197, 4, '2023-05-19 00:00:00', 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', 1.98),
(198, 6, '2023-05-20 00:00:00', 'Rilská 3174/6', 'Prague', NULL, 'Czech Republic', '14300', 3.96),
(199, 10, '2023-05-21 00:00:00', 'Rua Dr. Falcão Filho, 155', 'São Paulo', 'SP', 'Brazil', '01007-010', 5.94),
(200, 16, '2023-05-24 00:00:00', '1600 Amphitheatre Parkway', 'Mountain View', 'CA', 'USA', '94043-1351', 8.91),
(201, 25, '2023-05-29 00:00:00', '319 N. Frances Street', 'Madison', 'WI', 'USA', '53703', 18.86),
(202, 39, '2023-06-06 00:00:00', '4, Rue Milton', 'Paris', NULL, 'France', '75009', 1.99),
(203, 40, '2023-06-19 00:00:00', '8, Rue Hanovre', 'Paris', NULL, 'France', '75002', 2.98),
(204, 42, '2023-06-19 00:00:00', '9, Place Louis Barthou', 'Bordeaux', NULL, 'France', '33000', 3.98),
(205, 44, '2023-06-20 00:00:00', 'Porthaninkatu 9', 'Helsinki', NULL, 'Finland', '00530', 7.96),
(206, 48, '2023-06-21 00:00:00', 'Lijnbaansgracht 120bg', 'Amsterdam', 'VV', 'Netherlands', '1016', 8.94),
(207, 54, '2023-06-24 00:00:00', '110 Raeburn Pl', 'Edinburgh ', NULL, 'United Kingdom', 'EH4 1HH', 8.91),
(208, 4, '2023-06-29 00:00:00', 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', 15.86),
(209, 18, '2023-07-07 00:00:00', '627 Broadway', 'New York', 'NY', 'USA', '10012-2612', 0.99),
(210, 19, '2023-07-20 00:00:00', '1 Infinite Loop', 'Cupertino', 'CA', 'USA', '95014', 1.98),
(211, 21, '2023-07-20 00:00:00', '801 W 4th Street', 'Reno', 'NV', 'USA', '89503', 1.98),
(212, 23, '2023-07-21 00:00:00', '69 Salem Street', 'Boston', 'MA', 'USA', '2113', 3.96),
(213, 27, '2023-07-22 00:00:00', '1033 N Park Ave', 'Tucson', 'AZ', 'USA', '85719', 5.94),
(214, 33, '2023-07-25 00:00:00', '5112 48 Street', 'Yellowknife', 'NT', 'Canada', 'X1A 1N6', 8.91),
(215, 42, '2023-07-30 00:00:00', '9, Place Louis Barthou', 'Bordeaux', NULL, 'France', '33000', 13.86),
(216, 56, '2023-08-07 00:00:00', '307 Macacha Güemes', 'Buenos Aires', NULL, 'Argentina', '1106', 0.99),
(217, 57, '2023-08-20 00:00:00', 'Calle Lira, 198', 'Santiago', NULL, 'Chile', NULL, 1.98),
(218, 59, '2023-08-20 00:00:00', '3,Raj Bhavan Road', 'Bangalore', NULL, 'India', '560001', 1.98),
(219, 2, '2023-08-21 00:00:00', 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', 3.96),
(220, 6, '2023-08-22 00:00:00', 'Rilská 3174/6', 'Prague', NULL, 'Czech Republic', '14300', 5.94),
(221, 12, '2023-08-25 00:00:00', 'Praça Pio X, 119', 'Rio de Janeiro', 'RJ', 'Brazil', '20040-020', 8.91),
(222, 21, '2023-08-30 00:00:00', '801 W 4th Street', 'Reno', 'NV', 'USA', '89503', 13.86),
(223, 35, '2023-09-07 00:00:00', 'Rua dos Campeões Europeus de Viena, 4350', 'Porto', NULL, 'Portugal', NULL, 0.99),
(224, 36, '2023-09-20 00:00:00', 'Tauentzienstraße 8', 'Berlin', NULL, 'Germany', '10789', 1.98),
(225, 38, '2023-09-20 00:00:00', 'Barbarossastraße 19', 'Berlin', NULL, 'Germany', '10779', 1.98),
(226, 40, '2023-09-21 00:00:00', '8, Rue Hanovre', 'Paris', NULL, 'France', '75002', 3.96),
(227, 44, '2023-09-22 00:00:00', 'Porthaninkatu 9', 'Helsinki', NULL, 'Finland', '00530', 5.94),
(228, 50, '2023-09-25 00:00:00', 'C/ San Bernardo 85', 'Madrid', NULL, 'Spain', '28015', 8.91),
(229, 59, '2023-09-30 00:00:00', '3,Raj Bhavan Road', 'Bangalore', NULL, 'India', '560001', 13.86),
(230, 14, '2023-10-08 00:00:00', '8210 111 ST NW', 'Edmonton', 'AB', 'Canada', 'T6G 2C7', 0.99),
(231, 15, '2023-10-21 00:00:00', '700 W Pender Street', 'Vancouver', 'BC', 'Canada', 'V6C 1G8', 1.98),
(232, 17, '2023-10-21 00:00:00', '1 Microsoft Way', 'Redmond', 'WA', 'USA', '98052-8300', 1.98),
(233, 19, '2023-10-22 00:00:00', '1 Infinite Loop', 'Cupertino', 'CA', 'USA', '95014', 3.96),
(234, 23, '2023-10-23 00:00:00', '69 Salem Street', 'Boston', 'MA', 'USA', '2113', 5.94),
(235, 29, '2023-10-26 00:00:00', '796 Dundas Street West', 'Toronto', 'ON', 'Canada', 'M6J 1V1', 8.91),
(236, 38, '2023-10-31 00:00:00', 'Barbarossastraße 19', 'Berlin', NULL, 'Germany', '10779', 13.86),
(237, 52, '2023-11-08 00:00:00', '202 Hoxton Street', 'London', NULL, 'United Kingdom', 'N1 5LH', 0.99),
(238, 53, '2023-11-21 00:00:00', '113 Lupus St', 'London', NULL, 'United Kingdom', 'SW1V 3EN', 1.98),
(239, 55, '2023-11-21 00:00:00', '421 Bourke Street', 'Sidney', 'NSW', 'Australia', '2010', 1.98),
(240, 57, '2023-11-22 00:00:00', 'Calle Lira, 198', 'Santiago', NULL, 'Chile', NULL, 3.96),
(241, 2, '2023-11-23 00:00:00', 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', 5.94),
(242, 8, '2023-11-26 00:00:00', 'Grétrystraat 63', 'Brussels', NULL, 'Belgium', '1000', 8.91),
(243, 17, '2023-12-01 00:00:00', '1 Microsoft Way', 'Redmond', 'WA', 'USA', '98052-8300', 13.86),
(244, 31, '2023-12-09 00:00:00', '194A Chain Lake Drive', 'Halifax', 'NS', 'Canada', 'B3S 1C5', 0.99),
(245, 32, '2023-12-22 00:00:00', '696 Osborne Street', 'Winnipeg', 'MB', 'Canada', 'R3L 2B9', 1.98),
(246, 34, '2023-12-22 00:00:00', 'Rua da Assunção 53', 'Lisbon', NULL, 'Portugal', NULL, 1.98),
(247, 36, '2023-12-23 00:00:00', 'Tauentzienstraße 8', 'Berlin', NULL, 'Germany', '10789', 3.96),
(248, 40, '2023-12-24 00:00:00', '8, Rue Hanovre', 'Paris', NULL, 'France', '75002', 5.94),
(249, 46, '2023-12-27 00:00:00', '3 Chatham Street', 'Dublin', 'Dublin', 'Ireland', NULL, 8.91),
(250, 55, '2024-01-01 00:00:00', '421 Bourke Street', 'Sidney', 'NSW', 'Australia', '2010', 13.86),
(251, 10, '2024-01-09 00:00:00', 'Rua Dr. Falcão Filho, 155', 'São Paulo', 'SP', 'Brazil', '01007-010', 0.99),
(252, 11, '2024-01-22 00:00:00', 'Av. Paulista, 2022', 'São Paulo', 'SP', 'Brazil', '01310-200', 1.98),
(253, 13, '2024-01-22 00:00:00', 'Qe 7 Bloco G', 'Brasília', 'DF', 'Brazil', '71020-677', 1.98),
(254, 15, '2024-01-23 00:00:00', '700 W Pender Street', 'Vancouver', 'BC', 'Canada', 'V6C 1G8', 3.96),
(255, 19, '2024-01-24 00:00:00', '1 Infinite Loop', 'Cupertino', 'CA', 'USA', '95014', 5.94),
(256, 25, '2024-01-27 00:00:00', '319 N. Frances Street', 'Madison', 'WI', 'USA', '53703', 8.91),
(257, 34, '2024-02-01 00:00:00', 'Rua da Assunção 53', 'Lisbon', NULL, 'Portugal', NULL, 13.86),
(258, 48, '2024-02-09 00:00:00', 'Lijnbaansgracht 120bg', 'Amsterdam', 'VV', 'Netherlands', '1016', 0.99),
(259, 49, '2024-02-22 00:00:00', 'Ordynacka 10', 'Warsaw', NULL, 'Poland', '00-358', 1.98),
(260, 51, '2024-02-22 00:00:00', 'Celsiusg. 9', 'Stockholm', NULL, 'Sweden', '11230', 1.98),
(261, 53, '2024-02-23 00:00:00', '113 Lupus St', 'London', NULL, 'United Kingdom', 'SW1V 3EN', 3.96),
(262, 57, '2024-02-24 00:00:00', 'Calle Lira, 198', 'Santiago', NULL, 'Chile', NULL, 5.94),
(263, 4, '2024-02-27 00:00:00', 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', 8.91),
(264, 13, '2024-03-03 00:00:00', 'Qe 7 Bloco G', 'Brasília', 'DF', 'Brazil', '71020-677', 13.86),
(265, 27, '2024-03-11 00:00:00', '1033 N Park Ave', 'Tucson', 'AZ', 'USA', '85719', 0.99),
(266, 28, '2024-03-24 00:00:00', '302 S 700 E', 'Salt Lake City', 'UT', 'USA', '84102', 1.98),
(267, 30, '2024-03-24 00:00:00', '230 Elgin Street', 'Ottawa', 'ON', 'Canada', 'K2P 1L7', 1.98),
(268, 32, '2024-03-25 00:00:00', '696 Osborne Street', 'Winnipeg', 'MB', 'Canada', 'R3L 2B9', 3.96),
(269, 36, '2024-03-26 00:00:00', 'Tauentzienstraße 8', 'Berlin', NULL, 'Germany', '10789', 5.94),
(270, 42, '2024-03-29 00:00:00', '9, Place Louis Barthou', 'Bordeaux', NULL, 'France', '33000', 8.91),
(271, 51, '2024-04-03 00:00:00', 'Celsiusg. 9', 'Stockholm', NULL, 'Sweden', '11230', 13.86),
(272, 6, '2024-04-11 00:00:00', 'Rilská 3174/6', 'Prague', NULL, 'Czech Republic', '14300', 0.99),
(273, 7, '2024-04-24 00:00:00', 'Rotenturmstraße 4, 1010 Innere Stadt', 'Vienne', NULL, 'Austria', '1010', 1.98),
(274, 9, '2024-04-24 00:00:00', 'Sønder Boulevard 51', 'Copenhagen', NULL, 'Denmark', '1720', 1.98),
(275, 11, '2024-04-25 00:00:00', 'Av. Paulista, 2022', 'São Paulo', 'SP', 'Brazil', '01310-200', 3.96),
(276, 15, '2024-04-26 00:00:00', '700 W Pender Street', 'Vancouver', 'BC', 'Canada', 'V6C 1G8', 5.94),
(277, 21, '2024-04-29 00:00:00', '801 W 4th Street', 'Reno', 'NV', 'USA', '89503', 8.91),
(278, 30, '2024-05-04 00:00:00', '230 Elgin Street', 'Ottawa', 'ON', 'Canada', 'K2P 1L7', 13.86),
(279, 44, '2024-05-12 00:00:00', 'Porthaninkatu 9', 'Helsinki', NULL, 'Finland', '00530', 0.99),
(280, 45, '2024-05-25 00:00:00', 'Erzsébet krt. 58.', 'Budapest', NULL, 'Hungary', 'H-1073', 1.98),
(281, 47, '2024-05-25 00:00:00', 'Via Degli Scipioni, 43', 'Rome', 'RM', 'Italy', '00192', 1.98),
(282, 49, '2024-05-26 00:00:00', 'Ordynacka 10', 'Warsaw', NULL, 'Poland', '00-358', 3.96),
(283, 53, '2024-05-27 00:00:00', '113 Lupus St', 'London', NULL, 'United Kingdom', 'SW1V 3EN', 5.94),
(284, 59, '2024-05-30 00:00:00', '3,Raj Bhavan Road', 'Bangalore', NULL, 'India', '560001', 8.91),
(285, 9, '2024-06-04 00:00:00', 'Sønder Boulevard 51', 'Copenhagen', NULL, 'Denmark', '1720', 13.86),
(286, 23, '2024-06-12 00:00:00', '69 Salem Street', 'Boston', 'MA', 'USA', '2113', 0.99),
(287, 24, '2024-06-25 00:00:00', '162 E Superior Street', 'Chicago', 'IL', 'USA', '60611', 1.98),
(288, 26, '2024-06-25 00:00:00', '2211 W Berry Street', 'Fort Worth', 'TX', 'USA', '76110', 1.98),
(289, 28, '2024-06-26 00:00:00', '302 S 700 E', 'Salt Lake City', 'UT', 'USA', '84102', 3.96),
(290, 32, '2024-06-27 00:00:00', '696 Osborne Street', 'Winnipeg', 'MB', 'Canada', 'R3L 2B9', 5.94),
(291, 38, '2024-06-30 00:00:00', 'Barbarossastraße 19', 'Berlin', NULL, 'Germany', '10779', 8.91),
(292, 47, '2024-07-05 00:00:00', 'Via Degli Scipioni, 43', 'Rome', 'RM', 'Italy', '00192', 13.86),
(293, 2, '2024-07-13 00:00:00', 'Theodor-Heuss-Straße 34', 'Stuttgart', NULL, 'Germany', '70174', 0.99),
(294, 3, '2024-07-26 00:00:00', '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', 1.98),
(295, 5, '2024-07-26 00:00:00', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', 1.98),
(296, 7, '2024-07-27 00:00:00', 'Rotenturmstraße 4, 1010 Innere Stadt', 'Vienne', NULL, 'Austria', '1010', 3.96),
(297, 11, '2024-07-28 00:00:00', 'Av. Paulista, 2022', 'São Paulo', 'SP', 'Brazil', '01310-200', 5.94),
(298, 17, '2024-07-31 00:00:00', '1 Microsoft Way', 'Redmond', 'WA', 'USA', '98052-8300', 10.91),
(299, 26, '2024-08-05 00:00:00', '2211 W Berry Street', 'Fort Worth', 'TX', 'USA', '76110', 23.86),
(300, 40, '2024-08-13 00:00:00', '8, Rue Hanovre', 'Paris', NULL, 'France', '75002', 0.99),
(301, 41, '2024-08-26 00:00:00', '11, Place Bellecour', 'Lyon', NULL, 'France', '69002', 1.98),
(302, 43, '2024-08-26 00:00:00', '68, Rue Jouvence', 'Dijon', NULL, 'France', '21000', 1.98),
(303, 45, '2024-08-27 00:00:00', 'Erzsébet krt. 58.', 'Budapest', NULL, 'Hungary', 'H-1073', 3.96),
(304, 49, '2024-08-28 00:00:00', 'Ordynacka 10', 'Warsaw', NULL, 'Poland', '00-358', 5.94),
(305, 55, '2024-08-31 00:00:00', '421 Bourke Street', 'Sidney', 'NSW', 'Australia', '2010', 8.91),
(306, 5, '2024-09-05 00:00:00', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', 16.86),
(307, 19, '2024-09-13 00:00:00', '1 Infinite Loop', 'Cupertino', 'CA', 'USA', '95014', 1.99),
(308, 20, '2024-09-26 00:00:00', '541 Del Medio Avenue', 'Mountain View', 'CA', 'USA', '94040-111', 3.98),
(309, 22, '2024-09-26 00:00:00', '120 S Orange Ave', 'Orlando', 'FL', 'USA', '32801', 3.98),
(310, 24, '2024-09-27 00:00:00', '162 E Superior Street', 'Chicago', 'IL', 'USA', '60611', 7.96),
(311, 28, '2024-09-28 00:00:00', '302 S 700 E', 'Salt Lake City', 'UT', 'USA', '84102', 11.94),
(312, 34, '2024-10-01 00:00:00', 'Rua da Assunção 53', 'Lisbon', NULL, 'Portugal', NULL, 10.91),
(313, 43, '2024-10-06 00:00:00', '68, Rue Jouvence', 'Dijon', NULL, 'France', '21000', 16.86),
(314, 57, '2024-10-14 00:00:00', 'Calle Lira, 198', 'Santiago', NULL, 'Chile', NULL, 0.99),
(315, 58, '2024-10-27 00:00:00', '12,Community Centre', 'Delhi', NULL, 'India', '110017', 1.98),
(316, 1, '2024-10-27 00:00:00', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', 1.98),
(317, 3, '2024-10-28 00:00:00', '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', 3.96),
(318, 7, '2024-10-29 00:00:00', 'Rotenturmstraße 4, 1010 Innere Stadt', 'Vienne', NULL, 'Austria', '1010', 5.94),
(319, 13, '2024-11-01 00:00:00', 'Qe 7 Bloco G', 'Brasília', 'DF', 'Brazil', '71020-677', 8.91),
(320, 22, '2024-11-06 00:00:00', '120 S Orange Ave', 'Orlando', 'FL', 'USA', '32801', 13.86),
(321, 36, '2024-11-14 00:00:00', 'Tauentzienstraße 8', 'Berlin', NULL, 'Germany', '10789', 0.99),
(322, 37, '2024-11-27 00:00:00', 'Berger Straße 10', 'Frankfurt', NULL, 'Germany', '60316', 1.98),
(323, 39, '2024-11-27 00:00:00', '4, Rue Milton', 'Paris', NULL, 'France', '75009', 1.98),
(324, 41, '2024-11-28 00:00:00', '11, Place Bellecour', 'Lyon', NULL, 'France', '69002', 3.96),
(325, 45, '2024-11-29 00:00:00', 'Erzsébet krt. 58.', 'Budapest', NULL, 'Hungary', 'H-1073', 5.94),
(326, 51, '2024-12-02 00:00:00', 'Celsiusg. 9', 'Stockholm', NULL, 'Sweden', '11230', 8.91),
(327, 1, '2024-12-07 00:00:00', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', 13.86),
(328, 15, '2024-12-15 00:00:00', '700 W Pender Street', 'Vancouver', 'BC', 'Canada', 'V6C 1G8', 0.99),
(329, 16, '2024-12-28 00:00:00', '1600 Amphitheatre Parkway', 'Mountain View', 'CA', 'USA', '94043-1351', 1.98),
(330, 18, '2024-12-28 00:00:00', '627 Broadway', 'New York', 'NY', 'USA', '10012-2612', 1.98),
(331, 20, '2024-12-29 00:00:00', '541 Del Medio Avenue', 'Mountain View', 'CA', 'USA', '94040-111', 3.96),
(332, 24, '2024-12-30 00:00:00', '162 E Superior Street', 'Chicago', 'IL', 'USA', '60611', 5.94),
(333, 30, '2025-01-02 00:00:00', '230 Elgin Street', 'Ottawa', 'ON', 'Canada', 'K2P 1L7', 8.91),
(334, 39, '2025-01-07 00:00:00', '4, Rue Milton', 'Paris', NULL, 'France', '75009', 13.86),
(335, 53, '2025-01-15 00:00:00', '113 Lupus St', 'London', NULL, 'United Kingdom', 'SW1V 3EN', 0.99),
(336, 54, '2025-01-28 00:00:00', '110 Raeburn Pl', 'Edinburgh ', NULL, 'United Kingdom', 'EH4 1HH', 1.98),
(337, 56, '2025-01-28 00:00:00', '307 Macacha Güemes', 'Buenos Aires', NULL, 'Argentina', '1106', 1.98),
(338, 58, '2025-01-29 00:00:00', '12,Community Centre', 'Delhi', NULL, 'India', '110017', 3.96),
(339, 3, '2025-01-30 00:00:00', '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', 5.94),
(340, 9, '2025-02-02 00:00:00', 'Sønder Boulevard 51', 'Copenhagen', NULL, 'Denmark', '1720', 8.91),
(341, 18, '2025-02-07 00:00:00', '627 Broadway', 'New York', 'NY', 'USA', '10012-2612', 13.86),
(342, 32, '2025-02-15 00:00:00', '696 Osborne Street', 'Winnipeg', 'MB', 'Canada', 'R3L 2B9', 0.99),
(343, 33, '2025-02-28 00:00:00', '5112 48 Street', 'Yellowknife', 'NT', 'Canada', 'X1A 1N6', 1.98),
(344, 35, '2025-02-28 00:00:00', 'Rua dos Campeões Europeus de Viena, 4350', 'Porto', NULL, 'Portugal', NULL, 1.98),
(345, 37, '2025-03-01 00:00:00', 'Berger Straße 10', 'Frankfurt', NULL, 'Germany', '60316', 3.96),
(346, 41, '2025-03-02 00:00:00', '11, Place Bellecour', 'Lyon', NULL, 'France', '69002', 5.94),
(347, 47, '2025-03-05 00:00:00', 'Via Degli Scipioni, 43', 'Rome', 'RM', 'Italy', '00192', 8.91),
(348, 56, '2025-03-10 00:00:00', '307 Macacha Güemes', 'Buenos Aires', NULL, 'Argentina', '1106', 13.86),
(349, 11, '2025-03-18 00:00:00', 'Av. Paulista, 2022', 'São Paulo', 'SP', 'Brazil', '01310-200', 0.99),
(350, 12, '2025-03-31 00:00:00', 'Praça Pio X, 119', 'Rio de Janeiro', 'RJ', 'Brazil', '20040-020', 1.98),
(351, 14, '2025-03-31 00:00:00', '8210 111 ST NW', 'Edmonton', 'AB', 'Canada', 'T6G 2C7', 1.98),
(352, 16, '2025-04-01 00:00:00', '1600 Amphitheatre Parkway', 'Mountain View', 'CA', 'USA', '94043-1351', 3.96),
(353, 20, '2025-04-02 00:00:00', '541 Del Medio Avenue', 'Mountain View', 'CA', 'USA', '94040-111', 5.94),
(354, 26, '2025-04-05 00:00:00', '2211 W Berry Street', 'Fort Worth', 'TX', 'USA', '76110', 8.91),
(355, 35, '2025-04-10 00:00:00', 'Rua dos Campeões Europeus de Viena, 4350', 'Porto', NULL, 'Portugal', NULL, 13.86),
(356, 49, '2025-04-18 00:00:00', 'Ordynacka 10', 'Warsaw', NULL, 'Poland', '00-358', 0.99),
(357, 50, '2025-05-01 00:00:00', 'C/ San Bernardo 85', 'Madrid', NULL, 'Spain', '28015', 1.98),
(358, 52, '2025-05-01 00:00:00', '202 Hoxton Street', 'London', NULL, 'United Kingdom', 'N1 5LH', 1.98),
(359, 54, '2025-05-02 00:00:00', '110 Raeburn Pl', 'Edinburgh ', NULL, 'United Kingdom', 'EH4 1HH', 3.96),
(360, 58, '2025-05-03 00:00:00', '12,Community Centre', 'Delhi', NULL, 'India', '110017', 5.94),
(361, 5, '2025-05-06 00:00:00', 'Klanova 9/506', 'Prague', NULL, 'Czech Republic', '14700', 8.91),
(362, 14, '2025-05-11 00:00:00', '8210 111 ST NW', 'Edmonton', 'AB', 'Canada', 'T6G 2C7', 13.86),
(363, 28, '2025-05-19 00:00:00', '302 S 700 E', 'Salt Lake City', 'UT', 'USA', '84102', 0.99),
(364, 29, '2025-06-01 00:00:00', '796 Dundas Street West', 'Toronto', 'ON', 'Canada', 'M6J 1V1', 1.98),
(365, 31, '2025-06-01 00:00:00', '194A Chain Lake Drive', 'Halifax', 'NS', 'Canada', 'B3S 1C5', 1.98),
(366, 33, '2025-06-02 00:00:00', '5112 48 Street', 'Yellowknife', 'NT', 'Canada', 'X1A 1N6', 3.96),
(367, 37, '2025-06-03 00:00:00', 'Berger Straße 10', 'Frankfurt', NULL, 'Germany', '60316', 5.94),
(368, 43, '2025-06-06 00:00:00', '68, Rue Jouvence', 'Dijon', NULL, 'France', '21000', 8.91),
(369, 52, '2025-06-11 00:00:00', '202 Hoxton Street', 'London', NULL, 'United Kingdom', 'N1 5LH', 13.86),
(370, 7, '2025-06-19 00:00:00', 'Rotenturmstraße 4, 1010 Innere Stadt', 'Vienne', NULL, 'Austria', '1010', 0.99),
(371, 8, '2025-07-02 00:00:00', 'Grétrystraat 63', 'Brussels', NULL, 'Belgium', '1000', 1.98),
(372, 10, '2025-07-02 00:00:00', 'Rua Dr. Falcão Filho, 155', 'São Paulo', 'SP', 'Brazil', '01007-010', 1.98),
(373, 12, '2025-07-03 00:00:00', 'Praça Pio X, 119', 'Rio de Janeiro', 'RJ', 'Brazil', '20040-020', 3.96),
(374, 16, '2025-07-04 00:00:00', '1600 Amphitheatre Parkway', 'Mountain View', 'CA', 'USA', '94043-1351', 5.94),
(375, 22, '2025-07-07 00:00:00', '120 S Orange Ave', 'Orlando', 'FL', 'USA', '32801', 8.91),
(376, 31, '2025-07-12 00:00:00', '194A Chain Lake Drive', 'Halifax', 'NS', 'Canada', 'B3S 1C5', 13.86),
(377, 45, '2025-07-20 00:00:00', 'Erzsébet krt. 58.', 'Budapest', NULL, 'Hungary', 'H-1073', 0.99),
(378, 46, '2025-08-02 00:00:00', '3 Chatham Street', 'Dublin', 'Dublin', 'Ireland', NULL, 1.98),
(379, 48, '2025-08-02 00:00:00', 'Lijnbaansgracht 120bg', 'Amsterdam', 'VV', 'Netherlands', '1016', 1.98),
(380, 50, '2025-08-03 00:00:00', 'C/ San Bernardo 85', 'Madrid', NULL, 'Spain', '28015', 3.96),
(381, 54, '2025-08-04 00:00:00', '110 Raeburn Pl', 'Edinburgh ', NULL, 'United Kingdom', 'EH4 1HH', 5.94),
(382, 1, '2025-08-07 00:00:00', 'Av. Brigadeiro Faria Lima, 2170', 'São José dos Campos', 'SP', 'Brazil', '12227-000', 8.91),
(383, 10, '2025-08-12 00:00:00', 'Rua Dr. Falcão Filho, 155', 'São Paulo', 'SP', 'Brazil', '01007-010', 13.86),
(384, 24, '2025-08-20 00:00:00', '162 E Superior Street', 'Chicago', 'IL', 'USA', '60611', 0.99),
(385, 25, '2025-09-02 00:00:00', '319 N. Frances Street', 'Madison', 'WI', 'USA', '53703', 1.98),
(386, 27, '2025-09-02 00:00:00', '1033 N Park Ave', 'Tucson', 'AZ', 'USA', '85719', 1.98),
(387, 29, '2025-09-03 00:00:00', '796 Dundas Street West', 'Toronto', 'ON', 'Canada', 'M6J 1V1', 3.96),
(388, 33, '2025-09-04 00:00:00', '5112 48 Street', 'Yellowknife', 'NT', 'Canada', 'X1A 1N6', 5.94),
(389, 39, '2025-09-07 00:00:00', '4, Rue Milton', 'Paris', NULL, 'France', '75009', 8.91),
(390, 48, '2025-09-12 00:00:00', 'Lijnbaansgracht 120bg', 'Amsterdam', 'VV', 'Netherlands', '1016', 13.86),
(391, 3, '2025-09-20 00:00:00', '1498 rue Bélanger', 'Montréal', 'QC', 'Canada', 'H2G 1A7', 0.99),
(392, 4, '2025-10-03 00:00:00', 'Ullevålsveien 14', 'Oslo', NULL, 'Norway', '0171', 1.98),
(393, 6, '2025-10-03 00:00:00', 'Rilská 3174/6', 'Prague', NULL, 'Czech Republic', '14300', 1.98),
(394, 8, '2025-10-04 00:00:00', 'Grétrystraat 63', 'Brussels', NULL, 'Belgium', '1000', 3.96),
(395, 12, '2025-10-05 00:00:00', 'Praça Pio X, 119', 'Rio de Janeiro', 'RJ', 'Brazil', '20040-020', 5.94),
(396, 18, '2025-10-08 00:00:00', '627 Broadway', 'New York', 'NY', 'USA', '10012-2612', 8.91),
(397, 27, '2025-10-13 00:00:00', '1033 N Park Ave', 'Tucson', 'AZ', 'USA', '85719', 13.86),
(398, 41, '2025-10-21 00:00:00', '11, Place Bellecour', 'Lyon', NULL, 'France', '69002', 0.99),
(399, 42, '2025-11-03 00:00:00', '9, Place Louis Barthou', 'Bordeaux', NULL, 'France', '33000', 1.98),
(400, 44, '2025-11-03 00:00:00', 'Porthaninkatu 9', 'Helsinki', NULL, 'Finland', '00530', 1.98),
(401, 46, '2025-11-04 00:00:00', '3 Chatham Street', 'Dublin', 'Dublin', 'Ireland', NULL, 3.96),
(402, 50, '2025-11-05 00:00:00', 'C/ San Bernardo 85', 'Madrid', NULL, 'Spain', '28015', 5.94),
(403, 56, '2025-11-08 00:00:00', '307 Macacha Güemes', 'Buenos Aires', NULL, 'Argentina', '1106', 8.91),
(404, 6, '2025-11-13 00:00:00', 'Rilská 3174/6', 'Prague', NULL, 'Czech Republic', '14300', 25.86),
(405, 20, '2025-11-21 00:00:00', '541 Del Medio Avenue', 'Mountain View', 'CA', 'USA', '94040-111', 0.99),
(406, 21, '2025-12-04 00:00:00', '801 W 4th Street', 'Reno', 'NV', 'USA', '89503', 1.98),
(407, 23, '2025-12-04 00:00:00', '69 Salem Street', 'Boston', 'MA', 'USA', '2113', 1.98),
(408, 25, '2025-12-05 00:00:00', '319 N. Frances Street', 'Madison', 'WI', 'USA', '53703', 3.96),
(409, 29, '2025-12-06 00:00:00', '796 Dundas Street West', 'Toronto', 'ON', 'Canada', 'M6J 1V1', 5.94),
(410, 35, '2025-12-09 00:00:00', 'Rua dos Campeões Europeus de Viena, 4350', 'Porto', NULL, 'Portugal', NULL, 8.91),
(411, 44, '2025-12-14 00:00:00', 'Porthaninkatu 9', 'Helsinki', NULL, 'Finland', '00530', 13.86),
(412, 58, '2025-12-22 00:00:00', '12,Community Centre', 'Delhi', NULL, 'India', '110017', 1.99);

-- --------------------------------------------------------

--
-- Table structure for table `invoiceline`
--

CREATE TABLE `invoiceline` (
  `InvoiceLineId` int(11) NOT NULL,
  `InvoiceId` int(11) NOT NULL,
  `TrackId` int(11) NOT NULL,
  `UnitPrice` decimal(10,2) NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoiceline`
--

INSERT INTO `invoiceline` (`InvoiceLineId`, `InvoiceId`, `TrackId`, `UnitPrice`, `Quantity`) VALUES
(1, 1, 2, 0.99, 1),
(2, 1, 4, 0.99, 1),
(3, 2, 6, 0.99, 1),
(4, 2, 8, 0.99, 1),
(5, 2, 10, 0.99, 1),
(6, 2, 12, 0.99, 1),
(7, 3, 16, 0.99, 1),
(8, 3, 20, 0.99, 1),
(9, 3, 24, 0.99, 1),
(10, 3, 28, 0.99, 1),
(11, 3, 32, 0.99, 1),
(12, 3, 36, 0.99, 1),
(13, 4, 42, 0.99, 1),
(14, 4, 48, 0.99, 1),
(15, 4, 54, 0.99, 1),
(16, 4, 60, 0.99, 1),
(17, 4, 66, 0.99, 1),
(18, 4, 72, 0.99, 1),
(19, 4, 78, 0.99, 1),
(20, 4, 84, 0.99, 1),
(21, 4, 90, 0.99, 1),
(579, 108, 1, 0.99, 1),
(580, 108, 5, 0.99, 1),
(581, 108, 9, 0.99, 1),
(582, 108, 13, 0.99, 1),
(583, 109, 19, 0.99, 1),
(584, 109, 25, 0.99, 1),
(585, 109, 31, 0.99, 1),
(586, 109, 37, 0.99, 1),
(587, 109, 43, 0.99, 1),
(588, 109, 49, 0.99, 1),
(589, 109, 55, 0.99, 1),
(590, 109, 61, 0.99, 1),
(591, 109, 67, 0.99, 1),
(592, 110, 76, 0.99, 1),
(593, 110, 85, 0.99, 1),
(594, 110, 94, 0.99, 1),
(1154, 214, 2, 0.99, 1),
(1155, 214, 8, 0.99, 1),
(1156, 214, 14, 0.99, 1),
(1157, 214, 20, 0.99, 1),
(1158, 214, 26, 0.99, 1),
(1159, 214, 32, 0.99, 1),
(1160, 214, 38, 0.99, 1),
(1161, 214, 44, 0.99, 1),
(1162, 215, 53, 0.99, 1),
(1163, 215, 62, 0.99, 1),
(1164, 215, 71, 0.99, 1),
(1165, 215, 80, 0.99, 1),
(1166, 215, 89, 0.99, 1),
(1167, 215, 98, 0.99, 1),
(1728, 319, 3, 0.99, 1),
(1729, 319, 9, 0.99, 1),
(1730, 319, 15, 0.99, 1),
(1731, 319, 21, 0.99, 1),
(1732, 320, 30, 0.99, 1),
(1733, 320, 39, 0.99, 1),
(1734, 320, 48, 0.99, 1),
(1735, 320, 57, 0.99, 1),
(1736, 320, 66, 0.99, 1),
(1737, 320, 75, 0.99, 1),
(1738, 320, 84, 0.99, 1),
(1739, 320, 93, 0.99, 1);

-- --------------------------------------------------------

--
-- Table structure for table `mediatype`
--

CREATE TABLE `mediatype` (
  `MediaTypeId` int(11) NOT NULL,
  `Name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mediatype`
--

INSERT INTO `mediatype` (`MediaTypeId`, `Name`) VALUES
(1, 'MPEG audio file'),
(2, 'Protected AAC audio file'),
(3, 'Protected MPEG-4 video file'),
(4, 'Purchased AAC audio file'),
(5, 'AAC audio file');

-- --------------------------------------------------------

--
-- Table structure for table `playlist`
--

CREATE TABLE `playlist` (
  `PlaylistId` int(11) NOT NULL,
  `Name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `playlist`
--

INSERT INTO `playlist` (`PlaylistId`, `Name`) VALUES
(1, 'Music'),
(2, 'Movies'),
(3, 'TV Shows'),
(4, 'Audiobooks'),
(5, '90’s Music'),
(6, 'Audiobooks'),
(7, 'Movies'),
(8, 'Music'),
(9, 'Music Videos'),
(10, 'TV Shows'),
(11, 'Brazilian Music'),
(12, 'Classical'),
(13, 'Classical 101 - Deep Cuts'),
(14, 'Classical 101 - Next Steps'),
(15, 'Classical 101 - The Basics'),
(16, 'Grunge'),
(17, 'Heavy Metal Classic'),
(18, 'On-The-Go 1');

-- --------------------------------------------------------

--
-- Table structure for table `playlisttrack`
--

CREATE TABLE `playlisttrack` (
  `PlaylistId` int(11) NOT NULL,
  `TrackId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `playlisttrack`
--

INSERT INTO `playlisttrack` (`PlaylistId`, `TrackId`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),
(1, 19),
(1, 20),
(1, 21),
(1, 22),
(1, 23),
(1, 24),
(1, 25),
(1, 26),
(1, 27),
(1, 28),
(1, 29),
(1, 30),
(1, 31),
(1, 32),
(1, 33),
(1, 34),
(1, 35),
(1, 36),
(1, 37),
(1, 38),
(1, 39),
(1, 40),
(1, 41),
(1, 42),
(1, 43),
(1, 44),
(1, 45),
(1, 46),
(1, 47),
(1, 48),
(1, 49),
(1, 50),
(1, 51),
(1, 52),
(1, 53),
(1, 54),
(1, 55),
(1, 56),
(1, 57),
(1, 58),
(1, 59),
(1, 60),
(1, 61),
(1, 62),
(1, 63),
(1, 64),
(1, 65),
(1, 66),
(1, 67),
(1, 68),
(1, 69),
(1, 70),
(1, 71),
(1, 72),
(1, 73),
(1, 74),
(1, 75),
(1, 76),
(1, 77),
(1, 78),
(1, 79),
(1, 80),
(1, 81),
(1, 82),
(1, 83),
(1, 84),
(1, 85),
(1, 86),
(1, 87),
(1, 88),
(1, 89),
(1, 90),
(1, 91),
(1, 92),
(1, 93),
(1, 94),
(1, 95),
(1, 96),
(1, 97),
(1, 98),
(5, 3),
(5, 4),
(5, 5),
(5, 23),
(5, 24),
(5, 25),
(5, 26),
(5, 27),
(5, 28),
(5, 29),
(5, 30),
(5, 31),
(5, 32),
(5, 33),
(5, 34),
(5, 35),
(5, 36),
(5, 37),
(5, 38),
(5, 39),
(5, 40),
(5, 41),
(5, 42),
(5, 43),
(5, 44),
(5, 45),
(5, 46),
(5, 47),
(5, 48),
(5, 49),
(5, 50),
(5, 51),
(5, 52),
(5, 53),
(5, 54),
(5, 55),
(5, 56),
(5, 57),
(5, 58),
(5, 59),
(5, 60),
(5, 61),
(5, 62),
(5, 77),
(5, 78),
(5, 79),
(5, 80),
(5, 81),
(5, 82),
(5, 83),
(5, 84),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(8, 7),
(8, 8),
(8, 9),
(8, 10),
(8, 11),
(8, 12),
(8, 13),
(8, 14),
(8, 15),
(8, 16),
(8, 17),
(8, 18),
(8, 19),
(8, 20),
(8, 21),
(8, 22),
(8, 23),
(8, 24),
(8, 25),
(8, 26),
(8, 27),
(8, 28),
(8, 29),
(8, 30),
(8, 31),
(8, 32),
(8, 33),
(8, 34),
(8, 35),
(8, 36),
(8, 37),
(8, 38),
(8, 39),
(8, 40),
(8, 41),
(8, 42),
(8, 43),
(8, 44),
(8, 45),
(8, 46),
(8, 47),
(8, 48),
(8, 49),
(8, 50),
(8, 51),
(8, 52),
(8, 53),
(8, 54),
(8, 55),
(8, 56),
(8, 57),
(8, 58),
(8, 59),
(8, 60),
(8, 61),
(8, 62),
(8, 63),
(8, 64),
(8, 65),
(8, 66),
(8, 67),
(8, 68),
(8, 69),
(8, 70),
(8, 71),
(8, 72),
(8, 73),
(8, 74),
(8, 75),
(8, 76),
(8, 77),
(8, 78),
(8, 79),
(8, 80),
(8, 81),
(8, 82),
(8, 83),
(8, 84),
(8, 85),
(8, 86),
(8, 87),
(8, 88),
(8, 89),
(8, 90),
(8, 91),
(8, 92),
(8, 93),
(8, 94),
(8, 95),
(8, 96),
(8, 97),
(8, 98),
(16, 52),
(17, 1),
(17, 2),
(17, 3),
(17, 4),
(17, 5);

-- --------------------------------------------------------

--
-- Table structure for table `track`
--

CREATE TABLE `track` (
  `TrackId` int(11) NOT NULL,
  `Name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AlbumId` int(11) DEFAULT NULL,
  `MediaTypeId` int(11) NOT NULL,
  `GenreId` int(11) DEFAULT NULL,
  `Composer` varchar(220) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Milliseconds` int(11) NOT NULL,
  `Bytes` int(11) DEFAULT NULL,
  `UnitPrice` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `track`
--

INSERT INTO `track` (`TrackId`, `Name`, `AlbumId`, `MediaTypeId`, `GenreId`, `Composer`, `Milliseconds`, `Bytes`, `UnitPrice`) VALUES
(1, 'For Those About To Rock (We Salute You)', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 343719, 11170334, 0.99),
(2, 'Balls to the Wall', 2, 2, 1, 'U. Dirkschneider, W. Hoffmann, H. Frank, P. Baltes, S. Kaufmann, G. Hoffmann', 342562, 5510424, 0.99),
(3, 'Fast As a Shark', 3, 2, 1, 'F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman', 230619, 3990994, 0.99),
(4, 'Restless and Wild', 3, 2, 1, 'F. Baltes, R.A. Smith-Diesel, S. Kaufman, U. Dirkscneider & W. Hoffman', 252051, 4331779, 0.99),
(5, 'Princess of the Dawn', 3, 2, 1, 'Deaffy & R.A. Smith-Diesel', 375418, 6290521, 0.99),
(6, 'Put The Finger On You', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 205662, 6713451, 0.99),
(7, 'Let\'s Get It Up', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 233926, 7636561, 0.99),
(8, 'Inject The Venom', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 210834, 6852860, 0.99),
(9, 'Snowballed', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 203102, 6599424, 0.99),
(10, 'Evil Walks', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 263497, 8611245, 0.99),
(11, 'C.O.D.', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 199836, 6566314, 0.99),
(12, 'Breaking The Rules', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 263288, 8596840, 0.99),
(13, 'Night Of The Long Knives', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 205688, 6706347, 0.99),
(14, 'Spellbound', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 270863, 8817038, 0.99),
(15, 'Go Down', 4, 1, 1, 'AC/DC', 331180, 10847611, 0.99),
(16, 'Dog Eat Dog', 4, 1, 1, 'AC/DC', 215196, 7032162, 0.99),
(17, 'Let There Be Rock', 4, 1, 1, 'AC/DC', 366654, 12021261, 0.99),
(18, 'Bad Boy Boogie', 4, 1, 1, 'AC/DC', 267728, 8776140, 0.99),
(19, 'Problem Child', 4, 1, 1, 'AC/DC', 325041, 10617116, 0.99),
(20, 'Overdose', 4, 1, 1, 'AC/DC', 369319, 12066294, 0.99),
(21, 'Hell Ain\'t A Bad Place To Be', 4, 1, 1, 'AC/DC', 254380, 8331286, 0.99),
(22, 'Whole Lotta Rosie', 4, 1, 1, 'AC/DC', 323761, 10547154, 0.99),
(23, 'Walk On Water', 5, 1, 1, 'Steven Tyler, Joe Perry, Jack Blades, Tommy Shaw', 295680, 9719579, 0.99),
(24, 'Love In An Elevator', 5, 1, 1, 'Steven Tyler, Joe Perry', 321828, 10552051, 0.99),
(25, 'Rag Doll', 5, 1, 1, 'Steven Tyler, Joe Perry, Jim Vallance, Holly Knight', 264698, 8675345, 0.99),
(26, 'What It Takes', 5, 1, 1, 'Steven Tyler, Joe Perry, Desmond Child', 310622, 10144730, 0.99),
(27, 'Dude (Looks Like A Lady)', 5, 1, 1, 'Steven Tyler, Joe Perry, Desmond Child', 264855, 8679940, 0.99),
(28, 'Janie\'s Got A Gun', 5, 1, 1, 'Steven Tyler, Tom Hamilton', 330736, 10869391, 0.99),
(29, 'Cryin\'', 5, 1, 1, 'Steven Tyler, Joe Perry, Taylor Rhodes', 309263, 10056995, 0.99),
(30, 'Amazing', 5, 1, 1, 'Steven Tyler, Richie Supa', 356519, 11616195, 0.99),
(31, 'Blind Man', 5, 1, 1, 'Steven Tyler, Joe Perry, Taylor Rhodes', 240718, 7877453, 0.99),
(32, 'Deuces Are Wild', 5, 1, 1, 'Steven Tyler, Jim Vallance', 215875, 7074167, 0.99),
(33, 'The Other Side', 5, 1, 1, 'Steven Tyler, Jim Vallance', 244375, 7983270, 0.99),
(34, 'Crazy', 5, 1, 1, 'Steven Tyler, Joe Perry, Desmond Child', 316656, 10402398, 0.99),
(35, 'Eat The Rich', 5, 1, 1, 'Steven Tyler, Joe Perry, Jim Vallance', 251036, 8262039, 0.99),
(36, 'Angel', 5, 1, 1, 'Steven Tyler, Desmond Child', 307617, 9989331, 0.99),
(37, 'Livin\' On The Edge', 5, 1, 1, 'Steven Tyler, Joe Perry, Mark Hudson', 381231, 12374569, 0.99),
(38, 'All I Really Want', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 284891, 9375567, 0.99),
(39, 'You Oughta Know', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 249234, 8196916, 0.99),
(40, 'Perfect', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 188133, 6145404, 0.99),
(41, 'Hand In My Pocket', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 221570, 7224246, 0.99),
(42, 'Right Through You', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 176117, 5793082, 0.99),
(43, 'Forgiven', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 300355, 9753256, 0.99),
(44, 'You Learn', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 239699, 7824837, 0.99),
(45, 'Head Over Feet', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 267493, 8758008, 0.99),
(46, 'Mary Jane', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 280607, 9163588, 0.99),
(47, 'Ironic', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 229825, 7598866, 0.99),
(48, 'Not The Doctor', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 227631, 7604601, 0.99),
(49, 'Wake Up', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 293485, 9703359, 0.99),
(50, 'You Oughta Know (Alternate)', 6, 1, 1, 'Alanis Morissette & Glenn Ballard', 491885, 16008629, 0.99),
(51, 'We Die Young', 7, 1, 1, 'Jerry Cantrell', 152084, 4925362, 0.99),
(52, 'Man In The Box', 7, 1, 1, 'Jerry Cantrell, Layne Staley', 286641, 9310272, 0.99),
(53, 'Sea Of Sorrow', 7, 1, 1, 'Jerry Cantrell', 349831, 11316328, 0.99),
(54, 'Bleed The Freak', 7, 1, 1, 'Jerry Cantrell', 241946, 7847716, 0.99),
(55, 'I Can\'t Remember', 7, 1, 1, 'Jerry Cantrell, Layne Staley', 222955, 7302550, 0.99),
(56, 'Love, Hate, Love', 7, 1, 1, 'Jerry Cantrell, Layne Staley', 387134, 12575396, 0.99),
(57, 'It Ain\'t Like That', 7, 1, 1, 'Jerry Cantrell, Michael Starr, Sean Kinney', 277577, 8993793, 0.99),
(58, 'Sunshine', 7, 1, 1, 'Jerry Cantrell', 284969, 9216057, 0.99),
(59, 'Put You Down', 7, 1, 1, 'Jerry Cantrell', 196231, 6420530, 0.99),
(60, 'Confusion', 7, 1, 1, 'Jerry Cantrell, Michael Starr, Layne Staley', 344163, 11183647, 0.99),
(61, 'I Know Somethin (Bout You)', 7, 1, 1, 'Jerry Cantrell', 261955, 8497788, 0.99),
(62, 'Real Thing', 7, 1, 1, 'Jerry Cantrell, Layne Staley', 243879, 7937731, 0.99),
(63, 'Desafinado', 8, 1, 2, NULL, 185338, 5990473, 0.99),
(64, 'Garota De Ipanema', 8, 1, 2, NULL, 285048, 9348428, 0.99),
(65, 'Samba De Uma Nota Só (One Note Samba)', 8, 1, 2, NULL, 137273, 4535401, 0.99),
(66, 'Por Causa De Você', 8, 1, 2, NULL, 169900, 5536496, 0.99),
(67, 'Ligia', 8, 1, 2, NULL, 251977, 8226934, 0.99),
(68, 'Fotografia', 8, 1, 2, NULL, 129227, 4198774, 0.99),
(69, 'Dindi (Dindi)', 8, 1, 2, NULL, 253178, 8149148, 0.99),
(70, 'Se Todos Fossem Iguais A Você (Instrumental)', 8, 1, 2, NULL, 134948, 4393377, 0.99),
(71, 'Falando De Amor', 8, 1, 2, NULL, 219663, 7121735, 0.99),
(72, 'Angela', 8, 1, 2, NULL, 169508, 5574957, 0.99),
(73, 'Corcovado (Quiet Nights Of Quiet Stars)', 8, 1, 2, NULL, 205662, 6687994, 0.99),
(74, 'Outra Vez', 8, 1, 2, NULL, 126511, 4110053, 0.99),
(75, 'O Boto (Bôto)', 8, 1, 2, NULL, 366837, 12089673, 0.99),
(76, 'Canta, Canta Mais', 8, 1, 2, NULL, 271856, 8719426, 0.99),
(77, 'Enter Sandman', 9, 1, 3, 'Apocalyptica', 221701, 7286305, 0.99),
(78, 'Master Of Puppets', 9, 1, 3, 'Apocalyptica', 436453, 14375310, 0.99),
(79, 'Harvester Of Sorrow', 9, 1, 3, 'Apocalyptica', 374543, 12372536, 0.99),
(80, 'The Unforgiven', 9, 1, 3, 'Apocalyptica', 322925, 10422447, 0.99),
(81, 'Sad But True', 9, 1, 3, 'Apocalyptica', 288208, 9405526, 0.99),
(82, 'Creeping Death', 9, 1, 3, 'Apocalyptica', 308035, 10110980, 0.99),
(83, 'Wherever I May Roam', 9, 1, 3, 'Apocalyptica', 369345, 12033110, 0.99),
(84, 'Welcome Home (Sanitarium)', 9, 1, 3, 'Apocalyptica', 350197, 11406431, 0.99),
(85, 'Cochise', 10, 1, 1, 'Audioslave/Chris Cornell', 222380, 5339931, 0.99),
(86, 'Show Me How to Live', 10, 1, 1, 'Audioslave/Chris Cornell', 277890, 6672176, 0.99),
(87, 'Gasoline', 10, 1, 1, 'Audioslave/Chris Cornell', 279457, 6709793, 0.99),
(88, 'What You Are', 10, 1, 1, 'Audioslave/Chris Cornell', 249391, 5988186, 0.99),
(89, 'Like a Stone', 10, 1, 1, 'Audioslave/Chris Cornell', 294034, 7059624, 0.99),
(90, 'Set It Off', 10, 1, 1, 'Audioslave/Chris Cornell', 263262, 6321091, 0.99),
(91, 'Shadow on the Sun', 10, 1, 1, 'Audioslave/Chris Cornell', 343457, 8245793, 0.99),
(92, 'I am the Highway', 10, 1, 1, 'Audioslave/Chris Cornell', 334942, 8041411, 0.99),
(93, 'Exploder', 10, 1, 1, 'Audioslave/Chris Cornell', 206053, 4948095, 0.99),
(94, 'Hypnotize', 10, 1, 1, 'Audioslave/Chris Cornell', 206628, 4961887, 0.99),
(95, 'Bring\'em Back Alive', 10, 1, 1, 'Audioslave/Chris Cornell', 329534, 7911634, 0.99),
(96, 'Light My Way', 10, 1, 1, 'Audioslave/Chris Cornell', 303595, 7289084, 0.99),
(97, 'Getaway Car', 10, 1, 1, 'Audioslave/Chris Cornell', 299598, 7193162, 0.99),
(98, 'The Last Remaining Light', 10, 1, 1, 'Audioslave/Chris Cornell', 317492, 7622615, 0.99);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserId` int(11) NOT NULL,
  `UserPassword` char(255) NOT NULL,
  `UserEmail` char(255) NOT NULL,
  `UserSalt` char(32) NOT NULL,
  `UserRoleId` int(11) NOT NULL DEFAULT 3,
  `UserActive` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserId`, `UserPassword`, `UserEmail`, `UserSalt`, `UserRoleId`, `UserActive`) VALUES
(1, 'test123', 'admin@chinookcorp.com', 'xxx', 1, 1),
(2, 'test123', 'andrew@chinookcorp.com', 'xxx', 2, 1),
(3, 'test123', 'nancy@chinookcorp.com', 'xxx', 2, 1),
(4, 'test123', 'jane@chinookcorp.com', 'xxx', 2, 1),
(5, 'test123', 'margaret@chinookcorp.com', 'xxx', 2, 1),
(6, 'test123', 'steve@chinookcorp.com', 'xxx', 2, 1),
(7, 'test123', 'michael@chinookcorp.com', 'xxx', 2, 1),
(8, 'test123', 'robert@chinookcorp.com', 'xxx', 2, 1),
(9, 'test123', 'laura@chinookcorp.com', 'xxx', 2, 1),
(17, 'test123', 'luisg@embraer.com.br', 'xxx', 3, 1),
(18, 'test123', 'leonekohler@surfeu.de', 'xxx', 3, 1),
(19, 'test123', 'ftremblay@gmail.com', 'xxx', 3, 1),
(20, 'test123', 'bjorn.hansen@yahoo.no', 'xxx', 3, 1),
(21, 'test123', 'frantisekw@jetbrains.com', 'xxx', 3, 1),
(22, 'test123', 'hholy@gmail.com', 'xxx', 3, 1),
(23, 'test123', 'astrid.gruber@apple.at', 'xxx', 3, 1),
(24, 'test123', 'daan_peeters@apple.be', 'xxx', 3, 1),
(25, 'test123', 'kara.nielsen@jubii.dk', 'xxx', 3, 1),
(26, 'test123', 'eduardo@woodstock.com.br', 'xxx', 3, 1),
(27, 'test123', 'alero@uol.com.br', 'xxx', 3, 1),
(28, 'test123', 'roberto.almeida@riotur.gov.br', 'xxx', 3, 1),
(29, 'test123', 'fernadaramos4@uol.com.br', 'xxx', 3, 1),
(30, 'test123', 'mphilips12@shaw.ca', 'xxx', 3, 1),
(31, 'test123', 'jenniferp@rogers.ca', 'xxx', 3, 1),
(32, 'test123', 'fharris@google.com', 'xxx', 3, 1),
(33, 'test123', 'jacksmith@microsoft.com', 'xxx', 3, 1),
(34, 'test123', 'michelleb@aol.com', 'xxx', 3, 1),
(35, 'test123', 'tgoyer@apple.com', 'xxx', 3, 1),
(36, 'test123', 'dmiller@comcast.com', 'xxx', 3, 1),
(37, 'test123', 'kachase@hotmail.com', 'xxx', 3, 1),
(38, 'test123', 'hleacock@gmail.com', 'xxx', 3, 1),
(39, 'test123', 'johngordon22@yahoo.com', 'xxx', 3, 1),
(40, 'test123', 'fralston@gmail.com', 'xxx', 3, 1),
(41, 'test123', 'vstevens@yahoo.com', 'xxx', 3, 1),
(42, 'test123', 'ricunningham@hotmail.com', 'xxx', 3, 1),
(43, 'test123', 'patrick.gray@aol.com', 'xxx', 3, 1),
(44, 'test123', 'jubarnett@gmail.com', 'xxx', 3, 1),
(45, 'test123', 'robbrown@shaw.ca', 'xxx', 3, 1),
(46, 'test123', 'edfrancis@yachoo.ca', 'xxx', 3, 1),
(47, 'test123', 'marthasilk@gmail.com', 'xxx', 3, 1),
(48, 'test123', 'aaronmitchell@yahoo.ca', 'xxx', 3, 1),
(49, 'test123', 'ellie.sullivan@shaw.ca', 'xxx', 3, 1),
(50, 'test123', 'jfernandes@yahoo.pt', 'xxx', 3, 1),
(51, 'test123', 'masampaio@sapo.pt', 'xxx', 3, 1),
(52, 'test123', 'hannah.schneider@yahoo.de', 'xxx', 3, 1),
(53, 'test123', 'fzimmermann@yahoo.de', 'xxx', 3, 1),
(54, 'test123', 'nschroder@surfeu.de', 'xxx', 3, 1),
(55, 'test123', 'camille.bernard@yahoo.fr', 'xxx', 3, 1),
(56, 'test123', 'dominiquelefebvre@gmail.com', 'xxx', 3, 1),
(57, 'test123', 'marc.dubois@hotmail.com', 'xxx', 3, 1),
(58, 'test123', 'wyatt.girard@yahoo.fr', 'xxx', 3, 1),
(59, 'test123', 'isabelle_mercier@apple.fr', 'xxx', 3, 1),
(60, 'test123', 'terhi.hamalainen@apple.fi', 'xxx', 3, 1),
(61, 'test123', 'ladislav_kovacs@apple.hu', 'xxx', 3, 1),
(62, 'test123', 'hughoreilly@apple.ie', 'xxx', 3, 1),
(63, 'test123', 'lucas.mancini@yahoo.it', 'xxx', 3, 1),
(64, 'test123', 'johavanderberg@yahoo.nl', 'xxx', 3, 1),
(65, 'test123', 'stanisław.wójcik@wp.pl', 'xxx', 3, 1),
(66, 'test123', 'enrique_munoz@yahoo.es', 'xxx', 3, 1),
(67, 'test123', 'joakim.johansson@yahoo.se', 'xxx', 3, 1),
(68, 'test123', 'emma_jones@hotmail.com', 'xxx', 3, 1),
(69, 'test123', 'phil.hughes@gmail.com', 'xxx', 3, 1),
(70, 'test123', 'steve.murray@yahoo.uk', 'xxx', 3, 1),
(71, 'test123', 'mark.taylor@yahoo.au', 'xxx', 3, 1),
(72, 'test123', 'diego.gutierrez@yahoo.ar', 'xxx', 3, 1),
(73, 'test123', 'luisrojas@yahoo.cl', 'xxx', 3, 1),
(74, 'test123', 'manoj.pareek@rediff.com', 'xxx', 3, 1),
(75, 'test123', 'puja_srivastava@yahoo.in', 'xxx', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `userrole`
--

CREATE TABLE `userrole` (
  `UserRoleId` int(11) NOT NULL,
  `UserRoleName` varchar(30) NOT NULL,
  `UserRoleDescription` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userrole`
--

INSERT INTO `userrole` (`UserRoleId`, `UserRoleName`, `UserRoleDescription`) VALUES
(1, 'Admin', 'Elevated permissions to manage the system'),
(2, 'Employee', 'For users who are employees'),
(3, 'Customer', 'For users who are customers');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`AlbumId`),
  ADD KEY `IFK_AlbumArtistId` (`ArtistId`);

--
-- Indexes for table `artist`
--
ALTER TABLE `artist`
  ADD PRIMARY KEY (`ArtistId`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerId`),
  ADD KEY `IFK_CustomerSupportRepId` (`SupportRepId`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EmployeeId`),
  ADD KEY `IFK_EmployeeReportsTo` (`ReportsTo`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`GenreId`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`InvoiceId`),
  ADD KEY `IFK_InvoiceCustomerId` (`CustomerId`);

--
-- Indexes for table `invoiceline`
--
ALTER TABLE `invoiceline`
  ADD PRIMARY KEY (`InvoiceLineId`),
  ADD KEY `IFK_InvoiceLineInvoiceId` (`InvoiceId`),
  ADD KEY `IFK_InvoiceLineTrackId` (`TrackId`);

--
-- Indexes for table `mediatype`
--
ALTER TABLE `mediatype`
  ADD PRIMARY KEY (`MediaTypeId`);

--
-- Indexes for table `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`PlaylistId`);

--
-- Indexes for table `playlisttrack`
--
ALTER TABLE `playlisttrack`
  ADD PRIMARY KEY (`PlaylistId`,`TrackId`),
  ADD KEY `IFK_PlaylistTrackPlaylistId` (`PlaylistId`),
  ADD KEY `IFK_PlaylistTrackTrackId` (`TrackId`);

--
-- Indexes for table `track`
--
ALTER TABLE `track`
  ADD PRIMARY KEY (`TrackId`),
  ADD KEY `IFK_TrackAlbumId` (`AlbumId`),
  ADD KEY `IFK_TrackGenreId` (`GenreId`),
  ADD KEY `IFK_TrackMediaTypeId` (`MediaTypeId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserId`),
  ADD KEY `UserRoleId` (`UserRoleId`);

--
-- Indexes for table `userrole`
--
ALTER TABLE `userrole`
  ADD PRIMARY KEY (`UserRoleId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `album`
--
ALTER TABLE `album`
  MODIFY `AlbumId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=348;

--
-- AUTO_INCREMENT for table `artist`
--
ALTER TABLE `artist`
  MODIFY `ArtistId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=276;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CustomerId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `EmployeeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `GenreId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `InvoiceId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=413;

--
-- AUTO_INCREMENT for table `invoiceline`
--
ALTER TABLE `invoiceline`
  MODIFY `InvoiceLineId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2241;

--
-- AUTO_INCREMENT for table `mediatype`
--
ALTER TABLE `mediatype`
  MODIFY `MediaTypeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `playlist`
--
ALTER TABLE `playlist`
  MODIFY `PlaylistId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `track`
--
ALTER TABLE `track`
  MODIFY `TrackId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3504;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `userrole`
--
ALTER TABLE `userrole`
  MODIFY `UserRoleId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `album`
--
ALTER TABLE `album`
  ADD CONSTRAINT `FK_AlbumArtistId` FOREIGN KEY (`ArtistId`) REFERENCES `artist` (`ArtistId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `FK_CustomerSupportRepId` FOREIGN KEY (`SupportRepId`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `FK_EmployeeReportsTo` FOREIGN KEY (`ReportsTo`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `FK_InvoiceCustomerId` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `invoiceline`
--
ALTER TABLE `invoiceline`
  ADD CONSTRAINT `FK_InvoiceLineInvoiceId` FOREIGN KEY (`InvoiceId`) REFERENCES `invoice` (`InvoiceId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_InvoiceLineTrackId` FOREIGN KEY (`TrackId`) REFERENCES `track` (`TrackId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `playlisttrack`
--
ALTER TABLE `playlisttrack`
  ADD CONSTRAINT `FK_PlaylistTrackPlaylistId` FOREIGN KEY (`PlaylistId`) REFERENCES `playlist` (`PlaylistId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_PlaylistTrackTrackId` FOREIGN KEY (`TrackId`) REFERENCES `track` (`TrackId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `track`
--
ALTER TABLE `track`
  ADD CONSTRAINT `FK_TrackAlbumId` FOREIGN KEY (`AlbumId`) REFERENCES `album` (`AlbumId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_TrackGenreId` FOREIGN KEY (`GenreId`) REFERENCES `genre` (`GenreId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_TrackMediaTypeId` FOREIGN KEY (`MediaTypeId`) REFERENCES `mediatype` (`MediaTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`UserRoleId`) REFERENCES `userrole` (`UserRoleId`);


-- WHEN WE GET TO ENCRYPTING PASSWORDS WE CAN RUN THIS QUERY (ALL PASSWORDS WILL BE 'test123')
-- UPDATE user SET UserPassword = '$2a$08$zvWApJkRSK1124iESJU5Puo9mUelLn3sgy9A.dPSySghLe7MMGGGS', UserSalt = 'xxx';



COMMIT;
