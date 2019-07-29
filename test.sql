create procedure stp_employee_insert(@id int,@name varchar(20),@adid int)
as 
begin
	if exists(select empid from employee where empid=@id )
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