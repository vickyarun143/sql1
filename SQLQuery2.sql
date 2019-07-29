create table customers(custid int primary key,custname varchar(50),phone varchar(50),address varchar(250))
create table roomtype(roomtype varchar(50) primary key,rentperday int)
create table rooms(roomno int primary key,roomtype varchar(50),availability varchar(20) Default 'yes')
create table allocation(custid int,roomno int,checkin datetime,checkout datetime,reasonforstay varchar(250),primary key(custid,roomno,checkin))

create procedure stp_customers_insert(@id int,@name varchar(50),@phone varchar(50),@address varchar(250))
as
begin
	if exists(select custid from customers where custid=@id)
		begin
			raiserror('id already exists...',12,1)
		end
	else
		begin
			if exists(select phone from customers where phone=@phone)
				begin
					raiserror('phone already exists...',12,1)
				end
			else
				begin
					if exists(select address from customers  where address=@address)
						begin
							raiserror('address already exists..',12,1)
						end
					else
						begin
							insert into customers values(@id,@name,@phone,@address)
						end
				end
		end
end


exec stp_customers_insert 01,'vignesh','9952666093','trichy'
exec stp_customers_insert 02,'hassan','9952666993','128,vaniyambadi,vellore'

select *from customers

--room type
create procedure stp_roomtype_insert(@roomtype varchar(50),@rentperday int)
as
begin
insert into roomtype values(@roomtype,@rentperday)
end

exec stp_roomtype_insert 'Duluxe',100
exec stp_roomtype_insert 'Non Duluxe',200
exec stp_roomtype_insert 'AC',300
exec stp_roomtype_insert 'Non AC',400

select * from roomtype

					
			
--rooms
create procedure stp_rooms_insert(@roomno int,@roomtype varchar(50),@availability varchar(50))
as 
begin
	if exists(select roomno from allocation where roomno=@roomno)
		begin
			raiserror('room already booked..',16,1)
		end
	else
		begin
			if exists(select roomtype from roomtype where roomtype=@roomtype)
				begin
					raiserror('this room type not available...',16,1)
				end
			else
				begin
					if exists(select roomno from allocation where availability=@roomno)
						begin
							raiserror('not available ...',16,1)
						end
					else
						begin
							insert into customers values(@roomno,@roomtype,@availability)
						end
				end
		end
end
					

		






--allocation
create procedure stp_allocation_insert(@custid int,@roomno int,@checkin datetime,@checkout datetime,@reasonforstay varchar(250))
as 
begin
	if exists(select custid from customers where custid=@custid)
		raiserror('register customer id first..',16,1)
	else
		begin
			if exists(select roomno from rooms where roomno=@roomno)
				raiserror('poda...',16,1)
			else
				begin
