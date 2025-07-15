--5.  Sales orders with customer name, date, and total
select 
    p.FirstName + ' ' + p.LastName as CustomerName,
    o.OrderDate,
    o.TotalDue
from Sales.SalesOrderHeader as o
join Sales.Customer as c on o.CustomerID = c.CustomerID
join Person.Person as p on c.PersonID = p.BusinessEntityID;

--6. Product Name and Subcategory
select
    p.Name as ProductName,
    s.Name as Subcategory
from Production.Product p
join Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID;

--7. Employee Name dan Job Title
select 
    p.FirstName + ' ' + p.LastName as EmployeeName,
    e.JobTitle as JobTitle
from HumanResources.Employee as e
join Person.Person as p on e.BusinessEntityID = p.BusinessEntityID;

--8. Order and Salesperson Name
select
    o.SalesOrderID,
    sp.BusinessEntityID as SalesPersonID,
    p.FirstName + ' ' + p.LastName as SalesPersonName
from Sales.SalesOrderHeader as o
left join Sales.SalesPerson as sp on o.SalesPersonID = sp.BusinessEntityID
left join Person.Person as p on sp.BusinessEntityID = p.BusinessEntityID;

--9. Count Number of Product
select 
    ProductLine,
    count(*) as ProductCount
from Production.Product
group by ProductLine;

--10. Avg ListPrice
select
    ProductSubcategoryID,
    avg(ListPrice) as AveragePrice
from Production.Product
where ProductSubcategoryID is not null
group by ProductSubcategoryID;

--11. Total Employee
select
    JobTitle,
    count(*) as TotalEmployee
from HumanResources.Employee
group by JobTitle;

--12. Order placed per Year
select
    Year(OrderDate) as OrderYear,
    count(*) as OrderPlaced
from Sales.SalesOrderHeader
group by Year(OrderDate)
order by OrderYear;

--13. Sales Amount By Customer
select
    p.FirstName + ' ' + p.LastName as CustomerName,
    sum(o.TotalDue) as TotalSales
from Sales.SalesOrderHeader as o
join Sales.Customer as c on o.CustomerID = c.CustomerID
join Person.Person as p on c.PersonID = p.BusinessEntityID
group by p.FirstName, p.LastName
order by TotalSales;

--14. Order per Salesperson
select
    p.FirstName + ' ' + p.LastName as SalespersonName,
    count(o.SalesOrderID) as TotalOrder
from Sales.SalesPerson as sp
left join HumanResources.Employee as e on sp.BusinessEntityID = e.BusinessEntityID
left join Person.Person as p on e.BusinessEntityID = p.BusinessEntityID
left join Sales.SalesOrderHeader as o on sp.BusinessEntityID = o.SalesPersonID
group by p.FirstName, p.LastName
order by TotalOrder;

--15. Avg Order amount by Year
select
    Year(OrderDate) as OrderYear,
    sum(TotalDue) as OrderAmount
from Sales.SalesOrderHeader
group by Year(OrderDate)
order by OrderYear;

--16. Top 5 Total Sold
select top 5
    p.Name as ProductName,
    sum(od.OrderQty) as QuantitySold
from Sales.SalesOrderDetail as od
join Production.Product as p on od.ProductID = p.ProductID
group by p.Name
order by QuantitySold desc;

--17. 
select 
    ps.Name as Subcategory,
    count(*) as ProductCount
from Production.Product as p
join Production.ProductSubcategory as ps on p.ProductSubcategoryID = ps.ProductSubcategoryID
where p.ListPrice > 500
group by ps.Name
order by ProductCount;

--18.
select top 1
    p.FirstName + ' ' + p.LastName as SalespersonName,
    count(o.SalesOrderID) as TotalOrder
from Sales.SalesOrderHeader as o
join Sales.SalesPerson as sp on o.SalesPersonID = sp.BusinessEntityID
join Person.Person as p on sp.BusinessEntityID = p.BusinessEntityID
group by p.FirstName, p.LastName
order by TotalOrder desc;
