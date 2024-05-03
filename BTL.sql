create database QlyBanMayTinh_G05
go
drop database QlyBanMayTinh_G05
go

use QlyBanMayTinh_G05
go

-- tao bang loai hang
create table tblLoaiHang
(
	sMaLH varchar(6) not null Primary key,
	sTenLH nvarchar(30) not null
)
go
-- tao bang nha cung cap
create table tblNhaCungCap
(
	iMaNCC int not null Primary key,
	sTenNCC nvarchar(20) not null,
	sDiaChi Nvarchar(50) not null,
	sDienThoai varchar(10) not null
)
go
-- tao bang mat hang
create table tblMatHang
(
	sMaMH varchar(6) not null Primary key,
	sTenMH nvarchar(50) not null,
	iMaNCC int not null,
	sMaLH varchar(6) not null,
	fSoLuong float not null,
	fGiaHang float not null,
	sDonViTinh nvarchar(10) not null

	Foreign key(iMaNCC) REFERENCES dbo.tblNhaCungCap(iMaNCC) ON DELETE CASCADE,
	Foreign key(sMaLH) REFERENCES dbo.tblLoaiHang(sMaLH) ON DELETE CASCADE
)
go
-- tao bang khach hang
create table tblKhachHang
(
	iMaKH int not null Primary key,
	sTenKH nvarchar(30) not null,
	bGioiTinh bit not null,
	sDiaChi nvarchar(50) not null,
	sDienThoai varchar(10) not null
)
go
-- tao bang nhan vien
create table tblNhanVien
(
	iMaNV int not null Primary key,
	sTenNV nvarchar(30) not null,
	bGioiTinh bit not null,
	sDiaChi nvarchar(50) not null,
	sDienThoai varchar(10) not null,
	dNgaySinh datetime not null,
	dNgayVaoLam datetime not null,
	fLuongCoBan float not null,
	fHeSoLuong float not null,
	fPhuCap float not null
)
go
ALTER TABLE dbo.tblNhanVien ADD CONSTRAINT CheckTuoiNV CHECK (datediff(YEAR,dNgaySinh, dNgayVaoLam) >=18)
-- tao bang hoa don
create table tblHoaDon
(
	iMaHD int not null Primary key,
	iMaNV int not null,
	iMaKH int not null,
	dNgayMua date not null,
	dNgayGiaoHang date not null,
	sDiaChiGiaoHang nvarchar(30) not null

	Foreign key(iMaNV) REFERENCES dbo.tblNhanVien(iMaNV) ON DELETE CASCADE,
	Foreign key(iMaKH) REFERENCES dbo.tblKhachHang(iMaKH) ON DELETE CASCADE
)
go
ALTER TABLE tblHoadon ADD CONSTRAINT CheckNgayMua CHECK(dNgayMua <= GETDATE())
ALTER TABLE tblHoadon ADD CONSTRAINT CheckNgayGiaoHang CHECK(dNgayGiaoHang >= dNgayMua)
-- tao bang cho tiet hoa don
create table tblChiTietHoaDon
(
	iMaHD int not null Foreign key(iMaHD) REFERENCES dbo.tblHoaDon(iMaHD) ON DELETE CASCADE,
	sMaMH varchar(6) not null Foreign key(sMaMH) REFERENCES dbo.tblMatHang(sMaMH) ON DELETE CASCADE,
	fGiaBan float not null,
	iSoLuong int not null,
	fMucGiamGia float not null

	Primary key(iMaHD, sMaMH)
)
go
-- tao bang phieu nhap
create table tblPhieuNhap
(
	iMaPN int not null Primary key,
	iMaNV int not null,
	dNgayNhap date not null

	Foreign key(iMaNV) REFERENCES dbo.tblNhanVien(iMaNV) ON DELETE CASCADE
)
go
-- tao bang chi tiet phieu nhap
create table tblChiTietPhieuNhap
(
	iMaPN int not null Foreign key(iMaPN) REFERENCES dbo.tblPhieuNhap(iMaPN) ON DELETE CASCADE,
	sMaMH varchar(6) not null Foreign key(sMaMH) REFERENCES dbo.tblMatHang(sMaMH) ON DELETE CASCADE,
    fGiaNhap float not null,
	iSoLuong int not null

	Primary key(iMaPN, sMaMH)
)
go

--======================================= NHẬP DỮ LIỆU CHO CÁC BẢNG ==========
-- insert du lieu bang loai hang
Insert into tblLoaiHang (sMaLH, sTenLH)
values( N'LH01', N'Máy tính'),
      ( N'LH02', N'Màn hình'),
      ( N'LH03', N'Bàn phím'),
      ( N'LH04', N'Chuột'),
      ( N'LH05', N'Tai nghe')
