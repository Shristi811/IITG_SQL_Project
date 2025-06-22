-- SQL Queries for Urban Retail Co. Inventory Management

-- 1. Stock Level Calculations across stores and warehouse
-- This query calculates the current stock level for each product in each store and in total across all stores.
SELECT
    s.store_id,
    p.product_id,
    p.category,
    SUM(it.inventory_level) AS current_stock_level
FROM
    Inventory_Transactions it
JOIN
    Stores s ON it.store_id = s.store_id
JOIN
    Products p ON it.product_id = p.product_id
GROUP BY
    s.store_id, p.product_id, p.category
ORDER BY
    s.store_id, p.product_id;

-- Total stock level across all stores for each product
SELECT
    p.product_id,
    p.category,
    SUM(it.inventory_level) AS total_stock_level_across_all_stores
FROM
    Inventory_Transactions it
JOIN
    Products p ON it.product_id = p.product_id
GROUP BY
    p.product_id, p.category
ORDER BY
    p.product_id;


-- 2. Low Inventory Detection based on reorder point
-- This query identifies products with inventory levels below a predefined reorder point (e.g., 50 units).
-- In a real scenario, the reorder point would be dynamically calculated or stored in a separate table.
SELECT
    s.store_id,
    p.product_id,
    p.category,
    SUM(it.inventory_level) AS current_stock_level,
    50 AS reorder_point -- Example reorder point
FROM
    Inventory_Transactions it
JOIN
    Stores s ON it.store_id = s.store_id
JOIN
    Products p ON it.product_id = p.product_id
GROUP BY
    s.store_id, p.product_id, p.category
HAVING
    SUM(it.inventory_level) < 50
ORDER BY
    s.store_id, p.product_id;


-- 3. Reorder Point Estimation using historical trend
-- This query estimates a reorder point based on average daily sales over a period (e.g., last 30 days) and a lead time.
-- For simplicity, we'll use a fixed lead time and safety stock factor. In practice, these would be dynamic.
SELECT
    p.product_id,
    p.category,
    AVG(it.units_sold) AS average_daily_sales,
    (AVG(it.units_sold) * 7) + (AVG(it.units_sold) * 0.5) AS estimated_reorder_point -- Avg daily sales * lead time (7 days) + safety stock (50% of lead time sales)
FROM
    Inventory_Transactions it
JOIN
    Products p ON it.product_id = p.product_id
WHERE
    it.date >= DATE('now', '-30 days') -- Adjust as per historical trend period
GROUP BY
    p.product_id, p.category
ORDER BY
    p.product_id;


-- 4. Inventory Turnover Analysis
-- This query calculates inventory turnover ratio (Cost of Goods Sold / Average Inventory) for each product.
-- Assuming 'units_sold' can be used as a proxy for COGS and 'inventory_level' for inventory value.
SELECT
    p.product_id,
    p.category,
    SUM(it.units_sold * p.price) AS total_sales_value, -- Proxy for COGS
    AVG(it.inventory_level * p.price) AS average_inventory_value, -- Proxy for Average Inventory
    CASE
        WHEN AVG(it.inventory_level * p.price) > 0 THEN SUM(it.units_sold * p.price) / AVG(it.inventory_level * p.price)
        ELSE 0
    END AS inventory_turnover_ratio
FROM
    Inventory_Transactions it
JOIN
    Products p ON it.product_id = p.product_id
GROUP BY
    p.product_id, p.category
ORDER BY
    inventory_turnover_ratio DESC;


-- 5. Summary Reports with KPIs

-- Stockout Rates (conceptual - requires more detailed transaction data to accurately calculate stockouts)
-- This is a simplified approach. A true stockout rate would require tracking demand when inventory is zero.
SELECT
    p.product_id,
    p.category,
    SUM(CASE WHEN it.inventory_level = 0 THEN 1 ELSE 0 END) AS days_with_zero_inventory,
    COUNT(DISTINCT it.date) AS total_days_recorded,
    (CAST(SUM(CASE WHEN it.inventory_level = 0 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT it.date)) * 100 AS stockout_rate_percentage
FROM
    Inventory_Transactions it
JOIN
    Products p ON it.product_id = p.product_id
GROUP BY
    p.product_id, p.category
ORDER BY
    stockout_rate_percentage DESC;

-- Inventory Age (conceptual - requires tracking inventory receipt dates)
-- This is a simplified approach based on the assumption that lower inventory levels indicate older stock has been sold.
-- A more accurate calculation would involve tracking FIFO/LIFO.
SELECT
    p.product_id,
    p.category,
    AVG(it.inventory_level) AS average_inventory_level,
    AVG(it.units_sold) AS average_units_sold_per_transaction,
    CASE
        WHEN AVG(it.units_sold) > 0 THEN AVG(it.inventory_level) / AVG(it.units_sold)
        ELSE 0
    END AS estimated_days_of_supply -- Proxy for inventory age
FROM
    Inventory_Transactions it
JOIN
    Products p ON it.product_id = p.product_id
GROUP BY
    p.product_id, p.category
ORDER BY
    estimated_days_of_supply DESC;

-- Average Stock Levels
SELECT
    s.store_id,
    p.product_id,
    p.category,
    AVG(it.inventory_level) AS average_stock_level
FROM
    Inventory_Transactions it
JOIN
    Stores s ON it.store_id = s.store_id
JOIN
    Products p ON it.product_id = p.product_id
GROUP BY
    s.store_id, p.product_id, p.category
ORDER BY
    s.store_id, p.product_id;

-- Overall Average Stock Level
SELECT
    AVG(inventory_level) AS overall_average_stock_level
FROM
    Inventory_Transactions;
