--allocation
create procedure stp_insert_alloction(@cutid int ,@roomno int,@checkin datetime,@reasonforstay varchar(20))
as 
begin
	if exists(select custid from customers where custid=@custid)
	begin
		if exists(select roomno from rooms where roomno=@roomno and availability='yes')
			begin	
				insert into allocation(custid,roomno,checkin,reasonforstay)values(@custid,@roomno,@reasonforstay)
				update rooms set availability='no' where roomno=@roomno
			end
	end
	else
		begin
			raiserror('room not available..'1,1)
		end
	end
	else
		begin
			raiserror('customer does not exist...',1,1)
		end
	end
end




----chargerent-------
create procedure changerent(@type varchar(20),@newrent int)
as 
begin
update roomtype set rentperday=@newrent where roomtype=@type
end

exec chagerent 'asdeluxe',3000
select * from roomtype


create procedure checkout(@custid int,@roomno int,@check datetime,@checkout datetime)
as 
begin
update allocation set checkout=@checkout where custid and roomno=@roomno and checkin=@checkin
update rooms set availability='yes' where roomno=@roomno
end


exec checkout 1,1,'2010111','20101112'

select * from allocation
select * from rooms




