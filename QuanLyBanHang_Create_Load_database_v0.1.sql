﻿USE master
GO
DROP DATABASE IF EXISTS QLBH
GO
CREATE DATABASE QLBH 
GO
USE QLBH

GO
create table KHACHHANG
(		MAKH    char(4)	primary key,
		HOTEN   nvarchar(40),
		DCHI    nvarchar(50),
		SODT    varchar(20),
		NGSINH  date,
		NGDK    date,
		DOANHSO money,
        LOAIKH tinyint default 0,
        -- (0: vãng lai 1: Thường xuyên, 2:Vip  3:hoàng kim 4:Kim Cương 5:Chí tôn )
        constraint CHK_LoaiKH check (LOAIKH < 5),
        CONSTRAINT CHK_NGDK_NGSINH CHECK (NGDK>NGSINH)
)
GO
create table NHANVIEN
(		MANV char(4) primary key,
		HOTEN nvarchar(40),
		SODT varchar(20),
		NGVL date,
)
GO
create table SANPHAM
(
	MASP char(4) primary key,
	TENSP nvarchar(20),
	DVT nvarchar(20),
	NUOCSX nvarchar(40),
	GIA money,
    constraint CHK_DVT check ( DVT in (N'cây', N'hộp', N'cái', N'quyển', N'chục'))
)
GO
create table HOADON
(
		SOHD int primary key Identity(1001,1),
		NGHD datetime,
		MAKH char(4) references KHACHHANG(MAKH),
		MANV char(4) references NHANVIEN (MANV),
		TRIGIA money
)

GO
create table CTHD(
		SOHD int references HOADON (SOHD),
		MASP char(4) references SANPHAM (MASP),
		SL int
)
GO
-- Phần 2: Update dữ liệu theo yêu cầu
--2
-- alter table SANPHAM add GHICHU nvarchar(20)
-- --3
-- alter table KHACHHANG add LOAIKH tinyint
-- --4
-- alter table SANPHAM alter column GHICHU nvarchar(100)
-- --5
-- alter table SANPHAM drop column GHICHU
-- --6
-- alter table KHACHHANG alter column LOAIKH nvarchar(20)
--7
-- alter table SANPHAM add constraint CHK_DVT check DVT in ("cây", "hộp", "cái", "quyển", "chục") 
GO
SET dateformat DMY
GO

INSERT INTO [dbo].[KHACHHANG]
           ([MAKH]
           ,[HOTEN]
           ,[DCHI]
           ,[SODT]
           ,[NGSINH]
           ,[NGDK]
           ,[DOANHSO]
           )
VALUES
    ('KH01',N'Nguyen Van A','731,Tran Hung Dao, Q 5 ,Tp HCM','1','22/10/1960','22/10/2006',13000000),
    ('KH02','Tran Ngoc Han','23/5, Nguyen Trai, Q 5, Tp HCM','0908256478','03/04/1974','30/07/2006',280000),
    ('KH03','Tran Ngoc Linh','45, Nguyen Canh Chan, Q 1, Tp HCM','0938776266','12/06/1980','05/08/2006',3860000),
    ('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q 10, Tp HCM','0917325476','09/03/1965','02/10/2006',250000),
    ('KH05','Le Nhat Minh','34, Truong Dinh, Q 3, Tp HCM','08246108','10/03/1950','28/10/2006',21000),
    ('KH06','Le Hoai Thuong','227, Nguyen Van Cu, Q 5, Tp HCM','08631738','31/12/1981','24/11/2006',915000),
    ('KH07','Nguyen Van Tam','32/3, Tran Binh Trong, Q 5, Tp HCM','0916783565','06/04/1971','01/12/2006',12500),
    ('KH08','Phan Thi Thanh','45/2, An Duong Vuong, Q 5, Tp HCM','0938435756','10/01/1971','13/12/2006',365000),
    ('KH09','Le Ha Vinh','873, Le Hong Phong, Q 5, Tp HCM','08654763','03/09/1979','14/01/2007',70000),
    ('KH10','Ha Duy Lap','34/34B, Nguyen Trai, Q 1, Tp HCM','08768904','02/05/1983','16/01/2007',67500)
GO
INSERT INTO [dbo].[NHANVIEN]  
    VALUES
    ('NV01','Nguyen Nhu Nhut','0927345678','13/04/2006'),
    ('NV02','Le Thi Phi Yen','0987567390','21/04/2006'),
    ('NV03','Nguyen Van B','0997047382','27/04/2006'),
    ('NV04','Ngo Thanh Tuan','0913758498','24/06/2006'),
    ('NV05','Nguyen Thi Truc Thanh','0918590387','20/07/2006')

GO

