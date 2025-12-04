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