go
-- insert du lieu bang nha cung cap
Insert into tblNhaCungCap (iMaNCC, sTenNCC, sDiaChi, sDienThoai)
values(1, N'FPT Shop', N'TP HCM', N'0236789271'),
      (2, N'Hanoicomputer', N'Hà nội', N'0236789861'),
	  (3, N'Viettel Store', N'Hà nội', N'0236745271'),
	  (4, N'Nguyễn kim', N'TP HCM', N'0836790271'),
	  (5, N'Laptop 88', N'Hà nội', N'0936789271')
go
--  Insert du lieu cho bang mat hang
Insert into tblMatHang (sMaMH, sTenMH, iMaNCC, sMaLH, fSoLuong, fGiaHang, sDonViTinh)
values(N'MH01', N'Laptop Dell Vostro 3400', 1, N'LH01', 30, 13000000, N'Hộp'),
      (N'MH02', N'Laptop Dell Inspiron 7506', 3, N'LH01',20, 11000000, N'Hộp'),
	  (N'MH03', N'Laptop ASUS ZenBook 14 Flip', 4, N'LH01',40, 15000000, N'Hộp'),
	  (N'MH04', N'Màn hình Samsung', 2, N'LH02', 8, 3000000, N'Hộp'),
	  (N'MH05', N'Màn hình Dell', 5, N'LH02', 10, 4000000, N'Hộp'),
	  (N'MH06', N'Màn hình LG', 2, N'LH02', 5, 2000000, N'Hộp'),
	  (N'MH07', N'Bàn phím Surface pro', 3, N'LH03', 15, 350000, N'Hộp'),
	  (N'MH08', N'Bàn phím Bluetooth Logitech', 3, N'LH03', 11, 130000, N'Hộp'),
	  (N'MH09', N'Bàn phím Apple', 1, N'LH03', 9, 310000, N'Hộp'),
	  (N'MH10', N'Chuột Gaming Rapoo', 1, N'LH04', 5, 450000, N'Hộp'),
	  (N'MH11', N'Chuột Surface', 4, N'LH04', 7, 540000, N'Hộp'),
	  (N'MH12', N'Chuột Bluetooth', 4, N'LH04', 8, 620000, N'Hộp'),
	  (N'MH13', N'Tai nghe Logitech', 5, N'LH05', 2, 600000, N'Hộp'),
      (N'MH14', N'Tai nghe Samsung', 5, N'LH05', 12, 500000, N'Hộp'),
      (N'MH15', N'Tai nghe Bluetooth JBL', 3, N'LH05', 14, 370000, N'Hộp')
go
-- Insert du lieu cho bang khach hang
INSERT INTO tblKhachHang(iMaKH, sTenKH, bGioiTinh, sDiaChi, sDienThoai)
VALUES  (1, N'Nguyễn Xuân Huỳnh', 1, N'Đà Nẵng', '0598651150'),
		(2, N'Lê Đức Anh', 1, N'Hà Nam', '0397232132'),
		(3, N'Nguyễn Văn Tấn', 1, N'TP HCM', '0973212311'),
		(4, N'Hoàng Anh Tuấn', 1, N'Hà Nội', '0384112353'),
		(5, N'Nguyễn Thị Hoa', 0, N'Quảng Ninh', '0967413232'),
		(6, N'Lê Trọng Bình', 0, N'Hà Nội', '0513248235'),
		(7, N'Nguyễn Kim Ngân', 0, N'TP HCM', '0941313235'),
		(8, N'Nguyễn Hoài Thu', 0, N'Bắc Giang', '0348465122'),
		(9, N'Lê Đức Nhân', 1, N'TP HCM', '0129845163'),
		(10, N'Nguyễn Đức Thịnh', 1, N'Nam Định', '0978613222')
GO
-- Insert du lieu cho bang nhan vien
INSERT INTO tblNhanVien(iMaNV, sTenNV, bGioiTinh, sDiaChi, sDienThoai, dNgaySinh, dNgayVaoLam, fLuongCoBan, fHeSoLuong, fPhuCap)
VALUES  (1, N'Đỗ Xuân Thiện',1 ,N'Hà Nội', '0364654566', '1996/12/20', '2018/09/23', 1000000, 3, 400000),
		(2, N'Nguyễn Hoài Nam',1 ,N'Đà Nẵng', '0945131323', '1997/12/10', '2018/09/22', 1200000, 4, 400000),
		(3, N'Đỗ Thị Huyền',0, N'Quảng Ninh', '0389753489', '1999/01/20', '2020/01/30', 1400000, 5, 400000),
		(4, N'Lê Hương Giang',0, N'TP HCM', '0389765132', '1995/12/30', '2017/01/23', 2000000, 4, 400000),
		(5, N'Nhâm Thanh Tùng',1, N'Hà Nội', '0597523346', '1996/06/07', '2018/09/09', 4000000, 2, 400000),
		(6,N'Lê Thành Chính',1, N'Bắc Giang','0973078703','1996/01/29','2018/08/23', 1500000, 5, 400000),	
		(7, N'Nguyễn Tiếng Long',1, N'TP HCM', '0367239790', '1998/12/20', '2020/02/23', 1700000, 5, 400000),
		(8, N'Nguyễn Thu Trang',0, N'Hà Nội', '0911197131', '1997/12/09', '2019/09/13', 1900000, 4, 400000),
		(9,N'Đỗ Viết Thiện',1, N'Nam Định', '0396754762', '1998/12/12', '2018/12/23', 1040000, 6, 400000),
		(10, N'Nguyễn Thu Hương',0, N'Hà Nội', '0399997131', '1976/02/10', '2021/09/03', 1700000, 5, 400000)
