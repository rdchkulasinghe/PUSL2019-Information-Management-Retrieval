create database pos;

USE pos;

CREATE TABLE customers (
    customerID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    contact_info VARCHAR(10) 
);

CREATE TABLE user (
    userID INT NOT NULL PRIMARY KEY,
    userName VARCHAR(10) NOT NULL UNIQUE,
    password VARCHAR(10) NOT NULL,
    role VARCHAR(15)
);

CREATE TABLE Loyalty(
    customerID INT,
    membershipType VARCHAR(15),
    points INT,
     FOREIGN KEY (customerID) REFERENCES customers(customerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Transactions(
    transactionID INT AUTO_INCREMENT PRIMARY KEY,
    customerID INT,
    date DATE,
    paymentMethod INT,
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Purchase_History(
    purchaseID INT(10) PRIMARY KEY,
    customerID INT,
    purchaseDetails VARCHAR(100),
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Receipt (
    receiptID INT(10) NOT NULL PRIMARY KEY,
    transactionID INT,
    totalAmount DECIMAL(10, 2) CHECK (totalAmount > 0),
    FOREIGN KEY (transactionID) REFERENCES Transactions(transactionID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Discount(
    discountID INT AUTO_INCREMENT PRIMARY KEY,
    details VARCHAR(40),
    startDate DATE,
    endDate DATE CHECK (endDate > startDate)
);

CREATE TABLE Product(
    productID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25),
    expiryDate DATE
);

CREATE TABLE Stock(
    productID INT,
    quantity INT,
    price DECIMAL(10, 2) CHECK (price > 0),
    FOREIGN KEY (productID) REFERENCES Product(productID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Purchase_Order(
    orderID INT(10) PRIMARY KEY,
    productID INT,
    quantity INT check (quantity >0),
    FOREIGN KEY (productID) REFERENCES Product(productID)
    ON DELETE CASCADE
    ON UPDATE CASCADE   
);

CREATE TABLE Report(
    reportID INT PRIMARY KEY,
    details VARCHAR(50),
    genaratedDay DATE
);

USE pos;
-- Insert data into user table 
INSERT INTO user (userID, userName, password, role)
VALUES
  (1, 'admin', 'admin123', 'Administrator'),
  (2, 'manager', 'manager456', 'Manager'),
  (3, 'cashier1', 'cashier789', 'Cashier'),
  (4, 'cashier2', 'cashier101', 'Cashier'),
  (5, 'stock_keeper1', 'stock123', 'Stock Keeper'),
  (6, 'stock_keeper2', 'stock456', 'Stock Keeper'),
  (7, 'accountant', 'account123', 'Accountant'),
  (8, 'customer_service', 'service123', 'Customer Service'),
  (9, 'marketing_manager', 'marketing123', 'Marketing Manager'),
  (10, 'buyer', 'buyer123', 'Buyer');

select * from user;

 INSERT INTO customers (customerID, name, contact_info)
VALUES
  (1001, 'Raveesha Pereira', 'raveesha@example.com'),
  (1002, 'Saduni Fernando', 'saduni@example.com'),
  (1003, 'Buddima Perera', 'buddima@example.com'),
  (1004, 'Crishmark Fernando', 'crishmark@example.com'),
  (1005, 'Shavinda Silva', 'shavinda@example.com'),
  (1006, 'Shyini Malsha', 'shyini@example.com'),
  (1007, 'Chintha Peiris', 'chintha@example.com'),
  (1008, 'Eric Peiris', 'eric@example.com'),
  (1009, 'Kaushala Fernando', 'kaushala@example.com'),
  (1010, 'Niduki Silva', 'niduki@example.com');

select * from customers;

INSERT INTO loyalty (customerId, membershipType, points)
VALUES
  (1001, 'silver', 500.00),
  (1002, 'gold', 350.25),
  (1003, 'bronze', 120.75),
  (1004, 'blue', 450.50),
  (1005, 'platinum', 200.00),
  (1006, 'blue',  600.25),
  (1007, 'silver', 300.00),
  (1008, 'silver', 250.50),
  (1009, 'gold',  400.00),
  (1010, 'gold', 180.75);

select * from loyalty;

  INSERT INTO transactions (transactionId, customerId, date, paymentMethod)
VALUES
  (1, 1001, '2024-10-10', 'Cash'),
  (2, 1002, '2024-10-15', 'Card'),
  (3, 1003, '2024-10-20', 'Cash'),
  (4, 1004, '2024-10-25', 'Card'),
  (5, 1005, '2024-10-30', 'Cash'),
  (6, 1006, '2024-11-05', 'Card'),
  (7, 1007, '2024-11-10', 'Cash'),
  (8, 1008, '2024-11-15', 'Card'),
  (9, 1009, '2024-11-20', 'Cash'),
  (10, 1010, '2024-11-25', 'Card');
  
alter table transactions modify paymentMethod varchar(15);
update transactions set paymentMethod = 'cash' where transactionID = 10;
  
select * from transactions;

INSERT INTO purchase_history (purchaseId, customerId, purchaseDetails)
VALUES
  (1001, 1001, 'Bread, Milk, Eggs'),
  (1002, 1002, 'Rice, Dhal, Sugar'),
  (1003, 1003, 'Fruits, Veg, Meat'),
  (1004, 1004, 'Snacks, Drinks'),
  (1005, 1005, 'Det, Soap, Sham'),
  (1006, 1006, 'Battery, Light'),
  (1007, 1007, 'Fruits, Veg'),
  (1008, 1008, 'Books, Pens'),
  (1009, 1009, 'Dhal, Bakery'),
  (1010, 1010, 'Milk, Eggs');
  
select * from purchase_history;

  INSERT INTO product (productId, name, expiryDate)
VALUES
  (1001, 'Milk', '2024-12-25'),
  (1002, 'Bread', '2024-12-24'),
  (1003, 'Eggs', '2024-12-23'),
  (1004, 'Yogurt', '2024-12-22'),
  (1005, 'Cheese', '2024-12-21'),
  (1006, 'Juice', '2024-12-20'),
  (1007, 'Soda', '2024-12-19'),
  (1008, 'Chips', '2024-12-18'),
  (1009, 'Cookies', '2024-12-17'),
  (1010, 'Candy', '2024-12-16');
  
select * from product;

  INSERT INTO receipt (receiptID, transactionID, totalAmount)
VALUES
  (101, 1, 100.00),
  (102, 2, 250.50),
  (103, 3, 150.25),
  (104, 4, 300.75),
  (105, 5, 220.00),
  (106, 6, 400.50),
  (107, 7, 350.00),
  (108, 8, 280.25),
  (109, 9, 320.75),
  (110, 10, 180.00);
  
select * from receipt;

  INSERT INTO discount (discountId, details, startDate, endDate)
VALUES
  (1201, '10% off on all groceries', '2024-01-01', '2024-01-15'),
  (1202, '20% off on electronics', '2024-02-14', '2024-02-16'),
  (1203, 'Buy 1 Get 1 Free on selected items', '2024-03-15', '2024-03-31'),
  (1204, '5% off on fresh produce', '2024-04-01', '2024-04-15'),
  (1205, '15% off on home appliances', '2024-05-01', '2024-05-15'),
  (1206, 'Free gift with purchase over Rs. 5000', '2024-06-01', '2024-06-30'),
  (1207, '25% off on selected brands', '2024-07-01', '2024-07-15'),
  (1208, '10% off on all online orders', '2024-08-01', '2024-08-31'),
  (1209, 'Happy Hour Discounts (3-5 PM)', '2024-09-01', '2024-09-30'),
  (1210, 'Student Discount (10%)', '2024-10-01', '2024-10-31');
  
select * from discount;


  INSERT INTO stock (productID, quantity, price)
VALUES
  (1001, 100, 500.00),
  (1002, 50, 130.00),
  (1003, 200, 40.00),
  (1004, 150, 75.00),
  (1005, 80, 480.00),
  (1006, 120, 920.00),
  (1007, 70, 170.00),
  (1008, 100, 310.00),
  (1009, 90, 390.00),
  (1010, 60, 260.00);
  
select * from stock;

  INSERT INTO purchase_order (orderId, productId, quantity)
VALUES
  (2001, 1001, 50),
  (2002, 1002, 30),
  (2003, 1003, 100),
  (2004, 1004, 75),
  (2005, 1005, 40),
  (2006, 1006, 60),
  (2007, 1007, 35),
  (2008, 1008, 50),
  (2009, 1009, 45),
  (2010, 1010, 30);
  
select * from purchase_order;



  