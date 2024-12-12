/*Create database*/
CREATE DATABASE pos_system;
/*use database*/
USE pos_system;
/*create tables-----*/
/*custemer*/
CREATE TABLE user_details (
	pos_user_id INTEGER NOT NULL,
	pos_user_name VARCHAR(30) NOT NULL,
	user_password CHAR(15) NOT NULL,
	user_role VARCHAR(25),
	PRIMARY KEY (pos_user_id) 
	);
/*view table for check*/
SELECT * FROM user_details;
/*view all tables*/

/* user*/
CREATE TABLE customer (
	customer_id INTEGER NOT NULL,
	customer_name VARCHAR(30) NOT NULL,
	contact_info VARCHAR(50),
	PRIMARY KEY (customer_id) 
	);
/*view table for check*/
SELECT * FROM customer;
/* loyalty*/
CREATE TABLE loyalty (
	loyalty_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	points DECIMAL(7,2),
	PRIMARY KEY (loyalty_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
	);
/* transaction*/
CREATE TABLE s_transaction (
	transaction_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	transaction_date DATETIME NOT NULL,
	payment_method VARCHAR(15) NOT NULL,
	PRIMARY KEY (transaction_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
	);
/* purchaseHistory*/
CREATE TABLE purchase_history (
	purchase_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	purchase_details  VARCHAR NOT NULL,
	PRIMARY KEY (purchase_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
	);
/* product*/
CREATE TABLE product_info (
	product_id INTEGER NOT NULL,
	product_name VARCHAR(30) NOT NULL,
	exipry_date DATETIME NOT NULL,
	PRIMARY KEY (product_id),
	);
/* recipt*/
CREATE TABLE receipt (
	recipt_id INTEGER NOT NULL IDENTITY(0000,1),
	transaction_id INTEGER NOT NULL,
	total_amount DECIMAL(6,2) NOT NULL,
	PRIMARY KEY (recipt_id),
	FOREIGN KEY (transaction_id) REFERENCES s_transaction(transaction_id)
	);
/* discount*/
CREATE TABLE discount (
	discount_id INTEGER NOT NULL ,
	details VARCHAR(50) NOT NULL,
	starting_date DATE NOT NULL,
	end_date DATE NOT NULL,
	PRIMARY KEY (discount_id),
	);
/* stock*/
CREATE TABLE stock (
	stock_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	price DECIMAL(12,2) NOT NULL, 
	PRIMARY KEY (stock_id),
	FOREIGN KEY (product_id) REFERENCES product_info(product_id)
	);
/* purchaseOder*/
CREATE TABLE purchase_order (
	p_oder_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	PRIMARY KEY (p_oder_id),
	FOREIGN KEY (product_id) REFERENCES product_info(product_id)
	);
	
/*report*/
CREATE TABLE report (
	report_id INTEGER NOT NULL IDENTITY(0000,1),
	details VARCHAR NOT NULL,
	reprot_date DATE,
	PRIMARY KEY (report_id),	
	);
SELECT * FROM purchase_order;