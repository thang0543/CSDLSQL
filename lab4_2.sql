begin try
insert into CONGVIEC(MADA,STT,TEN_CONG_VIEC)
values (3,12,'Thiet ke');
print 'them du lieu Thanh cong'
end try

begin catch
print 'them du lieu That bai'
end catch

--raiserror() 

select MANV, TENNV, IIF(PHAI like 'nam', 'Mr.','Ms.') as GioiTinh,
NGSINH,DATEDIFF(year,NGSINH,GETDATE())as 'tuoi',
TrangThai = case 
when year(NGSINH) > 1960 then 'tuoi gia'
when year(NGSINH) <  1960 then 'tuoi tre'
end
from NHANVIEN