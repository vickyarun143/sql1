insert into dbo.Categories values,N,'vitamins',null,null);
select * from dbo.Categories where  CategoryName='vitamins'
--cause error
--must provide list of columns or null values in thr value cause

insert into dbo.Categories values (N'vitamins')  --error 
--suppresing the return of rows affected 
set nocount on;
insert into dbo.Categories(CategoryName) values('vitamins')
set nocount off;

--rows affected may cause problems when used with data adapter,which assume that no row in affected if no row count in returned
--retriving the new identity column value

select @@IDENTITY as newcategoryid

--@@identity find in a globel transact sql for that
select SCOPE_IDENTITY() as newcategoryid;

select IDENT_CURRENT('dbo.categories') as newcategoryid;

--inserting multiple values and dealing with delimeters
insert into.dbo.Products(ProductName,CategoryID,UnitPrice,QuantityPerUnit,Discontinued) values 
('pure''sunine''range juice',1,6.6,9,0)

select * from Products where UnitPrice=6.6

--notice use of two '' to insert a single into the table column
--insert multiple rows
--first create table insert into 

create table dbo.baverages(productid int not null,productname nvarchar(50),supplierid int not null,categoryid int null,Quantityperunit nvarchar(50),unitprice money null,unitstock smallint null,unitsonorder smallint null,reorderlevel smallint null,discontinued bit not null);
select * from baverages

--now insert into using a select cause
insert into baverages
select productid,productname,supplierid,categoryid,Quantityperunit,unitprice,UnitsInStock,unitsonorder,reorderlevel,discontinued from dbo.Products where products.CategoryID=1

select * from baverages

--or you can include the field
insert into dbo.baverages(productid,productname,supplierid,categoryid,Quantityperunit,unitprice,unitstock,unitsonorder,reorderlevel,discontinued)
select productid,productname,supplierid,categoryid,Quantityperunit,unitprice,UnitsInStock,unitsonorder,reorderlevel,discontinued from dbo.Products where Products.CategoryID=1

--inserting multiple rows  with multiple insert statements
--using a row constriuctor in 2008
--limit for rows constructor is 1000 rows at a 

insert into dbo.baverages([productid],Quantityperunit,unitprice,unitstock,discontinued)values(25,'lemon',12,56,23,0),
(25,'cofee',3,54,28,0),(25,'juice',12,56,23,0)
go

--here you cant use diff field list for diff rows
--you can also create a new table using the select into statement
--it creater the distinatio table (dbo.products) and inserts data into it

select dbo.Products.* into dbo.produce from dbo.Products where CategoryID=7;
select * from produce


--you can crate a table once so you cannot re excure the above statement


select dbo.Products.* into #produce from dbo.Products where CategoryID=7;
--select data from temp table
select * from #produce

--insert into #beverages 
select dbo.Categories.*into #bevarages from dbo.Categories where CategoryID=1
select * from #bevarages



--creating globel temp table
create table ##categories(categoryid int not null primary key clustered,categoryname varchar(255));
--inserting with output
--create table to insert to
create table dbo.condiments(productid int identity(1,1) not null primary key clustered,productname nvarchar(50) not null);
go
--here we declare in variable which is an in memory table that a structure 
--create table variable

declare @newvalues table(productid int not null,productname nvarchar(40))



--dont excute the above statement seperatly 
--insert values from products and capture new identity values

insert into dbo.condiments(productname)
output inserted.productid,inserted.productname
into @newvalues
select productname from dbo.Products where CategoryID=2;
--using bulk insert
--create a table to bulk insert into
create table dbo.newproducts(productid int not null,productname nvarchar(50) not null,unitprice money null);

bulk insert Northwind.dbo.newproducts
from 'c:\data\products.txt' --using path according user define
with (FIELDTERMINATOR='\t',ROWTERMINATOR='\n');