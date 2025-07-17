use AdventureWorks2022;

drop view if exists vw_ProductPricingByCategory;

create view vw_ProductPricingByCategory
as
select
	pp.Name as ProductName,
	ps.Name as SubcategoryName,
	pc.Name as CategoryName,
	pp.ListPrice
from
Production.ProductSubcategory ps
join Production.Product pp on ps.ProductSubcategoryID=pp.ProductSubcategoryID
join Production.ProductCategory pc on ps.ProductCategoryID=pc.ProductCategoryID

where pp.ListPrice>0;

select * from vw_ProductPricingByCategory
order by CategoryName, SubcategoryName, ProductName;
