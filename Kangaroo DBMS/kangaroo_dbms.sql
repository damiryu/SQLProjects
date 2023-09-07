-- Scenario: Kangaroo is an online delivery company, which is looking for the development an effective 
-- Relational Database Management System (RDBMS) and data warehouse to satisfy theneeds of the growing business. 
-- As a data analyst, you have been asked to develop arequired system for Kangaroo

CREATE DATABASE Kang;

USE Kang;

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    UNIQUE (Email)
);

-- Create the Drivers table
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Salary DECIMAL(10, 2) DEFAULT 0.00,
    Email VARCHAR(100) UNIQUE,
    ManagerID INT,
    LicenseNumber VARCHAR(50) UNIQUE,
    IssueDate DATE,
    CountryOfIssue VARCHAR(50),
    ExpiryDate DATE,
    FOREIGN KEY (ManagerID) REFERENCES Drivers(DriverID) ON DELETE SET NULL
);

-- Create the Vehicles table
CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY AUTO_INCREMENT,
    RegistrationNumber VARCHAR(50) UNIQUE,
    Color VARCHAR(50),
    PurchaseDate DATE,
    EngineSize VARCHAR(20),
    DriverID INT, -- Add DriverID column for the relationship
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID) ON DELETE SET NULL
);

-- Create the Restaurants table
CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantName VARCHAR(100) NOT NULL,
    Address VARCHAR(200)
);

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    CustomerID INT,
    DriverID INT,
    RestaurantID INT, -- Add RestaurantID column for the relationship
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID) ON DELETE SET NULL,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID) ON DELETE SET NULL
);

-- Create the Items table
CREATE TABLE Items (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    ItemName VARCHAR(100) NOT NULL,
    ItemPrice DECIMAL(10, 2) DEFAULT 0.00,
    Category VARCHAR(50)
);

-- Create the OrderItems table for the many-to-many relationship between Orders and Items
CREATE TABLE OrderItems (
    OrderID INT,
    ItemID INT,
    PRIMARY KEY (OrderID, ItemID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID) ON DELETE CASCADE
    
);


-- Insert some data into the Customers table

INSERT INTO Customers (LastName, FirstName, Email, PhoneNumber)
VALUES
	('Cassius', 'Clay', 'cassiusclay@hotmail.com', '456-981-1974'),
    ('Daniel', 'Red', 'Daniel.red@hotmail.com', '267-745-1395'),
    ('Hannah', 'May', 'hannahmay@hotmail.com', '932-003-6942'),
    ('Van', 'Robin', 'robinvan1@hotmail.com', '921-691-2738'),
    ('Kelsie', 'Jack', 'jackk@hotmail.com', '274-129-0361'),
    ('Chelsea', 'Harvey', 'h.chelsea@hotmail.com', '210-038-9428'),
    ('Tory', 'Kemp', 'tory.k@hotmail.com', '642-971-1632'),
    ('Theresa', 'Grey', 'theresagrey@hotmail.com', '943-3854-9127'),
    ('Prince', 'Franklin', 'FP2@hotmail.com', '431-7530-8621'),
    ('Josh', 'Walters', 'w.josh@hotmail.com', '289-964-4385')
   ;

-- Insert some data into the Drivers table
INSERT INTO Drivers (Name, Salary, Email, LicenseNumber, IssueDate, CountryOfIssue, ExpiryDate)
VALUES
    ('Jared Jake', 50000.00, 'jjk@hotmail.com', 'TX6738', '2021-05-19', 'USA', '2025-01-01'),
    ('Aaron Liam', 35000.00, 'liam.aaron@hotmail.com', 'FL1567', '2022-07-23', 'USA', '2024-05-15'),
    ('Dame Gordon', 28000.00, 'g.dame@hotmail.com', 'FL9493', '2018-09-20', 'USA', '2023-09-20'),
    ('Gregg Craig', 32000.00, 'grcraig@hotmail.com', 'DL2712', '2021-02-10', 'USA', '2026-02-10'),
    ('Bryan Wall', 35000.00, 'bryanwall@hotmail.com', 'TX2861', '2022-12-11', 'USA', '2027-11-05'),
    ('Holly Jennifer', 42000.00, 'j.holly@hotmail.com', 'CH5386', '2022-05-12', 'USA', '2024-08-28'),
    ('Hyde Patrick', 38000.00, 'PH@hotmail.com', 'IL2194', '2022-01-24', 'USA', '2023-01-18'),
    ('Regan Daniel', 26000.00, 'danielregan@hotmail.com', 'SC7638', '2023-06-12', 'USA', '2025-06-12'),
    ('Johnson Phillip', 70000.00, 'Philjohnson@hotmail.com', 'NC1293', '2023-05-23', 'USA', '2026-04-25'),
    ('Mark Scone', 28500.00, 'm.scone@hotmail.com', 'SC6712', '2018-12-02', 'USA', '2023-12-02')
    ;