GO
-- Insert du lieu cho bang hoa don
Insert into tblHoaDon (iMaHD, iMaNV, iMaKH, dNgayMua, dNgayGiaoHang, sDiaChiGiaoHang)
values  (1,1, 5, '2019/12/20','2020/1/1' ,N'Nam Định'),
		(2, 5, 7, '2018/06/26', '2018/7/28', N'Hải Phòng'),
		(3, 9, 4, '2019/05/20', '2019/5/29', N'Định Công'),
		(4, 5, 1, '2019/02/28', '2019/3/4', N'Trương Định'),
		(5, 10, 2, '2021/12/20', '2021/12/22', N'Cầu Giấy'),
		(6, 2, 6, '2019/12/03', '2020/1/1', N'Đông Anh'),
		(7, 4, 8, '2019/11/12', '2019/12/4', N'Xuân Đỉnh'),
		(8, 8, 7, '2019/8/20', '2019/9/2', N'Nghĩa Tân'),
		(9, 6, 10, '2018/09/30', '2018/10/2', N'Giải Phóng'),
		(10, 9, 9, '2020/1/11', '2020/2/1', N'Tam Trinh')
go
-- Insert du lieu bang chi tiet hoa don
Insert into tblChiTietHoaDon (iMaHD, sMaMH, fGiaBan, iSoLuong, fMucGiamGia)
values (1, N'MH02', 2000000, 1, 0.5),
       (2, N'MH05', 1200000, 2, 0.3),
	   (4, N'MH06', 2100000, 1, 0.2),
	   (2, N'MH01', 200000, 4, 0.1),
	   (3, N'MH04', 1000000, 3, 0.4),
	   (7, N'MH03', 500000, 1, 0.1),
	   (5, N'MH08', 700000, 4, 0.1),
	   (6, N'MH09', 4000000, 1, 0.3),
	   (9, N'MH07', 900000, 1, 0.6),
	   (8, N'MH10', 300000, 6, 0.3),
	   (10, N'MH09', 400000, 1, 0.1),
	   (4, N'MH10', 600000, 2, 0.3),
	   (1, N'MH10', 700000, 1, 0.2),
	   (5, N'MH12', 8000000, 3, 0.1),
	   (3, N'MH11', 9000000, 1, 0.1),
	   (6, N'MH08', 220000, 5, 0.5)
go
-- Insert du lieu cho bang Phieu nhap
Insert into tblPhieuNhap (iMaPN, iMaNV, dNgayNhap)
values  (1, 1, '2021/02/01'),
		(2, 6, '2019/03/02'),
		(3, 5, '2022/04/03'),
		(4, 9, '2019/05/04'),
		(5, 2, '2019/07/06'),
		(6, 3, '2021/04/12'),
		(7, 1, '2022/05/13'),
		(8, 3, '2021/04/12')
go
-- Insert cho bang du lieu chi tiet phieu nhap
Insert into tblChiTietPhieuNhap (iMaPN, sMaMH, fGiaNhap, iSoLuong)
values  (1, N'MH02', 1000000, 2),
        (4, N'MH05', 200000, 1),
        (2, N'MH02', 200000, 3),
	    (7, N'MH09', 100000, 6),
		(6, N'MH07', 120000, 4),
		(8, N'MH10', 150000, 2),
		(3, N'MH12', 140000, 7),
		(5, N'MH12', 200000, 8),
		(1, N'MH03', 3200000, 3),
		(7, N'MH04', 1200000, 1),
		(8, N'MH03', 560000, 1),
		(4, N'MH06', 790000, 1),
		(5, N'MH02', 1600000, 2),
		(2, N'MH06', 1800000, 2),
		(2, N'MH01', 700000, 2)
go


--=============================== CÁC CÂU LỆNH TRUY VẤN LẤY DỮ LIỆU ==============================
--		LẤY DỮ LIỆU TỪ 1 BẢNG
-- Cho biết những mat hang có số lượng > 12
select * from tblMatHang where fSoLuong > 14
go

