create database QuanLiNhaTro
go 
use QuanLiNhaTro
go

create table Quan(
MaQuan varchar(10) not null,
tenQuan nvarchar(50) not null,
primary key(MaQuan)
)

create table loaiNha(
maLN varchar(10) not null,
tenLN nvarchar(50) not null,
primary key (maLN) 
)

create table NguoiDung(
MaND varchar(10) not null,
tenND nvarchar(50) not null,
GioiTinh nvarchar(7) not null,
DienThoai nvarchar(13) not null,
DiaChi nvarchar(100) not null,
MaQuan varchar(10) not null,
email nvarchar(100) not null,
primary key(MaND),

foreign key(MaQuan) references Quan(MaQuan)
)

create table nhaTro(
MaNT varchar(10) not null,
maLN varchar(10) not null,
dienTich int not null,
giaPhong money not null,
diaChi nvarchar(100) not null,
MaQuan varchar(10) not null,
Mota nvarchar(100) not null,
ngaydang date not null,
nguoiLienHe varchar(10) not null,
primary key(MaNT),
foreign key(maLN) references loaiNha(maLN),
foreign key(MaQuan) references Quan(MaQuan),
foreign key(nguoiLienHe) references NguoiDung(MaND),
)





create table HopDongThue(
MaND varchar(10) not null,
MaNhaTro varchar(10) not null,
NgayDen date not null,
ngayDi date not null,
primary key(MaND, MaNhaTro),
foreign key(MaND) references NguoiDung(MaND),
foreign key(MaNhaTro) references nhaTro(MaNT)
)
create table DanhGia(
MaDG varchar(10) not null,
MaND varchar(10) not null,
MaNhaTro varchar(10) not null,
likes bit not null,
NoiDung nvarchar(1000) not null,
primary key(MaDG),
foreign key(MaND,MaNhaTro) references HopDongThue(MaND,MaNhaTro)
)