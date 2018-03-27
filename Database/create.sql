-- Level 7
DROP TABLE ReservationUnitPackage;

-- Level 6
DROP TABLE ReservationUnit;

--Level 5
DROP TABLE Option;
DROP TABLE ReservationPerson;

-- Level 4
DROP TABLE Reservation;

-- Level 2
DROP TABLE ContactNode;
DROP TABLE PackageDescription;
DROP TABLE Person;

-- Level 1
DROP TABLE Contact;
DROP TABLE HotelServiceDescription;
DROP TABLE RoomCategoryPrice;

-- Level 0
DROP TABLE Address;
DROP TABLE MerchandiseGroup;
DROP TABLE OptionDescription;
DROP TABLE OptionStatus;
DROP TABLE ReservationStatus;
DROP TABLE RoomCategory;
DROP TABLE Season;

-----------------------------------------------------------------

-- Level 0
CREATE TABLE Address (
  addressId INT UNSIGNED AUTO_INCREMENT,
  country VARCHAR(30),
  province VARCHAR(30),
  zipCode VARCHAR(6),
  city VARCHAR(30),
  street VARCHAR(40),
  streetNumber VARCHAR(10),
  apartment VARCHAR(10),
  PRIMARY KEY (addressId)
);
CREATE TABLE MerchandiseGroup (
  merchandiseGroupId INT UNSIGNED AUTO_INCREMENT,
  description VARCHAR(40),
  taxPercentageRate NUMERIC(5,2),
  PRIMARY KEY (merchandiseGroupId)
);
CREATE TABLE OptionDescription (
  optionId INT UNSIGNED AUTO_INCREMENT,
  description TEXT,
  PRIMARY KEY (optionId)
);
CREATE TABLE OptionStatus (
  optionStatusCode INT UNSIGNED NOT NULL,
  description VARCHAR(40),
  PRIMARY KEY (optionStatusCode)
);
CREATE TABLE ReservationStatus (
  reservationStatusCode INT UNSIGNED NOT NULL,
  description VARCHAR(40),
  PRIMARY KEY (reservationStatusCode)
);
CREATE TABLE RoomCategory (
  roomCategoryId INT UNSIGNED AUTO_INCREMENT,
  description VARCHAR(40),
  PRIMARY KEY (roomCategoryId)
);
CREATE TABLE Season (
  seasonId INT UNSIGNED AUTO_INCREMENT,
  description VARCHAR(40),
  startDate DATE,
  endDate DATE,
  PRIMARY KEY (seasonId)
);

-- Level 1
CREATE TABLE Contact (
  contactId INT UNSIGNED AUTO_INCREMENT,
  phone VARCHAR(15),
  email VARCHAR(254),
  fax VARCHAR(15),
  creditCardNumber VARCHAR(19),
  addressId INT UNSIGNED,
  PRIMARY KEY (contactId),
  FOREIGN KEY (addressId) REFERENCES Address (addressId)
);
CREATE TABLE HotelServiceDescription (
  hotelServiceDescriptionId INT UNSIGNED AUTO_INCREMENT,
  description TEXT,
  title VARCHAR(50),
  priceSuggestion NUMERIC(6,2),
  isPackage BOOL,
  merchandiseGroupId INT UNSIGNED,
  PRIMARY KEY (hotelServiceDescriptionId),
  FOREIGN KEY (merchandiseGroupId) REFERENCES MerchandiseGroup (merchandiseGroupId)
);
CREATE TABLE RoomCategoryPrice (
  roomCategoryPriceId INT UNSIGNED AUTO_INCREMENT,
  listPrice NUMERIC(6,2) UNSIGNED,
  minimumPrice NUMERIC(6,2) UNSIGNED,
  dayPrice NUMERIC(6,2) UNSIGNED,
  costPrice NUMERIC(6,2) UNSIGNED,
  roomCategoryId INT UNSIGNED,
  seasonId INT UNSIGNED,
  PRIMARY KEY (roomCategoryPriceId),
  FOREIGN KEY (roomCategoryId) REFERENCES RoomCategory (roomCategoryId),
  FOREIGN KEY (seasonId) REFERENCES Season (seasonId)
);

