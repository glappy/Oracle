-- ���� ���̺� ����
DROP TABLE tbl_iolist ;
DROP TABLE tbl_dept;

-- ������ ���Ը��������� ����Ŭ�� ����Ʈ
-- ���Ը���DB�κ��� ��2����ȭ�� �ؼ� �ŷ�ó ������ �и��Ѵ�

DROP TABLE tbl_iolist;
CREATE TABLE tbl_iolist(
    io_id	    NUMBER		    PRIMARY KEY,
    io_date	    CHAR(10)    	NOT NULL,
    io_cname	nVARCHAR2(50)	NOT NULL,
    io_dname	nVARCHAR2(50)	NOT NULL,	
    io_dceo	    nVARCHAR2(50),		
    io_inout	nVARCHAR2(5)	NOT NULL,	
    io_quan 	NUMBER,	
    io_price	NUMBER,		
    io_total	NUMBER		
);

--������ ����Ʈ Ȯ��
SELECT * FROM tbl_iolist;

-- ���Ը��� �����ؼ� ����Ʈ Ȯ��
SELECT io_inout, COUNT(*) FROM tbl_iolist
GROUP BY io_inout;

-- ���Ը����������� �ŷ�ó������ �ٸ� ���̺�� �и��ؼ� ��2����ȭ ������ ����
-- ���Ը����������� �ŷ�ó ���� ����
-- �ŷ�ó��� ��ǥ���� �׷����� ���� ����Ʈ ����
SELECT io_dname, io_dceo
FROM tbl_iolist
GROUP BY io_dname, io_dceo
ORDER BY io_dname;

--��������  ������ �ŷ�ó������ ����Ʈ �ϱ� ���� ���̺� ����
CREATE TABLE tbl_dept(
    d_code CHAR(6) PRIMARY KEY,
    d_name nVARCHAR2(50) NOT NULL,
    d_ceo nVARCHAR2(20)
);

-- �����κ��� �ŷ�ó������ ����Ʈ
SELECT COUNT(*) FROM tbl_dept;

-- tbl_iolist�� tbl_dept�� ������ Į�� �߰��ϰ� tbl_dept�κ��� �����۾��� ����
ALTER TABLE tbl_iolist ADD io_dcode CHAR(6);
--�߰��� Į�� Ȯ��
DESC tbl_iolist;

-- SUB QUERY
-- DML ���ο� �ٸ� SELECT ���� �ִ� SQL�� ���Ѵ�
SELECT io_dname, io_dceo, io_dcode
FROM tbl_iolist;

--�� SQL�� SUB QUERY�� �߰��ؼ� DEPT���̺�κ��� IOLIST�� ��ȸ
SELECT io_dname, io_dceo,
    (SELECT d_code FROM tbl_dept D
        WHERE D.d_name = tbl_iolist.io_dname AND
              D.d_ceo = tbl_iolist.io_dceo) AS dcode
FROM tbl_iolist ;

-- SUB QUERY �̿��ؼ� TBA_DEPT�κ��� TBL_IOLIST�� �ŷ�ó�ڵ� UPDATE�ϴ� �ڵ�
UPDATE tbl_iolist I
SET io_dcode 
    =  (SELECT d_code FROM tbl_dept D
        WHERE D.d_name = I.io_dname AND
              D.d_ceo = I.io_dceo);
              
SELECT io_dcode, io_dname, io_dceo FROM tbl_iolist;              

-- TBL_IOLIST�� IO_DNAME�� IO_dceo Į�� ����
ALTER TABLE tbl_iolist DROP COLUMN io_dname ;
ALTER TABLE tbl_iolist DROP COLUMN io_dceo ;
DESC tbl_iolist;

-- IOLIST�� DEPT���̺��� JOIN�ؼ� ��ȸ�ϴ� SQL
SELECT I.io_date, I.io_cname, I.io_dcode, D.d_name, D.d_ceo
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dcode = D.d_code;
--�� JOIN�� EQ JOIN�̶�� �ϸ� TBL_IOLIST���̺� �ο� TBL_DEPT ���̺� ���� IO_DCODE�� ���ٴ� ������ ���� �� ������ ����� �����ش�
-- ���� ��Ȳ������ TBL_DEPT�� ���� �ڵ尡 TBL_IOLIST�� ���� �� �ִ�

--�׽�Ʈ �����͸� ����� ���ؼ� 
-- ������ �����Ϳ� IO_DCODE�� ���� �� ����

SELECT * FROM tbl_iolist
WHERE io_dcode = 'D00100';

UPDATE tbl_iolist
SET io_dcode = 'D00500'
WHERE io_id = 306;

SELECT I.io_date, I.io_cname, I.io_dcode, D.d_name, D.d_ceo
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dcode = D.d_code
    AND io_id BETWEEN 300 AND 310
ORDER BY I.io_id ;    

--JOIN���� ���� ���·� ���Ը��� ���о��� �հ� ���
SELECT COUNT(*), SUM(io_total)
FROM tbl_iolist
WHERE io_id BETWEEN 300 AND 310;

-- EQ JOIN���� ���Ը��� ���о��� �հ� ���
-- ���� �հ� �ݾ�, ������ ���� ��
SELECT COUNT(*), SUM(io_total)
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dcode = D.d_code;
    AND io_id BETWEEN 300 AND 310;
    
-- LEFT JOIN���� ���Ը��� ���о��� �հ� ���
SELECT COUNT(*), SUM(io_total)
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code
WHERE io_id BETWEEN 300 AND 310;

-- LEFT JOIN�� ���� ���̺��� �����ʹ� ��� �����ְ� ���� ���̺��� Ű�� ��ġ�ϴ� �����Ͱ� ������ ���̺� ������ �����ְ� ������ NULL�� ǥ��
-- ������ ���̺� ��ġ�ϴ� ������ ��� ���� ������ �Ϻΰ� �����Ǿ� ��谡 �߸��Ǵ� ������ Ȯ���ϴ� ����̸� ���� ��Ȳ���� ����� ������ JOIN
SELECT I.io_dcode, D.d_name, D.d_ceo
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code
WHERE io_id BETWEEN 300 AND 310;

-- IOLIST�κ��� �ŷ�ó������ �и�. �ŷ�ó������ GROUP���� ���� ��ȸ. ������ ����. CODE�� �ο�.
-- ���̺� ����. ����Ʈ. IOLIST�� DCODE Į�� ����. �ŷ�ó���� ���̺��� IOLIST�� DCODEĮ���� UPDATE

SELECT io_dname
FROM tbl_iolist
GROUP BY io_dname;