Create Database bank_db;
Use bank_db;
Create table branches(branch_id INT PRIMARY KEY,branch_name VARCHAR(100),city VARCHAR(50));

Create table customers (customer_id INT PRIMARY KEY,customer_name VARCHAR(100),phone VARCHAR(15),city VARCHAR(50));

Create table accounts(account_id INT PRIMARY KEY,customer_id INT,branch_id INT,account_type ENUM('SAVINGS', 'CURRENT', 'FD'),
balance DECIMAL(12,2),open_date DATE,status ENUM('ACTIVE', 'CLOSED') DEFAULT 'ACTIVE',FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (branch_id) REFERENCES branches(branch_id));

Create table transactions(txn_id INT PRIMARY KEY,account_id INT,txn_date DATE,txn_type ENUM('DEPOSIT', 'WITHDRAWAL', 'TRANSFER'),
amount DECIMAL(12,2),description VARCHAR(255),FOREIGN KEY (account_id) REFERENCES accounts(account_id));

Create table loans(loan_id INT PRIMARY KEY,customer_id INT,branch_id INT,loan_type ENUM('HOME', 'PERSONAL', 'CAR'),loan_amount DECIMAL(12,2),
interest_rate DECIMAL(5,2),start_date DATE,status ENUM('ONGOING', 'CLOSED', 'DEFAULTED') DEFAULT 'ONGOING',FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (branch_id) REFERENCES branches(branch_id));