-- Level 2
CREATE TABLE ContactNode (
  contactNodeId INT UNSIGNED AUTO_INCREMENT,
  text TEXT,
  contactId INT UNSIGNED,
  PRIMARY KEY (contactNodeId),
  FOREIGN KEY (contactId) REFERENCES Contact (contactId)
);
CREATE TABLE PackageDescription (
  packageId INT UNSIGNED,
  serviceId INT UNSIGNED,
  PRIMARY KEY (packageId,serviceId),
  FOREIGN KEY (packageId) REFERENCES HotelServiceDescription (hotelServiceDescriptionId),
  FOREIGN KEY (serviceId) REFERENCES HotelServiceDescription (hotelServiceDescriptionId)
);
CREATE TABLE Person (
  personId INT UNSIGNED NOT NULL,
  degree VARCHAR(15),
  fname VARCHAR(50),
  sname VARCHAR(50),
  lname VARCHAR(50),
  dateOfBirth DATE,
  sex CHAR(1),
  isVip BOOL,
  inArchive BOOL,
  PRIMARY KEY (personId),
  FOREIGN KEY (personId) REFERENCES Contact (contactId)
);

--Level 4
CREATE TABLE Reservation (
  reservationNumber INT UNSIGNED AUTO_INCREMENT,
  arrivalDate DATE,
  arrivalTime TIME,
  departureDate DATE,
  -- cancelationPolicy,
  reservationStatusCode INT UNSIGNED,
  PRIMARY KEY (reservationNumber),
  -- FOREIGN KEY (cancelationPolicy) REFERENCES CancelationPolicy (id),
  FOREIGN KEY (reservationStatusCode) REFERENCES ReservationStatus (reservationStatusCode)
);

-- Level 5
CREATE TABLE Option (
  optionId INT UNSIGNED AUTO_INCREMENT,
  optionDate DATE,
  optionDescriptionId INT UNSIGNED,
  optionStatusCode INT UNSIGNED,
  reservationNumber INT UNSIGNED,
  PRIMARY KEY (optionId),
  FOREIGN KEY (optionDescriptionId) REFERENCES OptionDescription (optionId),
  FOREIGN KEY (optionStatusCode) REFERENCES OptionStatus (optionStatusCode),
  FOREIGN KEY (reservationNumber) REFERENCES Reservation (reservationNumber)
);
CREATE TABLE ReservationPerson (
  reservationNumber INT UNSIGNED,
  personId INT UNSIGNED,
  PRIMARY KEY (reservationNumber,personId),
  FOREIGN KEY (reservationNumber) REFERENCES Reservation (reservationNumber),
  FOREIGN KEY (personId) REFERENCES Person (personId)
);

-- Level 6
CREATE TABLE ReservationUnit (
  reservationUnitId INT UNSIGNED AUTO_INCREMENT,
  startDate DATE,
  endDate DATE,
  notes TEXT,
  reservationNumber INT UNSIGNED,
  -- roomNumber,
  roomCategoryId INT UNSIGNED,
  packageId INT UNSIGNED,
  -- quotaId,
  PRIMARY KEY (reservationUnitId),
  FOREIGN KEY (reservationNumber) REFERENCES Reservation (reservationNumber),
  -- FOREIGN KEY (roomNumber) REFERENCES Room (number),
  FOREIGN KEY (roomCategoryId) REFERENCES RoomCategory (roomCategoryId),
  FOREIGN KEY (packageId) REFERENCES HotelServiceDescription (hotelServiceDescriptionId),
  -- FOREIGN KEY (quotaId) REFERENCES Quota (id)
);

-- Level 7
CREATE TABLE ReservationUnitPackage (
  packageId INT UNSIGNED,
  reservationUnitId INT UNSIGNED,
  PRIMARY KEY (packageId,reservationUnitId),
  FOREIGN KEY (packageId) REFERENCES HotelServiceDescription (hotelServiceDescriptionId),
  FOREIGN KEY (reservationUnitId) REFERENCES ReservationUnit (reservationUnitId)
);