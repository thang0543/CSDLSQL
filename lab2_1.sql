declare @ChieuDai int , @ChieuRong int, @DienTich int, @ChuVi int
set @ChieuDai = 10
set @ChieuRong = 2
set @DienTich = @ChieuDai * @ChieuRong
set @ChuVi = (@ChieuDai + @ChieuRong) *2
select @DienTich as 'dienTich'
select 'Chu vi: ' + cast(@DienTich as varchar)
print 'Dien Tich: ' +  convert(char(12),@DienTich)
print 'Chu vi: ' + convert(char(12),@ChuVi)

--1. Cho biêt nhân viên có lương cao nhất
declare @max float;
select @max = max(LUONG) from NHANVIEN
select * from NHANVIEN where LUONG = @max

--2. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương
--trên mức lương trung bình của phòng "Nghiên cứu”
declare @avg float, @PhongBan int;
select  @avg = avg(LUONG) from NHANVIEN
select @PhongBan =  MAPHG from PHONGBAN where TENPHG like N'Nghiên cứu'
select HONV, TENLOT, TENNV from NHANVIEN
where LUONG > @avg and PHG = @PhongBan
select * from PHONGBAN;
--3. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên
--phòng ban và số lượng nhân viên của phòng ban đó.
declare @ThongKe table(MPHG int, avgSalary float, ten nvarchar(100), soLuong int)
insert into @ThongKe
select PHG,  AVG(LUONG), b.TENPHG , count(MANV) from NHANVIEN a
inner join PHONGBAN b on a.PHG = b.MAPHG
group by PHG , b.TENPHG
having  AVG(LUONG) > 30000

select * from @ThongKe


--4. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà
--phòng ban đó chủ trì
select * from DEAN
declare @ThongKeSoDuAn table (ten nvarchar(100), soLuong int)
insert into @ThongKeSoDuAn
select b.TENPHG, count(a.MADA) from DEAN a
right join PHONGBAN b on b.MAPHG = a.PHONG
group by(b.TENPHG)
select * from @ThongKeSoDuAn
--5 tinh tong nhan vien
declare @sum int
select @sum = count(MANV) from NHANVIEN
select @sum as N'Tong'
print 'tong: '+ cast(@sum as nvarchar)