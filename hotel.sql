create table customers(custid int primary key,custname varchar(50),phone varchar(50),address varchar(250))
create table roomtype(roomtype varchar(50) primary key,rentperday int)
create table rooms(roomno int primary key,roomtype varchar(50),availability varchar(20) Default 'yes')
create table allocation(custid int,roomno int,checkin datetime,checkout datetime,reasonforstay varchar(250),primary key(custid,roomno,checkin))


---room type
create procedure stp_insert_roomtype(@type varchar(50),@rent int)
as
begin
insert into roomtype values(@type,@rent)
end

exec stp_insert_roomtype 'AC',2000
exec stp_insert_roomtype 'AC DELUXE',1500
exec stp_insert_roomtype 'NORMAL',1000
exec stp_insert_roomtype 'DELUXE',1800

select * from roomtype


---rooms add
create procedure stp_insert_rooms(@roomno int,@Roomtype varchar(50),@availability varchar(50))
as
begin
	if exists(select roomtype from roomtype where roomtype=@type)
		begin
			insert into rooms values(@roomno,@roomtype,@availability)
		end
	else
		begin
			raiserror('roomtype does not exist..',16,1)
		end
end

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