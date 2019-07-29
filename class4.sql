create table employee(empid int not null,empname varchar(10),adid int )
create table address(adid int primary key,city varchar(10))

--T-SQL- procedure for inserting data into employee
create procedure stp_employee_insert(@id int,@name varchar(10),@adid int)
as
begin
insert into employee values(@id,@name,@adid)
end
--excuting a stored procedure
exec stp_employee_insert 1,'vicky',101
exec stp_employee_insert 2,'hassan',102
--excuting using key values pairs
exec stp_employee_insert @name='sadhu',@id=3,@adid=103

select * from employee
exec stp_employee_insert 1,'vicky',101

--delete
delete from  employee where empid=1

--how to using primary key------------
--create  stored procedure forinsrting data into employee and to check primary key constraint

alter procedure stp_employee_insert(@id int ,@name varchar(20),@adid int)
as
begin
	if exists(select empid from employee where empid=@id)
		begin
			raiserror('employee id already exists.....',17,1)
		end
	else
		begin
			insert into employee values(@id,@name,@adid)
		end
end

select * from employee
--executing stp
exec stp_employee_insert 1,'vicky',101

--checking foreign key constrains in stp
alter procedure stp_employee_insert(@id int,@name varchar(20),@adid int)
as 
begin
	if exists(select empid from employee where empid=@id)
		begin
			raiserror('employee id already exists',1,1)
		end
	else
		begin
			if exists(select adid from address where adid=@adid)
				begin
					insert into employee values(@id,@name,@adid)
				end
			else
				begin
					raiserror('invalid address id...check address table',16,1)
				end
		end
end

--exec using invalid foreign keys---
select * from employee
select * from address

exec stp_employee_insert 3,'raja',102

insert into address values(101,'trichy')
insert into address values(103,'trich1')

			 
drop table employee
drop table address

create table employee(empid int not null,empname varchar(10),adid int)
create table address (adid int identity(1,1) primary key,city varchar(10))

create procedure stp_employeedetails(@id int,@name varchar(10),@city varchar(10))
as
begin
declare @addressid int
insert into address values(@city)
set @addressid=(select max(adid) from address)
if exists(select empid from employee where empid=@id)
	begin
		raiserror('employee is already exists',16,1)
	end
else
	begin
		insert into employee values(@id,@name,@addressid)
	end
end

select * from employee
select * from address

exec stp_employeedetails 1,'vicky','trichy'



--validate using stp
--some text conversions are also possible
create table customers(custname varchar(10),email varchar(10),country varchar(10),city varchar(10))

create procedure stp_customers_insert(@name varchar(10),@mail varchar(10),@country varchar(10),@city varchar(10))
as
begin
	if exists(select custname from customers where custname=@name)
		begin
			raiserror('customer id already exists...',16,1)
		end
	else
		begin
			set @name=UPPER(@name)
			set @country=UPPER(@country)
			set @city=UPPER(@city)

			declare @validemail tinyint
			set @validemail=charindex('@',@mail)
				if @validemail<2
					begin
						raiserror('invalid email...',16,1)
					return
					end
				else
					begin
						insert into customers values(@name,@mail,@country,@city)
					end
		end
end



exec stp_customers_insert 'vicky','a@bgmail.com','india','trichy'

select* from customers









			