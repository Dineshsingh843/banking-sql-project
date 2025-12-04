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