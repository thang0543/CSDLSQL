create database QuanLiNhaTro
go 
use QuanLiNhaTro
go

create table Quan(
MaQuan varchar(10) not null,
tenQuan nvarchar(50) not null,
primary key(MaQuan)
)

create table loaiNha(
maLN varchar(10) not null,
tenLN nvarchar(50) not null,
primary key (maLN) 
)

create table NguoiDung(
MaND varchar(10) not null,
tenND nvarchar(50) not null,
GioiTinh nvarchar(7) not null,
DienThoai nvarchar(13) not null,
DiaChi nvarchar(100) not null,
MaQuan varchar(10) not null,
email nvarchar(100) not null,
primary key(MaND),

foreign key(MaQuan) references Quan(MaQuan)
)

create table nhaTro(
MaNT varchar(10) not null,
maLN varchar(10) not null,
dienTich int not null,
giaPhong money not null,
diaChi nvarchar(100) not null,
MaQuan varchar(10) not null,
Mota nvarchar(100) not null,
ngaydang date not null,
nguoiLienHe varchar(10) not null,
primary key(MaNT),
foreign key(maLN) references loaiNha(maLN),
foreign key(MaQuan) references Quan(MaQuan),
foreign key(nguoiLienHe) references NguoiDung(MaND),
)

create table HopDongThue(
MaND varchar(10) not null,
MaNhaTro varchar(10) not null,
NgayDen date not null,
ngayDi date not null,
primary key(MaND, MaNhaTro),
foreign key(MaND) references NguoiDung(MaND),
foreign key(MaNhaTro) references nhaTro(MaNT)
)
create table DanhGia(
MaDG varchar(10) not null,
MaND varchar(10) not null,
MaNhaTro varchar(10) not null,
likes bit not null,
NoiDung nvarchar(1000) not null,
primary key(MaDG),
foreign key(MaND,MaNhaTro) references HopDongThue(MaND,MaNhaTro)
)

insert into loaiNha(maLN,tenLN)
values ('NH01',N'chung cư'),
       ('NH02',N'xã Hội'),
	   ('NH03',N'tái định cư'),
	   ('NH04',N'thương mại'),
	   ('NH05',N'công vụ')

insert into Quan(MaQuan,tenQuan)
values ('15', N'Tân Phú'),
		('16', N'Bình Thạnh'),
		('18', N'Thủ Đức'),
		('17', N'Phú Nhuận'),
		('03', N'Quận Hai Bà Trưng')

insert into NguoiDung(MaND,tenND,MaQuan,DiaChi,DienThoai,email,GioiTinh)
values  ('PH01',N'Trần văn Hào','15',N'Điện Biên - Ba ĐÌnh - Hà Nội','0338977587','hao@gmail.com','nam'),
('PH02',N'Nguyễn văn Sơn','15',N'Điện Biên - Ba ĐÌnh - Hà Nội','09868658587','son@gmail.com','nam'),
('PH03',N'Nguyễn Thị Phương','15',N'Cổ Nhuế 1 - Bắc Từ Liêm - Hà Nội','0337687345','phuong@gmail.com','nữ'),
('PH04',N'Cù Đức Hiếu','15',N'Cổ Nhuế 12 - Bắc Từ Liêm - Hà Nội','0986843578','hieu@gmail.com','nam'),
('PH05',N'Nguyễn Văn An','15',N'Nghĩa Đô - Cầu Giấy  - Hà Nội','06845856487','An@gmail.com','nam'),
('PH06',N'Trần Thị Linh','15',N'Nghĩa Đô - Cầu Giấy  - Hà Nội','0475857463','linh@gmail.com','nữ'),
('PH07',N'Nguyễn Minh thư','15',N'Văn Miếu - Đống Đa- Hà Nội','0475756342','thu@gmail.com','nữ'),
('PH08',N'Nguyễn văn Lâm','15',N'Văn Miếu - Đống Đa- Hà Nội','0583567442','lam@gmail.com','nam'),
('PH09',N'Dào Văn linh','15',N'Quang Trung - Hà Đông - Hà Nội','0375639574','linhdv@gmail.com','nam'),
('PH10',N'Dương Văn Phúc','15',N'Quang Trung - Hà Đông - Hà Nội','0486745341','phuc@gmail.com','nam')


insert into nhaTro(MaNT,maLN,dienTich,giaPhong,diaChi,MaQuan,Mota,ngaydang,nguoiLienHe)
values 

