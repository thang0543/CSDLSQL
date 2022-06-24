select MA_NVIEN,MADA,STT, cast(THOIGIAN as nvarchar)as N'Thời gian' from PHANCONG
select MA_NVIEN,MADA,STT, convert( nvarchar, THOIGIAN)as N'Thời gian' from PHANCONG

--Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên
--tham dự đề án đó.
--o Xuất định dạng “tổng số giờ làm việc” kiểu decimal với 2 số thập phân.
--o Xuất định dạng “tổng số giờ làm việc” kiểu varchar


select  convert(decimal(5,2),sum(c.THOIGIAN)) as N'tổng số giờ làm việc', TENDEAN from DEAN a
inner join CONGVIEC b on b.MADA = a.MADA
inner join  PHANCONG c on c.MADA = a.MADA
group by a.TENDEAN

select  cast(sum(c.THOIGIAN) as nvarchar) as N'tổng số giờ làm việc', TENDEAN from DEAN a
inner join CONGVIEC b on b.MADA = a.MADA
inner join  PHANCONG c on c.MADA = a.MADA
group by a.TENDEAN


--➢ Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm
--việc cho phòng ban đó.
--o Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu
--phẩy để phân biệt phần nguyên và phần thập phân.
--o Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3
--chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace

select TENPHG,format(convert(decimal(15,2),avg(b.LUONG),2),'N','vi-VN') from PHONGBAN a
inner join NHANVIEN b on a.MAPHG = b.PHG
group by (TENPHG)

select TENPHG,convert(varchar(50),cast(avg(b.LUONG) as money),1) from PHONGBAN a
inner join NHANVIEN b on a.MAPHG = b.PHG
group by (TENPHG)


select TENPHG,
REPLACE(left(CONVERT(nvarchar,avg(b.LUONG)),len(CONVERT(nvarchar,avg(b.LUONG)))-3),'.',',')+','+RIGHT(CONVERT(nvarchar,avg(b.LUONG)),2)
from PHONGBAN a
inner join NHANVIEN b on a.MAPHG = b.PHG
group by (TENPHG)


--Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên
--tham dự đề án đó.
--o Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
select MADA,
CEILING(sum(THOIGIAN)),
FLOOR(sum(THOIGIAN)),
 round(sum(THOIGIAN),2)
from PHANCONG
group by MADA

select b.TENDEAN,
CEILING(sum(THOIGIAN))as N'Thời gian lam việc'
from PHANCONG a
inner join DEAN b on b.MADA = a.MADA
group by b.TENDEAN
--o Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
--o Xuất định dạng “tổng số giờ làm việc” làm tròn tới 2 chữ số thập phân
--➢ Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương
--trung bình (làm tròn đến 2 số thập phân) của phòng "Nghiên cứu"
select HONV + ' ' +TENLOT +' ' + TENNV as 'họ tên ', LUONG from NHANVIEN where LUONG > 
(select avg(LUONG) from NHANVIEN 
where PHG in(select MAPHG from PHONGBAN where TENPHG like N'Nghiên cứu'))


--Danh sách những nhân viên (HONV, TENLOT, TENNV, DCHI) có trên 2 thân nhân,
--thỏa các yêu cầu
--o Dữ liệu cột HONV được viết in hoa toàn bộ
--o Dữ liệu cột TENLOT được viết chữ thường toàn bộQuản trị cơ sở dữ liệu với SQL Server
--3
--o Dữ liệu chột TENNV có ký tự thứ 2 được viết in hoa, các ký tự còn lại viết
--thường( ví dụ: kHanh)
--o Dữ liệu cột DCHI chỉ hiển thị phần tên đường, không hiển thị các thông tin khác
--như số nhà hay thành phố.
select UPPER(HONV),LOWER(TENLOT),LOWER(left(TENNV,1))+UPPER(SUBSTRING(TENNV,2,1))+LOWER(SUBSTRING(TENNV,3,LEN(TENNV))),
SUBSTRING(DCHI,CHARINDEX(' ',DCHI)+1,CHARINDEX(',',DCHI)- CHARINDEX(' ',DCHI)-1)
from NHANVIEN a
inner join THANNHAN b on a.MANV = b.MA_NVIEN
group by HONV, TENLOT,TENNV,DCHI
having count(b.MA_NVIEN) >= 2

select count(MA_NVIEN) from THANNHAN
group by MA_NVIEN

--➢ Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất,
--hiển thị thêm một cột thay thế tên trưởng phòng bằng tên “Fpoly”

declare @ThongKe table(PHG int, sumNV int, MA_NQL nvarchar(9) )
insert into @ThongKe
select PHG, count(MANV),MA_NQL from NHANVIEN
group by PHG,MA_NQL

declare @MaxNV int 
select @MaxNV = max(sumNV) from @ThongKe
select HONV + ' '+ TENLOT+' '+'Fpoly' from PHONGBAN a
inner join (select * from @ThongKe where sumNV = @MaxNV) b on a.MAPHG = b.PHG
inner join NHANVIEN c on c.MANV = b.MA_NQL

-- Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965.
--➢ Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại.
--➢ Dựa vào dữ liệu NGSINH, cho biết nhân viên sinh vào thứ mấy.
--➢ Cho biết số lượng nhân viên, tên trưởng phòng, ngày nhận chức trưởng phòng và ngày
--nhận chức trưởng phòng hiển thi theo định dạng dd-mm-yy (ví dụ 25-04-2019)

select HONV,TENLOT,TENNV, DATEDIFF(YEAR,NGSINH,GETDATE())as  N'tuoi', DATENAME(WEEKDAY,NGSINH) as N'Thu' from NHANVIEN
where DATENAME(YEAR,NGSINH) > 1960 or DATENAME(YEAR,NGSINH) < 1965

select b.Sl, c.TENNV,NG_NHANCHUC,convert(date, NG_NHANCHUC,3) as Ngay from PHONGBAN a
inner Join(select PHG, count(MANV) as Sl from NHANVIEN group by PHG) b on a.MAPHG = b.PHG
inner Join NHANVIEN c on c.MA_NQL = a.TRPHG
