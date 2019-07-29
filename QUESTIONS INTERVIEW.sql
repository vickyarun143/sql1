select * from Orders
--1 .Find the second costliest product

select  max(unitprice)
from dbo.Products
where unitprice<(select max(unitprice) from dbo.Products)

--n no of costliest product
with result as
(
select unitprice,DENSE_RANK() over (order by unitprice desc) as DENSERANK
from dbo.Products
)
select top 2 UnitPrice
from result
where result.DENSERANK=3 


 ---product name 
SELECT max(unitprice),Productname
FROM dbo.Products
GROUP BY ProductName,UnitPrice 
having UnitPrice <(select max(unitprice) from dbo.Products) 
ORDER BY unitprice DESC;

---List out all orders with total cost higher than average total cost
select max(unitprice*quantity) as amount,OrderID
 from [Order Details]
group by OrderID,max(unitprice* quantity)
having  max(unitprice*quantity)>(select max(unitprice*quantity) from dbo.[Order Details])
order by max(UnitPrice*Quantity)
--2 without using like operator
select * from Customers where CHARINDEX('S',ContactName)=3

--3.List out all the customers and the count of the orders that they made
select Customerid,count(*) as numorders
from dbo.Orders
group by CustomerID
order by numorders desc,CustomerID

--3.	Find the customer with the highest number of orders


select  Customerid,count(*) as numorders
from dbo.Orders
group by CustomerID
order by numorders desc,CustomerID


 



select OrderID ,count(*) discount
from dbo.Orders
group  by OrderID
order by discount desc ,CustomerID 



--7.	Find the supplier who supplies the highest number of products

select TOP 5  SupplierID,count(*) as productsupplies
from dbo.Products
group by SupplierID
order by productsupplies desc,SupplierID


--- 8 Which category has the highest number of products
select * from Categories
select * from Products

select top 1 categoryname
from dbo.Categories
join Products
on Categories.CategoryID=Products.ProductID
group by CategoryName
order by count(*) desc


select * from Orders

select * from region
select * from Customers

select max(region)
from dbo.Customers

---11---List all the regions and the count of customers from that region
select Region,count(customerid) as NUM_customers
from dbo.Customers
group by region
order by NUM_customers
 



 --01. Find the second costliest product--
 select top 1 productname,unitprice from(select top 2 productname,UnitPrice from products order by UnitPrice desc)as my_table order by UnitPrice asc 
--02. List out all the customers and the count of the orders that they made-- 
select customerid,count(OrderID) as num_orders from Orders group by customerid order by num_orders desc
 --03. Find the customer with the highest number of orders-- 
select top 1 customerid,count(OrderID) as num_orders from Orders group by customerid order by num_orders desc 
--04. Find the customer with the second highest numbers of orders--
 select top 1 customerid from(select top 2 CustomerID,count(OrderID) as num_orders from Orders group by customerid order by num_orders desc) as my_table order by num_orders asc 
--05. Find the order with highest number of items--.
 select orderid,count(productid) as high_items from [Order Details] group by OrderID 
-07. --Find the supplier who supplies the highest number of products. -- 
select top 1 supplierid,count(productid) as high_products from products group by SupplierID order by high_products desc 
--08. Which category has the highest number of products-- 
select top 1 categoryid,count(productid) as high_products from Products group by CategoryID order by high_products desc
 --10. From which region do we have the highest number of customers-- 
select top 1 Region,count(customerid) as Num_customers from Customers group by Region order by Num_customers desc 
--11.-- List all the regions and the count of customers from that region--
 select Region,count(customerid) as Num_customers from Customers group by Region order by Num_customers
 --12--	List all the regions and the count of all suppliers from that region
select * from Suppliers
select Region,count( ContactName) as num_sup   from Suppliers group by Region order by num_sup

--13.	--List out all orders that were delivered before the requested date?
select * from Orders
select  OrderID,CustomerID,employeeid from Orders where ShippedDate<requireddate order by CustomerID,EmployeeID
--14.	--Which customer received the highest discount?
select * from [Order Details]

select  top 1 d1.orderid,Discount ,d2.CustomerID
from [Order Details] d1
join Orders d2
on d1.OrderID=d2.OrderID
order by Discount desc


--15.	Which order contains the highest quantity for a single product?


select  p1.orderID,Quantity,p2.CustomerID 
from dbo.[Order Details] p1
join Orders p2
on p1.OrderID=p2.OrderID
order by Quantity desc




--16.--	List out all orders with total cost higher than average total cost.--
select * from [Order Details] 

select * from(select distinct(orderid),sum(unitprice*quantity) as totals from [Order Details] group by OrderID) a where a.totals>(select avg(unitprice*quantity)  from [Order Details])

select orderid, sum(unitprice*quantity) from [Order Details] group by OrderID

---17.---	List out all products with discounts higher than average discount offered.---
select * from [Order Details]

select productid,discount from [Order Details] order by Discount desc

select * from (select p1.productid,discount,p2.ProductName
from dbo.[Order Details] p1
join Products p2
on p1.ProductID=p2.ProductID
order by Discount desc) 


with order_cte (productid,discount,prodcutname)as
(
select ProductID as productid,Discount as discount from  [Order Details]
)
select * from 
(
select productid,discount,dense_rank() over(order by discount desc) as ranked from order_cte)
as a where a.ranked=1


select * from [Order Details]
select * from Products