-- Cho biết thông tin nhân viên sinh năm 1996
select * from tblNhanVien where YEAR(dNgaySinh) = 1996
go

-- Cho biết nhân viên có lương cơ bản trên 1400000
select * from tblNhanVien where fLuongCoBan > 1400000
go

--Cho biết những nhà cung cấp ở Hà Nội
select * from tblNhaCungCap where sDiaChi = N'Hà nội'
go

-- Cho biết số lượng khách hàng là Nam(1)
select * from tblKhachHang where bGioiTinh = 1
go

--		LẤY DỮ LIỆU TRÊN 2 BẢNG
-- Cho biết những nhân viên lập trên 1 hóa đơn 
select * from tblNhanVien as NV
where 1 < 
	(
		select count(iMaNV) from tblHoaDon as HD
		where NV.iMaNV = HD.iMaNV
	)
go

-- Cho biết số lượng hóa đơn nhập của mỗi nhân viên
-- cach 1: inner join: nối bảng, on = where 
select NV.iMaNV, sTenNV, count(HD.iMaNV) as [Số Lượng] from tblNhanVien as NV inner join tblHoaDon as HD
on NV.iMaNV = HD.iMaNV
group by NV.iMaNV, sTenNV
go
-- cach 2
select NV.iMaNV, sTenNV, count(HD.iMaNV) as [Số Lượng] from tblNhanVien as NV, tblHoaDon as HD
where NV.iMaNV = HD.iMaNV
group by NV.iMaNV, sTenNV
go

-- Cho biết khách hàng mua nhiều hơn 1 hóa đơn
select KH.sTenKH from tblKhachHang as KH 
where 1 < 
	(
		select count(*) from tblHoaDon as HD
		where KH.iMaKH = HD.iMaKH
	)
go

-- Cho biết mặt hàng bán trong năm 2018
select MH.sTenMH from tblHoaDon as HD, tblMatHang as MH, tblChiTietHoaDon as CTHD
where HD.iMaHD = CTHD.iMaHD and CTHD.sMaMH = MH.sMaMH and YEAR(dNgayMua) = 2018
go

-- Cho biết tổng tiền bán được của từng mặt hàng
select MH.sTenMH, sum(fGiaBan) as [Tổng tiền] 
from tblMatHang as MH, tblChiTietHoaDon as CTHD, tblHoaDon as HD
where MH.sMaMH = CTHD.sMaMH and HD.iMaHD = CTHD.iMaHD
group by MH.sTenMH
go

--============================================= VIEW ===========================================
-- Số mặt hàng của từng loại hàng
create view vSoMatHangTungLoai
as
select LH.sTenLH, count(LH.sMaLH) as [Số Lượng] from tblMatHang as MH, tblLoaiHang as LH
where MH.sMaLH = LH.sMaLH
group by LH.sTenLH, LH.sMaLH
go
select * from vSoMatHangTungLoai

-- Tổng tiền của từng hóa đơn 
create view vTongTienTungHoaDon
as
select HD.iMaHD ,sum((fGiaBan*iSoLuong)*(1-fMucGiamGia)) as [Tổng Tiền] from tblHoaDon as HD, tblChiTietHoaDon as CTHD
where HD.iMaHD = CTHD.iMaHD
group by HD.iMaHD
go
select * from dbo.vTongTienTungHoaDon

-- cho biết số tiền thu được của từng tháng trong năm 2019
create view vTongTienTungThang2019
as
select MONTH(dNgayMua) as [Tháng], sum((fGiaBan*iSoLuong)*(1-fMucGiamGia)) as [Tổng Tiền ] 
from tblHoaDon as HD, tblChiTietHoaDon as CTHD
where HD.iMaHD = CTHD.iMaHD and YEAR(dNgayMua) = 2019
group by Month(dNgayMua)
go
select * from vTongTienTungThang2019

-- Cho biết danh sách các mặt hàng không được nhập về trong tháng 3 năm 2019
create view vMatHangNhapTheoNam
as
select MH.sTenMH from tblMatHang as MH
where 1 >
(
	select count(*) from tblPhieuNhap as PN, tblChiTietPhieuNhap as CTPN
	where MH.sMaMH = CTPN.sMaMH and PN.iMaPN = CTPN.iMaPN and MONTH(dNgayNhap) = 3 and YEAR(dNgayNhap) = 2019
)
go
select * from vMatHangNhapTheoNam

-- Cho biết nhân viên đang làm việc trên 3 năm
create view vSoNamNVLamViec
as
select * from tblNhanVien as NV
where YEAR(GETDATE()) - YEAR(dNgayVaoLam) > 3
go
select * from dbo.vSoNamNVLamViec

