USE QLBH;
GO

SET DATEFORMAT dmy
GO

--Câu 1:
SELECT MASP, TENSP FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
GO

--Câu 2:
SELECT MASP, TENSP FROM SANPHAM
WHERE DVT = N'cây' OR DVT = N'quyển'
GO

--Câu 3:
SELECT MASP, TENSP FROM SANPHAM
WHERE MASP LIKE 'B%01'
GO

--Câu 4:
SELECT MASP, TENSP FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND GIA BETWEEN 30000 AND 40000
GO

--Câu 5:
SELECT MASP, TENSP FROM SANPHAM
WHERE (NUOCSX = 'Trung Quoc' OR NUOCSX = 'Thai Lan') AND GIA BETWEEN 30000 AND 40000
GO

--Cau 6:
--In ra các số hóa đơn, 
--Trị giá hóa đơn 
--Bán ra trong ngày 1/1/2007 và ngày 2/1/2007
SELECT SOHD, TRIGIA FROM HOADON
WHERE NGHD BETWEEN '1/1/2007' AND '2/1/2007';
GO

--Câu 7:
--In ra các số hóa đơn, 
--Trị giá hóa đơn 
--Trong tháng 1/2007
--Sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần)

SELECT SOHD, TRIGIA FROM HOADON
WHERE NGHD BETWEEN '1/1/2007' AND '31/1/2007'
ORDER BY NGHD ASC, TRIGIA DESC
GO

--Câu 8:
--In ra danh sách các khách hàng (MAKH, HOTEN) 
--Đã mua hàng trong ngày 1/1/2007.
SELECT HOTEN, MAKH FROM KHACHHANG
WHERE MAKH IN (
	SELECT MAKH FROM HOADON
	WHERE NGHD = '1/1/2007'
)
GO

--Câu 9:
--In ra số hóa đơn, 
--Trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập 
--Trong ngày 28/10/2006.
SELECT HOADON.SOHD, HOADON.TRIGIA FROM HOADON
INNER JOIN NHANVIEN ON HOADON.MANV = NHANVIEN.MANV
WHERE NHANVIEN.HOTEN = 'Nguyen Van B' AND NGHD ='28/10/2006'
GO

--Câu 10:
--In ra danh sách các sản phẩm (MASP,TENSP) 
--Được khách hàng có tên “Nguyen Van A”
--Mua trong tháng 10/2006.
SELECT CTHD.MASP, SANPHAM.TENSP FROM CTHD
INNER JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
INNER JOIN KHACHHANG ON HOADON.MAKH = KHACHHANG.MAKH
WHERE (KHACHHANG.HOTEN = 'Nguyen Van A') AND (HOADON.NGHD BETWEEN '1/10/2006' AND '31/10/2006')
GO

--Câu 11:
--Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”
SELECT DISTINCT SOHD FROM CTHD
WHERE MASP = 'BB01' OR MASP = 'BB02'
GO

--Câu 12:
--Tìm các số hóa đơn đã mua sản phẩm 
--Có mã số “BB01” hoặc “BB02”,
--Mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT DISTINCT SOHD FROM CTHD
WHERE (MASP = 'BB01' AND SL BETWEEN 10 AND 20) OR (MASP = 'BB02' AND SL BETWEEN 10 AND 20)
GO

--Câu 13:
--Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”
--Mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD FROM CTHD WHERE MASP = 'BB01' AND (SL BETWEEN 10 AND 20)
INTERSECT
SELECT SOHD FROM CTHD WHERE MASP = 'BB02' AND (SL BETWEEN 10 AND 20)
GO

--Câu 14:
--In ra danh sách các sản phẩm (MASP,TENSP) 
--Do “Trung Quoc” sản xuất 
--Hoặc các sản phẩm được bán ra trong ngày 1/1/2007
SELECT CTHD.MASP, SANPHAM.TENSP FROM CTHD
INNER JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE SANPHAM.NUOCSX = 'Trung Quoc' OR HOADON.NGHD = '1/1/2007'
GO

--Câu 15:
--In ra danh sách các sản phẩm (MASP,TENSP) không bán được
SELECT SANPHAM.MASP, SANPHAM.TENSP FROM SANPHAM
LEFT JOIN CTHD ON CTHD.MASP = SANPHAM.MASP
WHERE CTHD.SOHD IS NULL
GO

--Câu 16:
--In ra danh sách các sản phẩm (MASP,TENSP)
--Không bán được trong năm 2006
CREATE VIEW vw_ProductSaleIn2006 
AS
SELECT SANPHAM.MASP, SANPHAM.TENSP, HOADON.NGHD FROM CTHD
INNER JOIN SANPHAM ON SANPHAM.MASP = CTHD.MASP
INNER JOIN HOADON ON HOADON.SOHD = CTHD.SOHD
WHERE YEAR(NGHD) = '2006'
GO

SELECT SANPHAM.MASP, SANPHAM.TENSP FROM SANPHAM
LEFT JOIN vw_ProductSaleIn2006 ON vw_ProductSaleIn2006.MASP = SANPHAM.MASP
WHERE vw_ProductSaleIn2006.NGHD IS NULL
GO

--Câu 17:
--In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
CREATE VIEW vw_ProductOfChina
AS
SELECT SANPHAM.MASP, SANPHAM.TENSP, CTHD.SOHD FROM SANPHAM
LEFT JOIN CTHD ON CTHD.MASP = SANPHAM.MASP
WHERE SANPHAM.NUOCSX = 'Trung Quoc'
GO

CREATE VIEW vw_ProductChineSale2006
AS
SELECT vw_ProductOfChina.MASP, vw_ProductOfChina.TENSP, HOADON.NGHD FROM vw_ProductOfChina
LEFT JOIN HOADON ON HOADON.SOHD = vw_ProductOfChina.SOHD
WHERE YEAR(HOADON.NGHD) = '2006'
GO

SELECT vw_ProductOfChina.MASP, vw_ProductOfChina.TENSP FROM vw_ProductOfChina
LEFT JOIN vw_ProductChineSale2006  ON vw_ProductChineSale2006.MASP = vw_ProductOfChina.MASP
WHERE vw_ProductChineSale2006.NGHD IS NULL
GO

--Câu 18:
--Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT CTHD.SOHD FROM SANPHAM
LEFT JOIN CTHD ON CTHD.MASP = SANPHAM.MASP
WHERE SANPHAM.NUOCSX = 'Singapore'
GO

--Câu 19:
--Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(SOHD) FROM HOADON
WHERE MAKH IS NULL
GO

--Câu 20:
--Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006
SELECT COUNT(DISTINCT CTHD.MASP) FROM CTHD
INNER JOIN HOADON ON HOADON.SOHD = CTHD.SOHD
WHERE YEAR(HOADON.NGHD) = '2006'
GO