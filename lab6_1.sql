--Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì
--xuất thông báo “luong phải >15000’
--➢ Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.
--➢ Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM

create trigger addNhanVien on NhanVien
for insert
as
if exists(select * from NHANVIEN where Luong <= 15000)
begin
print 'luong phải >15000'
rollback tran
end



CREATE TRIGGER TG_insertNhanVien2 on NHANVIEN
for INSERT 
AS
    DECLARE @age int 
    SET @age = YEAR(GETDATE()) - (select YEAR(NGSINH) from inserted)
    IF (@age <18 or @age >65)
    BEGIN 
        PRINT N'Tuổi không hợp lệ'
        ROLLBACK TRANSACTION
    END 


create trigger updateTP on NhanVien
for update
as
if exists(select * from inserted where DCHI like '%tp HCM%')
begin 
print 'no update'
rollback tran
end

--➢ Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động
--thêm mới nhân viên.
create trigger ThongKe1 on NhanVien
after insert
as
begin
declare @Nam int, @nu int;
select @nam = count(*)  from NhanVien where Phai like 'nam'
select @nu = count(*)   from NhanVien where Phai like N'nữ'
print 'tong so nhan vien nam la: ' + cast(@nam as varchar)
print 'tong so nhan vien nu la: ' + cast(@nu as varchar)
end
--➢ Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động
--cập nhật phần giới tính nhân viên
create trigger ThongKe2 on NhanVien
after update 
as
begin
declare @Nam int, @nu int;
select @nam = count(*)  from NhanVien where Phai like 'nam'
select @nu = count(*)   from NhanVien where Phai like N'nữ'
print 'tong so nhan vien nam la: ' + cast(@nam as varchar)
print 'tong so nhan vien nu la: ' + cast(@nu as varchar)
end 
--➢ Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng
--DEAN

create trigger thongke3 on DEAN
after delete
as
begin
declare @thongKe table(maNV nvarchar(9), tong int)
insert  @thongKe
select MA_NVIEN, count(MADA) from PHANCONG
group by MA_NVIEN
end


--Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân
--viên trong bảng nhân viên.
create trigger deleteNhanVien on NhanVien
instead of delete 
as
begin
  delete THANNHAN where MA_NVIEN in (select MA_NVIEN from deleted)
  delete NHANVIEN where MANV in(select MANV from deleted);
end

--➢ Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA
--là 1.

select * from nhanVien
create trigger dean on NhanVien
instead of insert
as
begin
update PHANCONG
set MADA = 1
where MA_NVIEN in(select MANV from inserted)
end