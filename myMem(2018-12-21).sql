--myMem���� ������ ȭ��
-- TBL_IOLIST���� ��ǰ�������̺��� �и��ؼ� ��2����ȭ ����
-- TBL_IOLIST ������ Ȯ��
SELECT COUNT(*) FROM tbl_iolist ;

-- ��ü �����Ͱ� �ƴ� ���ǿ� �´� �����͸� �����ؼ� Ȯ���� ���� WHERE������ Į�� = ���� ������ �̿�
-- Ư�� ������ �����ϱ� ���� ������ �����ؼ� ���� ������ ����Ŭ ���� SQL Ű���� �� ROWNUM�̶�� Į���� ���
-- ROWNUM�� ����� �������� ���� ������ �������� ǥ���ϴ� ����Ŭ DUMMYĮ��
SELECT ROWNUM io_date, io_cname, io_dcode 
FROM tbl_iolist ;

-- ROWNUM�� �̿��ϸ� �����͸���Ʈ �� �Ϻθ� ��ȸ�� �� �ִ�
SELECT ROWNUM, io_date, io_cname
FROM tbl_iolist 
WHERE ROWNUM <= 10;

-- ROWNUM�� �̿��ؼ� 10��°���� 20��°���� ��ȸ�ϰ� ������..
SELECT ROWNUM, io_date, io_cname
FROM tbl_iolist
WHERE ROWNUM BETWEEN 10 AND 20;

-- MYSQL
-- SELECT * FROM tbl_iolist LIMIT 10;

SELECT * FROM tbl_iolist WHERE ROWNUM < 10;

-- ��ǰ������ ��ǰ���̺�� �и��ϱ� ���ؼ� ��ǰ�̸� ����Ʈ �����
SELECT io_cname
FROM tbl_iolist
GROUP BY io_cname ;

SELECT io_cname, io_inout, io_price
FROM tbl_iolist
WHERE ROWNUM <10;

-- ���� ��ȸ�� �����Ϳ��� io_inout�� '����'�̸� io_price�� '���Դܰ�'�� ���̰� '����'�̸� '����ܰ�'�� ������ ����
-- io_inout�� ���� �ܰ��� �ٸ��� ǥ���� ����
SELECT io_cname, io_inout, -- ����
    DECODE(io_inout,'����',io_price) ���Դܰ�,
    DECODE(io_inout,'����',io_price) ����ܰ�
FROM tbl_iolist
WHERE ROWNUM < 10;

SELECT io_cname, io_inout,
    AVG(DECODE(io_inout,'����',io_price)) ���Դܰ�,
    AVG(DECODE(io_inout,'����',io_price)) ����ܰ�
FROM tbl_iolist
GROUP BY io_cname,io_inout;

SELECT io_cname, -- �� ��
    DECODE(io_inout,'����',io_price) ���Դܰ�,
    DECODE(io_inout,'����',io_price) ����ܰ�
FROM tbl_iolist
GROUP BY io_cname,io_inout, DECODE(io_inout, '����',io_price),DECODE(io_inout,'����',io_price)
ORDER BY io_cname;

-- ��ǰ���̺� ����
CREATE TABLE tbl_product(
    p_code  	CHAR(9)		PRIMARY KEY,
    p_name	    nVARCHAR2(50)	NOT NULL,	
    p_iprice	NUMBER,
    p_oprice	NUMBER		
);

SELECT COUNT(*) FROM tbl_product ;
DROP TABLE tbl_product ;

--��ǰ���� ���̺��� �����ϰ� �����͸� ��������� ���Ը����������� ��ǰ�ڵ� Į�� �����ϰ� ��ǰ�ڵ� Į�� �����͸� ������Ʈ �ϰ� ��ǰ�� Į���� �����Ѵ�
ALTER TABLE tbl_iolist ADD io_pcode CHAR(9) ;
-- �������� �̿��ؼ� iolist�� product table���� ���踦 ����
SELECT I.io_cname, 
    (SELECT P.p_name FROM tbl_product P 
        WHERE P.p_name = I.io_cname),
        (SELECT P.p_code FROM tbl_product P 
        WHERE P.p_name = I.io_cname)
FROM tbl_iolist I;


-- PRODUCT TABLE���� ��ǰ�ڵ� ��ȸ�ؼ� IOLIST TABLE�� IO_PCODEĮ���� UPDATE ����
UPDATE tbl_iolist
SET io_pcode =
    (SELECT p_code FROM tbl_product  P
        WHERE P.p_name = I.io_cname);
        
-- UPDATE�Ŀ� JOIN���� ����        
SELECT I.io_pcode, P.p_code, I.io_cname, P.p_name
FROM tbl_iolist I
     LEFT JOIN tbl_product P
            ON I.io_pcode = P.p_code
ORDER BY I.io_pcode ;            

--��ǰ�� Į���� ����
ALTER TABLE tbl_iolist DROP COLUMN io_cname ;
DESC tbl_iolist ;

SELECT * FROM tbl_iolist
WHERE ROWNUM < 10;

--TBL_IOLIST�� ��2����ȭ�� �Ϸ�Ǿ���
--���Ը������ ���鼭 ��ǰ��� �ŷ�ó���� ���� Ȯ���ϰ� �ʹ�
--���Ը������ ��ǰ�� ���� ����
SELECT I.io_date, I.io_pcode, P.p_name, I.io_inout, 
        I.io_price, I.io_quan, I.io_price*I.io_quan AS �հ�
FROM tbl_iolist I
    LEFT JOIN tbl_product P
        ON I.io_pcode = P.P_code;
        
-- ���Ը������ �ŷ�ó ���� ���� ���� ������
SELECT I.io_date, I.io_dcode, I.io_inout, 
        I.io_price, I.io_quan, I.io_price*I.io_quan AS �հ�
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code;

--���Ը������ ���鼭 ��ǰ����, �ŷ�ó������ ���� ���� �ʹ�
SELECT I.io_date, I.io_pcode, P.p_name, I.io_inout, 
        I.io_price, P.p_iprice, P.p_oprice, I.io_quan, I.io_price*I.io_quan AS �հ�
FROM tbl_iolist I
    LEFT JOIN tbl_product P
        ON I.io_pcode = P.p_code
        
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code ;
        
-- ���Ը������ ��ǰ����, �ŷ�ó������ JOIN�ؼ� ��ȸ�ߴ��� ������ �ʹ� �����ϴ�
-- ���� ����� �� ���ٸ�?
-- SQL�� VIEW�� �������ش�
CREATE VIEW io_dept_product_view
AS 
SELECT I.io_date, I.io_pcode, P.p_name, I.io_inout, I.io_dcode,
        I.io_price, P.p_iprice, P.p_oprice, I.io_quan, I.io_price*I.io_quan AS �հ�
FROM tbl_iolist I
    LEFT JOIN tbl_product P
        ON I.io_pcode = P.p_code
        
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code ;
        
SELECT * FROM io_dept_product_view ;        

SELECT io_inout, COUNT(*), SUM(io_total)
FROM tbl_iolist 
WHERE io_date BETWEEN '2018-03-01' AND '2018-03-31'
    AND io_inout = '����'
GROUP BY io_inout ;

SELECT io_inout, COUNT(*), SUM(io_total)
FROM tbl_iolist 
WHERE io_inout = '����' AND io_date BETWEEN '2018-03-01' AND '2018-03-31'
GROUP BY io_inout ;