-- Cho biết khách hàng đã mua hàng trong 2020
create view vKHMuaHangTrongNam
as
select KH.* from tblKhachHang as KH, tblHoaDon as HD
where KH.iMaKH = HD.iMaKH and YEAR(dNgayMua) = 2020
go
select * from dbo.vKHMuaHangTrongNam

-- Cho biết hóa đơn xuất có giá trị trên 5tr
create view vHDCoGiaTri
as
select HD.* from tblHoaDon as HD
where 5000000 < 
	(
		select sum((fGiaBan*iSoLuong)*(1-fMucGiamGia)) from tblChiTietHoaDon as CTHD
		where HD.iMaHD = CTHD.iMaHD
	)
go
select * from dbo.vHDCoGiaTri

-- Cho biết giá bán trung bình từng loại hàng 
create view vGiaBanTBMatHang
as
select LH.sTenLH, AVG(fGiaHang) as [Giá TB] from tblMatHang as MH, tblLoaiHang as LH
where LH.sMaLH = MH.sMaLH
group by LH.sTenLH
go
select * from dbo.vGiaBanTBMatHang

-- Cho biết tên nhà cung cấp mặt hàng máy tính
create view vNCCMayTinh
as
select NCC.sTenNCC from tblNhaCungCap as NCC, tblMatHang as MH, tblLoaiHang as LH
where NCC.iMaNCC = MH.iMaNCC and MH.sMaLH = LH.sMaLH and LH.sTenLH = N'Máy tính'
go
select * from dbo.vNCCMayTinh

--Cho biết danh sách 3 khách hàng mua nhiều mặt hàng nhất
create view vKHMuaNhieuMHNhat
as
select top 3 KH.iMaKH, KH.sTenKH, count(MH.sMaMH) as [Số lượng mặt hàng] from tblKhachHang as KH, tblHoaDon as HD, tblMatHang as MH, tblChiTietHoaDon as CTHD
where KH.iMaKH = HD.iMaKH and HD.iMaHD = CTHD.iMaHD and MH.sMaMH = CTHD.sMaMH
group by KH.iMaKH, KH.sTenKH
order by [Số lượng mặt hàng] desc 
go
-- order by [namecot] desc: sx giam dan; asc: sx tang dan
select * from vKHMuaNhieuMHNhat


--=========================================== STORED PROCEDURE ===========================================
-- Tuổi cao nhất của nhân viên
create proc spMaxTuoiNV
as
begin
	declare @Max int
	select @Max = Max(YEAR(GETDATE()) - YEAR(dNgaySinh)) from tblNhanVien
	return @Max 
end
go
declare @TuoiMax int
exec @TuoiMax = dbo.spMaxTuoiNV
select @TuoiMax as [Tuổi lớn nhất của NV]

-- Lương cao nhất của nhân viên
create proc spMaxLuongNV
as
begin
	declare @Max int
	select @Max = Max(fLuongCoBan*fHeSoLuong+fPhuCap) from tblNhanVien
 	return @Max 
end
go
declare @LuongMax int
exec @LuongMax = dbo.spMaxLuongNV
select @LuongMax as [Lương cao nhất của NV]

-- Mặt Hàng bán trong năm X(X là tham số truyền vào)
create proc spMHBanTrongNam
@year int
as
begin
	select MH.sTenMH from tblMatHang as MH, tblHoaDon as HD, tblChiTietHoaDon as CTHD
	where HD.iMaHD = CTHD.iMaHD and CTHD.sMaMH = MH.sMaMH and YEAR(dNgayMua) = @year
end
go
exec spMHBanTrongNam @year = 2021
drop proc spMHBanTrongNam

-- tăng lương nhân viên làm trên 2 năm lên 1.2 lần
create proc spTangLuongNV
as 
begin
	update tblNhanVien set fLuongCoBan = fLuongCoBan * 1.2
	where YEAR(GETDATE()) - YEAR(dNgayVaoLam) > 2
end
select * from tblNhanVien
exec spTangLuongNV
select * from tblNhanVien

-- Cho biết nhân viên làm từ năm X
create proc spNVLamTuNam
@year int
as
begin
	select NV.sTenNV from tblNhanVien as NV where YEAR(dNgayVaoLam) >= @year
end
go
exec spNVLamTuNam @year = 2020

-- Thêm 1 khách hàng mới vào danh sách
create proc spThemKHMoi
@MaKH int, @TenKH nvarchar(30), @GT bit, @Diachi nvarchar(50), @Dienthoai varchar(10)
as
begin
	if(not exists (select * from tblKhachHang where iMaKH = @MaKH))
		begin
			insert into tblKhachHang
			values (@MaKH, @TenKH, @GT, @Diachi, @Dienthoai)
		end
	else
 		print N'Mã Khách hàng đã tồn tại trong dữ liệu'
end
go
exec spThemKHMoi 11, N'Nguyễn Ngọc Tuân', 1, N'Đà nẵng', N'0936789279'
select * from tblKhachHang

