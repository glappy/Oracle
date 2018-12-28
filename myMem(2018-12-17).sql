-- ����� myMem ����� ȭ���Դϴ�
CREATE TABLE tbl_iolist(
    id      	NUMBER		PRIMARY KEY,
    io_date 	CHAR(10)	NOT NULL,
    io_cname	nVARCHAR2(30)	NOT NULL,	
    io_dname	nVARCHAR2(50)	NOT NULL,	
    io_ceo	    nVARCHAR2(30),
    io_inout	nVARCHAR2(5),
    io_quan	    NUMBER,
    io_price	NUMBER,
    io_total	NUMBER
);

SELECT COUNT(*) 
FROM tbl_iolist ;

SELECT COUNT(*), SUM(io_total)
FROM tbl_iolist 
WHERE io_inout = '����';
-- ���԰� ������ �����ؼ� ������ �հ踦 Ȯ���ؾ� ������ ��� ��ġ�� �ִ�
-- ���԰� ������ �����ϰ� �Ѳ����� Ȯ��


-- ���ں��� �����Ͽ� ���԰� ������ ������ ���հ�
SELECT io_date, io_inout, COUNT(io_total), SUM(io_total)
FROM tbl_iolist
GROUP BY io_date, io_inout
ORDER BY io_date;

-- ���ڿ� �Լ� ���
SELECT 'KOREA' FROM DUAL ;
SELECT 'Republic of Korea' FROM DUAL ;

-- ���ڿ��� ��,�ҹ��ڷ�
SELECT UPPER('korea') FROM DUAL ;
SELECT LOWER('KOREA') FROM DUAL ;

-- �ܾ��� ù���ڸ� �빮�ڷ� ����
SELECT INITCAP('republic of korea') FROM DUAL ;

SELECT LENGTH('republic of korea') FROM DUAL ;
--LENGTH�Լ��� ����� �� ��Ȥ �ѱ۰����� *2�� ������ ǥ���ϴ� ��찡 �ִ�
-- �̶� �ѱ��� ��Ȯ�� ������ �˰��� �� ���� '' ���ڿ� �տ� N�� �ٿ��ش�

SELECT LENGTH(N'���ѹα�') FROM DUAL ;
--�������� ����뷮�� BYTE������ �����ش�
SELECT LENGTHB('���ѹα�')FROM DUAL ;
--OF�� REPUBLIC OF KOREA���ڿ� �� ���° ��ġ�� �ֳ�?
SELECT INSTR ('Republic of Korea', 'of') FROM DUAL ;
-- ���� ���ڿ��� 4° �ڸ����� 3����
-- ����Ŭ�� ù���� ��ġ�� 0�ƴ� 1���� �����Ѵ�
SELECT SUBSTR('Republic of Korea',4,3) FROM DUAL ;

--ǥ�� SQL���� ���ʺ��� 3��° ��ġ�� ����(����Ŭ������ �ȵ�)
--SELECT LEFT('Republic',3) FROM DUAL ;
-- 3��°���� 2����
--SELECT MID('Republic',3,2) FROM DUAL ;

--KOREA���ڿ��� �����Ͽ� �� 20�� ���ڿ��� �����ϵ� �� ���� *�� ä�� ��
SELECT LPAD('KOREA',20,'*') FROM DUAL ;
-- ����1�� ���ڿ��� �ٲٰ� �� 5�� ���ڿ��� �����ϵ� ����� 0���� ä�� ��
SELECT LPAD(1,5,'0') FROM DUAL ;

SELECT RPAD(1,5,'0'),LPAD(1,5,'0') FROM DUAL ;
INSERT test(t_num) VALUE(LPAD(1,3,'0') ;

--������ ����
SELECT LTRIM('  KOREA   ���ѹα�  ') FROM DUAL ;
SELECT RTRIM('  KOREA   ���ѹα�  ') FROM DUAL ;

SELECT TRIM ('     KOREA     ') FROM DUAL ;
--TRIM�Լ��� Ư���� ���
-- ���ڿ��� �յڿ� ���� A���ڵ��� ��� �����϶�
SELECT TRIM('a' FROM 'aaabbbKOREAnnnaaa') FROM DUAL ;

-- ���ں��� �ŷ� ���п� ���� ������ �հ踦 Ȯ���ϰ��� �� ��
-- �� �߿� 2018-03-01~2018-03-31���� �����ͷ� �����Ϸ���
SELECT io_date, io_inout, COUNT(io_total), SUM(io_total)
FROM tbl_iolist
WHERE io_date BETWEEN '2018-03-01' AND '2018-03-31'
GROUP BY io_date, io_inout
ORDER BY io_date;

-- ����, ������ ����ϰ� �ʹٸ�?
CREATE VIEW �������
AS
SELECT SUBSTR(io_date,1,7) AS ����, 
       io_inout, COUNT(io_total)AS ����, SUM(io_total)AS �հ�
FROM tbl_iolist
GROUP BY SUBSTR(io_date,1,7),io_inout
ORDER BY SUBSTR(io_date,1,7) ;

SELECT * FROM ������� ;
WHERE ���� BETWEEN '2018-03' AND '2018-06' ;

CREATE VIEW �ŷ�ó���
AS
SELECT io_dname AS �ŷ�ó, 
       io_inout, COUNT(io_total)AS ����, SUM(io_total)AS �հ�
FROM tbl_iolist
GROUP BY io_dname, io_inout
ORDER BY io_inout ;

SELECT * FROM �ŷ�ó���;

-- ERP �󿡼� '����'�̶�� �ϸ� '��-��'�� ���Ѵ�
CREATE VIEW ��ǰ���
AS
SELECT io_cname AS ��ǰ��, SUBSTR(io_date,1,7) AS ����,
        io_inout, COUNT(io_total) AS ����, SUM(io_total) AS �հ�
FROM tbl_iolist
GROUP BY io_cname, SUBSTR(io_date,1,7), io_inout
ORDER BY io_cname;

SELECT * FROM ��ǰ���;
DROP VIEW ��ǰ���;

--��ǰ�� '��Ű��'�� ���Ը��⸮��Ʈ Ȯ��
SELECT io_cname, SUBSTR(io_date,1,7), COUNT(*), SUM(io_total)
FROM tbl_iolist
WHERE io_cname = ' �� Ű ��'
GROUP BY io_cname, SUBSTR(io_date,1,7)
ORDER BY io_cname;