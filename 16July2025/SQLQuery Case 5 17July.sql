create database MitsubishiWarranty;
use database MitsubishiWarranty;

create table Customer (
    CustomerID int identity(1,1) primary key,
    Name varchar(50),
    Email varchar(50),
    Phone varchar(20),
    Address text
);

create table Car (
    VIN varchar(20) primary key,
    Model varchar(50),
    PurchaseDate date,
    CustomerID int foreign key references Customer(CustomerID)
);

create table WarrantyRegistration (
    WarrantyID int identity(1,1) primary key,
    VIN varchar(20) unique foreign key references Car(VIN),
    WarrantyStartDate date,
    WarrantyEndDate date
);

create table WarrantyClaim (
    ClaimID int identity(1,1) primary key,
    WarrantyID int foreign key references WarrantyRegistration(WarrantyID),
    IssueReported text,
    RepairDate date,
    RepairCost decimal(12, 1),
    ClaimStatus varchar(20),
    ServiceCenter varchar(50)
);
