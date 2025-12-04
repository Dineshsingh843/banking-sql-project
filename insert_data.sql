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