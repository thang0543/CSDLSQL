--Viết chương trình xem xét có tăng lương cho nhân viên hay không. Hiển thị cột thứ 1 là
--TenNV, cột thứ 2 nhận giá trị
--o “TangLuong” nếu lương hiện tại của nhân viên nhở hơn trung bình lương trong
--phòng mà nhân viên đó đang làm việc.
--o “KhongTangLuong “ nếu lương hiện tại của nhân viên lớn hơn trung bình lương
--trong phòng mà nhân viên đó đang làm việc.
declare @TangLuong table (avgLuong float, PHG int)
insert into @TangLuong
select  avg(LUONG),PHG from NHANVIEN
group by PHG
select TENNV, iif(LUONG<b.avgLuong,'TangLuong','khongTangLuong')as 'giá trị' from NHANVIEN a
inner join @TangLuong b on a.PHG = b.PHG
select * from NHANVIEN

--➢ Viết chương trình phân loại nhân viên dựa vào mức lương.
--o Nếu lương nhân viên nhỏ hơn trung bình lương mà nhân viên đó đang làm việc thì
--xếp loại “nhanvien”, ngược lại xếp loại “truongphong”
declare @ThongKe table (avgLuong float, PHG int)
insert into @ThongKe
select  avg(LUONG),PHG from NHANVIEN
group by PHG
select TENNV, iif(LUONG>avgLuong,'truongphong','nhanvien')as 'Chức vụ' from NHANVIEN a
inner join @ThongKe b on a.PHG = b.PHG

--➢ .Viết chương trình hiển thị TenNV như hình bên dưới, tùy vào cột phái của nhân viên

select 
case Phai
when N'nam' then 'mr.'+TENNV
when N'nữ' then 'ms.'+TENNV
end as 'tenNV'
from NHANVIEN

--Viết chương trình tính thuế mà nhân viên phải đóng theo công thức:
--o 0<luong<25000 thì đóng 10% tiền lương
--o 25000<luong<30000 thì đóng 12% tiền lương
--o 30000<luong<40000 thì đóng 15% tiền lương
--o 40000<luong<50000 thì đóng 20% tiền lương
--o Luong>50000 đóng 25% tiền lương

select 
TENNV, LUONG, thue = case 
when LUONG between 0 and 25000 then LUONG*0.1
when LUONG between 25000 and 30000 then LUONG*0.12
when LUONG between 30000 and 40000 then LUONG*0.15
when LUONG between 40000 and 50000 then LUONG*0.2
when LUONG > 50000 then LUONG*0.25

end
from NHANVIEN

 --Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn.
 declare @max int, @count int = 1
select @max = max(cast(MANV as int)) from NHANVIEN

while @count <= @max
begin 
	if(@count = 4)
		begin
		set @count += 1
		continue
		end
	if(@count%2 = 0)
	begin
		select HONV,TENLOT,TENNV from NHANVIEN
		where cast(MANV as int) like @count
	end
	set @count += 1
end
 
-- ➢ Thực hiện chèn thêm một dòng dữ liệu vào bảng PhongBan theo 2 bước
--o Nhận thông báo “ thêm dư lieu thành cong” từ khối Try
--o Chèn sai kiểu dữ liệu cột MaPHG để nhận thông báo lỗi “Them dư lieu that bai”
--từ khối Catch
--➢ Viết chương trình khai báo biến @chia, thực hiện phép chia @chia cho số 0 và dùng
--RAISERROR để thông báo lỗi.

begin try
insert into PHONGBAN(MAPHG,TENPHG,TRPHG,NG_NHANCHUC)
values ('San xuat',4,'934902','2020-9-7')
print  'thêm dư lieu thành cong'
end try
begin catch
print 'Them dư lieu that bai'
end catch

begin try
declare @chia int = 55/0;

end try
begin catch
declare @erromessage nvarchar, @erroServer int ,@erroStat int

select @erromessage = ERROR_MESSAGE(),
@erroServer = ERROR_SEVERITY(),
@erroStat = ERROR_STATE();

raiserror(@erromessage,@erroServer,@erroStat)

end catch