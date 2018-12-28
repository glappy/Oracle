-- ����� myuser�� ������ ȭ���Դϴ�
-- 
CREATE TABLE tbl_iolist(
    id      	NUMBER	PRIMARY KEY,
    io_date	    CHAR(10)	NOT NULL,
    io_cname	nVARCHAR2(50)	NOT NULL,
    io_dname	nVARCHAR2(30)	NOT NULL,
    io_dceo	    nVARCHAR2(10),
    io_inout	nVARCHAR2(5),
    io_quan	    NUMBER,
    io_price	NUMBER,	
    io_total	NUMBER	
);
SELECT * 
FROM tbl_iolist ;
SELECT COUNT(*) 
FROM tbl_ioList ;

DELETE FROM tbl_iOlist ;

SELECT io_date, io_cname, io_dname, io_inout, io_total 
FROM tbl_ioList 
WHERE io_date>='2018-02-01' AND io_date<='2018-02-28'
--AND io_inout = '����' 
ORDER BY io_date;

SELECT COUNT(*) ,SUM(io_total) 
FROM tbl_iolist ;
-- ����Լ��� �̿��ؼ� ������ �հ� ���ϱ�
SELECT COUNT (io_total) AS ����, SUM(io_total) AS �հ�
FROM tbl_iolist;

-- ����Լ� �̿��ؼ� ������ �հ� ���ϵ�, �����հ�� �����հ� ���� ����ϱ�
-- ����,������ �����ϴ� Į�� : io_inout
SELECT io_inout, COUNT(io_total), SUM(io_total)
FROM tbl_iolist
GROUP BY io_inout ;

-- ������ �հ���
-- ���� : ��¥���� ���� �ο��ؼ� ������ �հ���
-- ��¥ �����ϴ� Į�� : io_date
SELECT io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
GROUP BY io_date
ORDER BY io_date ;

-- ���� : ��¥���� ���� ����, ����� �����Ͽ� ������ �հ� ���
SELECT io_date, io_inout, COUNT(*), SUM(io_total)
FROM tbl_iolist
GROUP BY io_date, io_inout
ORDER BY io_date;

SELECT io_inout, io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
GROUP BY io_inout, io_date
ORDER BY io_date;

SELECT io_inout, io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
WHERE io_date BETWEEN '2018-03-01' AND '2018-03-31'
GROUP BY io_inout, io_date
ORDER BY io_date;

-- �հ�ݾ�100���� �̻��� �׸�
SELECT io_inout, io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
WHERE io_date BETWEEN '2018-03-01' AND '2018-03-31'
GROUP BY io_inout, io_date
HAVING SUM(io_total) >= 500000
ORDER BY io_date;
-- ����Լ��� ����ϴ� ���
-- ����Լ� ����� ���� �����ϴ� ����Ʈ�� �����ϰ� ���� ��(�ʿ��� ���� ���� ����)
-- WHERE�� ������ �ο��ϸ� �ȵȴ�
-- HAVING�̶�� ���� ����ؾ� �Ѵ�

SELECT io_inout, io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
GROUP BY io_inout, io_date
HAVING SUM(io_total) >= 500000 AND io_date BETWEEN '2018-03-01' AND '2018-03-31'
ORDER BY io_date;
-- HAVING���� ��� ��踦 ����� �� �������� �����ϱ� ������ ��� �����Ϳ� ī��Ʈ�� ���� ����ϰ� ��μ� ��¥ ������ �����Ѵ�
-- DB SELECT���� �־��� �ð� �ҿ䰡 �ȴ