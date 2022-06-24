create database Test
go
use Test
go

create table SINHVIEN (
MaSV nvarchar(10) not null primary key, 
HoTen nvarchar(50) not null,
NgaySinh date not null, 
GioiTinh nvarchar(3) not null, 
Lop nvarchar(10) not null
)

create table DIEM (
MaSV nvarchar(10) not null, 
MaMonHoc nvarchar(10) not null,
DiemLan1 float ,
DiemLan2 float ,
primary key(MaSV,MaMonHoc),
foreign key(MaSV) references SINHVIEN(MaSV)
)



if OBJECT_ID('fn_MaSV') is not null
drop proc fn_MaSV

create proc themMoiSinhVien 
@MaSV nvarchar(10) = null, 
@HoTen nvarchar(50) = null,
@NgaySinh date = null, 
@GioiTinh nvarchar(3) = null, 
@Lop nvarchar(10)  = null
as
begin
if(@MaSV is null or @HoTen is null or @HoTen is null or @NgaySinh is null or @GioiTinh is null or @Lop is null )
print 'vui long khong de trong thong tin'
else
begin
insert into SINHVIEN
values(@MaSV,@HoTen,@NgaySinh,@GioiTinh,@Lop)
end
end
--rollback tran

exec themMoiSinhVien 'Sv','Le Van A','2000-12-09','nam','Ph01'
exec themMoiSinhVien 'Sv2','Le Van B','2000-12-08','nu','Ph01'

create proc themMoiDiem
@MaSV nvarchar(10) = null, 
@MaMonHoc nvarchar(10) = null,
@DiemLan1 float = null,
@DiemLan2 float = null
as
begin
if(@MaSV is null or @MaMonHoc is null or @DiemLan1 is null )
print 'vui long khong de trong thong tin'
else
begin
insert into DIEM
values(@MaSV,@MaMonHoc,@DiemLan1,@DiemLan2)
end
end

exec themMoiDiem 'Sv1','C1',9.8
exec themMoiDiem 'Sv2','C1',2.3,6.9
select * from DIEM


create function fn_MaSV (
@HoTen nvarchar(50) ,
@NgaySinh date , 
@GioiTinh nvarchar(3) , 
@Lop nvarchar(10)  
)
returns nvarchar(10)
begin

   return (select  MaSV from SINHVIEN
where HoTen like @HoTen  and
 NgaySinh like @NgaySinh  and
GioiTinh like @GioiTinh  and
 lop like @Lop )
 end
 


-- 4. Xây dựng thủ tục xóa có đầu vào là kqThi. Thủ tục thực hiện xóa thông tin Diem và Sinhvien
--có DiemLan1 &lt; kqThi truyền vào.

create  proc  xoa
@diem float
as
begin
begin try
 delete DIEM where MaSV in(select MaSV from SINHVIEN sv 
join DIEM d on d.MaSV = sv.MaSV
having d.DiemLan1 < @diem)
delete 
end try
begin catch

end catch


end



--Tạo View lưu thông tin của TOP 2 Sinh Viên thi nhiều môn nhất: Masv, hoten, Số môn thi.
create view top2
as
select top 2 sv.MaSV,sv.HoTen, count(d.MaSV)  from SINHVIEN sv
join DIEM d on d.MaSV = sv.MaSV
group by sv.MaSV,sv.HoTen
order by count(d.MaSV) desc




