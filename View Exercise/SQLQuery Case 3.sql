create view vw_SalesOrderSummary as
select 
	o.SalesOrderID as OrderID,
	o.OrderDate,
	p.FirstName + ' ' + isnull(p.MiddleName + ' ', '') + p.LastName as FullName,
	o.TotalDue
from
	Sales.SalesOrderHeader as o
	join Sales.Customer c on o.CustomerID=c.CustomerID
	join Person.Person p on o.CustomerID=p.BusinessEntityID;
