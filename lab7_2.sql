if OBJECT_ID('fn_ThongKe') is not null
drop function fn_ThongKe

Giảng Viên Trần Thị Hiếu12:32
--Bài 1: Xây dựng hàm có tham số đầu vào MaDA, hàm trả về tổng số thời gian làm việc của dự án truyền vào.  
---	Viết  lời gọi hàm
--Bài 2: Xây dựng hàm có tham số đầu vào là MaDA. Hàm trả về thông tin phòng ban thực hiện dự án truyền vào: MaDA, TenDA, TenPhong. Thực hiện bài toán bằng 2 cách. Viết lời goi hàm
--a.	Dùng hàm giá trị bảng đơn giản
--b.	Dùng hàm giá trị bảng đa câu lệnh.
--Bài 1: Xây dựng hàm có tham số đầu vào MaDA, hàm trả về tổng số thời gian làm việc của dự án truyền vào.  
---	Viết  lời gọi hàm


create function fn_ThongKe(@MaDuAn int)
returns int
as
begin
  return (select sum(THOIGIAN) from PHANCONG where MADA =  @MaDuAn )
end

print 'so h lam viec la: ' + cast(dbo.fn_ThongKe(1) as nvarchar)

--Bài 2: Xây dựng hàm có tham số đầu vào là MaDA. Hàm trả về thông tin phòng ban thực hiện dự án truyền vào:
--MaDA, TenDA, TenPhong. Thực hiện bài toán bằng 2 cách. Viết lời goi hàm
--a.	Dùng hàm giá trị bảng đơn giản
--b.	Dùng hàm giá trị bảng đa câu lệnh.

create function fn_thongKe2(@MaDuAn int)
returns @ThongKe table(maDa int, TenDa nvarchar(50), TenPhong nvarchar(50))
as
begin
insert into @ThongKe
select MADA,TENDEAN,TENPHG from DeAn da 
join PHONGBAN pb on da.PHONG = pb.MAPHG
where MADA = @MaDuAn
return
end

create function fn_thongKe3(@MaDuAn int)
returns table
as
return(select MADA,TENDEAN,TENPHG from DeAn da 
join PHONGBAN pb on da.PHONG = pb.MAPHG
where MADA = @MaDuAn)


select * from fn_thongKe2(1)
select * from fn_thongKe3(1)
