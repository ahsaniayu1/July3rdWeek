create view vw_FrequentCustomers
as
select
    p.FirstName + ' ' + isnull(p.MiddleName + ' ', '') + p.LastName as FullName,
    count(o.SalesOrderID) as OrderCount
from
    Sales.SalesOrderHeader o
    join Sales.Customer c on o.CustomerID = c.CustomerID
    join Person.Person p on c.PersonID = p.BusinessEntityID
group by
    p.FirstName,
    p.MiddleName,
    p.LastName
having
    count(o.SalesOrderID) > 3;