('NT01','NH01', 1000, 2000000, N'Điện Biên - Ba ĐÌnh - Hà Nội','15','Còn','2020-08-12','PH01'),
('NT02','NH01', 1100, 2220000, N'Điện Biên - Ba ĐÌnh - Hà Nội','15','Còn','2021-09-27','PH02'),
('NT03','NH02', 2200, 21200000, N'Cổ Nhuế 1 - Bắc Từ Liêm - Hà Nội','16','Còn','1995-08-06','PH03'),
('NT04','NH02', 1210, 12100000, N'Cổ Nhuế 12 - Bắc Từ Liêm - Hà Nội','16','Còn','2000-09-01','PH04'),
('NT05','NH03', 1030, 121000000, N' Nghĩa Đô - Cầu Giấy - Hà Nội','17','Còn','2021-04-22','PH05'),
('NT06','NH03', 3300, 22100000, N'Nghĩa Đô - Cầu Giấy - Hà Nội','17','Còn','2021-01-30','PH06'),
('NT07','NH04', 1200, 33210000, N'Văn Miếu - Đống Đa- Hà Nội','18','Còn','1980-08-11','PH07'),
('NT08','NH04', 2323000, 221100000, N'Văn Miếu - Đống Đa- Hà Nội','18','hết','2020-07-02','PH08'),
('NT09','NH05', 234200, 201310000, N'Quang Trung - Hà Đông - Hà Nội','03','Còn','2020-12-31','PH09'),
('NT10','NH05', 123200, 21313000, N'Quang Trung - Hà Đông - Hà Nội','03','Còn','2000-09-19','PH10')

insert into HopDongThue(MaND,MaNhaTro,NgayDen,ngayDi)
values 
('PH10','NT01','1999-09-13','2000-12-30'),
('PH01','NT01','1999-09-13','2020-12-30'),
('PH02','NT01','2000-05-23','2022-01-30'),
('PH03','NT02','1989-10-26','2022-12-30'),
('PH04','NT03','2011-09-03','2021-01-19'),
('PH05','NT04','1999-09-13','2004-12-29'),
('PH06','NT01','1988-10-22','2003-08-30'),
('PH07','NT05','1992-09-14','2002-12-30'),
('PH08','NT03','1989-08-26','1999-09-27'),
('PH09','NT06','1999-11-16','2002-11-14'),
('PH01','NT02','2000-01-12','2009-05-31')

insert into DanhGia(MaDG,MaND,MaNhaTro,likes,NoiDung)
values ('DA1','PH10','NT01','true','Tot'),
('DA2','PH01','NT01','true','Tot'),
('DA3','PH02','NT01','true','Tot'),
('DA4','PH03','NT02','true','Tot'),
('DA5','PH04','NT03','true','Tot'),
('DA6','PH05','NT04','true','Tot'),
('DA7','PH06','NT01','true','Tot'),
('DA8','PH07','NT05','true','Tot'),
('DA9','PH09','NT06','true','Tot'),
('DA10','PH01','NT02','true','Tot')

select * from DanhGia
-- Tạo ba Stored Procedure (SP) với các tham số đầu vào phù hợp.
--o SP thứ nhất thực hiện chèn dữ liệu vào bảng NGUOIDUNG
if Object_ID('sp_NguoiDung') is not null
drop proc sp_NguoiDung 

create proc sp_NguoiDung 
@MaND varchar(10) = null,
@tenND nvarchar(50) = null,
@GioiTinh nvarchar(7) = null,
@DienThoai nvarchar(13)= null,
@DiaChi nvarchar(100) = null,
@MaQuan varchar(10) = null,
@email nvarchar(100) = null
as
begin
if @MaND is null or @tenND is null or @GioiTinh is null or @DienThoai is null or
@DiaChi is null or  @MaQuan is null or @email is null 
begin 
print 'vui long nhap day du'
return 
end
begin try
insert into NguoiDung (MaND,tenND,GioiTinh,DienThoai,DiaChi,MaQuan,email)
values (@MaND,@tenND,@GioiTinh,@DienThoai,@DiaChi,@MaQuan,@email)
print 'them thanh cong'
end try
begin catch
print 'them that bai '
end catch
end

exec sp_NguoiDung 't'
------------------------------c2---------------------------------------
if Object_ID('sp_NguoiDung') is not null
drop proc sp_NguoiDung 

create proc sp_NguoiDung 
@MaND varchar(10) = null,
@tenND nvarchar(50) = null,
@GioiTinh nvarchar(7) = null,
@DienThoai nvarchar(13)= null,
@DiaChi nvarchar(100) = null,
@MaQuan varchar(10) = null,
@email nvarchar(100) = null
as
begin
if @MaND is null or @tenND is null or @GioiTinh is null or @DienThoai is null or
@DiaChi is null or  @MaQuan is null or @email is null 
begin 
print 'vui long nhap day du'
return
end
else if exists(select * from NguoiDung where MaND like @MaND)
print 'id da ton tai'

