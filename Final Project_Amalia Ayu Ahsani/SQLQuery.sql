create database DealershipAutoCar;
use DealershipAutoCar;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address TEXT
);

CREATE TABLE Dealer (
    DealerID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50),
    City varchar(20),
    Region varchar(30)
);

CREATE TABLE SalesPerson (
    SalesPersonID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100),
    Phone VARCHAR(20),
    DealerID INT
);

 CREATE TABLE Car (
    CarID INT PRIMARY KEY IDENTITY,
    Model VARCHAR(50),
    Price DECIMAL(18,2),
    Stock INT,
    DealerID INT,
    FOREIGN KEY (DealerID) REFERENCES Dealer(DealerID)
);

CREATE TABLE ConsultHistory (
    ConsultID INT PRIMARY KEY IDENTITY,
    CustomerID INT,
    SalesPersonID INT,
    Date DATE DEFAULT GETDATE(),
    Notes TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
);

CREATE TABLE TestDrive (
    TestDriveID INT PRIMARY KEY IDENTITY,
    CustomerID INT,
    CarID INT,
    SalesPersonID INT,
    Date DATE,
    Feedback TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
);

CREATE TABLE LOI (
    LOIID INT PRIMARY KEY IDENTITY,
    CustomerID INT,
    CarID INT,
    AgreedPrice DECIMAL(18,2),
    Discount DECIMAL(18,2),
    BookingFee DECIMAL(18,2),
    DownPayment DECIMAL(18,2),
    DateSigned DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

CREATE TABLE Credit (
    CreditID INT PRIMARY KEY IDENTITY,
    CustomerID INT,
    LOIID INT,
    CreditNominal DECIMAL(18,2),
    Tenor INT, -- in months
    InterestRate float,
    MonthlyInstallment DECIMAL(18,2),
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (LOIID) REFERENCES LOI(LOIID)
);

CREATE TABLE SalesTransaction (
    TransactionID INT PRIMARY KEY IDENTITY,
    CustomerID INT,
    CarID INT,
    SalesPersonID INT,
    TransactionDate DATE DEFAULT GETDATE(),
    PaymentMethod VARCHAR(10) CHECK (PaymentMethod IN ('Cash', 'Credit')),
    TotalAmount DECIMAL(18,2),
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
);