-- Products Table
CREATE TABLE Products (
    product_id VARCHAR(10) PRIMARY KEY,
    category VARCHAR(50)
);

-- Stores Table
CREATE TABLE Stores (
    store_id VARCHAR(10) PRIMARY KEY,
    region VARCHAR(50)
);

-- Sales Table (fact table)
CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    inventory_level INT,
    units_sold INT,
    units_ordered INT,
    demand_forecast FLOAT,
    price FLOAT,
    discount INT,
    weather_condition VARCHAR(30),
    holiday_promotion BOOLEAN,
    competitor_pricing FLOAT,
    seasonality VARCHAR(30),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