begin try
insert into NguoiDung (MaND,tenND,GioiTinh,DienThoai,DiaChi,MaQuan,email)
values (@MaND,@tenND,@GioiTinh,@DienThoai,@DiaChi,@MaQuan,@email)
print 'them thanh cong'
end try
begin catch
print 'them that bai '
end catch
end

exec sp_NguoiDung 't'
--o SP thứ hai thực hiện chèn dữ liệu vào bảng NHATRO
if Object_ID('sp_NhaTro') is not null
drop proc sp_NhaTro
create proc sp_NhaTro
@MaNT varchar(10) = null,
@maLN varchar(10) = null,
@dienTich int = null,
@giaPhong money = null,
@diaChi nvarchar(100) = null,
@MaQuan varchar(10) = null,
@Mota nvarchar(100) = null,
@ngaydang date = null,
@nguoiLienHe varchar(10) = null
as
begin
if @MaNT is null or @maLN is null or @dienTich is null or @giaPhong is null or @diaChi is null or
@MaQuan is null or @Mota is null or @ngaydang is null or @nguoiLienHe is null 
begin 
print 'vui long nhap day du'
return 
end
begin try 
insert into nhaTro(MaNT,maLN,dienTich,giaPhong,diaChi,MaQuan,Mota,ngaydang,nguoiLienHe)
values(@MaNT,@maLN,@dienTich,@giaPhong,@diaChi,@MaQuan,@Mota,@ngaydang,@nguoiLienHe)
print 'them thanh cong'
end try
begin catch
print 'them that bai '
end catch
end
--o SP thứ ba thực hiện chèn dữ liệu vào bảng DANHGIA
if Object_ID('sp_DanhGia') is not null
drop proc sp_DanhGia 

create proc sp_DanhGia 
@MaDG varchar(10) = null,
@MaND varchar(10) = null,
@MaNhaTro varchar(10) = null,
@likes bit = null,
@NoiDung nvarchar(1000) = null
as 
begin
if @MaDG is null or @MaND is null or @MaNhaTro is null or @likes is null or @NoiDung is null 
begin 
print 'vui long nhap day du'
return 
end
begin try
insert into DanhGia(MaDG,MaND,MaNhaTro,likes,NoiDung)
values (@MaDG,@MaND,@MaNhaTro,@likes,@NoiDung)
print 'them thanh cong'
end try
begin catch
print 'them that bai '
end catch
end 
--Yêu cầu đối với các SP: Trong mỗi SP phải kiểm tra giá trị các tham số đầu vào. Với
--các cột không chấp nhận thuộc tính NULL, nếu các tham số đầu vào tương ứng với
--chúng không được truyền giá trị, thì không thực hiện câu lệnh chèn mà in một thông báo
--yêu cầu người dùng nhập liệu đầy đủ.
--- Với mỗi SP, viết hai lời gọi. Trong đó, một lời gọi thực hiện chèn thành công dữ liệu,
--và một lời gọi trả về thông báo lỗi cho người dùng.

--a. Viết một SP với các tham số đầu vào phù hợp. SP thực hiện tìm kiếm thông tin các
--phòng trọ thỏa mãn điều kiện tìm kiếm theo: Quận, phạm vi diện tích, phạm vi ngày đăng
--tin, khoảng giá tiền, loại hình nhà trọ.
--SP này trả về thông tin các phòng trọ, gồm các cột có định dạng sau:
--o Cột thứ nhất: có định dạng ‘Cho thuê phòng trọ tại’ + <Địa chỉ phòng trọ>
--+ <Tên quận/Huyện>
--o Cột thứ hai: Hiển thị diện tích phòng trọ dưới định dạng số theo chuẩn Việt Nam +
--m2. Ví dụ 30,5 m2
--o Cột thứ ba: Hiển thị thông tin giá phòng dưới định dạng số theo định dạng chuẩn
--Việt Nam. Ví dụ 1.700.000
--o Cột thứ tư: Hiển thị thông tin mô tả của phòng trọ
--o Cột thứ năm: Hiển thị ngày đăng tin dưới định dạng chuẩn Việt Nam.
--Ví dụ: 27-02-2012
--o Cột thứ sáu: Hiển thị thông tin người liên hệ dưới định dạng sau:
--▪ Nếu giới tính là Nam. Hiển thị: A. + tên người liên hệ. Ví dụ A. Thắng
--▪ Nếu giới tính là Nữ. Hiển thị: C. + tên người liên hệ. Ví dụ C. Lan
--o Cột thứ bảy: Số điện thoại liên hệ
--o Cột thứ tám: Địa chỉ người liên hệ
--- Viết hai lời gọi cho SP này

