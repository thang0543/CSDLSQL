--ĐỀ THI CUỐI MÔN COM2034- Đề 1
--Câu 1: (1,5 điểm) Tạo cơ sở dữ liệu DATHANG gồm 3 bảng: 
--MATHANG (MaH,TenH,LoaiH,DVTinh)
--DONHANG (SoDH, NgayDH, NgayGH)
--CTDH (SoDH, MaH, SoLuong, DonGia)
create database De_1_DATHANG_dungna29
go
use De_1_DATHANG_dungna29
go
create table MATHANG 
(MaH nvarchar(10) primary key,  TenH nvarchar(50), LoaiH nvarchar(50),DVTinh nvarchar(10))
create table DONHANG 
(SoDH int primary key, NgayDH date,NgayGH date)
create table CTDH 
(SoDH int foreign key references DONHANG(SoDH),MaH nvarchar(10) foreign key references MATHANG(MaH),Soluong int , DonGia decimal , primary key (SoDH,MaH))
--Câu 2: (3 điểm) Chèn thông tin vào các bảng 
--•	Tạo Stored Procedure (SP) với các tham số đầu vào phù hợp
--SP thứ nhất thực hiện chèn dữ liệu vào bảng MATHANG 
--SP thứ hai thực hiện chèn dữ liệu vào bảng DONHANG 
--SP thứ ba thực hiện chèn dữ liệu vào bảng CTDH
--•	Yêu cầu mỗi SP phải kiểm tra tham số đầu vào. Với các cột không chấp nhân thuộc tính NULL.
--•	Với mỗi SP viết 3 lời gọi thành công 
if OBJECT_ID('SP_MATHANG') is not null 
DROP PROC SP_MATHANG
go 
create proc SP_MATHANG 
(@MaH nvarchar(10),  @TenH nvarchar(50), @LoaiH nvarchar(50),@DVTinh nvarchar(10))
as
begin
	if(@MaH is null or @TenH is null or @LoaiH is null or @DVTinh is null)
	print N'Dữ liệu nhập vào không đươc để trống'
	else
	begin
		insert into MATHANG values (@MaH , @TenH , @LoaiH , @DVTinh )
		print N'Thêm thành công dữ liệu vào bảng MatHang'
	end
end
go 
exec SP_MATHANG N'MH1',N'Bánh',N'loại 1',N'túi'
exec SP_MATHANG N'MH2',N'Kẹo',N'loại 2',N'túi'
exec SP_MATHANG N'MH3',N'Sữa',N'loại 1',N'lít'


if OBJECT_ID('SP_DONHANG') is not null 
DROP PROC SP_DONHANG
go 
create proc SP_DONHANG
(@SoDH int , @NgayDH date,@NgayGH date)
as
begin
	if(@SoDH is null or @NgayDH is null or @NgayGH is null )
	print N'Dữ liệu nhập vào không đươc để trống'
	else
	begin
		insert into DONHANG values (@SoDH,@NgayDH,@NgayGH )
		print N'Thêm thành công dữ liệu vào bảng DonHang'
	end
end
go 
--
exec SP_DONHANG 1,'03-03-2022','03-06-2022'
exec SP_DONHANG 2,'03-03-2022','03-09-2022'
exec SP_DONHANG 3,'03-03-2022','03-11-2022'

if OBJECT_ID('SP_CTDH') is not null 
DROP PROC SP_CTDH
go 
create proc SP_CTDH
(@SoDH int ,@MaH nvarchar(10) ,@Soluong int , @DonGia decimal)
as
begin
	if(@SoDH is null or @MaH is null or @Soluong is null or @DonGia is null )
	print N'Dữ liệu nhập vào không đươc để trống'
	else
	begin
		insert into CTDH values (@SoDH,@MaH,@Soluong,@DonGia )
		print N'Thêm thành công dữ liệu vào bảng Chi tiet Don Hang'
	end
end
go 

--
exec SP_CTDH 1,'MH1',10,10000
exec SP_CTDH 1,'MH2',10,10000
exec SP_CTDH 2,'MH1',10,10000

--Câu 3: (2 điểm) Viết Hàm 
--Viết hàm các tham số đầu vào tương ứng với các cột của bảng MATHANG. Hàm này trả về MaH thỏa mãn các giá trị được truyền tham số.

if OBJECT_ID('FC_MH') is not null 
DROP function FC_MH
go 
create function FC_MH 
(  @TenH nvarchar(50), @LoaiH nvarchar(50),@DVTinh nvarchar(10))
returns table 
as 
	return (select MaH from MATHANG where TenH like @TenH and LoaiH like @LoaiH and DVTinh like @DVTinh)
go 
select * from FC_MH ('%','%','túi')
--Câu 4: (1,5 điểm) Tạo View 
--Tạo view lưu thông tin của TOP 2 có giá trị đơn hàng lớn nhất, gồm các thông tin sau: 
--MaH, TenH, LoaiH, NgayDH, NgayGH, SoLuong, DonGia, “Gia Tri Max”
if OBJECT_ID('v_c4') is not null 
DROP view v_c4
go 

