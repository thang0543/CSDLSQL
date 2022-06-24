declare @tong int 
select @tong = count(MAPHG) from PHONGBAN
print 'So phong ban: ' + cast(@tong as nvarchar)

declare @thongke table (ten nvarchar(15), phai nvarchar(3 ), NgaySinh date, MoiQuanHe nvarchar(15))
insert into @thongke
select TENTN,Phai,NGSINH,QUANHE from THANNHAN
where MA_NVIEN like '009'
select * from @thongke 
