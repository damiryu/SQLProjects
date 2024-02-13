
USE Amazon_RDBMS; 

-- Create the Customers table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(150),
    RegistrationDate DATE,
    LoyaltyPoints INT DEFAULT 0
);

-- Create Vendor table
CREATE TABLE Vendor (
    VendorID INT PRIMARY KEY,
    VendorName VARCHAR(150),
    ContactName VARCHAR(100),
    ContactEmail VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(150)
);

-- Create Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    Weight DECIMAL(8, 2),
    Dimensions VARCHAR(50),
    VendorID INT,
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    ShippingAddress VARCHAR(150),
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50),
    TotalAmount DECIMAL(12, 2),
    TaxAmount DECIMAL(10, 2),
    ShippingFee DECIMAL(8, 2),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create OrderItems table for the many to many relationships between orders and orderitems
CREATE TABLE OrderItem (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT, -- Add the ProductID column for the relationship
    Quantity INT,
    Subtotal DECIMAL(12, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
);



-- Create Review table
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    Rating INT,
    ReviewText TEXT,
    ReviewDate DATE,
    ProductID INT, -- Add the ProductID column for the relationship
    CustomerID INT, -- Add the CustomerID columnb for the relationship
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);

-- Insert some data into the Customers table
INSERT INTO Customer
VALUES 
	(1, 'Ray', 'Smith', 'raysmith@hotmail.com', '234-674-2640', '28 Elthorne Road', '2023-03-01', 15),
    (2, 'Jordan', 'Husk', 'huskjr@hotmail.com', '478-284-0163', '19 Newham way', '2023-03-25', 38),
    (3, 'Drake', 'Andrew', 'dandrew6r@hotmail.com', '201=362-8459', '235 Canary Wharf', '2023-04-12', 125),
    (4, 'Quadri', 'Hassan', 'quadrihassan22@hotmail.com', '278-716-3282', '436 Leyton Road', '2023-04-16', 220),
    (5, 'Williams', 'Bane', 'b.Williams@hotmail.com', '935-671-8426', '188 Chiselhurst Avenue ', '2023-04-22', 112),
    (6, 'Mary', 'Jane', 'maryj@hotmail.com', '902-831-7630', '204 Orpington road', '2023-06-23', 126),
    (7, 'Kayla', 'Lexi', 'lexik@hotmail.com', '093-7410-3285', '19 St.Johns park', '2023-06-12', 109),
    (8, 'Chelsea', 'Brooke', 'brroke.c@hotmail.com', '026-879-6329', '232 Wembley avenue', '2023-07-12', 36),
    (9, 'Justin', 'Jakes', 'jjakes@hotmail.com', '631-482-8421', '162 Lee Road', '2023-07-28', 229),
    (10, 'Alexis', 'Mikayla', 'a.mikayla@hotmail.com', '469-204-8712', '12 Bond Street', '2023-08-18', 367)
;

INSERT INTO Vendor 
VALUES
    (212, 'Frittles', 'Jake', 'jake@frittles.co.uk', '278-391-6482', '24 Hanault Road'),
    (127, 'ElectroBay', 'Dan', 'w.dan@electrobay.co.uk', '230-374-8922', '432 White City'),
    (12, 'Cyclone', 'Maria', 'Maria@cyclotech.co.uk', '029-13', '231 Ruislip Avenue'),
    (78, 'Watch Hub', 'kate', 'o.kate@watchhub.co.uk', '903-835-9013', '18b Olympic Stratford'),
    (34, 'Fig Tree', 'Milan', 'milano@figtree.co.uk', '083-749-7252', '361 Leytonstone Side'),
    (240, 'AC Expats', 'Brian', 'brian@acexpats.co.uk', '732-531-9243', '100a Oxford Circus'),
    (102, 'Sonic Empire', 'Aisha', 'aisha@sonicempire.co.uk', '092-163-6729', '18 Holborn Way'),
    (92, 'Chopstix', 'Liu', 'Liu@chopstix.co.uk', '904-732-8169', '202 Mile End'),
    (136, 'Wingstop', 'Sean', 'sean@wingstop.co.uk', '926-532-8392', '2c Snaresbrook End'),
    (261, 'Costcutter', 'Raj', 'Raj@costcutter.co.uk', '363-219-5218', '45 Loughton Park')
;

INSERT INTO Product
VALUES
    (135, 'Fish Frittles', 'soulfood', 22.20, 15, '1.90', '2mmx2mm', 212),
    (225, 'AI Echo', 'Intelligent sound assistant', 55.00, 10, '5.00', '3mmx2mm', 127),
    (160, 'USB device', 'Fater device to device connection', 11.35, 50, '0.80', '1.5mmx1.5mm', 12),
    (23, 'Cartier', 'Tell the time prestigiously', 120000.00, 5, '3.00', '5mmx1.5mm', 78),
    (34, 'Heineken', 'Drink responsibly', 8.30, 100, '0.50', '4mmx1mm', 34),
    (302, 'LG', 'Lets go green-renewable cooling device', 250.00, 22, '12.00', '24mmx12mm', 240),
    (49, 'Grand Piano', 'Access Life melodiously', 15000.00, 10, '10.00', '40mmx10mm', 102),
    (12, 'Vermicelli', 'Taste the feeling', 23.00, 56, '0.30', '2mmx2mm', 92),
    (132, 'Food Box', 'Quick stop for nutrients', 30.00, 63, '1.50', '4mmx4mm', 136),
    (24, 'Grocery Pack', 'Everything at a discount', 24.00, 20, '8.00', '4mmx8mm', 261)
