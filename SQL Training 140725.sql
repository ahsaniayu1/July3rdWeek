---Case 1
create table Plant (
    PlantID int identity(1,1) primary key,
    PlantName varchar(100) not null,
    City varchar(100) not null,
    Country varchar(100) not null,
    TotalArea int not null,
    StartYear int not null
);

---Case 2
create table CarModel (
    ModelID int identity(1,1) primary key,
    ModelName varchar(100) not null,
    CarType varchar(50) not null,
    EngineCapacity decimal(4,1) not null,
    LaunchYear int not null,
    FuelType varchar(20) not null
);

---Case 3
create table ProductionPlan (
    PlanID int identity(1,1) primary key,
    PlanName varchar(100) not null,
    PlanMonth int not null,
    PlanYear int not null,
    TargetUnits int not null,
    Notes varchar(500)
);

---Case 4
create table Dealer (
    DealerID int identity(1,1) primary key,
    DealerName varchar(100) not null,
    City varchar(100) not null,
    Province varchar(100) not null,
    PhoneNumber varchar(20) not null,
    StartYear int not null
);

---Case 5
create table CarSale (
    SaleID int identity(1,1) primary key,
    BuyerName varchar(100) not null,
    ModelID int not null,
    SaleDate date not null,
    SalePrice decimal(18,2) not null,
    PaymentType varchar(20) not null check (PaymentType in ('Full', 'Credit'))
);

---Case 6
create table MaintenanceLog (
    LogID int identity(1,1) primary key,
    CustomerName varchar(100) not null,
    ModelID int not null,
    ServiceDate date not null,
    ServiceType varchar(100) not null,
    ServiceCenterName varchar(100) not null,
    ServiceCost decimal(18,2) not null,
    ServiceNotes varchar(500)
);

---Case 7
create table PartInventory (
    PartID int identity(1,1) primary key,
    PartName varchar(100) not null,
    PartNumber varchar(50) not null,
    PartCategory varchar(50) not null,
    StockQuantity int not null,
    UnitPrice decimal(18,2) not null,
    IsActive bit not null
);

---Case 8
create table CustomerFeedback (
    FeedbackID int identity(1,1) primary key,
    CustomerName varchar(100) not null,
    ModelID int not null,
    FeedbackDate date not null,
    SatisfactionRating int not null check (SatisfactionRating between 1 and 5),
    Comments varchar(1000)
);
