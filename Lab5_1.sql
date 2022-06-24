--Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
create proc sp_NhanVien @MaNV nvarchar(9)
as
begin
select * from NHANVIEN
where MANV like @MaNV
end
exec sp_NhanVien '005'

--➢ Nhập vào @MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó
if OBJECT_ID('sp_thongKe') is not null
drop proc sp_thongKe
go
create proc sp_thongKe @MaDA int, @tong int out
as begin
select  count(MA_NVIEN) from PHANCONG a
where MADA = @MaDA
end

declare @sum int;
exec sp_thongKe 1 ,@sum out
print @sum
--➢ Nhập vào @MaDa và @Ddiem_DA (địa điểm đề án), cho biết số lượng nhân viên tham
--gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA

create proc sp_SoLuong
@MaDa int, @Ddiem_Da nvarchar(15)
as
begin
declare @count int
select count(MA_NVIEN) from PHANCONG a
inner join CONGVIEC b on a.MADA = b.MADA
inner join DEAN c on c.MADA = b.MADA
where a.MADA like @MaDa and c.DDIEM_DA like @Ddiem_Da
return @count
end

declare @kq int
exec @kq = sp_SoLuong 1 , N'Vũng tàu'
--➢ Nhập vào @Trphg (mã trưởng phòng), xuất thông tin các nhân viên có trưởng phòng là
--@Trphg và các nhân viên này không có thân nhân.
create proc thongTin @Trphg int 
as 
begin
select * from PHONGBAN a
inner join NHANVIEN b on b.PHG = a.MAPHG
where @Trphg = PHG and exists(select * from THANNHAN where MANV = b.MANV)
end

exec thongTin '005'

--➢ Nhập vào @Manv và @Mapb, kiểm tra nhân viên có mã @Manv có thuộc phòng ban có
--mã @Mapb hay không

create proc sp_Check @Manv nvarchar(9),@Mapb int
as
begin
declare @dem int
select @dem = count(MANV) from NHANVIEN
where MANV like @Manv and @Mapb = PHG
if @dem > 0
print 'ton tai nhan vien'
else 
print ' khong ton tai nhan vien'
end

exec sp_Check '005', 5

select * from NHANVIEN

--b3

--Thêm phòng ban có tên CNTT vào csdl QLDA, các giá trị được thêm vào dưới dạng
--tham số đầu vào, kiếm tra nếu trùng Maphg thì thông báo thêm thất bại.
create proc sp_insert @TenPHG nvarchar(15), @MaPHG int, @TRPHG nvarchar(9), @NG_nhanChuc date
as 
begin
if exists(select * from PHONGBAN where MAPHG = @MaPHG)
begin
print ' maphg da ton tai'
end
insert into PHONGBAN(MAPHG,TENPHG,TRPHG,NG_NHANCHUC)
values (@MaPHG,@TenPHG,@TRPHG,@NG_nhanChuc)
end

--➢ Cập nhật phòng ban có tên CNTT thành phòng IT.
create proc sp_update @TenPHG nvarchar(15), @MaPHG int, @TRPHG nvarchar(9), @NG_nhanChuc date
as
begin
update PHONGBAN 
set TENPHG = @TenPHG,MAPHG = @MaPHG, TRPHG = @TRPHG,@NG_nhanChuc = NG_NHANCHUC
where TENPHG like 'CNTT'
end
--➢ Thêm một nhân viên vào bảng NhanVien, tất cả giá trị đều truyền dưới dạng tham số đầu
--vào với điều kiện:
--o nhân viên này trực thuộc phòng IT
--o Nhận @luong làm tham số đầu vào cho cột Luong, nếu @luong<25000 thì nhân
--viên này do nhân viên có mã 009 quản lý, ngươc lại do nhân viên có mã 005 quản
--lý
--o Nếu là nhân viên nam thi nhân viên phải nằm trong độ tuổi 18-65, nếu là nhân
--viên nữ thì độ tuổi phải từ 18-60.
create proc sp_insertNV @Ho nvarchar(15), @tenLot nvarchar(15), @tenNV nvarchar(15),@MaNV nvarchar(9), @ngaySinh dateTime, 
@diaChi nvarchar(30), @phai nvarchar(3), @luong float,@Ma_NQL nvarchar(9), @PHG int, @QuocTich nvarchar(100)
as
begin
if not exists(select * from PHONGBAN where TENPHG like 'IT')
begin
print 'nhan vien phai la phong it'
return
end
if @luong <25000 
set @Ma_NQL = '009'
else
begin
set @Ma_NQL= '005'
end
declare @age int = datediff(YEAR,@ngaySinh,getdate())
if(@phai like 'nam' and @age > 65 and @age < 18)
begin
print 'nam phai tu 18 -65'
return
end
else if(@phai like N'nữ' and @age > 60 and @age < 18)
begin
print 'nu phai tu 18-60'
return 
end
insert into NHANVIEN(HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG,MA_NQL,PHG,QuocTich)
values (@Ho,@tenLot,@tenNV,@MaNV,@ngaySinh,@diaChi,@phai,@luong,@Ma_NQL,@PHG,@QuocTich)
end