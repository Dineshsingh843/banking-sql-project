This project is a complete MySQL-based Banking Database System that includes database schema creation, sample data insertion, and 30+ SQL queries for analysis.
The project covers realistic banking operations such as customers, accounts, transactions, branches, and loans.
**1. Database Schema Overview**
The project creates a fully relational SQL database containing the following tables:
branches
customers
accounts
transactions
loans
Each table includes proper PRIMARY KEY, FOREIGN KEY, ENUM, and DECIMAL constraints.
**2. Files Included in This Project**
File_Name	                         Description
banking_project.sql	               Full project (schema + insert data + 30 SQL queries)
schema.sql	                       Contains only the CREATE TABLE statements
insert_data.sql	                   Contains all INSERT INTO statements
queries.sql	                       Contains all SQL queries used for analysis
Project_Report.docx	               Full documentation of the project
README.md	                         GitHub project description

**3. SQL Schema (DDL)**
The SQL file contains schema creation for all tables.
CREATE DATABASE bank_db;
USE bank_db;

CREATE TABLE branches(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50)
);
(Full schema available in banking_project.sql)

**4. Insert Sample Data (DML)**
uploaded SQL contains full sample data for branches, customers, accounts, transactions, and loans.

INSERT INTO branches (branch_id, branch_name, city) VALUES
(1, 'MG Road Branch', 'Bengaluru'),
(2, 'Andheri West Branch', 'Mumbai'),
(3, 'Anna Nagar Branch', 'Chennai');

**5. Queries Included**
**Basic Queries**
SELECT * FROM customers;
SELECT * FROM accounts WHERE balance > 20000;

**JOIN Queries**
SELECT c.customer_name, a.account_id, a.balance FROM customers c JOIN accounts a ON c.customer_id = a.customer_id;

**Aggregation Queries**
SELECT branch_id, COUNT(*) AS total_accounts FROM accounts GROUP BY branch_id;

**Subqueries**
SELECT DISTINCT c.customer_id, c.customer_name FROM customers c JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.balance > (SELECT AVG(balance) FROM accounts WHERE account_type='SAVINGS');

**6. ER Diagram (Conceptual Description)**
Customers ↔ Accounts (One-to-Many)
Branches ↔ Accounts (One-to-Many)
Customers ↔ Loans (One-to-Many)
Accounts ↔ Transactions (One-to-Many)
This structure models real banking workflows.

**7. How to Run This Project**
*Open MySQL Workbench
*Run:source banking_project.sql;
-This creates tables
-Inserts data
-Runs queries

Or run each section individually:
-source schema.sql;
-source insert_data.sql;
-source queries.sql;

**8. Skills Demonstrated**
SQL DDL & DML
Database modeling
Joins, Group By, Subqueries
Analytical SQL
MySQL Workbench
Project documentation
GitHub project structure

**9. Author**
Dinesh Singh

**10. Support**
If you like this project, please ⭐ star the repository!
It helps others discover the project too.
