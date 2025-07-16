-- create database
create database MitsubishiParts;
use MitsubishiParts;

-- create tables
create table PartCategory (
    CategoryID int primary key identity(1,1),
    CategoryName varchar(50) not null
);

create table Part (
    PartNumber int primary key,
    PartName varchar(50) not null,
    CategoryID int not null,
    foreign key (CategoryID) references PartCategory(CategoryID)
);

create table Supplier (
    SupplierID int primary key identity(1,1),
    SupplierName varchar(50) not null,
    Country varchar(30),
);

create table SupplierPartOffer (
    OfferID int primary key identity(1,1),
    PartNumber int not null,
    SupplierID int not null,
    UnitPrice decimal(12, 0) not null,
    LeadTimeDays int not null,       
    Rating int check (Rating between 1 and 5),
    foreign key (PartNumber) references Part(PartNumber),
    foreign key (SupplierID) references Supplier(SupplierID)
);
