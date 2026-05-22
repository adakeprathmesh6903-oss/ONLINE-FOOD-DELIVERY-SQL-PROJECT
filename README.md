# 🍔 Online Food Delivery Database System
### A Complete SQL Project | MySQL 8.0

![SQL](https://img.shields.io/badge/SQL-MySQL%208.0-blue?logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Phases](https://img.shields.io/badge/Phases-9-orange)
![Queries](https://img.shields.io/badge/Queries-25%2B-purple)

---

## 📌 Project Overview

This project implements an end-to-end relational database system for an online food delivery platform using **MySQL**. It covers the complete data lifecycle — from schema design and data population through business analysis, performance optimization, and automated monitoring using triggers.

A **Google Sheets dashboard** was also built using exported SQL query results to provide visual business insights.

---

## 🗂️ Project Structure

```
food-delivery-sql/
│
├── food_delivery_project.sql   ← Complete SQL file (all phases)
├── README.md                   ← This file
└── report/
    └── SQL_Project_Report.docx ← Full project report
```

---

## 🏗️ Database Schema

The database consists of **6 interrelated tables**:

| Table | Description | Key Columns |
|---|---|---|
| `customers` | Customer profiles | customer_id (PK), name, city, email |
| `restaurants` | Restaurant details | restaurant_id (PK), name, cuisine_type |
| `menu` | Menu items per restaurant | menu_id (PK), restaurant_id (FK), price |
| `delivery_agents` | Agent profiles & ratings | agent_id (PK), vehicle_type, rating |
| `orders` | Master transaction table | order_id (PK), order_amount, delivery_time |
| `order_items` | Line items per order | order_id (FK), menu_id (FK), quantity |

### Entity Relationships

```
customers ──< orders >── restaurants
                │
         delivery_agents
                │
           order_items >── menu
```

---

## 📋 Phase-by-Phase Breakdown

### Phase 1 — Database & Table Creation
- Created `food_delivery_db` database
- Defined 6 tables with `PRIMARY KEY`, `FOREIGN KEY`, and `NOT NULL` constraints
- Enforced referential integrity across all tables

### Phase 2 — Sample Data Population
- 10 customers across 7 cities
- 10 restaurants across 5 cuisine types
- 5 delivery agents with different vehicle types
- 20 orders with varied amounts, discounts, and delivery times
- 30+ order items linking orders to menu entries

### Phase 3 — Basic Exploration
- Total orders, total revenue, net revenue (after discounts)
- Orders grouped by payment method and status

### Phase 4 — Customer Analysis
- Top spenders by total order value
- Customer segmentation: Loyal / Returning / One-Time
- City-wise customer distribution and revenue
- Above-average spending customer identification

### Phase 5 — Restaurant & Revenue Analysis
- Top 10 restaurants ranked by revenue
- Revenue breakdown by cuisine type
- City-wise restaurant performance
- Best-selling menu items across the platform

### Phase 6 — Delivery Performance Analysis
- Agent performance: avg delivery time, fastest/slowest delivery
- SLA breach detection: orders exceeding 45-minute delivery target
- City-wise average delivery time comparison
- Overall delayed order percentage

### Phase 7 — Advanced Queries
- Monthly revenue and order trend analysis
- High-value order identification (> ₹500)
- Discount effectiveness analysis
- Inactive customer identification (no order in 60 days)

### Phase 8 — Performance Optimization (Indexes)
- Created 5 indexes on high-frequency filter columns
- Used `EXPLAIN` to verify index usage by MySQL query optimizer

| Index | Table | Column |
|---|---|---|
| `idx_order_date` | orders | order_date |
| `idx_order_amount` | orders | order_amount |
| `idx_delivery_time` | orders | delivery_time |
| `idx_customer_name` | customers | name |
| `idx_restaurant_name` | restaurants | name |

> **Note:** Primary key columns are indexed automatically by MySQL and excluded here.

### Phase 9 — Triggers (Automation)
Three triggers automate business monitoring silently in the background:

| Trigger | Event | Condition | Action |
|---|---|---|---|
| `trg_high_value_log` | AFTER INSERT | order_amount > 1000 | Logs to `high_value_orders_log` |
| `trg_no_negative_discount` | BEFORE INSERT | discount < 0 | Resets discount to 0 |
| `trg_delivery_delay_log` | AFTER INSERT | delivery_time > 45 | Logs to `delivery_delay_log` |

---

## 📊 Dashboard

Five export-ready queries feed a **Google Sheets dashboard** with the following charts:

| Chart | Type | Metric |
|---|---|---|
| Total Revenue KPI | Scorecard | Overall revenue, orders, avg value |
| Orders by City | Pie Chart | Order volume per customer city |
| Top 10 Restaurants | Bar Chart | Revenue per restaurant |
| Avg Delivery Time by City | Column Chart | City-wise delivery efficiency |
| Monthly Trend | Line Chart | Orders and revenue over time |

---

## 🚀 How to Run

1. **Clone this repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/food-delivery-sql.git
   cd food-delivery-sql
   ```

2. **Open MySQL Workbench** (or any MySQL client)

3. **Run the SQL file**
   ```sql
   SOURCE food_delivery_project.sql;
   ```
   Or use File → Open SQL Script in MySQL Workbench and execute.

4. **Verify setup**
   ```sql
   USE food_delivery_db;
   SHOW TABLES;
   SELECT COUNT(*) FROM orders;
   ```

---

## 🛠️ Tools & Technologies

- **Database:** MySQL 8.0
- **IDE:** MySQL Workbench / VS Code (SQLTools extension)
- **Dashboard:** Google Sheets
- **Version Control:** Git & GitHub
- **Report:** Microsoft Word / Canva

---

## 💡 Key Business Insights

- The **top 3 customers** account for ~40% of total platform revenue
- **Indian cuisine** restaurants generate the highest average order value
- **~30% of orders** exceed the 45-minute delivery SLA target
- **UPI** is the most preferred payment method among customers
- Orders with discounts show a **higher average order value**, suggesting discount-driven upsell behaviour

---

## 📁 Files

| File | Description |
|---|---|
| `food_delivery_project.sql` | Complete SQL script — all 9 phases |
| `README.md` | Project documentation |
| `SQL_Project_Report.docx` | Full project report with analysis |

---

## 👤 Author

**[Prathmesh Adake]**  
[SQL Project]  
📧 [adakeprathmesh6903@gmail.com]  
🔗 [https://www.linkedin.com/in/prathmesh-adake-340b17410]

---

## 📄 License

This project is submitted as part of a SQL course assignment. Feel free to use it as a learning reference.
