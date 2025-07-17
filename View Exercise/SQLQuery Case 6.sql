create view vw_SalespersonPerformance
as

select
    p.FirstName + ' ' + isnull(p.MiddleName + ' ', '') + p.LastName as FullName,
    count(o.SalesOrderID) as OrderCount,
    sum(o.TotalDue) as TotalSales
from
    Sales.SalesOrderHeader o
    join Sales.SalesPerson sp on o.SalesPersonID = sp.BusinessEntityID
    join Person.Person p on sp.BusinessEntityID = p.BusinessEntityID
where
    o.SalesPersonID is not null
group by (p.FirstName + ' ' + isnull(p.MiddleName + ' ', '') + p.LastName)
