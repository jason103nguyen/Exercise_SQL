CREATE DATABASE ASG_BUOI_3;

GO
USE ASG_BUOI_3;

GO
SET DATEFORMAT dmy;

--Câu 1.1:

--***Table KHACH HANG***--
--MAKH: Mã khách hàng
--HOTEN: Họ và tên
--DCHI: Địa chỉ
--SODT: Số điện thoại
--NGSINH: Ngày sinh
--NGDK: Ngày đăng ký thành viên
--DOANHSO: Tổng trị giá các hóa đơn khách hàng đã mua
GO
CREATE TABLE KHACHHANG (
	MAKH char(4),
	HOTEN varchar(40),
	DCHI varchar(50),
	SODT varchar(20),
	NGSINH smalldatetime,
	NGDK smalldatetime,
	DOANHSO money,
	CONSTRAINT PK_MAKH PRIMARY KEY (MAKH)
);

--***Table NHAN VIEN***--
--MANV: Mã nhân viên
--HOTEN: Họ và tên
--SODT: Số điện thoại
--NGVL: Ngày vào làm
GO
CREATE TABLE NHANVIEN (
	MANV char(4),
	HOTEN varchar(40),
	SODT varchar(20),
	NGVL smalldatetime,
	CONSTRAINT PK_MANV PRIMARY KEY (MANV)
);

--***Table SAN PHAM***--
--MASP: Mã sản phẩm
--TENSP: Tên sản phẩm
--DVT:Đơn vị tính
--NUOCSX:Nước sản xuất
--GIA: Giá bán
GO
CREATE TABLE SANPHAM (
	MASP char(4),
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(40),
	GIA money,
	CONSTRAINT PK_MASP PRIMARY KEY (MASP)
);

--***Table HOA DON***--
--SOHD: Số hóa đơn
--NGHD: Ngày mua hàng
--MAKH: Mã khách hàng
--MANV: Mã nhân viên bán hàng
--TRIGIA: Trị giá hóa đơn
GO
CREATE TABLE HOADON (
	SOHD int identity(1001,1),
	NGHD smalldatetime,
	MAKH char(4),
	MANV char(4),
	TRIGIA money,
	CONSTRAINT PK_SOHD PRIMARY KEY (SOHD),
	CONSTRAINT FK_MAKH FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
	CONSTRAINT FK_MANV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
);

--***Table CHUNG TU HOA DON***--
--SOHD: Số hóa đơn
--MASP: Mã sản phẩm
--SL: Số lượng
GO
CREATE TABLE CTHD (
	SOHD int,
	MASP char(4),
	SL int,
	CONSTRAINT PK_SOHD_MASP PRIMARY KEY (SOHD, MASP),
	CONSTRAINT FK_SOHD FOREIGN KEY (SOHD) REFERENCES HOADON(SOHD),
	CONSTRAINT FK_MASP FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
);

--Câu 1.1:

--Câu 1.2:

--Câu 1.3:
GO
ALTER TABLE SANPHAM
ADD GHICHU nvarchar(200);

--Câu 1.4:
GO
ALTER TABLE KHACHHANG
ADD LOAIKH tinyint;

--Câu 1.5:
GO
ALTER TABLE SANPHAM
ALTER COLUMN GHICHU nvarchar(100);

--Câu 1.6:
GO
ALTER TABLE SANPHAM
DROP COLUMN GHICHU;

--Câu 1.7*:
GO
ALTER TABLE KHACHHANG
ALTER COLUMN LOAIKH nvarchar(50);

GO
ALTER TABLE KHACHHANG
ADD CONSTRAINT CHK_LOAIKH CHECK (LOAIKH = N'Vãng lai' or LOAIKH = N'Thường xuyên' or LOAIKH = N'Vip 1' or LOAIKH = N'Vip 2');

--Câu: 1.8
GO 
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_DVT CHECK (DVT = N'cây' or DVT = N'hộp' or DVT = N'cái' or DVT = N'quyển' or DVT = N'chục');

--Câu 1.9
GO
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_GIA CHECK (GIA >= 500);

--Câu 1.10*:

--Câu 1.11:
GO
ALTER TABLE KHACHHANG
ADD CONSTRAINT CHK_NGDK CHECK (NGDK > NGSINH);

--Câu 1.12:

--Câu 1.13:

--Câu 1.14:

--Câu 1.17:
GO
ALTER TABLE KHACHHANG
ALTER COLUMN HOTEN nvarchar(40);

