DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE IF NOT EXISTS bookstore;


USE bookstore;


CREATE TABLE IF NOT EXISTS Author (
   AuthorID INT AUTO_INCREMENT PRIMARY KEY,
   FirstName VARCHAR(255) NOT NULL,
   LastName VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS Customer (
   CustomerID INT PRIMARY KEY,
   FirstName VARCHAR(255),
   LastName VARCHAR(255),
   Address VARCHAR(255),
   City VARCHAR(255),
   State VARCHAR(255),
   Email VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS CustomerEmail (
   Email VARCHAR(255),
   CustomerID INT,
   PRIMARY KEY (Email, CustomerID),
   FOREIGN KEY (CustomerID)
       REFERENCES Customer(CustomerID)
);


CREATE TABLE IF NOT EXISTS Book (
   BookID INT AUTO_INCREMENT PRIMARY KEY,
   Title VARCHAR(255) NOT NULL,
   Genre VARCHAR(50),
   ISBN VARCHAR(20),
   ReleaseDate DATE,
   Format VARCHAR(50),
   Status ENUM('Available', 'Out of Stock', 'Unavailable'),
   OriginalPrice DECIMAL(10, 2),
   IsOnSale BOOLEAN,
   CurrentPrice DECIMAL(10, 2),
   IsTrending BOOLEAN,
   NumStock INT
);


CREATE TABLE IF NOT EXISTS Book_Author (
   BookID INT,
   AuthorID INT,
   PRIMARY KEY (BookID, AuthorID),
   FOREIGN KEY (BookID)
       REFERENCES Book(BookID),
   FOREIGN KEY (AuthorID)
       REFERENCES Author(AuthorID)
);


CREATE TABLE IF NOT EXISTS InventoryShipment (
   ShipmentID INT AUTO_INCREMENT PRIMARY KEY,
   ArrivalDate DATE,
   SupplierName VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS Shipment_Book (
   BookID INT,
   ShipmentID INT,
   PRIMARY KEY (BookID, ShipmentID),
   FOREIGN KEY (BookID)
       REFERENCES Book(BookID),
   FOREIGN KEY (ShipmentID)
       REFERENCES InventoryShipment(ShipmentID)
);


CREATE TABLE IF NOT EXISTS Orders (
   OrderID INT AUTO_INCREMENT PRIMARY KEY,
   CustomerID INT,
   OrderDate DATE,
   ArrivalDate DATE,
   CurrentLocation VARCHAR(255),
   Address VARCHAR(255),
   IsGift BOOLEAN,
   GiftMessage TEXT,
   FOREIGN KEY (CustomerID)
       REFERENCES Customer(CustomerID)
);


CREATE TABLE IF NOT EXISTS Order_Book (
   OrderID INT,
   BookID INT,
   PRIMARY KEY (OrderID, BookID),
   FOREIGN KEY (OrderID)
       REFERENCES Orders(OrderID),
   FOREIGN KEY (BookID)
       REFERENCES Book(BookID)
);


CREATE TABLE IF NOT EXISTS Profile (
   Username VARCHAR(255) PRIMARY KEY,
   CustomerID INT,
   Bio TEXT,
   FOREIGN KEY (CustomerID)
       REFERENCES Customer(CustomerID)
);




CREATE TABLE IF NOT EXISTS Profile_Book (
   BookID INT,
   Username VARCHAR(255),
   PRIMARY KEY (BookID, Username),
   FOREIGN KEY (BookID) REFERENCES Book(BookID),
   FOREIGN KEY (Username) REFERENCES Profile(Username)
);


CREATE TABLE IF NOT EXISTS Review (
   BookID INT,
   CustomerID INT,
   Rating INT,
   Comment TEXT,
   PRIMARY KEY (CustomerID, BookID),
   FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
   FOREIGN KEY (BookID) REFERENCES Book(BookID)
);
