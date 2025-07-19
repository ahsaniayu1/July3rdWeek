-- Create Database
CREATE DATABASE AutoCar;
GO

USE AutoCar;
GO

-- Customer Table
CREATE TABLE Customer (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(30) NOT NULL,
    CardID VARCHAR(30) NOT NULL,
    Address TEXT,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(30)
);

-- Car Table
CREATE TABLE Car (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Model VARCHAR(50) NOT NULL,
    Type VARCHAR(20),
    BasePrice DECIMAL(18,2),
    Color VARCHAR(20)
);

-- Dealer Table
CREATE TABLE Dealer (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    City VARCHAR(50),
    PhoneNumber VARCHAR(20)
);

-- DealerCar Junction Table
CREATE TABLE DealerCar (
    ID INT PRIMARY KEY IDENTITY(1,1),
    DealerID INT NOT NULL,
    CarID INT NOT NULL,
    LocalPrice DECIMAL(18,2),
    TaxRate DECIMAL(5,2),
    Stock INT DEFAULT 1,

    FOREIGN KEY (DealerID) REFERENCES Dealer(ID),
    FOREIGN KEY (CarID) REFERENCES Car(ID)
);

-- SalesPerson Table
CREATE TABLE SalesPerson (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(50)
);

-- Consultation History
CREATE TABLE ConsultHistory (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    DealerID INT NOT NULL,
    SalesPersonID INT NOT NULL,
    CarID INT,
    Budget DECIMAL(18,2),
    Date DATE DEFAULT GETDATE(),
    Note TEXT,

    FOREIGN KEY (CustomerID) REFERENCES Customer(ID),
    FOREIGN KEY (DealerID) REFERENCES Dealer(ID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(ID),
    FOREIGN KEY (CarID) REFERENCES Car(ID)
);

-- Test Drive
CREATE TABLE TestDrive (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    DealerID INT NOT NULL,
    SalesPersonID INT NOT NULL,
    CarID INT NOT NULL,
    Date DATE DEFAULT GETDATE(),
    Feedback TEXT,

    FOREIGN KEY (CustomerID) REFERENCES Customer(ID),
    FOREIGN KEY (DealerID) REFERENCES Dealer(ID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(ID),
    FOREIGN KEY (CarID) REFERENCES Car(ID)
);

-- Letter of Intent (LOI)
CREATE TABLE LetterOfIntent (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    SalesPersonID INT,
    PaymentMethod VARCHAR(10) CHECK (PaymentMethod IN ('Cash', 'Credit', 'Transfer')),
    DateSigned DATE DEFAULT GETDATE(),

    FOREIGN KEY (CustomerID) REFERENCES Customer(ID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(ID)
);

-- LOI Car Table
CREATE TABLE LOICar (
    ID INT PRIMARY KEY IDENTITY(1,1),
    LOIID INT NOT NULL,
    DealerCarID INT NOT NULL,
    ProposedPrice DECIMAL(18,2),

    FOREIGN KEY (LOIID) REFERENCES LetterOfIntent(ID),
    FOREIGN KEY (DealerCarID) REFERENCES DealerCar(ID)
);

-- Agreement Table
CREATE TABLE Agreement (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    DealerCarID INT NOT NULL,
    SalesPersonID INT,
    LoiID INT NOT NULL,
    Date DATE DEFAULT GETDATE(),
    DeliveryDate DATE NULL,

    FOREIGN KEY (CustomerID) REFERENCES Customer(ID),
    FOREIGN KEY (DealerCarID) REFERENCES DealerCar(ID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(ID),
    FOREIGN KEY (LoiID) REFERENCES LetterOfIntent(ID)
);

-- Credit Table
CREATE TABLE Credit (
    ID INT PRIMARY KEY IDENTITY(1,1),
    AgreementID INT NOT NULL UNIQUE,
    CreditAmount DECIMAL(18,2) NOT NULL,
    Tenor INT,
    InterestRate DECIMAL(5,2) NOT NULL,
    MonthlyPaymentAmount DECIMAL(18,2) NOT NULL,
    CreditStatus VARCHAR(20) CHECK (CreditStatus IN ('Smooth', 'Late', 'Default')),
    PaidFully BIT NOT NULL,

    FOREIGN KEY (AgreementID) REFERENCES Agreement(ID)
);

-- Payment History Table
CREATE TABLE PaymentHistory (
    ID INT PRIMARY KEY IDENTITY(1,1),
    AgreementID INT NOT NULL,
    CreditID INT,
    Amount DECIMAL(18,2) NOT NULL,
    PaymentNumber INT,
    Date DATE DEFAULT GETDATE(),

    FOREIGN KEY (AgreementID) REFERENCES Agreement(ID),
    FOREIGN KEY (CreditID) REFERENCES Credit(ID)
);

-- Warranty Table
CREATE TABLE Warranty (
    ID INT PRIMARY KEY IDENTITY(1,1),
    AgreementID INT NOT NULL UNIQUE,  -- one warranty per purchase
    WarrantyProvider VARCHAR(50),
    StartDate DATE NOT NULL DEFAULT GETDATE(),
    EndDate DATE NOT NULL,
    CoverageDetails TEXT,

    FOREIGN KEY (AgreementID) REFERENCES Agreement(ID)
);