insert into SANPHAM values ('BC01','But chi',N'cây','Singapore',3000)
insert into SANPHAM values ('BC02','But chi',N'cây','Singapore',5000)
insert into SANPHAM values ('BC03','But chi',N'cây','Viet Nam',3500)
insert into SANPHAM values ('BC04','But chi',N'hộp','Viet Nam',30000)
insert into SANPHAM values ('BB01','But bi',N'cây','Viet Nam',5000)
insert into SANPHAM values ('BB02','But bi',N'cây','Trung Quoc',7000)
insert into SANPHAM values ('BB03','But bi',N'hộp','Thai Lan',100000)
insert into SANPHAM values ('TV01','Tap 100 giay mong',N'quyển','Trung Quoc',2500)
insert into SANPHAM values ('TV02','Tap 200 giay mong',N'quyển','Trung Quoc',4500)
insert into SANPHAM values ('TV03','Tap 100 giay tot',N'quyển','Viet Nam',3000)
insert into SANPHAM values ('TV04','Tap 200 giay tot',N'quyển','Viet Nam',5500)
insert into SANPHAM values ('TV05','Tap 100 trang',N'chục','Viet Nam',23000)
insert into SANPHAM values ('TV06','Tap 200 trang',N'chục','Viet Nam',53000)
insert into SANPHAM values ('TV07','Tap 100 trang',N'chục','Trung Quoc',34000)
insert into SANPHAM values ('ST01','So tay 500 trang',N'quyển','Trung Quoc',40000)
insert into SANPHAM values ('ST02','So tay loai 1',N'quyển','Viet Nam',55000)
insert into SANPHAM values ('ST03','So tay loai 2',N'quyển','Viet Nam',51000)
insert into SANPHAM values ('ST04','So tay ',N'quyển','Thai Lan',55000)
insert into SANPHAM values ('ST05','So tay mong',N'quyển','Thai Lan',20000)
insert into SANPHAM values ('ST06','Phan viet bang',N'hộp','Viet Nam',5000)
insert into SANPHAM values ('ST07','Phan khong bui',N'hộp','Viet Nam',7000)
insert into SANPHAM values ('ST08','Bong bang',N'cái','Viet Nam',1000)
insert into SANPHAM values ('ST09','But long',N'cây','Viet Nam',5000)
insert into SANPHAM values ('ST10','But long',N'cây','Trung Quoc',7000)

GO
SET IDENTITY_INSERT [dbo].[HOADON] ON;

INSERT INTO [dbo].[HOADON]
           ([SOHD],
		    [NGHD],
            [MAKH],
            [MANV],
            [TRIGIA])
VALUES 
    (1001,'23/07/2006','KH01','NV01',320000),
    (1002,'12/08/2006','KH01','NV02',840000),
    (1003,'23/08/2006','KH02','NV01',100000),
    (1004,'01/09/2006','KH02','NV01',180000),
    (1005,'20/10/2006','KH01','NV02',3800000),
    (1006,'16/10/2006','KH01','NV03',2430000),
    (1007,'28/10/2006','KH03','NV03',510000),
    (1008,'28/10/2006','KH01','NV03',440000),
    (1009,'28/10/2006','KH03','NV04',200000),
    (1010,'01/11/2006','KH01','NV01',5200000),
    (1011,'04/11/2006','KH04','NV03',250000),
    (1012,'30/11/2006','KH05','NV03',21000),
    (1013,'12/12/2006','KH06','NV01',5000),
    (1014,'31/12/2006','KH03','NV02',3150000),
    (1015,'01/01/2007','KH06','NV01',910000),
    (1016,'01/01/2007','KH07','NV02',12500),
    (1017,'02/01/2007','KH08','NV03',35000),
    (1018,'13/01/2007','KH08','NV03',330000),
    (1019,'13/01/2007','KH01','NV03',30000),
    (1020,'14/01/2007','KH09','NV04',70000),
    (1021,'16/01/2007','KH10','NV03',67500),
    (1022,'16/01/2007',null,'NV03',7000),
    (1023,'17/01/2007',null,'NV01',330000)

SET IDENTITY_INSERT [dbo].[HOADON] OFF;  

GO
insert into CTHD values (1001,'TV02',10)
insert into CTHD values (1001,'ST01',5)
insert into CTHD values (1001,'BC01',5)
insert into CTHD values (1001,'BC02',10)
insert into CTHD values (1001,'ST08',10)
insert into CTHD values (1002,'BC04',20)
insert into CTHD values (1002,'BB01',20)
insert into CTHD values (1002,'BB02',20)
insert into CTHD values (1003,'BB03',10)
insert into CTHD values (1004,'TV01',20)
insert into CTHD values (1004,'TV02',20)
insert into CTHD values (1004,'TV03',20)
insert into CTHD values (1004,'TV04',20)
insert into CTHD values (1005,'TV05',50)
insert into CTHD values (1005,'TV06',50)
insert into CTHD values (1006,'TV07',20)
insert into CTHD values (1006,'ST01',30)
insert into CTHD values (1006,'ST02',10)
insert into CTHD values (1007,'ST03',10)
insert into CTHD values (1008,'ST04',8)
insert into CTHD values (1009,'ST05',10)
insert into CTHD values (1010,'TV07',50)
insert into CTHD values (1010,'ST07',50)
insert into CTHD values (1010,'ST08',100)
insert into CTHD values (1010,'ST04',50)
insert into CTHD values (1010,'TV03',100)
insert into CTHD values (1011,'ST06',50)
insert into CTHD values (1012,'ST07',3)
insert into CTHD values (1013,'ST08',5)
insert into CTHD values (1014,'BC02',80)
insert into CTHD values (1014,'BB02',100)
insert into CTHD values (1014,'BC04',60)
insert into CTHD values (1014,'BB01',50)
insert into CTHD values (1015,'BB02',30)
insert into CTHD values (1015,'BB03',7)
insert into CTHD values (1016,'TV01',5)
insert into CTHD values (1017,'TV02',1)
insert into CTHD values (1017,'TV03',1)
insert into CTHD values (1017,'TV04',5)
insert into CTHD values (1018,'ST04',6)
insert into CTHD values (1019,'ST05',1)
insert into CTHD values (1019,'ST06',2)
insert into CTHD values (1020,'ST07',10)
insert into CTHD values (1021,'ST08',5)
insert into CTHD values (1021,'TV01',7)
insert into CTHD values (1021,'TV02',10)
insert into CTHD values (1022,'ST07',1)
insert into CTHD values (1023,'ST04',6)