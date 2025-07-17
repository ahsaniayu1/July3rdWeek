create database MitsubishiCampaign;
use MitsubishiCampaign;

create table CarModel (
    CarModelID int primary key identity(1,1),
    ModelName varchar(100) not null,
    Year int not null
);

create table Dealer (
    DealerID int primary key identity(1,1),
    DealerName varchar(100) not null,
    Region varchar(50)
);

create table PromotionCampaign (
    CampaignID int primary key identity(1,1),
    CampaignName varchar(100) not null,
    StartDate date not null,
    EndDate date not null,
    DiscountPercent decimal(5,2) not null,
    Region varchar(50) not null
);

create table CampaignModel (
    CampaignModelID int primary key identity(1,1),
    CampaignID int not null,
    CarModelID int not null,
    foreign key (CampaignID) references PromotionCampaign(CampaignID),
    foreign key (CarModelID) references CarModel(CarModelID)
);

create table CampaignDealer (
    CampaignDealerID int primary key identity(1,1),
    CampaignID int not null,
    DealerID int not null,
    foreign key (CampaignID) references PromotionCampaign(CampaignID),
    foreign key (DealerID) references Dealer(DealerID)
);

create table CustomerBenefit (
    BenefitID int primary key identity(1,1),
    CustomerName varchar(100) not null,
    CarModelID int not null,
    CampaignID int not null,
    EligibleDate date not null,
    foreign key (CarModelID) references CarModel(CarModelID),
    foreign key (CampaignID) references PromotionCampaign(CampaignID)
);
