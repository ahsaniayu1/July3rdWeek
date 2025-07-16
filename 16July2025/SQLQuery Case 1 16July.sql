-- create and use the database
create database MitsubishiVehicleTesting;
use MitsubishiVehicleTesting;

-- create tables
create table CarModel (
    CarModelID int primary key identity(1,1),
    ModelName varchar(50) not null,
    ModelYear int not null,
    EngineType varchar(50)
);

create table PrototypeVehicle (
    PrototypeID int primary key identity(1,1),
    CarModelID int not null,
    BuildDate date not null,
    foreign key (CarModelID) references CarModel(CarModelID)
);

create table TestEngineer (
    EngineerID int primary key identity(1,1),
    FullName varchar(50) not null,
    Email varchar(50) unique,
    PhoneNumber varchar(20)
);

create table TestLocation (
    LocationID int primary key identity(1,1),
    LocationName varchar(50) not null,
    City varchar(50),
    Country varchar(30)
);

create table VehicleTest (
    TestID int primary key identity(1,1),
    PrototypeID int not null,
    EngineerID int not null,
    LocationID int not null,
    TestDate date not null,
    TestType varchar(50) not null,
    TestResult varchar(5) not null check (TestResult in ('Pass', 'Fail')),
    Notes text,
    foreign key (PrototypeID) references PrototypeVehicle(PrototypeID),
    foreign key (EngineerID) references TestEngineer(EngineerID),
    foreign key (LocationID) references TestLocation(LocationID)
);
