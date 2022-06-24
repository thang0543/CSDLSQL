--➢ Nhập vào MaNV cho biết tuổi của nhân viên này.
create function fn_tinhTuoi(@MaNV nvarchar(9))
returns int
as
begin
  return (select datediff(year,NGSINH,getDate()) from NHANVIEN where MANV like @MaNV)
end

print 'tuoi nhan vien la: ' + cast(dbo.fn_tinhTuoi('001')  as nvarchar)
--➢ Nhập vào Manv cho biết số lượng đề án nhân viên này đã tham gia
create function fn_tongDeAn(@MaNV nvarchar(9))
returns int
as
begin
  return (select count(MADA) from PHANCONG  where MA_NVIEN like @MaNV)
end
print 'tong so de an la: ' + cast(dbo.fn_tongDeAn('001')  as nvarchar)
--➢ Truyền tham số vào phái nam hoặc nữ, xuất số lượng nhân viên theo phái
create function fn_Tong( @phai nvarchar(5)= N'nam')
returns int 
as
begin
declare @tong int;
select @tong = count(MANV) from NHANVIEN
where PHAI like @phai
return @tong
end
select dbo.fn_Tong(N'nữ') as tong
--➢ Truyền tham số đầu vào là tên phòng, tính mức lương trung bình của phòng đó, Cho biết
--họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình
--của phòng đó.
if Object_ID ('fn_thongKe1') is not null
drop function fn_thongKe1
create function fn_thongKe1(@TenPhong nvarchar(15))
returns @hoVaTen table (hoTen nvarchar(50)) 
as
begin
declare @maPHG int 
select @maPHG = MAPHG from PHONGBAN 
where TENPHG like @TenPhong
insert into @hoVaTen
select HONV + ' ' + TENLOT + ' ' + TENNV from NHANVIEN 
where LUONG > (select  avg(Luong) from PHONGBAN pb
join NHANVIEN nv on nv.PHG = pb.MAPHG
where MAPHG = @maPHG
group by MAPHG)
and PHG = @maPHG
return
end

select * from PHONGBAN
select * from fn_thongKe1(N'Nghiên Cứu')
--➢ Tryền tham số đầu vào là Mã Phòng, cho biết tên phòng ban, họ tên người trưởng phòng
--và số lượng đề án mà phòng ban đó chủ trì.
if Object_ID ('fn_thongKe2') is not null
drop function fn_thongKe2
create function fn_thongKe2(@maPHG int)
returns @thongKe table(TenPB nvarchar(15), hoTen nvarchar(50),SoDeAn int )
as
begin
insert into @thongKe
select TENPHG,HONV + ' ' + TENLOT + ' ' + TENNV as hoTen,count(MADA) as soDeAn from PHONGBAN pb
join NHANVIEN nv on nv.MANV = pb.TRPHG
join DEAN da on da.PHONG = pb.MAPHG
where MAPHG = @maPHG
group by MAPHG,TENPHG,HONV,TENLOT,TENNV
return
end

select * from fn_thongKe2(5)

--➢ Hiển thị thông tin HoNV,TenNV,TenPHG, DiaDiemPhg.
create view ThongKeB2_1 
as
select HONV, TENNV, TENPHG,DIADIEM from NHANVIEN nv
join PHONGBAN pb on  nv.PHG = pb.MAPHG
join DIADIEM_PHG dd on dd.MAPHG = pb.MAPHG

select * from ThongKeB2_1 
--➢ Hiển thị thông tin TenNv, Lương, Tuổi.
create view ThongKeB2_2
as
select TENNV, LUONG, datediff(year,NGSINH,getdate()) as tuoi from NHANVIEN 

select * from ThongKeB2_2
--➢ Hiển thị tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất

create view ThongKeB2_3
as
select Top 1   TENPHG, HONV + ' ' + TENLOT + ' ' + TENNV as HoTen, count(MANV) as soLuongNV from NHANVIEN nv
join PHONGBAN pb on  nv.PHG = pb.MAPHG
group by TENPHG,HONV,TENLOT,TENNV,MAPHG
order by  count(MANV) desc
select * from ThongKeB2_3

