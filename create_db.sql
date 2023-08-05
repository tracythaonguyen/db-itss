CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT, 
    customer_card VARCHAR(255) NOT NULL UNIQUE,
    customer_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (customer_id)
);

CREATE TABLE docks (
    dock_id INT AUTO_INCREMENT,
    dock_address VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,
    number_of_bikes INT DEFAULT 0,
    dock_status INT DEFAULT 0,
    CHECK(dock_status IN (0, 1, 2, 3)),
    CHECK(number_of_bikes <= capacity),
    PRIMARY KEY (dock_id)
);

-- dock_status:
-- 0 - available
-- 1 - full
-- 2 - unavailable

CREATE TABLE bikes (
    bike_id INT AUTO_INCREMENT,
    bike_type VARCHAR(255) NOT NULL,
    bike_color VARCHAR(255),
    bike_status INT DEFAULT 0,
    CHECK(bike_status IN (0, 1, 2, 3)),
    dock_id INT NOT NULL,
    PRIMARY KEY (bike_id),
    CONSTRAINT fk_dock_id
    FOREIGN KEY (dock_id) 
        REFERENCES docks(dock_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    bike_id INT NOT NULL,
    initial_dock_id INT NOT NULL,
    return_dock_id INT NOT NULL, 
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    return_time TIME,
    deposit DECIMAL(10, 2) NOT NULL,
    total_fee DECIMAL(10, 2) NOT NULL,
    order_status INT DEFAULT 0,
    CHECK(order_status IN (0, 1, 2, 3)),
    PRIMARY KEY (order_id),
    CONSTRAINT fk_customer_id
        FOREIGN KEY (customer_id) 
            REFERENCES customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_bike_id
        FOREIGN KEY (bike_id) 
            REFERENCES bikes(bike_id) ON DELETE CASCADE,
    CONSTRAINT fk_initial_dock_id
        FOREIGN KEY (initial_dock_id) 
            REFERENCES docks(dock_id) ON DELETE CASCADE,
    CONSTRAINT fk_return_dock_id
        FOREIGN KEY (return_dock_id) 
            REFERENCES docks(dock_id) ON DELETE CASCADE
);

-- order status:
-- 0 - ordered
-- 1 - renting
-- 2 - returned
-- 3 - cancelled

CREATE TABLE receipt (
    receipt_id INT AUTO_INCREMENT PRIMARY KEY,
    user_credit_card_number INT NOT NULL,
    bank_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_time TIME NOT NULL,
    transaction_amount DECIMAL(10, 2) NOT NULL,
    transaction_status VARCHAR(20) NOT NULL
);
