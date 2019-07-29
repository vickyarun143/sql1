create table Employee(empid int primary key,empname varchar(50) not null,empphone varchar(50),empmail varchar(50))
create table Training(empid int not null,tid int not null,lang varchar(50) not null,primary key(empid,tid))
create table langknown(empid int not null,lang varchar(50),primary key(empid,lang))

select * from Training

create procedure stp_Employee_insert(@empid int,@empname varchar(50),@empphone varchar(50),@empmail varchar(50))
as
begin
if exists(select empname from Employee where empname=@empname)
		begin
			raiserror('customer id already exists...',16,1)
		end
	else
		begin
			declare @validemail tinyint
			set @validemail=charindex('@',@empmail)
				if @validemail<2
					begin
						raiserror('invalid email...',16,1)
					return
					end
				else
					begin
						insert into Employee values(@empid,@empname,@empphone,@empmail)
					end
		end
end

exec stp_Employee_insert 1,'vicky','9952666093','vicky@gmail.com'
exec stp_Employee_insert 2,'sadhu','9953666093','sadhu@gmail.com'

select * from Employee

create trigger trg_insert_training on training for insert
as 
begin
declare @empid int
set @empid=(select inserted.empid from inserted,training where inserted.empid=training.empid and inserted.tid=training.tid)
declare @lang varchar(50)
set @lang=(select inserted.lang from inserted,training where inserted.empid=Training.empid and inserted.tid=Training.tid)
insert into langknown values(@empid,@lang)
end

insert into Training values (1,2,'java')
insert into Training values (2,3,'pyhton')
insert into Training values (1,4,'c')
select * from training
select * from langknown


create trigger trg_training_delete on training instead of delete
as
begin
declare @empid int
declare @lang int
declare @oldlang int
declare @tid int
set @lang=(select inserted.lang from inserted,Training where inserted.tid=Training.tid and inserted.empid=Training.empid)
set @empid=(select inserted.empid from inserted ,training where inserted.tid=training.tid and inserted.empid=training.empid)
set @tid=(select inserted.tid from inserted,Training where inserted.tid=Training.tid and inserted.empid=Training.empid)
update langknown set lang=@lang where empid=@empid and lang=@oldlang
end
select * from training
select * from langknown

update Training set lang='C#' where empid=2 and tid=6



