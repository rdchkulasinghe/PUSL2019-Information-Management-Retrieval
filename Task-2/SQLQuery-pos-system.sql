/*Create database---rename it*/
CREATE DATABASE pos_test22;
/*use database*/
USE pos_test22;

/*create tables-----*/
/*1.custemer*/
CREATE TABLE user_details (
	userID INTEGER NOT NULL,
	userName VARCHAR(30) NOT NULL,
	User_password CHAR(15) NOT NULL,
	user_role VARCHAR(25),
	PRIMARY KEY (userID) 
	);
/*view table for check*/
SELECT * FROM user_details;
view db1;
/*2.customer-details-table*/
CREATE TABLE customer (
	customer_id INTEGER NOT NULL,
	customer_name VARCHAR(30) NOT NULL,
	contact_info VARCHAR(50),
	PRIMARY KEY (customer_id) 
	);

/*view table for check*/
SELECT * FROM customer;
DELETE FROM  customer;

/*3.loyalty-table---for-customer*/
CREATE TABLE loyalty (
	loyalty_id INTEGER NOT NULL IDENTITY(1,1),
	customer_id INTEGER NOT NULL,
	points DECIMAL(10,2) CHECK (points >=0),
	PRIMARY KEY (loyalty_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE
	);
SELECT * FROM loyalty;
/*check*/
insert into customer values (0001, 'george', '22233334');


/*4.transaction-info-table---for-supermarket*/
CREATE TABLE transaction_details (
	transaction_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	transaction_date DATE NOT NULL DEFAULT GETDATE(),
	CurrentTime VARCHAR(8) DEFAULT CONVERT(VARCHAR(8), GETDATE(), 108),
	payment_method VARCHAR(30) NOT NULL,
	PRIMARY KEY (transaction_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE
	);
/*check*/
INSERT INTO transaction_details (transaction_id,customer_id, payment_method)
VALUES (103, 3, 'card');
       
SELECT*FROM transaction_details ;
/*8.product*/
CREATE TABLE product_info (
	product_id INTEGER NOT NULL,
	product_name VARCHAR(50) NOT NULL,
	product_price DECIMAL(10,2) NOT NULL,
	exipry_date DATE NOT NULL,
	PRIMARY KEY (product_id),
	);
/*check*/
INSERT INTO product_info VALUES (111,'cow-milk', 200.05, '12-03-2026');

SELECT * FROM product_info;

/*5.recepit-details------goods-price-recording*/
CREATE TABLE recipt_details (
    receipt_id INTEGER NOT NULL IDENTITY(0,1),
    transaction_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (transaction_id) REFERENCES transaction_details(transaction_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES product_info(product_id)	
);
SELECT * FROM recipt_details;
/*6.recipt---customer-final*/

CREATE TABLE receipt (
	/*recipt_id INTEGER NOT NULL DEFAULT 'R0001',trigger*/
	receipt_id INTEGER NOT NULL IDENTITY(0000,1),
	transaction_id INTEGER NOT NULL,
	total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount > 0),
	PRIMARY KEY (receipt_id),
	FOREIGN KEY (transaction_id) REFERENCES transaction_details(transaction_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE
	);
select * from receipt;/*trigger for update from transaction table*/

/*7.purchaseHistory*/
CREATE TABLE purchase_history (
	purchase_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	purchase_details VARCHAR(255) NOT NULL,
	PRIMARY KEY (purchase_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE
	);
/*check*/
select * from purchase_history;


/*9.discount*/
CREATE TABLE discount (
	discount_id INTEGER NOT NULL ,
	details VARCHAR(50) NOT NULL,
	starting_date DATE NOT NULL,
	end_date DATE NOT NULL,
	PRIMARY KEY (discount_id),
	CHECK (end_date > starting_date)
	);
/*10.stock*/
CREATE TABLE stock (
	stock_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	price DECIMAL(12,2) NOT NULL CHECK (price > 0), 
	PRIMARY KEY (stock_id),
	FOREIGN KEY (product_id) REFERENCES product_info(product_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE
	);
/*11.purchaseOder--supermarket?*/
CREATE TABLE purchase_order (
	p_order_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	PRIMARY KEY (p_order_id),
	FOREIGN KEY (product_id) REFERENCES product_info(product_id)
	ON DELETE CASCADE
    ON UPDATE CASCADE
	);
	
/*12.report*/
CREATE TABLE report (
	report_id INTEGER NOT NULL IDENTITY(0000,1),
	details VARCHAR NOT NULL,
	reprot_date DATE DEFAULT GETDATE(),
	PRIMARY KEY (report_id),	
	);
SELECT * FROM purchase_order;



/*tigger*/
CREATE TRIGGER LoyaltyRecord
ON customer
AFTER INSERT
AS
BEGIN
    INSERT INTO loyalty (customer_id, points)
    SELECT inserted.customer_id, 0
    FROM inserted;
END;
SELECT * FROM loyalty;
SELECT * FROM customer;


/*------*/
/*---Create a trigger on the purchase_order table that will update 
the quantity field in the stock table whenever a new purchase order
is inserted or an existing one is updated.---*/
/*---This trigger will automatically generate the receipt ID in the 
format 'R0001', 'R0002', and so on, after each insertion into the
receipt table.----*/
/*-----. Trigger to Update total_amount and Insert into customer_receipt:---*/
/*check all tables*/
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS;