-- Thêm hóa đơn
create proc spThemHDMoi
@MaHD int, @MaNV int, @MaKH int, @NgayMua date, @NgayGiaoHang date, @Diachigiaohang nvarchar(30)
as 
begin
	if(not exists (select * from tblHoaDon where iMaHD = @MaHD) 
	and exists(select * from tblNhanVien where @MaNV = iMaNV) 
	and exists(select * from tblKhachHang where iMaKH = @MaKH))
		begin
			insert into tblHoaDon
			values (@MaHD, @MaNV, @MaKH, @NgayMua, @NgayGiaoHang, @Diachigiaohang)
		end
	else
		print N'Mã HD đã tồn tại hoặc Mã KH không tồn tại hoặc Mã NV không tồn tại'
end
go
exec spThemHDMoi 11,10, 5, '2021/12/22','2021/12/25' ,N'Ninh Bình'
select * from tblHoaDon

-- Thêm chi tiết hóa đơn
create proc spThemChiTietHoaDon
@MaHD int, @MaMH varchar(6), @Giaban float, @Soluong int, @Mucgiamgia float
as 
begin
	if(exists (select * from tblHoaDon where iMaHD = @MaHD) and exists (select * from tblMatHang where sMaMH = @MaMH))
		begin
			insert into tblChiTietHoaDon
			values (@MaHD, @MaMH, @Giaban, @Soluong, @Mucgiamgia)
		end
	else
		print N'Mã HD hoặc Mã MH không đúng'
end
go
exec spThemChiTietHoaDon 9, N'MH02', 3200000, 1, 0.3
select * from tblChiTietHoaDon

-- cho biết tên các loại hàng của nhà cung cấp nào đó
create proc spMHCuaNCC
@TenNCC nvarchar(30)
as
begin
	select LH.sTenLH from tblNhaCungCap as NCC, tblLoaiHang as LH, tblMatHang as MH
	where MH.sMaLH = LH.sMaLH and NCC.iMaNCC = MH.iMaNCC and NCC.sTenNCC = @TenNCC
end
go
exec spMHCuaNCC @TenNCC = N'FPT Shop'

-- Xóa 1 nhân viên trong bảng theo mã
create proc spXoaNVTheoMa
@MaNV int
as
begin
	if(not exists (select * from tblNhanVien where iMaNV = @MaNV))
		begin
			print N'Không tồn tại Nhân viên này'
			rollback tran
		end
	else
		begin
			-- Vì khi tạo bảng đã thêm ràng buộc khóa ngoại ON DELETE CASCADE nên tự động sẽ xóa dữ liêu ở các bảng liên quan
			delete from tblNhanVien where @MaNV = iMaNV
			print N'Xóa thành công nhân viên'
		end
end
go
exec spXoaNVTheoMa @MaNV = 4

-- nhập vào mã nhân viên cho biết nhân viên đó bán được bao nhiêu mặt hàng
create proc spDemNVBanMH
@MaNV int
as
begin
	select count(CTHD.sMaMH) as [Số lượng mặt hàng bán được] 
	from tblHoaDon as HD, tblChiTietHoaDon as CTHD
	where HD.iMaHD = CTHD.iMaHD and HD.iMaNV = @MaNV
end
go
exec spDemNVBanMH @MaNV = 6

-- cho biết danh sách tên các mặt hàng đã được nhập hàng từ một nhà cung cấp (theo tên NCC) trong 1 năm nào đó
create proc spDsMHNhapTuNCC
@TenNCC nvarchar(30), @Year int
as
begin
	select MH.sTenMH from tblMatHang as MH, tblNhaCungCap as NCC, tblPhieuNhap as PN, tblChiTietPhieuNhap as CTPN
	where PN.iMaPN = CTPN.iMaPN and CTPN.sMaMH = MH.sMaMH and MH.iMaNCC = NCC.iMaNCC and NCC.sTenNCC = @TenNCC and YEAR(PN.dNgayNhap) = @Year
end
go
exec spDsMHNhapTuNCC @TenNCC = N'FPT Shop', @Year = 2022

-- cho biết tên các NCC và ngày nhâp hàng đã được nhập hàng của một mặt hàng nào đó theo tên mặt hàng
create proc spTenNCCNgayNhap
@TenMH nvarchar(30)
as 
begin
	select NCC.sTenNCC, PN.dNgayNhap 
	from tblMatHang as MH, tblChiTietPhieuNhap as CTPN, tblPhieuNhap as PN, tblNhaCungCap as NCC
	where MH.iMaNCC = NCC.iMaNCC and MH.sMaMH = CTPN.sMaMH and PN.iMaPN = CTPN.iMaPN and MH.sTenMH = @TenMH
