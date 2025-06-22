-- Products Table
CREATE TABLE Products (
    product_id VARCHAR(50) PRIMARY KEY,
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Stores Table
CREATE TABLE Stores (
    store_id VARCHAR(50) PRIMARY KEY,
    region VARCHAR(100)
);

-- Inventory_Transactions Table
CREATE TABLE Inventory_Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    store_id VARCHAR(50),
    product_id VARCHAR(50),
    inventory_level INT,
    units_sold INT,
    units_ordered INT,
    demand_forecast DECIMAL(10, 2),
    discount DECIMAL(10, 2),
    weather_condition VARCHAR(100),
    holiday_promotion BOOLEAN,
    competitor_pricing DECIMAL(10, 2),
    seasonality VARCHAR(50),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