;

INSERT INTO Orders
VALUES
    (162, '2023-04-21', '12 Wanstead Road', 'Card', 'Received', 28.00, 2.25, 3.00, 1),
    (32, '2023-04-18', '32 Limehouse Blvd', 'Cash', 'Pending', 60.00, 4.25, 2.80, 2),
    (21, '2023-05-06', '130 Westferry Close', 'Card', 'Received', 16.00, 1.25, 2.00, 3),
    (25, '2023-05-22', '183d Canary Wharf', 'Card', 'Pending', 138000.00, 6532.25, 250.00, 4),
    (18, '2023-05-31', '123 South Quay Avenue', 'Cash', 'Received', 10.00, 1.70, 0.00, 5),
    (124, '2023-07-25', '46 Crossharbour Road', 'Card', 'Received', 280.00, 25.00, 5.00, 6),
    (33, '2023-07-22', '2 Mudchute Way', 'Card', 'Pending', 16000.00, 820.00, 80.00, 7),
    (231, '2023-07-16', '232 Island Gardens', 'Card', 'Received', 28.00, 2.25, 2.25, 8),
    (178, '2023-08-22', '18b Greenich Maritime Square', 'Cash', 'Received', 24.00, 4.25, 1.75, 9),
    (150, '2023-08-28', '147 Elverson Road', 'Cash', 'Pending', 21.25, 1.75, 1.00, 10)
;

INSERT INTO OrderItem
VALUES
	(142, 162, 135, 24, 23.00),
    (183, 32, 225, 11, 450.00),
    (127, 21, 160, 10, 120.00),
    (29, 25, 23, 5, 220000.00),
    (73, 18, 34, 6, 160.00),
    (283, 124, 302, 21, 1670.00),
    (82, 33, 49, 15, 165000.00),
    (67, 231, 12, 13, 300.00),
    (145, 178, 132, 22, 360.00),
    (26, 150, 24, 14, 420.00)
;

INSERT INTO REVIEW
VALUES
	(21, 8, 'Deicious', '2023-04-15', 135, 1),
    (43, 7, 'Money well spent!', '2023-04-15', 225, 2),
    (122, 6, 'Not quite as fast', '2023-04-15', 160, 3),
    (121, 9, 'one word - Excellence', '2023-04-15', 23, 4),
    (90, 6, 'Great step down', '2023-04-15', 34, 5),
    (11, 8, 'Worth the buy!', '2023-04-15', 302, 6),
    (28, 8, 'Best brand ever!', '2023-04-15', 49, 7),
    (98, 7, 'Good food', '2023-04-15', 12, 8),
    (13, 6, 'Quick, nice and easy', '2023-04-15', 132, 9),
    (15, 7, 'Great offer!', '2023-04-15', 24, 10)
;


-- Data organization: listing vendors and their products
SELECT
    Vendor.VendorName,
    Product.ProductName,
    Product.Description,
    Product.Price
FROM
    Vendor
JOIN Product ON Vendor.VendorID = Product.VendorID;


-- Business Insights: Vendors performance analysis
SELECT Vendor.VendorID, Vendor.VendorName, AVG(Review.Rating) AS AvgRating
FROM Vendor
JOIN Product ON Vendor.VendorID = Product.VendorID
LEFT JOIN Review ON Product.ProductID = Review.ProductID
GROUP BY Vendor.VendorID, Vendor.VendorName;

-- Scalability: Placing an order and updating stock quantity

-- Assuming OrderID 101 is a new order with ProductID 201 and a quantity of 2

-- Insert Order
INSERT INTO Orders (OrderID, OrderDate, ShippingAddress, PaymentMethod, OrderStatus, TotalAmount, TaxAmount, ShippingFee)
VALUES (101, '2023-09-23', '456 Oak St', 'Card', 'Pending', 50.00, 5.00, 10.00);

-- Insert OrderItem
INSERT INTO OrderItem (OrderItemID, OrderID, ProductID, Quantity, Subtotal)
VALUES (501, 101, 201, 2, 30.00);

-- Update Stock Quantity
UPDATE Product SET StockQuantity = StockQuantity - 2 WHERE ProductID = 201;



-- Efficient Data Retrieval: Retrieve customer orders with product details
SELECT
    Customer.FirstName,
    Customer.LastName,
    Orders.OrderID,
    Orders.OrderDate,
    Product.ProductName,
    OrderItem.Quantity,
    OrderItem.Subtotal
FROM
    Customer
JOIN Orders ON Customer.CustomerID = Orders.CustomerID
JOIN OrderItem ON Orders.OrderID = OrderItem.OrderID
JOIN Product ON OrderItem.ProductID = Product.ProductID
WHERE
    Customer.CustomerID = 1;


-- Maintaining customer information: Identify high value customers
SELECT
    Customer.CustomerID,
    Customer.FirstName,
    Customer.LastName,
    SUM(Orders.TotalAmount) AS TotalSpent
FROM
    Customer
JOIN Orders ON Customer.CustomerID = Orders.CustomerID
GROUP BY
    Customer.CustomerID, Customer.FirstName, Customer.LastName
HAVING
    TotalSpent > 1000;
