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
DROP TABLE ContractNode;
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
  id INT UNSIGNED AUTO_INCREMENT,
  country VARCHAR(),
  province VARCHAR(),
  zipCode VARCHAR(),
  city VARCHAR(),
  street VARCHAR(),
  streetNumber VARCHAR(),
  apartment VARCHAR(),
  PRIMARY KEY (id)
);
CREATE TABLE MerchandiseGroup (
  id INT UNSIGNED AUTO_INCREMENT,
  description VARCHAR(),
  taxPercentageRate,
  PRIMARY KEY (id)
);
CREATE TABLE OptionDescription (
  id INT UNSIGNED AUTO_INCREMENT,
  description VARCHAR(),
  PRIMARY KEY (id)
);
CREATE TABLE OptionStatus (
  statusCode VARCHAR(),
  description VARCHAR(),
  PRIMARY KEY (statusCode)
);
CREATE TABLE ReservationStatus (
  statusCode VARCHAR(),
  description VARCHAR(),
  PRIMARY KEY (statusCode)
);
CREATE TABLE RoomCategory (
  id INT UNSIGNED AUTO_INCREMENT,
  description VARCHAR(),
  PRIMARY KEY (id)
);
CREATE TABLE Season (
  id INT UNSIGNED AUTO_INCREMENT,
  description VARCHAR(),
  startDate DATE,
  endDate DATE,
  PRIMARY KEY (id)
);

-- Level 1
CREATE TABLE Contact (
  id INT UNSIGNED AUTO_INCREMENT,
  phone VARCHAR(),
  email VARCHAR(),
  fax VARCHAR(),
  creditCardNumber VARCHAR(),
  addressId INT UNSIGNED,
  PRIMARY KEY (id),
  FOREIGN KEY (addressId) REFERENCES Address (id)
);
CREATE TABLE HotelServiceDescription (
  id INT UNSIGNED AUTO_INCREMENT,
  description VARCHAR(),
  title VARCHAR(),
  priceSuggestion,
  isPackage BOOL,
  merchandiseGroupId INT UNSIGNED,
  PRIMARY KEY (id),
  FOREIGN KEY (merchandiseGroupId) REFERENCES MerchandiseGroup (id)
);
CREATE TABLE RoomCategoryPrice (
  id INT UNSIGNED AUTO_INCREMENT,
  listPrice NUMERIC(6,2) UNSIGNED,
  minimumPrice NUMERIC(6,2) UNSIGNED,
  dayPrice NUMERIC(6,2) UNSIGNED,
  costPrice NUMERIC(6,2) UNSIGNED,
  roomCategoryId INT UNSIGNED,
  seasonId INT UNSIGNED,
  PRIMARY KEY (id),
  FOREIGN KEY (roomCategoryId) REFERENCES RoomCategory (id),
  FOREIGN KEY (seasonId) REFERENCES Season (id)
);

-- Level 2
CREATE TABLE ContractNode (
  id INT UNSIGNED AUTO_INCREMENT,
  text VARCHAR(),
  contactId INT UNSIGNED,
  PRIMARY KEY (id),
  FOREIGN KEY (contactId) REFERENCES Contact (id)
);
CREATE TABLE PackageDescription (
  packageId INT UNSIGNED,
  serviceId INT UNSIGNED,
  PRIMARY KEY (packageId,serviceId),
  FOREIGN KEY (packageId) REFERENCES HotelServiceDescription (id),
  FOREIGN KEY (serviceId) REFERENCES HotelServiceDescription (id)
);
CREATE TABLE Person (
  id INT UNSIGNED AUTO_INCREMENT,
  degree VARCHAR(),
  fname VARCHAR(),
  sname VARCHAR(),
  lname VARCHAR(),
  sex CHAR(1),
  isVip BOOL,
  inArchive BOOL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Contact (id)
);

--Level 4
CREATE TABLE Reservation (
  number INT UNSIGNED AUTO_INCREMENT,
  arrivalDate DATE,
  arrivalTime TIME,
  departureDate DATE,
  -- cancelationId,
  -- cancelationPolicy,
  reservationStatusCode VARCHAR(),
  PRIMARY KEY (number),
  -- FOREIGN KEY (cancelationId) REFERENCES Cancelation (id),
  -- FOREIGN KEY (cancelationPolicy) REFERENCES CancelationPolicy (id),
  FOREIGN KEY (reservationStatusCode) REFERENCES ReservationStatus (statusCode)
);

-- Level 5
CREATE TABLE Option (
  id INT UNSIGNED AUTO_INCREMENT,
  optionDate DATE,
  optionDescriptionId INT UNSIGNED,
  optionStatusCode VARCHAR(),
  reservationNumber INT UNSIGNED,
  PRIMARY KEY (id),
  FOREIGN KEY (optionDescriptionId) REFERENCES OptionDescription (id),
  FOREIGN KEY (optionStatusCode) REFERENCES OptionStatus (statusCode),
  FOREIGN KEY (reservationNumber) REFERENCES Reservation (number)
);
CREATE TABLE ReservationPerson (
  reservationNumber INT UNSIGNED,
  personId INT UNSIGNED,
  PRIMARY KEY (reservationNumber,personId),
  FOREIGN KEY (reservationNumber) REFERENCES Reservation (number),
  FOREIGN KEY (personId) REFERENCES Person (id)
);

-- Level 6
CREATE TABLE ReservationUnit (
  id INT UNSIGNED AUTO_INCREMENT,
  startDate DATE,
  endDate DATE,
  notes VARCHAR(),
  reservationNumber INT UNSIGNED,
  -- roomNumber,
  roomCategoryId INT UNSIGNED,
  packageId INT UNSIGNED,
  -- quotaId,
  PRIMARY KEY (id),
  FOREIGN KEY (reservationNumber) REFERENCES Reservation (number),
  -- FOREIGN KEY (roomNumber) REFERENCES Room (number),
  FOREIGN KEY (roomCategoryId) REFERENCES RoomCategory (id),
  FOREIGN KEY (packageId) REFERENCES HotelServiceDescription (id),
  -- FOREIGN KEY (quotaId) REFERENCES Quota (id)
);

-- Level 7
CREATE TABLE ReservationUnitPackage (
  packageId INT UNSIGNED,
  reservationUnitId INT UNSIGNED,
  PRIMARY KEY (packageId,reservationUnitId),
  FOREIGN KEY (packageId) REFERENCES HotelServiceDescription (id),
  FOREIGN KEY (reservationUnitId) REFERENCES ReservationUnit (id)
);