INSERT INTO branches (branch_id, branch_name, city) VALUES
(1, 'MG Road Branch', 'Bengaluru'),
(2, 'Andheri West Branch', 'Mumbai'),
(3, 'Anna Nagar Branch', 'Chennai');
INSERT INTO customers (customer_id, customer_name, phone, city) VALUES
(101, 'Rahul Sharma', '9876543210', 'Bengaluru'),
(102, 'Priya Singh', '9876501234', 'Mumbai'),
(103, 'Amit Verma', '9867001122', 'Chennai'),
(104, 'Sneha Rao', '9812345678', 'Bengaluru'),
(105, 'John David', '9822334455', 'Mumbai');
INSERT INTO accounts (account_id, customer_id, branch_id, account_type, balance, open_date, status) VALUES
(1001, 101, 1, 'SAVINGS', 25000.00, '2023-01-10', 'ACTIVE'),
(1002, 101, 1, 'CURRENT', 80000.00, '2022-10-05', 'ACTIVE'),
(1003, 102, 2, 'SAVINGS', 15000.00, '2023-03-15', 'ACTIVE'),
(1004, 103, 3, 'FD',      200000.00, '2022-06-01', 'ACTIVE'),
(1005, 104, 1, 'SAVINGS', 5000.00, '2024-01-20', 'ACTIVE'),
(1006, 105, 2, 'SAVINGS', 120000.00, '2021-11-11', 'CLOSED');
INSERT INTO transactions (txn_id, account_id, txn_date, txn_type, amount, description) VALUES
(1, 1001, '2024-01-01', 'DEPOSIT',    10000.00, 'Salary credit'),
(2, 1001, '2024-01-05', 'WITHDRAWAL',  2000.00, 'ATM withdrawal'),
(3, 1002, '2024-01-07', 'DEPOSIT',    30000.00, 'Client payment'),
(4, 1003, '2024-01-10', 'WITHDRAWAL',  5000.00, 'Online shopping'),
(5, 1004, '2024-01-12', 'DEPOSIT',    20000.00, 'FD renewal'),
(6, 1005, '2024-01-15', 'DEPOSIT',     3000.00, 'Cash deposit'),
(7, 1006, '2023-12-20', 'WITHDRAWAL', 100000.00, 'Closure withdrawal');
INSERT INTO loans (loan_id, customer_id, branch_id, loan_type, loan_amount, interest_rate, start_date, status) VALUES
(501, 101, 1, 'HOME',     5000000.00, 8.25, '2022-05-01', 'ONGOING'),
(502, 102, 2, 'PERSONAL',  300000.00, 12.50, '2023-02-10', 'ONGOING'),
(503, 103, 3, 'CAR',       800000.00, 9.75, '2021-09-15', 'CLOSED'),
(504, 105, 2, 'HOME',     6000000.00, 8.00, '2020-01-01', 'DEFAULTED');
-- Show all customers
SELECT * FROM customers; 
-- Show all accounts with balance greater than 20,000
SELECT * FROM accounts WHERE balance > 20000;
-- List accounts which are CLOSED
SELECT * FROM accounts WHERE status = 'CLOSED';
-- Show all customers who live in Bengaluru.
SELECT * FROM customers WHERE city = 'Bengaluru';
-- Show customer name, phone of customers in Mumbai.
SELECT customer_name, phone FROM customers WHERE city = 'Mumbai';
-- Show all accounts sorted by balance descending.
SELECT * FROM accounts ORDER BY balance DESC;
-- Show top 3 accounts with highest balance.
SELECT * FROM accounts ORDER BY balance DESC LIMIT 3;
-- Show transactions for account 1001 sorted by date (latest first).
SELECT * FROM transactions WHERE account_id = 1001 ORDER BY txn_date DESC;
-- Find total number of accounts in each branch.
SELECT branch_id, COUNT(*) AS total_accounts FROM accounts GROUP BY branch_id;
-- find total number of accounts in each branch along with branch name
SELECT b.branch_name, COUNT(a.account_id) AS total_accounts FROM branches b
LEFT JOIN accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_id, b.branch_name;
-- Find average balance of SAVINGS accounts.
SELECT AVG(balance) AS avg_savings_balance FROM accounts WHERE account_type = 'SAVINGS';
-- Find total deposit amount per account.
SELECT account_id,SUM(amount) AS total_deposit FROM transactions WHERE txn_type = 'DEPOSIT' GROUP BY account_id;
-- Count how many customers are in each city.
SELECT city,COUNT(*) AS total_customers FROM customers GROUP BY city;
-- Show customer name, account_id, account_type, balance for all accounts.
SELECT c.customer_name,a.account_id,a.account_type,a.balance FROM customers c JOIN accounts a ON c.customer_id = a.customer_id;
-- Show customer_name, branch_name, city, account_type, balance.
SELECT c.customer_name,b.branch_name,b.city,a.account_type,a.balance FROM customers c JOIN accounts a ON c.customer_id = a.customer_id
JOIN branches b ON a.branch_id = b.branch_id;
-- Show customer_name, loan_type, loan_amount, status of all loans.
SELECT c.customer_name,l.loan_type,l.loan_amount,l.status FROM loans l JOIN customers c ON l.customer_id = c.customer_id;
-- Show branch_name and total loan amount given by each branch.
SELECT b.branch_name,SUM(l.loan_amount) AS total_loan_amount FROM branches b JOIN loans l ON b.branch_id = l.branch_id
GROUP BY b.branch_id, b.branch_name;
-- Show all customers who have SAVINGS account with balance < 10,000.
SELECT DISTINCT c.customer_id,c.customer_name,c.phone,c.city FROM customers c JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_type = 'SAVINGS' AND a.balance < 10000;
-- Show all customers who have taken a HOME loan.
SELECT DISTINCT c.customer_id,c.customer_name,c.phone,c.city FROM customers c JOIN loans l ON c.customer_id = l.customer_id
WHERE l.loan_type = 'HOME';
-- Show customers who have both an account in Bengaluru branch and a loan.
SELECT DISTINCT c.customer_id,c.customer_name,c.phone,c.city FROM customers c JOIN accounts a ON c.customer_id = a.customer_id
JOIN branches b ON a.branch_id = b.branch_id JOIN loans l ON c.customer_id = l.customer_id WHERE b.city = 'Bengaluru';
-- Show branch wise: branch_name, number of accounts, number of loans.
SELECT b.branch_id,b.branch_name,COUNT(DISTINCT a.account_id) AS total_accounts,COUNT(DISTINCT l.loan_id) AS total_loans FROM branches b 
LEFT JOIN accounts a ON b.branch_id = a.branch_id LEFT JOIN loans l ON b.branch_id = l.branch_id GROUP BY b.branch_id, b.branch_name;
-- Customers who have balance greater than the average SAVINGS balance.
SELECT DISTINCT c.customer_id,c.customer_name,c.phone,c.city FROM customers c JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.balance > (SELECT AVG(balance)FROM accounts WHERE account_type = 'SAVINGS');
-- Accounts that have never done any transaction.
SELECT * FROM accounts a WHERE NOT EXISTS (SELECT 1 FROM transactions t WHERE t.account_id = a.account_id);
-- Customer with the highest loan amount.
SELECT c.customer_id,c.customer_name,l.loan_id,l.loan_amount FROM loans l JOIN customers c ON l.customer_id = c.customer_id
ORDER BY l.loan_amount DESC LIMIT 1;
-- Loan details of customers who live in the same city as their branch.
SELECT l.loan_id,c.customer_name,b.branch_name,c.city,l.loan_type,l.loan_amount,l.status FROM loans l JOIN customers c
ON l.customer_id = c.customer_id JOIN branches b ON l.branch_id = b.branch_id WHERE c.city = b.city;
-- Branches that have no loans.
SELECT b.branch_id,b.branch_name,b.city FROM branches b LEFT JOIN loans l ON b.branch_id = l.branch_id WHERE l.loan_id IS NULL;









