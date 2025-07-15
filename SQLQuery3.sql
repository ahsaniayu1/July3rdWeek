--1. Produk dengan ListPrice lebih dari 1000
select Name, ListPrice
from Production.Product
where ListPrice > 1000;

--2. Karyawan yang direkrut setelah 1 Januari 2012
select * from HumanResources.Employee
where HireDate > '2012-01-01';

--3. 10 Produk termahal berdasarkan ListPrice (urutan menurun)
select top 10 Name, ListPrice
from Production.Product
order by ListPrice desc;

--4. Produk dengan nama diawali huruf 'B'
select Name
from Production.Product
where Name like 'B%';