if Object_ID('sp_timKiem') is not null
drop proc sp_timKiem 

create proc sp_timKiem 
@tenQuan varchar(50) ='%',
@DienTichMax int = null,
@DienTichMin int = null,
@ngayDangMax date = null, 
@ngayDangMin date = null, 
@giaTienMax money = null,
@giaTienMin money = null,
@loaiNha nvarchar(50) = '%' 
as
begin
if @DienTichMax is null
select @DienTichMax = max(dienTich)
from nhaTro
if @DienTichMin is null
select @DienTichMin = min(dienTich)
from nhaTro
if @ngayDangMax is null
select @ngayDangMax = max(ngaydang)
from nhaTro
if @ngayDangMin is null
select @ngayDangMin = min(ngaydang)
from nhaTro
if @giaTienMax is null
select @giaTienMax = max(giaPhong)
from nhaTro
if @giaTienMin is null
select @giaTienMin = min(giaPhong)
from nhaTro
select 
 a.diaChi +' and ' + b.tenQuan as N'Cho thuê phòng trọ tại ',
format(dienTich,'N','Vi-vn') + 'm2' as dienTich,
format(giaPhong,'c','Vi-vn') as giaTien,
Mota, convert(nvarchar, ngaydang,105) as ngayDang,
NguoiLienHe = case 
when c.GioiTinh like 'nam' then 'A.'+c.tenND
when c.GioiTinh like N'nữ' then 'C.' + c.tenND
end,c.DienThoai,c.DiaChi
from nhaTro a
inner join Quan b on a.MaQuan = b.MaQuan
inner join NguoiDung c on a.nguoiLienHe = c.MaND
inner join loaiNha d on d.maLN = a.maLN
where b.tenQuan like @tenQuan and 
dienTich between @DienTichMin and  @DienTichMax and 
giaPhong between @giaTienMin and  @giaTienMax and 
ngaydang between @ngayDangMin and @ngayDangMax and
d.tenLN like @loaiNha
end
exec sp_timKiem 'tân phú'
exec sp_timKiem '1'

select * from Quan
--b. Viết một hàm có các tham số đầu vào tương ứng với tất cả các cột của bảng
--NGUOIDUNG. Hàm này trả về mã người dùng (giá trị của cột khóa chính của bảng
--NGUOIDUNG) thỏa mãn các giá trị được truyền vào tham số.

create function Fn_findID (
@tenND nvarchar(50) ,
@GioiTinh nvarchar(7) ,
@DienThoai nvarchar(13),
@DiaChi nvarchar(100) ,
@MaQuan varchar(10) ,
@email nvarchar(100)
)
returns nvarchar
as 
begin 
return (select * from NguoiDung 
where tenND like @tenND and GioiTinh like @GioiTinh and
DienThoai like @DienThoai and DiaChi like @DiaChi and MaQuan like @MaQuan and email like @email
)
end



--c. Viết một hàm có tham số đầu vào là mã nhà trọ (cột khóa chính của bảng
--NHATRO). Hàm này trả về tổng số LIKE và DISLIKE của nhà trọ này.

create function fn_danhGia (@Ma varchar(10) )
returns @thongKe table (sumLike int,  SumDisLike int )
as
begin
insert into @thongKe
select 
sum(iif(likes = 1,1,0)) as 'like',
sum(iif(likes = 0,1,0)) as 'dislike'
from DanhGia
where MaNhaTro like @Ma
return
end
-- c2

if OBJECT_ID('FC_c_TotalLike') is not null 
DROP FUNCTION FC_c_TotalLike
GO
CREATE FUNCTION FC_c_TotalLike (@MaNhaTro nchar(10))
RETURNS INT
as 
BEGIN
    RETURN
    (
        SELECT COUNT(*) FROM DanhGia
        WHERE MaNhaTro = @MaNhaTro and Likes = 1
    )
END
GO
PRINT N'Tổng like:' + CONVERT(nvarchar,dbo.FC_c_TotalLike('NT01'))
PRINT N'Tổng like:' + CONVERT(nvarchar,dbo.FC_c_TotalLike('NT02'))
--Tổng disliek 
if OBJECT_ID('FC_c_TotalDisLike') is not null 
DROP FUNCTION FC_c_TotalDisLike
GO
CREATE FUNCTION FC_c_TotalDisLike (@MaNhaTro nchar(10))
RETURNS INT
as 
BEGIN
    RETURN
    (
        SELECT COUNT(*) FROM DanhGia
        WHERE MaNhaTro = @MaNhaTro and Likes = 0
    )