end
go
exec spTenNCCNgayNhap @TenMH = N'Màn hình DELL'

-- đặt lại mức giảm giá cho các hóa đơn được bán cho năm nào đó
create proc spDatMucGiamGia
@year int
as
begin
	update tblChiTietHoaDon set fMucGiamGia = 0.2
	from tblHoaDon as HD, tblChiTietHoaDon as CTHD
	where HD.iMaHD = CTHD.iMaHD and YEAR(dNgayMua) = @year
end
go
exec spDatMucGiamGia @year = 2020

-- cho biết số tiền bán được trong năm X
create proc spTongTienBanDuocNam
@year int
as
begin
	select sum((fGiaBan * iSoLuong)*(1 - fMucGiamGia)) as [Tổng tiền các hóa đơn]
	from tblHoaDon as HD, tblChiTietHoaDon as CTHD
	where HD.iMaHD = CTHD.iMaHD and YEAR(dNgayMua) = @year
end
go
exec spTongTienBanDuocNam @year = 2021

-- cho biết thông tin khách hàng có mã hóa đơn x
create proc spTTKHTheoMaHD
@MaHD int
as 
begin
	select KH.* from tblHoaDon as HD, tblKhachHang as KH
	where HD.iMaKH = KH.iMaKH and iMaHD = @MaHD
end
go
exec spTTKHTheoMaHD @MaHD = 1

-- cho biết các mặt hàng không được nhập về trong năm nào đó
create proc spMHDuocNhapVe
@year int
as 
begin
	select MH.sTenMH from tblMatHang as MH
	where 0 < 
		(
			select count(*) from tblPhieuNhap as PN, tblChiTietPhieuNhap as CTPN
			where PN.iMaPN = CTPN.iMaPN and CTPN.sMaMH = MH.sMaMH and YEAR(dNgayNhap) = @year
		)
end
go
exec spMHDuocNhapVe @year = 2022


--=========================================== TRIGGER ===========================================
-- mỗi khi thêm 1 bản ghi mới hoặc sửa fGiaBan chỉ chấp nhận giá bán >= giá nhập trong bảng chi tiết hóa đơn
create trigger CheckGiaBanCTHD
on tblChiTietHoaDon
for insert, update
as
begin
	declare @Giaban float, @Gianhap float, @MaMH varchar(6)
	select @Giaban = fGiaBan, @MaMH = sMaMH from inserted
	select @Gianhap = fGiaNhap from tblChiTietPhieuNhap as CTPN where CTPN.sMaMH = @MaMH
	if(@Giaban < @Gianhap)
	begin
			print N'Giá bán không thể nhỏ hơn giá nhập'
			rollback tran
		end
	else
 		print N'Thêm thành công'
end
go
insert into tblChiTietHoaDon
values (9, N'MH09', 50000, 2, 0.3)
drop trigger CheckGiaBanCTHD

-- đảm bảo số lượng hàng bán ra không vượt quá số lượng hàng hiện có 
create trigger CheckSLBanRa
on tblChiTietHoaDon
for insert, update
as 
begin
	declare @SLM int, @MaMH varchar(6), @SLCO int
	select @SLM = iSoLuong, @MaMH = sMaMH from inserted
	select @SLCO = fSoLuong from tblMatHang as MH where MH.sMaMH = @MaMH
	if(@SLM > @SLCO)
		begin
			print N'Số lượng hàng trong kho không đủ'
			rollback tran
		end
	else
		print N'Thêm thành công'
end
go
insert into tblChiTietHoaDon
values (9, N'MH09', 500000, 11, 0.3)

-- thêm cột iTSMatHang giá trị mặc định là 0 vào bảng Loại hàng, tự dộng cập nhật số lượng hàng trong bảng loại hàng khi thêm 1 mặt hàng mới 
alter table tblLoaiHang add iTSMatHang int default (0) with values

update tblLoaiHang set iTSMatHang = (select count(*) from tblMatHang as MH where tblLoaiHang.sMaLH = MH.sMaLH)
go

create trigger TuDongCapNhatSoMH
on tblMatHang
for insert, update
as
begin
	declare @MaLH varchar(6)
	select @MaLH = sMaLH from inserted
	update tblLoaiHang set iTSMatHang += 1 where tblLoaiHang.sMaLH = @MaLH
end
go
select * from tblLoaiHang
Insert into tblMatHang (sMaMH, sTenMH, iMaNCC, sMaLH, fSoLuong, fGiaHang, sDonViTinh)
values(N'MH16', N'Laptop Dell Vostro 3600', 1, N'LH01', 30, 14000000, N'Hộp')
select * from tblLoaiHang

