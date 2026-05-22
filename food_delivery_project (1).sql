-- ============================================================
--  ONLINE FOOD DELIVERY DATABASE SYSTEM
--  Complete SQL Project — All Phases (1–9) + Dashboard Queries
--  Author  : [Your Name]
--  Date    : May 2026
--  Tool    : MySQL 8.0
-- ============================================================


-- ============================================================
-- PHASE 1 — DATABASE & TABLE CREATION
-- ============================================================

DROP DATABASE IF EXISTS food_delivery_db;
CREATE DATABASE food_delivery_db;
USE food_delivery_db;

-- Table 1: Customers
CREATE TABLE customers (
    customer_id   INT           PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(100)  NOT NULL,
    email         VARCHAR(150)  UNIQUE,
    phone         VARCHAR(20),
    city          VARCHAR(100),
    created_at    DATE
);

-- Table 2: Restaurants
CREATE TABLE restaurants (
    restaurant_id INT           PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(150)  NOT NULL,
    city          VARCHAR(100),
    cuisine_type  VARCHAR(100),
    rating        DECIMAL(3,2)
);

-- Table 3: Menu Items
CREATE TABLE menu (
    menu_id       INT           PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT           NOT NULL,
    item_name     VARCHAR(150)  NOT NULL,
    price         DECIMAL(8,2)  NOT NULL,
    category      VARCHAR(100),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- Table 4: Delivery Agents
CREATE TABLE delivery_agents (
    agent_id      INT           PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(100)  NOT NULL,
    phone         VARCHAR(20),
    vehicle_type  VARCHAR(50),
    rating        DECIMAL(3,2)
);

-- Table 5: Orders
CREATE TABLE orders (
    order_id       INT            PRIMARY KEY AUTO_INCREMENT,
    customer_id    INT            NOT NULL,
    restaurant_id  INT            NOT NULL,
    agent_id       INT,
    order_date     DATE           NOT NULL,
    order_amount   DECIMAL(10,2)  NOT NULL,
    discount       DECIMAL(8,2)   DEFAULT 0,
    payment_method VARCHAR(50),
    delivery_time  INT            COMMENT 'Delivery time in minutes',
    status         VARCHAR(50)    DEFAULT 'Delivered',
    FOREIGN KEY (customer_id)   REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (agent_id)      REFERENCES delivery_agents(agent_id)
);

-- Table 6: Order Items
CREATE TABLE order_items (
    item_id    INT  PRIMARY KEY AUTO_INCREMENT,
    order_id   INT  NOT NULL,
    menu_id    INT  NOT NULL,
    quantity   INT  NOT NULL DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (menu_id)  REFERENCES menu(menu_id)
);


-- ============================================================
-- PHASE 2 — SAMPLE DATA
-- ============================================================

-- Customers (10 rows)
INSERT INTO customers (name, email, phone, city, created_at) VALUES
('Riya Sharma',    'riya@email.com',    '9876543210', 'Mumbai',    '2023-01-15'),
('Arjun Mehta',    'arjun@email.com',   '9876543211', 'Delhi',     '2023-02-20'),
('Priya Nair',     'priya@email.com',   '9876543212', 'Bangalore', '2023-03-10'),
('Rahul Gupta',    'rahul@email.com',   '9876543213', 'Pune',      '2023-04-05'),
('Sneha Patel',    'sneha@email.com',   '9876543214', 'Hyderabad', '2023-04-18'),
('Vikram Singh',   'vikram@email.com',  '9876543215', 'Mumbai',    '2023-05-22'),
('Ananya Iyer',    'ananya@email.com',  '9876543216', 'Chennai',   '2023-06-01'),
('Kiran Joshi',    'kiran@email.com',   '9876543217', 'Delhi',     '2023-06-15'),
('Meera Reddy',    'meera@email.com',   '9876543218', 'Bangalore', '2023-07-09'),
('Saurabh Das',    'saurabh@email.com', '9876543219', 'Kolkata',   '2023-08-03');

-- Restaurants (10 rows)
INSERT INTO restaurants (name, city, cuisine_type, rating) VALUES
('Spice Garden',       'Mumbai',    'Indian',       4.5),
('Pizza Palace',       'Delhi',     'Italian',      4.2),
('Burger Barn',        'Bangalore', 'American',     4.0),
('Dragon Wok',         'Pune',      'Chinese',      4.3),
('Curry House',        'Hyderabad', 'Indian',       4.6),
('Pasta Point',        'Mumbai',    'Italian',      4.1),
('Grill Masters',      'Chennai',   'American',     4.4),
('Sushi Spot',         'Delhi',     'Japanese',     4.7),
('Biryani Bros',       'Bangalore', 'Indian',       4.8),
('Taco Town',          'Kolkata',   'Mexican',      3.9);

-- Menu Items (30 rows — 3 per restaurant)
INSERT INTO menu (restaurant_id, item_name, price, category) VALUES
(1, 'Butter Chicken',    320.00, 'Main Course'),
(1, 'Garlic Naan',        60.00, 'Bread'),
(1, 'Mango Lassi',        80.00, 'Beverage'),
(2, 'Margherita Pizza',  350.00, 'Main Course'),
(2, 'Garlic Bread',       90.00, 'Starter'),
(2, 'Tiramisu',          180.00, 'Dessert'),
(3, 'Classic Burger',    250.00, 'Main Course'),
(3, 'Crispy Fries',       90.00, 'Sides'),
(3, 'Chocolate Shake',   150.00, 'Beverage'),
(4, 'Veg Fried Rice',    220.00, 'Main Course'),
(4, 'Spring Rolls',      130.00, 'Starter'),
(4, 'Hot & Sour Soup',   110.00, 'Soup'),
(5, 'Hyderabadi Biryani',380.00, 'Main Course'),
(5, 'Mirchi Ka Salan',   120.00, 'Side'),
(5, 'Double Ka Meetha',  130.00, 'Dessert'),
(6, 'Spaghetti Carbonara',310.00,'Main Course'),
(6, 'Bruschetta',        140.00, 'Starter'),
(6, 'Panna Cotta',       160.00, 'Dessert'),
(7, 'BBQ Platter',       550.00, 'Main Course'),
(7, 'Coleslaw',           70.00, 'Sides'),
(7, 'Lemonade',           60.00, 'Beverage'),
(8, 'Salmon Sashimi',    480.00, 'Main Course'),
(8, 'Dragon Roll',       420.00, 'Sushi'),
(8, 'Miso Soup',         100.00, 'Soup'),
(9, 'Chicken Biryani',   350.00, 'Main Course'),
(9, 'Raita',              60.00, 'Side'),
(9, 'Gulab Jamun',        90.00, 'Dessert'),
(10,'Beef Tacos',         280.00,'Main Course'),
(10,'Nachos',             160.00,'Starter'),
(10,'Horchata',            80.00,'Beverage');

-- Delivery Agents (5 rows)
INSERT INTO delivery_agents (name, phone, vehicle_type, rating) VALUES
('Ravi Kumar',   '8001234567', 'Bike',     4.5),
('Suresh Yadav', '8001234568', 'Scooter',  4.2),
('Deepak Verma', '8001234569', 'Bike',     4.6),
('Manoj Tiwari', '8001234570', 'Cycle',    3.9),
('Rohit Sharma', '8001234571', 'Scooter',  4.4);

-- Orders (20 rows)
INSERT INTO orders (customer_id, restaurant_id, agent_id, order_date, order_amount, discount, payment_method, delivery_time, status) VALUES
(1,  1, 1, '2024-01-05',  460.00,  20.00, 'UPI',         30, 'Delivered'),
(2,  2, 2, '2024-01-10',  620.00,  50.00, 'Credit Card',  45, 'Delivered'),
(3,  3, 3, '2024-01-15',  490.00,   0.00, 'Cash',         25, 'Delivered'),
(4,  4, 4, '2024-01-20',  360.00,  10.00, 'Debit Card',   55, 'Delivered'),
(5,  5, 5, '2024-01-25',  630.00,  30.00, 'UPI',          40, 'Delivered'),
(6,  6, 1, '2024-02-01',  610.00,   0.00, 'Credit Card',  35, 'Delivered'),
(7,  7, 2, '2024-02-05', 1180.00, 100.00, 'UPI',          28, 'Delivered'),
(8,  8, 3, '2024-02-10', 1000.00,  80.00, 'Debit Card',   50, 'Delivered'),
(9,  9, 4, '2024-02-14',  500.00,  20.00, 'Cash',         60, 'Delivered'),
(10,10, 5, '2024-02-20',  520.00,   0.00, 'UPI',          42, 'Delivered'),
(1,  5, 1, '2024-03-01',  760.00,  40.00, 'Credit Card',  33, 'Delivered'),
(2,  9, 2, '2024-03-05',  700.00,   0.00, 'UPI',          27, 'Delivered'),
(3,  1, 3, '2024-03-10',  380.00,  15.00, 'Cash',         48, 'Delivered'),
(4,  8, 4, '2024-03-15',  900.00,  50.00, 'Debit Card',   38, 'Delivered'),
(5,  2, 5, '2024-03-20',  700.00,  30.00, 'UPI',          32, 'Delivered'),
(6,  7, 1, '2024-04-01', 1650.00, 150.00, 'Credit Card',  44, 'Delivered'),
(7,  3, 2, '2024-04-05',  340.00,   0.00, 'Cash',         22, 'Delivered'),
(8,  6, 3, '2024-04-10',  630.00,  25.00, 'UPI',          37, 'Delivered'),
(9,  4, 4, '2024-04-15',  440.00,   0.00, 'Debit Card',   65, 'Delivered'),
(10, 10,5, '2024-04-20',  440.00,  10.00, 'Cash',         29, 'Delivered');

-- Order Items (linking orders to menu items)
INSERT INTO order_items (order_id, menu_id, quantity) VALUES
(1,  1, 1), (1,  2, 2), (1,  3, 1),
(2,  4, 1), (2,  5, 2), (2,  6, 1),
(3,  7, 2), (3,  8, 2), (3,  9, 1),
(4, 10, 2), (4, 11, 1),
(5, 13, 1), (5, 14, 1), (5, 15, 2),
(6, 16, 1), (6, 17, 1), (6, 18, 1),
(7, 19, 2), (7, 20, 2), (7, 21, 2),
(8, 22, 1), (8, 23, 1), (8, 24, 1),
(9, 25, 1), (9, 26, 1), (9, 27, 2),
(10,28, 2), (10,29, 1), (10,30, 1);


-- ============================================================
-- PHASE 3 — BASIC EXPLORATION
-- ============================================================

-- Total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Total revenue generated
SELECT SUM(order_amount) AS total_revenue FROM orders;

-- Total discounts given
SELECT SUM(discount) AS total_discounts FROM orders;

-- Net revenue (after discounts)
SELECT SUM(order_amount - discount) AS net_revenue FROM orders;

-- Orders by payment method
SELECT
    payment_method,
    COUNT(*)          AS order_count,
    SUM(order_amount) AS total_revenue
FROM orders
GROUP BY payment_method
ORDER BY order_count DESC;

-- Orders by status
SELECT status, COUNT(*) AS count
FROM orders
GROUP BY status;


-- ============================================================
-- PHASE 4 — CUSTOMER ANALYSIS
-- ============================================================

-- Top 10 customers by total spending
SELECT
    c.name,
    c.city,
    COUNT(o.order_id)       AS total_orders,
    SUM(o.order_amount)     AS total_spent,
    AVG(o.order_amount)     AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spent DESC
LIMIT 10;

-- Customer order frequency (repeat vs one-time buyers)
SELECT
    c.name,
    COUNT(o.order_id) AS order_count,
    CASE
        WHEN COUNT(o.order_id) >= 3 THEN 'Loyal'
        WHEN COUNT(o.order_id) = 2  THEN 'Returning'
        ELSE 'One-Time'
    END AS customer_type
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY order_count DESC;

-- City-wise customer count and revenue
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS customers,
    COUNT(o.order_id)             AS total_orders,
    SUM(o.order_amount)           AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Customers with above-average spending
SELECT
    c.name,
    SUM(o.order_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING total_spent > (
    SELECT AVG(total) FROM (
        SELECT SUM(order_amount) AS total
        FROM orders
        GROUP BY customer_id
    ) AS sub
)
ORDER BY total_spent DESC;


-- ============================================================
-- PHASE 5 — RESTAURANT & REVENUE ANALYSIS
-- ============================================================

-- Top 10 restaurants by revenue
SELECT
    r.name,
    r.cuisine_type,
    r.city,
    COUNT(o.order_id)   AS total_orders,
    SUM(o.order_amount) AS total_revenue,
    AVG(o.order_amount) AS avg_order_value
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name, r.cuisine_type, r.city
ORDER BY total_revenue DESC
LIMIT 10;

-- Revenue and order volume by cuisine type
SELECT
    r.cuisine_type,
    COUNT(o.order_id)   AS total_orders,
    SUM(o.order_amount) AS total_revenue,
    AVG(o.order_amount) AS avg_order_value
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.cuisine_type
ORDER BY total_revenue DESC;

-- City-wise restaurant performance
SELECT
    r.city,
    COUNT(DISTINCT r.restaurant_id) AS restaurants,
    COUNT(o.order_id)               AS total_orders,
    SUM(o.order_amount)             AS total_revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.city
ORDER BY total_revenue DESC;

-- Best-selling menu items across platform
SELECT
    m.item_name,
    r.name          AS restaurant,
    m.category,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * m.price) AS estimated_revenue
FROM menu m
JOIN order_items oi ON m.menu_id = oi.menu_id
JOIN restaurants r  ON m.restaurant_id = r.restaurant_id
GROUP BY m.menu_id, m.item_name, r.name, m.category
ORDER BY total_units_sold DESC
LIMIT 10;


-- ============================================================
-- PHASE 6 — DELIVERY PERFORMANCE ANALYSIS
-- ============================================================

-- Agent performance: average delivery time and total deliveries
SELECT
    da.name              AS agent_name,
    da.vehicle_type,
    da.rating,
    COUNT(o.order_id)    AS total_deliveries,
    AVG(o.delivery_time) AS avg_delivery_mins,
    MIN(o.delivery_time) AS fastest_delivery,
    MAX(o.delivery_time) AS slowest_delivery
FROM delivery_agents da
JOIN orders o ON da.agent_id = o.agent_id
GROUP BY da.agent_id, da.name, da.vehicle_type, da.rating
ORDER BY avg_delivery_mins ASC;

-- Orders with delivery time exceeding 45 minutes (SLA breach)
SELECT
    o.order_id,
    c.name          AS customer,
    r.name          AS restaurant,
    da.name         AS agent,
    o.delivery_time AS delivery_mins,
    o.order_date
FROM orders o
JOIN customers       c  ON o.customer_id   = c.customer_id
JOIN restaurants     r  ON o.restaurant_id = r.restaurant_id
JOIN delivery_agents da ON o.agent_id      = da.agent_id
WHERE o.delivery_time > 45
ORDER BY o.delivery_time DESC;

-- City-wise average delivery time
SELECT
    r.city,
    AVG(o.delivery_time) AS avg_delivery_mins,
    COUNT(o.order_id)    AS total_orders
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY avg_delivery_mins ASC;

-- Percentage of delayed orders (>45 min) overall
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN delivery_time > 45 THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(
        SUM(CASE WHEN delivery_time > 45 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS delay_percentage
FROM orders;


-- ============================================================
-- PHASE 7 — ADVANCED QUERIES
-- ============================================================

-- Monthly revenue and order trend
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id)                  AS total_orders,
    SUM(order_amount)                AS total_revenue,
    SUM(discount)                    AS total_discounts,
    SUM(order_amount - discount)     AS net_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- High-value orders (order_amount > 500)
SELECT
    o.order_id,
    c.name          AS customer,
    r.name          AS restaurant,
    o.order_amount,
    o.discount,
    o.order_amount - o.discount AS net_amount,
    o.order_date
FROM orders o
JOIN customers   c ON o.customer_id   = c.customer_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.order_amount > 500
ORDER BY o.order_amount DESC;

-- Discount analysis: orders with and without discounts
SELECT
    CASE WHEN discount > 0 THEN 'With Discount' ELSE 'No Discount' END AS discount_type,
    COUNT(*)            AS order_count,
    AVG(order_amount)   AS avg_order_value,
    SUM(discount)       AS total_discount_given
FROM orders
GROUP BY discount_type;

-- Orders using the most common payment method
SELECT payment_method, COUNT(*) AS usage_count
FROM orders
GROUP BY payment_method
ORDER BY usage_count DESC
LIMIT 1;

-- Customers who haven't ordered in the last 60 days
SELECT c.name, c.email, c.city, MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.email, c.city
HAVING last_order_date < DATE_SUB(CURDATE(), INTERVAL 60 DAY)
    OR last_order_date IS NULL;


-- ============================================================
-- PHASE 8 — PERFORMANCE OPTIMIZATION (INDEXES)
-- ============================================================

-- Create indexes on frequently queried columns
-- Note: Primary key columns are already indexed automatically

CREATE INDEX idx_order_date     ON orders(order_date);
CREATE INDEX idx_order_amount   ON orders(order_amount);
CREATE INDEX idx_delivery_time  ON orders(delivery_time);
CREATE INDEX idx_customer_name  ON customers(name);
CREATE INDEX idx_restaurant_name ON restaurants(name);

-- Verify indexes were created
SHOW INDEX FROM orders;
SHOW INDEX FROM customers;
SHOW INDEX FROM restaurants;

-- Test index usage with EXPLAIN
EXPLAIN SELECT * FROM orders WHERE order_date >= '2024-03-01';
EXPLAIN SELECT * FROM orders WHERE order_amount > 1000;
EXPLAIN SELECT * FROM orders WHERE delivery_time > 45;
EXPLAIN SELECT * FROM customers WHERE name = 'Riya Sharma';
EXPLAIN SELECT * FROM restaurants WHERE name = 'Biryani Bros';


-- ============================================================
-- PHASE 9 — TRIGGERS
-- ============================================================

-- ---------- Log Tables for Triggers ----------

CREATE TABLE high_value_orders_log (
    log_id       INT            PRIMARY KEY AUTO_INCREMENT,
    order_id     INT,
    customer_id  INT,
    order_amount DECIMAL(10,2),
    logged_at    TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE delivery_delay_log (
    log_id        INT  PRIMARY KEY AUTO_INCREMENT,
    order_id      INT,
    agent_id      INT,
    delivery_time INT,
    logged_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------- Trigger 1: High Value Order Logger ----------
-- Automatically logs any order with amount > 1000 into high_value_orders_log

CREATE TRIGGER trg_high_value_log
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.order_amount > 1000 THEN
        INSERT INTO high_value_orders_log (order_id, customer_id, order_amount)
        VALUES (NEW.order_id, NEW.customer_id, NEW.order_amount);
    END IF;
END;

-- ---------- Trigger 2: Prevent Negative Discount ----------
-- Automatically resets any negative discount to 0 before insertion

CREATE TRIGGER trg_no_negative_discount
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.discount < 0 THEN
        SET NEW.discount = 0;
    END IF;
END;

-- ---------- Trigger 3: Delivery Delay Logger ----------
-- Automatically logs any order with delivery time > 45 minutes

CREATE TRIGGER trg_delivery_delay_log
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.delivery_time > 45 THEN
        INSERT INTO delivery_delay_log (order_id, agent_id, delivery_time)
        VALUES (NEW.order_id, NEW.agent_id, NEW.delivery_time);
    END IF;
END;

-- ---------- Trigger Testing ----------

-- Test Trigger 1: Insert a high-value order (should log automatically)
INSERT INTO orders (customer_id, restaurant_id, agent_id, order_date, order_amount, discount, payment_method, delivery_time)
VALUES (1, 7, 1, CURDATE(), 1500.00, 0, 'UPI', 30);

-- Test Trigger 2: Insert an order with negative discount (should become 0)
INSERT INTO orders (customer_id, restaurant_id, agent_id, order_date, order_amount, discount, payment_method, delivery_time)
VALUES (2, 3, 2, CURDATE(), 400.00, -50.00, 'Cash', 20);

-- Test Trigger 3: Insert a delayed order (should log automatically)
INSERT INTO orders (customer_id, restaurant_id, agent_id, order_date, order_amount, discount, payment_method, delivery_time)
VALUES (3, 4, 4, CURDATE(), 350.00, 0, 'Debit Card', 70);

-- Verify trigger results
SELECT * FROM high_value_orders_log;
SELECT * FROM delivery_delay_log;
SELECT order_id, discount FROM orders WHERE discount = 0 ORDER BY order_id DESC LIMIT 3;


-- ============================================================
-- DASHBOARD EXPORT QUERIES
-- (Run each, export as CSV, import to Google Sheets)
-- ============================================================

-- Dashboard Query 1: Total Revenue KPI (Scorecard)
SELECT
    COUNT(order_id)             AS total_orders,
    SUM(order_amount)           AS total_revenue,
    SUM(discount)               AS total_discounts,
    SUM(order_amount - discount) AS net_revenue,
    AVG(order_amount)           AS avg_order_value
FROM orders;

-- Dashboard Query 2: City-wise Order Volume (Pie Chart)
SELECT
    c.city,
    COUNT(o.order_id)   AS total_orders,
    SUM(o.order_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_orders DESC;

-- Dashboard Query 3: Top 10 Restaurants by Revenue (Bar Chart)
SELECT
    r.name          AS restaurant_name,
    r.cuisine_type,
    SUM(o.order_amount) AS total_revenue,
    COUNT(o.order_id)   AS total_orders
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name, r.cuisine_type
ORDER BY total_revenue DESC
LIMIT 10;

-- Dashboard Query 4: City-wise Avg Delivery Time (3D Pie / Column Chart)
SELECT
    r.city,
    ROUND(AVG(o.delivery_time), 1) AS avg_delivery_mins,
    COUNT(o.order_id)              AS total_orders
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.city
ORDER BY avg_delivery_mins ASC;

-- Dashboard Query 5: Monthly Order & Revenue Trend (Line Chart)
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id)                  AS total_orders,
    SUM(order_amount)                AS total_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- ============================================================
-- END OF PROJECT
-- ============================================================
