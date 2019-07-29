--create table 
create table Employee(empid int primary key not null,empname varchar(10) not null,empage int not null)
--insert table 
insert into employee(empid,empname,empage) values(10,'vignesh',25)
insert into employee(empid,empname,empage) values(11,'saravan',24)
--view table
select * from Employee

--where
select * from  employee where empid=11

--identity
create table student(stuid int identity(101,1) not null primary key,stdname varchar(10),studage varchar(10))
insert into student(stdname,studage) values('vignesh',20)  
insert into student(stdname,studage) values('hassan',20) 
select * from student where stuid=101

--date time
create table cust(cid int primary key not null,custname varchar(20) not null,custphone nvarchar(10),custdob datetime)
insert into cust(cid,custname,custphone,custdob)values(10,'vicky',9952666093,'19960513')
select * from cust

--more than primary key
create table studmark(studid int ,examtype varchar(20),examyear varchar(20),mark int,primary key(studid,examtype,examyear))
insert into studmark(studid,examtype,examyear,mark)values(12,'halfyearly',2012,50)
select * from studmark

--constrains
create table car(carid varchar(20) not null primary key,carcolor varchar(10) not null default 'white',carprice int not null check(carprice>10000),regnum varchar(10) not null unique)
insert into car (carid,carcolor,carprice,regnum)values('a12','green',12000,'12AA23')
insert into car (carid,carprice,regnum)values('a13',12000,'12pA23')
select * from car

--update 
update car set carprice=20000
delete from car where carid='a12'
select * from car where carid='a13'


--SQL ALTER COMMENDS
--column name change
create table emp(empid int ,empname varchar(20),empaddress varchar(20))
alter table emp alter column empid varchar(20)
select * from emp

--add column
alter table emp add empage int
select * from emp
--drop column
alter table emp drop column empage 

--primary key delete
create table std(studid int primary key,studname varchar(20))
alter table std drop constraint PK__std__E270950B647CDC33

--create primary key unique 
create table cus(custid int constraint pk_01 primary key,cusname varchar(10),age int constraint age_check check(age>18))
insert into cus(custid,cusname,age) values(13,'vicky',17)
select *from cus

--drop cus constraint age_check
alter table cus drop constraint age_check

--foreign key
create table customer(cusid int constraint pk_02 primary key,cname varchar(10) not null,cphone nvarchar(10))
insert into customer(cusid,cname,cphone) values(101,'vicky','9952666093')
insert into customer(cusid,cname,cphone) values(102,'hassan','9953666093')
create table purchase(orderid int constraint r_pk_01 primary key,cid int foreign key references customer(cusid),quantity int)
insert into purchase(orderid,cid,quantity) values(202,102,10)
insert into purchase(orderid,cid,quantity) values(203,101,12)
select * from customer
delete from purchase where cid=101
select *from purchase
