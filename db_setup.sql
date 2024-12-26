CREATE DATABASE amazon_db;
USE amazon_db;

-- parent tables
CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    state VARCHAR(10) NOT NULL,
    address VARCHAR(255) NOT NULL
);

CREATE TABLE seller (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(50) NOT NULL,
    country VARCHAR(10) NOT NULL
);

-- child tables
CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL, -- price_per_unit
    cogs FLOAT NOT NULL, -- manufacturing_cost_per_product
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT,
    seller_id INT,
    order_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id)
);

CREATE TABLE order_item (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL, 
    price FLOAT NOT NULL, -- total_sale_price_per_order
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_status VARCHAR(20) NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_date DATE NOT NULL,
    return_date DATE,
    shipping_provider VARCHAR(50) NOT NULL,
    shipping_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    warehouse_id INT NOT NULL,
    stock INT NOT NULL,
    last_stock_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    