use QLDA
go 
select *from NHANVIEN
--1. Tìm các nhân viên làm việc ở phòng số 4
select * from NHANVIEN
where PHG = 4
--2. Tìm các nhân viên có mức lương trên 30000
select * from NHANVIEN
where LUONG > 30000
--3A.Cho biết thông tin về nhân viên và số nhân thân của họ,
--Kể cả những nhân viên không có nhân thân nào
--Thông tin: MaNV, họ tên, số thân nhân
select MANV, HONV+' ' + TENLOT+' ' + TENNV as 'ho ten', count(b.MA_NVIEN) from NHANVIEN a
left join THANNHAN b on b.MA_NVIEN = a.MANV
group by MANV, HONV+' ' + TENLOT+' ' + TENNV 

select * from THANNHAN

select * from NHANVIEN
where (LUONG > 25000 and PHG = 4) or (LUONG > 30000 and PHG = 5)
--4. Cho biết họ tên đầy đủ của các nhân viên ở TP HCM
select * from NHANVIEN
where DCHI like '%TP HCM%'
--5. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự N
select  HONV+' ' + TENLOT+' ' + TENNV as 'ho ten' from  NHANVIEN
where HONV like 'N%'
--6. Cho biết ngày sinh và địa chỉ của nhân viên Dinh Ba Tien.
select NGSINH,DCHI from  NHANVIEN
where HONV like N'Dinh' and TENLOT like N'Ba' and TENNV like N'Tien'
