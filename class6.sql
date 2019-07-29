--controling flow of excution
--general synta
--if this statement is true
--excute this statement ;
--else


--union if --else
if(select count(*) from dbo.products where unitprice >100)>100 select  'found' as highprice else select 'not found' highprice

--using begin END
if exists(select * from dbo.Products where UnitPrice >100) 
	begin
		update dbo.products set unitprice=unitprice-.10 where unitprice >100;
		select 'ten cents removed from high' as message
end
else
	begin 
		update dbo.products set unitprice=unitprice + .10
		select 'ten cents add total prcie' as message
	end

--using goto
 if(3=2)
	goto jumptohere
print 'done'
jumptohere:
	print 'the expression true'


 if(3=2)
	goto jumptohere
print 'done'
return
jumptohere:
	print 'the expression true'

--here one way to fix if,using return
if (select count(*) from dbo.Products where unitprice>100)>0 return 
	update dbo.Products set UnitPrice=UnitPrice+.10
	select'ten cents added to all prices' as message

--using case
--syntax compare one exp to other exp
--case input -exp
--when -exp then-exp
--[..n]
--end

--using an input exp
--AND simple quality comparisions

select categoryname,mycategory=
case categoryname 
		when 'meat/poultry'then 'protien'
		when 'seefood' then 'protein'
		when 'grains/careal' then 'carbs'
		else 'other'
end,description from dbo.Categories order by mycategory


--syntax for no input expand
--boolean exp for each when
--case
--when boolean -exp then result exp
--[...n]
--[



--else result -exp
--]



select categoryname,mycategory=
	case 
	when categoryname in('meat/poultry','seafood') then 'protein'
	when categoryname in('grains/cereal') then 'carbs'
	else 'other'
end,description from dbo.Categories order by mycategory

------------------------------------------------

select address=city+
	case
	when region is null then ''+postalcode 
	else ',' +region +''+postalcode 
end
from dbo.Customers


---------------------------------------------------

--using while 
while(select AVG(unitprice) from dbo.Products)<=12
	begin
		update dbo.Products
		set UnitPrice=UnitPrice * 1.01
			if(select max(unitprice) from dbo.Products)>150
			break
			else
			continue
	end
---using waitfor
--syntax
--wait for{delay 'time' | time ;time}
--pause for ten second wait for delay '00:00:10'
--watch the query duration counter
--pause unitil a certain time 
waitfor time '4:40:00' print 'it is evening'

--using ranking functions
--ranked by unitprice and listed by unitprice
select productname,unitprice ,ROW_NUMBER() over(order by unitprice desc)as rownumber,
							 RANK() over(order by unitprice desc) as ra,
							 DENSE_RANK() over(order by unitprice desc) as denserank,
							 NTILE(50) over(order by unitprice desc) as ntile50
							 from dbo.products
							 order by unitprice desc;


--ranked within each category using partition by
select productname,categoryid,unitprice,
DENSE_RANK() over(partition by categoryid order by unitprice desc) as denserank
from dbo.Products
order by CategoryID,UnitPrice desc;

--ranked by category and overall,listed alphabetically
select productname,categoryid,unitprice,
DENSE_RANK() over(partition by categoryid order by unitprice desc) as denserankbycategory,
DENSE_RANK() over (order by unitprice desc) as overalldenserank,
DENSE_RANK() over (order by unitsonorder desc) as overallbyunitsonorder
from dbo.Products
order by ProductName

---the over clause allows use of aggregate functions
select distinct(categoryid),max(unitprice) over(partition by categoryid)as costliestproduct from Products
select * from [Order Details]

select distinct(orderid),sum(unitprice*quantity) over(partition by orderid ) as totals from [Order Details] order by totals desc

select orderid,sum(unitprice*quantity) as totals from [Order Details] 
group by OrderID order by totals 

--get orders with order value greater than 10000
--outer queries

select * from(select distinct(orderid),sum(unitprice*quantity) as totals from [Order Details] group by OrderID) a where a.totals>10000

select * from(select orderid ,sum(unitprice*quantity) as totals from [Order Details] group by orderid)a where a.totals>10000

select orderid,unitprice*quantity,RANK() over (order by unitprice*quantity) as ranked from dbo.[Order Details] order by ranked 


--get the 10 th costiliest product
select * from(select productname,unitprice,rank() over (order by unitprice desc) as ranked from dbo.Products)a where a.ranked=5;

--issue with rank here
select * from (select productname,unitprice,rank() over(order by unitprice desc)as ranked from dbo.Products)a where a.ranked=16;

--dense rank
select * from(select productname,unitprice,DENSE_RANK() over(order by unitprice desc) as ranked from dbo.Products) a where a.ranked=16;

select productname,unitprice from Products order by UnitPrice desc

--customer with second highest number of order
select customerid,count(orderid) myorders from orders group by customerid order by myorders desc

--sql common table expression
with order_cte(cutomerid,ordercount)as
(
select customerid as customerid,count(orderid) as ordercount from Orders group by CustomerID
)
select max(ordercount) from order_cte where ordercount<(select max(ordercount) from order_cte)


--more description results using rank and over functions
with order_cte(customerid,ordercount) as
(
select CustomerID as customerid,count(orderid) as ordercount from orders group by CustomerID
)
select customerid,ordercount,rank() over(order by ordercount desc) as ranked from order_cte 

---nth highest count
with order_cte (customerid,ordercount)as
(
select customerid as customerid,count(orderid)as ordercount from Orders group by CustomerID
)
select * from 
(
select customerid,ordercount,rank() over(order by ordercount desc) as ranked from order_cte)
as a where a.ranked=1

--for order value
with order_value_cte(orderid,ordervalue) as
(
select orderid,sum(unitprice * quantity) as ordervalue from [Order Details] group by OrderID
)
select orderid,ordervalue,rank() over (order by ordervalue desc) as ranked from order_value_cte order by ranked

--nth highest ordervalue
with order_value_cte(orderid,ordervalue) as
(
select orderid,sum(unitprice*quantity) as ordervalue from [Order Details] group by OrderID
)
select * from ( select orderid,ordervalue,rank() over (order by ordervalue desc) as ranked from order_value_cte) as a where a.ranked=2