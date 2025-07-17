create view vw_EmployeeDirectory
as
select
    p.FirstName + ' ' + isnull(p.MiddleName + ' ', '') + p.LastName as FullName,
    ea.EmailAddress,
    e.JobTitle
from
    HumanResources.Employee e
    join Person.Person p on e.BusinessEntityID = p.BusinessEntityID
    join Person.EmailAddress ea on p.BusinessEntityID = ea.BusinessEntityID
