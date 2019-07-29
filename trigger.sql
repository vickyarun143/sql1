create table students(studid int primary key,studname varchar(50),status varchar(50))

insert into students(studid,studname,status)values(1,'vicky','Active')
insert into students(studid,studname,status)values(2,'hassan','Active')
insert into students(studid,studname,status)values(3,'sadhu','Active')

select * from students
delete from students where studid=2
--select * from deleted
--DML trigger demo
--default template
--syntax

create /alter triggername on tablename for/instead of delete/insert/update
as
begin
--statement
end

create trigger trg_students_delete on students for delete
as
begin
select * from deleted
rollback transaction
end


--dont allow multiple deletion of multiple entries
alter trigger trg_students_delete on students for delete 
as
begin
	if(select count(*) from deleted)>1
	begin
		raiserror('cannot delete multiple records',1,1)
		rollback transaction
		end
end

--to drop the existing trigger
drop trigger trg_students_delete
delete from students where studid=1
select * from students


--instead of trigger
--an instead of trigger to change status to discontinued
create trigger trg_students_insteadofdelete on students instead of delete
as
begin
update students set status='discontinud'
end

drop trigger trg_students_insteadofdelete

delete from students where studid=2
select * from students
truncate table students

--correct update trigger using deleted table
create trigger trg_students_insteadofdelete on students instead of delete
as
begin
update students set status='discontinued' from deleted join students on deleted.studid=students.studid
end


--ddl triggers
--default templete
create/alter trigger triggername on database/server for drop_table(create or alter on table procedure,trigger...)
as
begin
--students--
end
--no instead of triggers in ddl
create trigger trg_ddl_blockdrop on database for drop_table
as
begin
	raiserror('you cannot drop table',1,1)
	rollback transaction
end

create table emp(empid int)
drop table emp


create table logevents(logid int identity(101,1)primary key,logevent xml)
select * from logevents
create trigger trg_logevents on database for create_table
as
begin
declare @action xml
set @action=eventdata()
insert into logevents values(@action)
end


create table emp1(empid int)
create table stud1(studid int primary key,studname varchar(50))
select * from logevents

--for all database level ddl statements
alter trigger trg_logevents on database for ddl_database_level_events
as
begin
declare @action xml
set @action=eventdata()
insert into logevents values(@action)
end

create table demo(stid int)
drop trigger trg_ddl_blockdrop on database
drop table demo
select * from logevents

