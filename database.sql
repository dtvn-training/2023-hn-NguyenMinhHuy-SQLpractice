CREATE DATABASE testDB;
USE testDB;
CREATE USER 'test'@'localhost' IDENTIFIED BY 'pass123';
SELECT user, host FROM mysql.user;
GRANT CREATE ON testDB TO 'test'@'localhost';
SHOW GRANTS FOR 'test'@'localhost';

CREATE TABLE users (
	user_id INT(10) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    address VARCHAR(50),
    email VARCHAR(20),
    PRIMARY KEY(user_id)
);

CREATE TABLE orders(
	order_id INT(10) NOT NULL,
    user_id INT(10) NOT NULL,
    product_ordered INT(10) NOT NULL,
    total_paid BIGINT,
	PRIMARY KEY(order_id)
);

CREATE TABLE products(
	product_id INT(10) NOT NULL,
	product_name VARCHAR(20) NOT NULL,
	description VARCHAR(255) NOT NULL,
	price DOUBLE NOT NULL,
    PRIMARY KEY(product_id)
);

ALTER TABLE orders
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id)
REFERENCES users(user_id);

ALTER TABLE orders
ADD CONSTRAINT fk_product_id
FOREIGN KEY (product_ordered)
REFERENCES products(product_id);

-- Create 10 users
INSERT INTO users (user_id, first_name, last_name, address, email)
VALUES
(1, 'John', 'Doe', '123 Main St', 'john.doe@ex.com'),
(2, 'Jane', 'Smith', '456 Oak St', 'jane.smith@ex.com'),
(3, 'Alice', 'John', '789 Pine St', 'alice.john@ex.com'),
(4, 'Bob', 'Williams', '101 Maple St', 'bob.williams@ex.com'),
(5, 'Eva', 'Brown', '202 Cedar St', 'eva.brown@ex.com'),
(6, 'Charl', 'Mill', '303 Birch St', 'charl.mill@ex.com'),
(7, 'Olivia', 'Davis', '404 Elm St', 'ol.davis@ex.com'),
(8, 'Max', 'Moore', '505 Walnut St', 'max.moore@ex.com'),
(9, 'Sophia', 'Smith', '606 Oak St', 'sophia.smith@ex.com'),
(10, 'Liam', 'Jones', '707 Pine St', 'liam.jones@ex.com');

-- Create 10 products
INSERT INTO products (product_id, product_name, description, price)
VALUES
(1, 'Product A', 'Description for Product A', 19.99),
(2, 'Product B', 'Description for Product B', 29.99),
(3, 'Product C', 'Description for Product C', 39.99),
(4, 'Product D', 'Description for Product D', 49.99),
(5, 'Product E', 'Description for Product E', 59.99),
(6, 'Product F', 'Description for Product F', 69.99),
(7, 'Product G', 'Description for Product G', 79.99),
(8, 'Product H', 'Description for Product H', 89.99),
(9, 'Product I', 'Description for Product I', 99.99),
(10, 'Product J', 'Description for Product J', 109.99);

-- Create 20 orders
INSERT INTO orders (order_id, user_id, product_ordered, total_paid)
VALUES
(1, 1, 1, 19.99),
(2, 2, 2, 29.99),
(3, 3, 3, 39.99),
(4, 4, 4, 49.99),
(5, 5, 5, 59.99),
(6, 6, 6, 69.99),
(7, 7, 7, 79.99),
(8, 8, 8, 89.99),
(9, 9, 9, 99.99),
(10, 10, 10, 109.99),
(11, 1, 3, 39.99),
(12, 2, 4, 49.99),
(13, 3, 5, 59.99),
(14, 4, 6, 69.99),
(15, 5, 7, 79.99),
(16, 6, 8, 89.99),
(17, 7, 9, 99.99),
(18, 8, 10, 109.99),
(19, 9, 1, 19.99),
(20, 10, 2, 29.99);

CREATE VIEW test_view AS 
SELECT order_id, user_id
FROM orders
WHERE order_id > 5;
 
CREATE INDEX idx_user_id ON users (user_id);

EXPLAIN 
SELECT u.user_id, u.first_name, u.last_name, o.order_id, o.product_ordered 
FROM users u 
JOIN orders o ON u.user_id = o.user_id
WHERE u.user_id > 4;