GO
ALTER TABLE KHACHHANG
ALTER COLUMN DCHI nvarchar(50);

GO
ALTER TABLE NHANVIEN
ALTER COLUMN HOTEN nvarchar(40);

GO
ALTER TABLE SANPHAM
ALTER COLUMN TENSP nvarchar(40);

GO
ALTER TABLE SANPHAM
ALTER COLUMN NUOCSX nvarchar(40);

--Câu 2:
INSERT INTO NHANVIEN VALUES 
('NV01', 'Nguyen Nhu Nhut', '0927345678', '13/4/2006'),
('NV02', 'Le Thi Phi Yen ', '0987567390', '21/4/2006'),
('NV03', 'Nguyen Van B ', '0997047382', '27/4/2006'),
('NV04', 'Ngo Thanh Tuan ', '0913758498', '24/6/2006'),
('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '20/7/2006');

INSERT INTO KHACHHANG VALUES
('KH02',	'Nguyen Van A',		'731 Tran Hung Dao, Q5, TpHCM',		'08823451',		'22/10/1960', 	'22/07/2006', '13060000', N'Vãng lai'),
('KH03',	'Tran Ngoc Han',	'23/5 Nguyen Trai, 05, TpHCM',		'0908256478',	'3/4/1974',		'30/07/2006', '280000', N'Thường xuyên'),
('KH04',	'Tran Ngoc Linh',	'45 Nguyen Canh Chan. 01, TpHCM',	'0938776266',	'12/6/1980',	'05/08/2006', '3860000', N'Vip 1'),
('KH05',	'Tran Minh Long',	'50/34 Le Dal Hanh, 010, TpHCM',	'0917325476',	'9/3/1965',		'02/10/2006', '250000', N'Vip 2'),
('KH06',	'Le Nhat Minh',		'34 Truong Dinh, 03, TpHCM',		'08246108',		'10/3/1950',	'28/10/2006', '21000', N'Vãng lai'),
('KH07',	'Le Hoai Thuong',	'227 Nguyen Van Cu, 05, TpHCM',		'08631738',		'31/12/1981',	'24/11/2006', '915000', N'Thường xuyên'),
('KH08',	'Nguyen Van Tam',	'32/3 Tran Binh Trong, 05, TpHCM',	'0916783565',	'6/4/1971',		'01/12/2006', '12500', N'Vip 1'),
('KH09',	'Phan Thi Thanh',	'4512 An Duong Vuong, 05, TpHCM',	'0938435756',	'10/1/1971',	'13/12/2006', '365000', N'Vip 2'),
('KH10',	'Le Ha Vinh',		'873 Le Hong Phong, 05, TpHCM',		'08654763',		'3/9/1979',		'14/01/2007', '70000', N'Vãng lai'),
('KH11',	'Ha Duy Lap',		'34/34B Nguyen Trai, 01, TpHCM',	'08768904',		'2/5/1983',		'16/01/2007', '67500', N'Thường xuyên');

GO
ALTER TABLE SANPHAM
DROP CONSTRAINT CHK_DVT;

GO 
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_DVT CHECK (DVT = 'cay' or DVT = 'hop' or DVT = 'cai' or DVT = 'quyen' or DVT = 'chuc');

INSERT INTO SANPHAM VALUES 
('BC01', 'But chi',				'cay',		'Singapore',	'3000'),
('BC02', 'But chi',				'cay',		'Singapore',	'5000'),
('BC03', 'But chi',				'cay',		'Viet Nam',		'3500'),
('BC04', 'But chi',				'hop',		'Viet Nam',		'30000'),
('BB01', 'But bi',				'cay',		'Viet Nam',		'5000'),
('BB02', 'But bi',				'cay',		'Trung Quoc',	'7000'),
('BB03', 'But bi',				'hop',		'Thai Lan',		'100000'),
('TV01', 'Tap 100 giay mong',	'quyen',	'Trung Quoc',	'2500'),
('TV02', 'Tap 200 giay mong',	'quyen',	'Trung Quoc',	'4500'),
('TV03', 'Tap 100 giay tot',	'quyen',	'Viet Nam',		'3000'),
('TV04', 'Tap 200 giay tot',	'quyen',	'Viet Nam',		'5500'),
('TV05', 'Tap 100 trang',		'chuc',		'Viet Nam',		'23000'),
('TV06', 'Tap 200 trang',		'chuc',		'Viet Nam',		'53000'),
('TV07', 'Tap 100 trang',		'chuc',		'Trung Quoc',	'34000'),
('ST01', 'So tay 500 trang',	'quyen',	'Trung Quoc',	'40000'),
('ST02', 'So tay loai 1',		'quyen',	'Viet Nam',		'55000'),
('ST03', 'So tay loai 2',		'quyen',	'Viet Nam',		'51000'),
('ST04', 'So tay',				'cay',		'Thai Lan',		'55000'),
('ST05', 'So tay mong',			'quyen',	'Thai Lan',		'20000'),
('ST06', 'Phan viet bang',		'hop',		'Viet Nam',		'5000'),
('ST07', 'Phan khong bui',		'hop',		'Viet Nam',		'7000'),
('ST08', 'Bong bang',			'cai',		'Viet Nam',		'1000'),
('ST09', 'But long',			'cay',		'Viet Nam',		'5000'),
('ST10', 'But long',			'cay',		'Trung Quoc',	'7000');

GO
INSERT INTO HOADON VALUES
('23/07/2006', 'KH01', 'NV01', '320000'),
('12/08/2006', 'KH01', 'NV02', '840000'),
('23/08/2006', 'KH02', 'NV01', '100000'),
('01/09/2006', 'KH02', 'NV01', '180000'),
('20/10/2006', 'KH01', 'NV02', '3800000'),
('16/10/2006', 'KH01', 'NV03', '2430000'),
('28/10/2006', 'KH03', 'NV03', '510000'),
('28/10/2006', 'KH01', 'NV03', '440000'),
('28/10/2006', 'KH03', 'NV04', '200000'),
('01/11/2006', 'KH01', 'NV01', '5200000'),
('04/11/2006', 'KH04', 'NV03', '250000'),
('30/11/2006', 'KH05', 'NV03', '21000'),
('12/12/2006', 'KH06', 'NV01', '5000'),
('31/12/2006', 'KH03', 'NV02', '3150000'),
('01/01/2007', 'KH06', 'NV01', '910000'),
('01/01/2007', 'KH07', 'NV02', '12500'),
('02/01/2007', 'KH08', 'NV03', '35000'),
('13/01/2007', 'KH08', 'NV03', '330000'),
('13/01/2007', 'KH01', 'NV03', '30000'),
('14/01/2007', 'KH09', 'NV04', '70000'),
('16/01/2007', 'KH10', 'NV03', '67500'),
('16/01/2007', 'Null', 'NV03', '7000'),
('17/07/2007', 'Null', 'NV01', '330000');

GO
INSERT INTO CTHD VALUES
('1001', 'TV02', '10'),
('1001', 'ST01', '5'),
('1001', 'BC01', '5'),
('1001', 'BC02', '10'),
('1001', 'ST08', '10'),
('1002', 'BC04', '20'),
('1002', 'BB01', '20'),
('1002', 'BB02', '20'),
('1003', 'BB03', '10'),
('1004', 'TV01', '20'),
('1004', 'TV02', '10'),
('1004', 'TV03', '10'),
('1004', 'TV04', '10'),
('1005', 'TV05', '50'),
('1005', 'TV06', '50'),
('1006', 'TV07', '20'),
('1006', 'ST01', '30'),
('1006', 'ST02', '10'),
('1007', 'ST03', '10'),
('1008', 'ST04', '8'),
('1009', 'ST05', '10'),
('1010', 'TV07', '50'),
('1010', 'ST07', '50'),
('1010', 'ST08', '100'),
('1010', 'ST04', '50'),
('1010', 'TV03', '100'),
('1011', 'ST06', '50'),
('1012', 'ST07', '3'),
('1013', 'ST08', '5'),
('1014', 'BC02', '80'),
('1014', 'BB02', '100'),
('1014', 'BC04', '60'),
('1014', 'BB01', '50'),
('1015', 'BB02', '30'),
('1015', 'BB03', '7'),
('1016', 'TV01', '5'),
('1017', 'TV02', '1'),
('1017', 'TV03', '1'),
('1017', 'TV04', '5'),
('1018', 'ST04', '6'),
('1019', 'ST05', '1'),
('1019', 'ST06', '2'),
('1020', 'ST07', '10'),
('1021', 'ST08', '5'),
('1021', 'TV01', '7'),
('1021', 'TV02', '10'),
('1022', 'ST07', '1'),
('1023', 'ST04', '6');

--Test
SELECT * FROM SANPHAM;
DROP TABLE KHACHHANG;