declare @Tong int
select @Tong = count(MADA) from DEAN a
inner join PHONGBAN b on a.PHONG = b.MAPHG
inner join NHANVIEN c on c.PHG = b.MAPHG
where MANV like '001'
print 'tong ' + cast(@Tong as nvarchar)
print 'tong ' + convert(nvarchar, @Tong)



declare @ThongTin table(MANV nvarchar(50), maDA int,tong int)
insert into @ThongTin
select  MA_NVIEN,MADA, count(MADA) from PHANCONG

select a.MANV,UPPER(TENNV) as ten,convert(nvarchar,NGSINH,101), DATEDIFF(year, NGSINH,getdate()),tong from NHANVIEN a
 join @ThongTin b on b.MANV = a.MANV