END
GO
PRINT N'Tổng dislike:' + CONVERT(nvarchar,dbo.FC_c_TotalDisLike('NT01'))
PRINT N'Tổng dislike:' + CONVERT(nvarchar,dbo.FC_c_TotalDisLike('NT02'))
select * from DanhGia


--d. Tạo một View lưu thông tin của TOP 10 nhà trọ có số người dùng LIKE nhiều nhất gồm
--các thông tin sau:
--- Diện tích
--- Giá
--- Mô tả
--- Ngày đăng tin
--- Tên người liên hệ
--- Địa chỉ
--- Điện thoại
--- Email

create view top10 
as
select dienTich,giaPhong,Mota,ngaydang,c.tenND,c.diaChi,c.DienThoai,c.email from (select top 10  MaNhaTro, count(iif(likes = 1,1,0))as countLike from DanhGia
group by MaNhaTro
order by countLike desc) a
inner join nhaTro b on a.MaNhaTro = b.MaNT
inner join NguoiDung c on c.MaND = b.nguoiLienHe


--. Viết một Stored Procedure nhận tham số đầu vào là mã nhà trọ (cột khóa chính của
--bảng NHATRO). SP này trả về tập kết quả gồm các thông tin sau:
--- Mã nhà trọ
--- Tên người đánh giá
--- Trạng thái LIKE hay DISLIKE
--- Nội dung đánh giá
if Object_ID('sp_ThongTin') is not null
drop proc sp_ThongTin

create proc sp_ThongTin @ma varchar(10) = '%'
as
begin
select a.MaNhaTro,c.tenND,iif(likes = 1 ,'like','dislike') as 'like'
,NoiDung from DanhGia a
inner join HopDongThue b on b.MaNhaTro = a.MaNhaTro
inner join NguoiDung c on c.MaND = b.MaND
where a.MaNhaTro like @ma
end

exec sp_ThongTin 'NT01'
--Viết một SP nhận một tham số đầu vào kiểu int là số lượng DISLIKE. SP này thực hiện
--thao tác xóa thông tin của các nhà trọ và thông tin đánh giá của chúng, nếu tổng số lượng
--DISLIKE tương ứng với nhà trọ này lớn hơn giá trị tham số được truyền vào.
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác
--xóa thực hiện không thành công.
if Object_ID('sp_deleteDisLike') is not null
drop proc sp_deleteDisLike

create proc  sp_deleteDisLike @dislike int 
as
begin
if(@dislike is null)
begin
print 'vui long nhap so dislike'
return
end
declare @thongke table(MaNT nvarchar(10))
insert into @thongke
select MaNhaTro from DanhGia
group by MaNhaTro
having sum(iif(likes = 0,1,0)) > @dislike

begin transaction 
begin try
delete DanhGia where MaNhaTro in(select MaNT from @thongke)
delete HopDongThue where MaNhaTro in (select MaNT from @thongke)
delete nhaTro where MaNT in(select MaNT from @thongke)
print 'Da xoa thanh cong'
rollback tran
end try
begin catch
rollback tran 
print 'xóa thực hiện không thành công.'
end catch
end

--Viết một SP nhận hai tham số đầu vào là khoảng thời gian đăng tin. SP này thực hiện
--thao tác xóa thông tin những nhà trọ được đăng trong khoảng thời gian được truyền vào
--qua các tham số.
--Lưu ý: SP cũng phải thực hiện xóa thông tin đánh giá của các nhà trọ này.
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác
--xóa thực hiện không thành công.
if Object_ID('sp_deleteDate') is not null
drop proc sp_deleteDate

create proc sp_deleteDate @datemax date , @dateMin date
as
begin
if(@datemax is null or @dateMin is null)
begin
print 'vui long nhap nagy max va min'
return 
end
declare @ThongKe table (MaNT varchar(9))
insert into @ThongKe
select MaNT from nhaTro
where ngaydang between @dateMin  and @dateMax 
begin transaction
begin try
delete nhaTro where MaNT in(select MaNT from @ThongKe)
delete DanhGia where MaNhaTro in (select MaNT from @ThongKe)
print 'xoa thanh cong'
rollback tran
end try
begin catch
 rollback tran
 print 'khong thanh cong'
end catch
end