create view v_c4 as
select top 2 MATHANG.MaH,TenH,LoaiH,NgayDH,NgayGH,SoLuong,DonGia, GTMax = 
(
select top 1 sum(Soluong*DonGia)
from DONHANG 
join CTDH on CTDH.SoDH = DONHANG.SoDH
join MATHANG on MATHANG.MaH = CTDH.MaH
group by MATHANG.MaH,TenH,LoaiH,NgayDH,NgayGH,SoLuong,DonGia
order by  sum(Soluong*DonGia) desc
)
from DONHANG 
join CTDH on CTDH.SoDH = DONHANG.SoDH
join MATHANG on MATHANG.MaH = CTDH.MaH
group by MATHANG.MaH,TenH,LoaiH,NgayDH,NgayGH,SoLuong,DonGia
order by  sum(Soluong*DonGia) desc
go
select * from v_c4
--Câu 5: (2 điểm) Viết thủ tục 
--Viết một SP nhận 1 tham số đầu vào là SoLuong, SP này thực hiện thao tác xóa thông tin mặt hàng và đơn hàng tương ứng.
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi 1 thao tác xóa được thực hiện không thành công. 
--Lưu ý! Tên CSDL: CSDL_Tên Sinh Viên _MSSV . Xóa hết các CSDL trên máy. Ngắt Internet, không trao đổi. Giám thị nhắc lần 1 trừ 2 điểm, lần 2 trừ 5 điểm, lần 3 hủy bài thi.
if OBJECT_ID('SP_xoa') is not null 
DROP PROC SP_xoa
go 
create proc SP_xoa @soLuong int 
as
begin
begin try 
	begin tran
		declare @thongKe table(SoDH int,MaH nvarchar(10))
		insert into @thongKe
		select SoDH,MaH from CTDH 
		where Soluong = @soLuong

		delete  CTDH where MaH in (select MaH from @thongKe) or SoDH in (select SoDH from @thongKe)
		
		delete MATHANG where MaH in(select MaH from @thongKe)
		delete DONHANG where SoDH in(select SoDH from @thongKe)

				--declare @Bang table (MaH nvarchar(10))
		--Declare @mah nvarchar(10)
		--declare @sohd int
		--select @mah = MaH from MATHANG where MaH in (Select MaH From CTDH Where SoLuong = @soluong)
		--select @sohd = SoDH from DONHANG where SoDH in (Select SoDH From CTDH Where SoLuong =  @soluong)
		--Delete From CTDH Where SoLuong = @soluong
		--Delete From MATHANG Where MaH = @mah
		--Delete From DONHANG Where SoDH = @sohd
		
	commit tran
end try 
begin catch 
	print 'Loi: ' + Error_Message()
	rollback tran
end catch 
end
go
exec SP_xoa 10
declare @thongKe table(SoDH int,MaH nvarchar(10),soluong int)
		insert into @thongKe
		select SoDH,MaH,Soluong from CTDH 
		where Soluong = 100

		
		delete  CTDH where MaH in (select MaH from @thongKe) 
		
		delete MATHANG where MaH in(
		select MaH from @thongKe  c join CTDH ct on ct.MaH= c.MaH where ct.soluong = c.soluong) 
		delete DONHANG where SoDH in(select SoDH from @thongKe )
exec SP_MATHANG N'MH1',N'Bánh',N'loại 1',N'túi'
exec SP_MATHANG N'MH2',N'Kẹo',N'loại 2',N'túi'
exec SP_MATHANG N'MH3',N'Sữa',N'loại 1',N'lít'
exec SP_MATHANG N'MH4',N'Sữa',N'loại 1',N'lít'
exec SP_MATHANG N'MH5',N'Sữa',N'loại 1',N'lít'
exec SP_MATHANG N'MH6',N'Sữa',N'loại 1',N'lít'
exec SP_MATHANG N'MH7',N'Sữa',N'loại 1',N'lít'


exec SP_DONHANG 1,'03-03-2022','03-06-2022'
exec SP_DONHANG 2,'03-03-2022','03-09-2022'
exec SP_DONHANG 3,'03-03-2022','03-11-2022'
exec SP_DONHANG 4,'03-03-2022','03-11-2022'
exec SP_DONHANG 5,'03-03-2022','03-11-2022'
exec SP_DONHANG 6,'03-03-2022','03-11-2022'
exec SP_DONHANG 7,'03-03-2022','03-11-2022'


exec SP_CTDH 1,'MH1',10,10000
exec SP_CTDH 2,'MH2',10,10000
exec SP_CTDH 3,'MH3',10,10000
exec SP_CTDH 4,'MH4',9,10000
exec SP_CTDH 5,'MH5',10,10000
exec SP_CTDH 6,'MH6',1,10000
exec SP_CTDH 7,'MH7',100,10000
exec SP_CTDH 7,'MH2',100,10000


select * from MATHANG
select * from DONHANG
select * from CTDH

exec SP_MATHANG N'MH1',N'Bánh',N'loại 1',N'túi'
exec SP_MATHANG N'MH2',N'Kẹo',N'loại 2',N'túi'
exec SP_MATHANG N'MH3',N'Sữa',N'loại 1',N'lít'

exec SP_DONHANG 1,'03-03-2022','03-06-2022'
exec SP_DONHANG 2,'03-03-2022','03-09-2022'
exec SP_DONHANG 3,'03-03-2022','03-11-2022'

exec SP_CTDH 1,'MH1',100,10000
exec SP_CTDH 1,'MH2',122,10000
exec SP_CTDH 2,'MH2',10,10000
exec SP_CTDH 3,'MH3',111,10000

select * from CTDH
select * from MATHANG
select * from DONHANG
