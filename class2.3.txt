select * from Employees
select * from Northwind.dbo.Employees 
use Northwind;
go
select firstname,lastname from dbo.employees
select * from dbo.Employees


--join two names
select lastname +'-'+ firstname from dbo.Employees

--Aliasing column names
select lastname+ ','+firstname As[fullname]from dbo.Employees

--As in optional
select lastname+','+firstname fullname from dbo.Employees

--Another aliasing option
select fullname=lastname+','+firstname from dbo.Employees

--this is depricated
select 'fullname'=lastname+','+firstname from dbo.employees;

--Select and Select distinct
select Title from dbo.employees
select distinct title from dbo.Employees

--where
select companyname,city
from dbo.Customers
where city ='paris';

select * from customers

select companyname,country
from dbo.Customers
where country='Mexico'

--like and wildcard characters
select companyname
from dbo.customers
where companyname LIKE 'r%'; 

--matching single characters
select customerid
from dbo.Customers
where customerid like 'B___P';
 
--matching  from a list
select CustomerID
from dbo.customers
where customerid like 'fran[RK]';

select CustomerID
from dbo.customers
where customerid like 'fran[A_S]';


select CustomerID
from dbo.customers
where customerid like 'fran[^R]';

--between

select 'fullname'=lastname+','+firstname ,postalcode
from dbo.Employees
where postalcode BETWEEN '98103' AND '98999'


--testing for null
select firstname,lastname,region
from dbo.Employees
where region is null;

--three level logic



