-- Create the database
create database MitsubishiCarRental;
use MitsubishiCarRental;

-- RentalBranch table
create table RentalBranch (
    BranchID int primary key identity(1,1),
    BranchName varchar(50) not null,
    City varchar(50),
    Country varchar(50)
);

-- Employee table
create table Employee (
    EmployeeID int primary key identity(1,1),
    FullName varchar(50) not null,
    Position varchar(50),
    BranchID int not null,
    foreign key (BranchID) references RentalBranch(BranchID)
);

-- Customer table
create table Customer (
    CustomerID int primary key identity(1,1),
    FullName varchar(50) not null,
    Email varchar(50),
    PhoneNumber varchar(20)
);

-- Vehicle table
create table Vehicle (
    VehicleID int primary key identity(1,1),
    BranchID int not null,
    Make varchar(50) not null,
    Model varchar(50) not null,
    Year int not null,
    LicensePlate varchar(20) unique not null,
    Mileage int not null,
    Status varchar(20) not null check (Status in ('Available', 'Rented', 'Maintenance')),
    foreign key (BranchID) references RentalBranch(BranchID)
);

-- RentalContract table
create table RentalContract (
    ContractID int primary key identity(1,1),
    CustomerID int not null,
    VehicleID int not null,
    EmployeeID int not null,
    StartDate date not null,
    EndDate date not null,
    TotalDays int not null,
    DailyRate decimal(12,0) not null,
    foreign key (CustomerID) references Customer(CustomerID),
    foreign key (VehicleID) references Vehicle(VehicleID),
    foreign key (EmployeeID) references Employee(EmployeeID)
);
