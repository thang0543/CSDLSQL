if OBJECT_ID('sp_ThanNhan') is not null
drop proc sp_ThanNhan

create proc sp_ThanNhan
    @MA_NVIEN nvarchar(9) = NULL,
	@TENTN nvarchar(15) = NULL,
	@PHAI nvarchar(3) = NULL,
	@NGSINH date = NULL,
	@QUANHE nvarchar(15) = NULL
as
begin
 if(@MA_NVIEN is null or @TENTN is null or @PHAI is null or @NGSINH  is null or @QUANHE is null )
 print 'vui long nhap day du'
 else if not exists (select * from NHANVIEN where  MANV like @MA_NVIEN)
  print 'ma nhan vien khong ton tai'
  else if exists (select * from THANNHAN where TENTN like @TENTN and MA_NVIEN like @MA_NVIEN)
  print 'ten than nhan da ton tai'
 else
 begin
 begin try
 insert into THANNHAN
 values(
 @MA_NVIEN,
	@TENTN ,
	@PHAI,
	@NGSINH ,
	@QUANHE
 )
 print 'them thanh cong'
 end try
 begin catch
 print 'loi du lieu'
 end catch
 end
end

select * from THANNHAN
exec sp_ThanNhan
exec sp_ThanNhan '001','anh','nu','1999-09-9','vo chong'
exec sp_ThanNhan '001','Minh','nu','1999-09-9','vo chong'
exec sp_ThanNhan '999','minh','nam','1999-09-9','vo chong'
--------------------------------------
if OBJECT_ID('sp_Thongke') is not null
drop proc sp_Thongke

create proc sp_Thongke
@MaNV nvarchar(9) = '%'
as
begin
select * from NHANVIEN where MANV like @MaNV
end

exec sp_Thongke 
exec sp_Thongke '001' 