-- Insert some data into the Vehicles table
INSERT INTO Vehicles (RegistrationNumber, Color, PurchaseDate, DriverID)
VALUES
    ('AGY453', 'Red', '2020-01-05', 1),
    ('PED291', 'Blue', '2019-05-20', 2),
    ('QTY374', 'Orange', '2018-09-25', 3),
    ('ANH261', 'Purple', '2021-02-15', 4),
    ('PNF462', 'Yellow', '2017-11-10', 5),
    ('LSX163', 'Black', '2019-09-02', 6),
    ('IFC249', 'Grey', '2022-03-25', 7),
    ('GHR730', 'Green', '2020-06-20', 8),
    ('DSH131', 'Gold', '2021-05-12', 9),
    ('WYE653', 'White', '2018-12-10', 10)
    ;
    
-- Insert some data into the Restaurants table
INSERT INTO Restaurants (RestaurantName, Address)
VALUES
    ('Jamaican Spot', '28 Park Lane'),
    ('Papa John Pizza', '12 Wenworth Road'),
    ('Metro Food', '216 Old Bromley Road'),
    ('Morleys', '11 Bellingham Station'),
    ('Wing it up', '23, Deptford High Street'),
    ('Five Guys', '19 Southwark Avenue'),
    ('Enish', '103 Lewisham Centre'),
    ('Hayatt', '12 Canning town'),
    ('Sam Grill', '27 Grove Green Road'),
    ('Tasty', '216 Plaistow')
    ;
    
-- Insert some data into the Orders table
INSERT INTO Orders (OrderDate, CustomerID, DriverID, RestaurantID)
VALUES
    ('2023-06-12', 1, 2, 3),
    ('2023-06-22', 2, 4, 1),
    ('2023-06-24', 3, 6, 5),
    ('2023-06-30', 4, 8, 2),
    ('2023-07-11', 5, 10, 4),
    ('2023-07-15', 6, 1, 6),
    ('2023-07-23', 7, 3, 8),
    ('2023-08-01', 8, 5, 10),
    ('2023-08-08', 9, 7, 9),
    ('2023-08-13', 10, 9, 7)
    ;

-- Insert some data into the Items table
INSERT INTO Items (ItemName, ItemPrice, Category)
VALUES
    ('Black COD Rolls', 14.50, 'Starter'),
    ('Jollofrice and Shrimps', 22.50, 'Main Dish'),
    ('Chicken pie', 4.50, 'Appertiser'),
    ('Beef Dumplings', 12.25, 'Starter'),
    ('Chocolate Cake', 8.50, 'Dessert'),
    ('California Cavar', 14.50, 'Main Dish'),
    ('Tuna Tartar', 19.25, 'Appetiser'),
    ('White Mibo', 8.25, 'Dessert'),
    ('Prawn Tom Yum', 12.20, 'Desert'),
    ('Spicy Octopus', 12.75, 'Appetiser')
    ;
    
-- Insert some data into the OrderItems table for the many-to-many relationship
INSERT INTO OrderItems (OrderID, ItemID)
VALUES
    (1, 1),
    (1, 3),
    (2, 2),
    (2, 4),
    (3, 5),
    (3, 7),
    (4, 6),
    (4, 8),
    (5, 9),
    (5, 10),
    (6, 1),
    (6, 2),
    (7, 3),
    (7, 4),
    (8, 5),
    (8, 6),
    (9, 7),
    (9, 8),
    (10, 9),
    (10, 10)
    ;