--  cập nhật số lượng mỗi mặt hàng trong kho có mỗi khi nhập hàng
create trigger TuDongTangSoLuongMoiMH
on tblChiTietPhieuNhap
for insert, update
as
begin
	declare @MaMH varchar(6), @SoluongNhap int
	select @MaMH = sMaMH, @SoluongNhap = iSoLuong from inserted
	update tblMatHang set fSoLuong += @SoluongNhap where tblMatHang.sMaMH = @MaMH
end
go
select * from tblMatHang
Insert into tblChiTietPhieuNhap (iMaPN, sMaMH, fGiaNhap, iSoLuong)
values  (1, N'MH01', 800000, 2)
select * from tblMatHang

-- thêm cột fTongTienMua vào bảng Khách Hàng với giá trị mặc đinh = 0, tạo trigger sao cho giá trị fTongTienMua tự động tăng lên mỗi khi khách hàng đến mua hàng
alter table tblKhachHang add fTongTienMua float default (0) with values

update tblKhachHang set fTongTienMua = (select sum((fGiaBan*iSoLuong)*(1-fMucGiamGia))
from tblHoaDon as HD, tblChiTietHoaDon as CTHD where CTHD.iMaHD = HD.iMaHD and HD.iMaKH = tblKhachHang.iMaKH)

create trigger TuDongTangTongTienKH
on tblChiTietHoaDon
for insert, update
as
begin
	declare @MaHD int, @MaKH int, @TongTien float
	select @MaHD = iMaHD from inserted
	select @MaKH = iMaKH from tblHoaDon as HD where HD.iMaHD = @MaHD
	select @TongTien = ((fGiaBan*iSoLuong)*(1-fMucGiamGia)) from inserted
	update tblKhachHang set fTongTienMua += @TongTien where tblKhachHang.iMaKH = @MaKH
end
go
select * from tblKhachHang
Insert into tblChiTietHoaDon (iMaHD, sMaMH, fGiaBan, iSoLuong, fMucGiamGia)
values (4, N'MH03', 1000000, 1, 0.5)
select * from tblKhachHang

-- cập nhật số lượng hàng trong kho mỗi khi bán hàng
create trigger CapNhatSLHangKhiBan
on tblChiTietHoaDon
for insert, update 
as
begin
	declare @MaMH varchar(6), @SL int
	select @MaMH = sMaMH, @SL = iSoLuong from inserted
	update tblMatHang set fSoLuong -= @SL where tblMatHang.sMaMH = @MaMH
end
go
select * from tblMatHang
Insert into tblChiTietHoaDon (iMaHD, sMaMH, fGiaBan, iSoLuong, fMucGiamGia)
values (4, N'MH01', 1000000, 2, 0.5)
select * from tblMatHang

-- thêm cột iSoMH vào bảng Hóa đơn. Cập nhật tổng số mặt hàng của mỗi hóa đơn mỗi khi thêm chi tiết hóa đơn 
alter table tblHoaDon add iSoMH int default (0) with values

update tblHoaDon set iSoMH = (select count(*) from tblMatHang as MH, tblChiTietHoaDon as CTHD where CTHD.iMaHD = tblHoaDon.iMaHD and CTHD.sMaMH = MH.sMaMH)

create trigger CapNhapSoMHTrongHD
on tblChiTietHoaDon
for insert, update
as
begin
	declare @MaHD int
	select @MaHD = iMaHD from inserted
	update tblHoaDon set iSoMH += 1 where @MaHD = tblHoaDon.iMaHD
end
go
select * from tblHoaDon
Insert into tblChiTietHoaDon (iMaHD, sMaMH, fGiaBan, iSoLuong, fMucGiamGia)
values (1, N'MH01', 1000000, 2, 0.5)
select * from tblHoaDon


-- ========================================== PHÂN QUYỀN ======================================
-- tạo các tài khoản người dùng cho tất cả thanh viên trong nhóm
create login ngoctan with password = 'ngoctan'
go
create login tanthanh with password = 'tanthanh'
go
create login tienquy with password = 'tienquy'
go

-- tạo user
create user tan1 for login ngoctan
go
create user thanh for login tanthanh
go
create user quy for login tienquy
go

-- tao nhom nguoi dung
create role Thanhvien

-- add user vao nhom Thanhvien
alter role Thanhvien add member tan1
alter role Thanhvien add member thanh
alter role Thanhvien add member quy

-- cap cac quyen cho user tan1 sd view vHDCoGiaTri
grant insert, update, delete, select on vHDCoGiaTri
to tan1
go

-- cap quyen cho user tan1 sd proc spMHDuocNhapVe
grant exec on spMHDuocNhapVe
to tan1
go
-- exec spMHDuocNhapVe @year = 2022


select * from tblLoaiHang
select * from tblMatHang
select * from tblKhachHang
select * from tblNhanVien
select * from tblHoaDon
select * from tblChiTietHoaDon
select * from tblPhieuNhap
select * from tblChiTietPhieuNhap