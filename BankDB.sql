CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Address TEXT,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    DateOfBirth DATE
);

CREATE TABLE Account (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    AccountType VARCHAR(20) CHECK (AccountType IN ('Savings', 'Current')),
    Balance DECIMAL(15,2) NOT NULL,
    OpenDate DATE NOT NULL,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);

CREATE TABLE BankTransaction (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    TransactionType VARCHAR(20) CHECK (TransactionType IN ('Deposit', 'Withdrawal', 'Transfer')),
    Amount DECIMAL(15,2) NOT NULL,
    Date DATETIME DEFAULT GETDATE(),
    AccountID INT,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID) ON DELETE CASCADE
);

CREATE TABLE Loan (
    LoanID INT PRIMARY KEY IDENTITY(1,1),
    LoanType VARCHAR(20) CHECK (LoanType IN ('Personal', 'Home', 'Car')),
    Amount DECIMAL(15,2) NOT NULL,
    InterestRate DECIMAL(5,2) NOT NULL,
    Duration INT NOT NULL, -- in months
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);

CREATE TABLE Branch (
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    BranchName VARCHAR(100) NOT NULL,
    Location TEXT NOT NULL,
    Manager VARCHAR(100)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(100),
    Salary DECIMAL(10,2) NOT NULL,
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) ON DELETE SET NULL
);

-- Customers
INSERT INTO Customer (Name, Address, Phone, Email, DateOfBirth) VALUES
('Ahmed Hassan', 'Tahrir Street, Cairo', '01012345678', 'ahmed@example.com', '1985-06-15'),
('Fatma Mohamed', 'Ramses Street, Alexandria', '01198765432', 'fatma@example.com', '1990-09-25'),
('Omar Youssef', 'Heliopolis, Cairo', '01234567891', 'omar@example.com', '1988-03-10'),
('Nourhan Ali', 'Nasr City, Cairo', '01098765432', 'nourhan@example.com', '1992-07-22'),
('Hassan Mostafa', 'Dokki, Giza', '01567894561', 'hassan@example.com', '1980-12-05');

-- Branches
INSERT INTO Branch (BranchName, Location, Manager) VALUES
('Main Branch', 'Tahrir Square, Cairo', 'Mohamed El-Sayed'),
('Alexandria Branch', 'Corniche Road, Alexandria', 'Omar Abdelrahman'),
('Giza Branch', 'Mohandessin, Giza', 'Hesham Saeed');

-- Employees
INSERT INTO Employee (Name, Position, Salary, BranchID) VALUES
('Mohamed El-Sayed', 'Manager', 80000, 1),
('Omar Abdelrahman', 'Manager', 75000, 2),
('Ali Mahmoud', 'Clerk', 45000, 1),
('Khaled Nassar', 'Accountant', 50000, 2),
('Laila Hussein', 'Customer Service', 42000, 3);

-- Accounts
INSERT INTO Account (AccountType, Balance, OpenDate, CustomerID) VALUES
('Savings', 5000.00, '2024-01-15', 1),
('Current', 12000.50, '2024-02-10', 2),
('Savings', 2500.75, '2024-03-05', 3),
('Current', 18000.00, '2024-04-08', 4),
('Savings', 7500.00, '2024-05-12', 5);

-- Transactions
INSERT INTO BankTransaction (TransactionType, Amount, AccountID) VALUES
('Deposit', 2000.00, 1),
('Withdrawal', 500.00, 2),
('Deposit', 1500.00, 3),
('Transfer', 3000.00, 4),
('Deposit', 4500.00, 5),
('Withdrawal', 250.00, 1),
('Transfer', 6000.00, 2);

-- Loans
INSERT INTO Loan (LoanType, Amount, InterestRate, Duration, CustomerID) VALUES
('Personal', 10000.00, 5.5, 24, 1),
('Home', 250000.00, 3.8, 240, 2),
('Car', 50000.00, 4.2, 60, 3),
('Personal', 15000.00, 6.0, 36, 4),
('Home', 200000.00, 3.5, 180, 5);

SELECT CustomerID, COUNT(AccountID) AS TotalAccounts 
FROM Account 
GROUP BY CustomerID;

SELECT TransactionType, SUM(Amount) AS TotalAmount 
FROM BankTransaction 
GROUP BY TransactionType;

SELECT LoanType, AVG(Amount) AS AvgLoanAmount 
FROM Loan 
GROUP BY LoanType;

SELECT BranchID, COUNT(EmployeeID) AS EmployeeCount 
FROM Employee 
GROUP BY BranchID;

SELECT AccountID, COUNT(TransactionID) AS TransactionCount 
FROM BankTransaction 
GROUP BY AccountID;