create view vw_ActiveProductCatalog as
select
    Name,
    ProductNumber,
    ListPrice,
    SellStartDate
from
    Production.Product
where
    SellEndDate is null;
