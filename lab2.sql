select * from PHONGBAN
select * from NHANVIEN
select * from CONGVIEC

select MANV, HONV+ ' '+TENLOT+' ' +TENNV as'Ho ten',NGSINH,DCHI,b.MAPHG,b.TENPHG,b.TRPHG  from NHANVIEN a
inner join PHONGBAN b on b.MAPHG = a.PHG

select MANV, HONV+ ' '+TENLOT+' ' +TENNV as'Ho ten',NGSINH,DCHI,b.MAPHG,b.TENPHG,b.TRPHG  from NHANVIEN a
inner join PHONGBAN b on b.MAPHG = a.PHG
where MAPHG like '5'

select a.MANV, HONV+ ' '+TENLOT+' ' +TENNV as'Ho ten', a.PHG,b.THOIGIAN,c.TEN_CONG_VIEC  from NHANVIEN a
inner join PHANCONG b on b.MA_NVIEN = a.MANV
inner join CONGVIEC c on c.MADA = b.MADA

select a.MANV, HONV+ ' '+TENLOT+' ' +TENNV as'Ho ten', a.PHG,b.THOIGIAN,c.TEN_CONG_VIEC  from NHANVIEN a
inner join PHANCONG b on b.MA_NVIEN = a.MANV
inner join CONGVIEC c on c.MADA = b.MADA
inner join PHONGBAN d on d.MAPHG = a.PHG
where d.MAPHG like '4'
--8
select * from  PHONGBAN a 
left join DEAN  b on b.PHONG = a.MAPHG
--9
--c1
select MAPHG, TENPHG, count(MADA) from  PHONGBAN a 
 join  DEAN b on b.PHONG = a.MAPHG
group by MAPHG, TENPHG
--c2
select MAPHG, TENPHG from  PHONGBAN a 
 join  DEAN b on b.PHONG = a.MAPHG
where TENDEAN is null
--c3
select *
from PHONGBAN where MAPHG not in(Select distinct PHONG  from DEAN)



select MAPHG, TENPHG, count(MADA) from  PHONGBAN a 
left join  DEAN b on b.PHONG = a.MAPHG
group by MAPHG, TENPHG
having count(MADA) = 0

select MAPHG, TENPHG, count(b.MANV) from PHONGBAN a
left join NHANVIEN b on a.MAPHG = b.PHG
group by MAPHG, TENPHG
--12 thêm cột và đặt giá trị mặc đinh 
alter  table NHANVIEN add  QuocTich nvarchar(100) default 'Vietnam' with values

insert into THANNHAN(MA_NVIEN,NGSINH,PHAI,QUANHE,TENTN)
values ('017','2019/09/19','nam',N'vợ','Lê Văn Tèo')

update NHANVIEN
set PHAI = 'Nam'
where MANV like '002'

select top 1 MANV,TENNV from NHANVIEN
order by LUONG desc 

select Avg(LUONG) from NHANVIEN
