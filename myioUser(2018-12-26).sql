-- ����� MYIOUSERȭ���Դϴ�

CREATE TABLE tbl_iolist(
    io_id	    NUMBER	    PRIMARY KEY,
    io_date	    CHAR(10)	NOT NULL,
    io_pname	nVARCHAR2(50)	NOT NULL,
    io_dname	nVARCHAR2(50)	NOT NULL,
    io_ceo  	nVARCHAR2(50),
    io_inout	nVARCHAR2(7),
    io_quan	    NUMBER,
    io_price	NUMBER,	
    io_total	NUMBER		
);

DROP TABLE tbl_iolist ;

SELECT * FROM tbl_iolist ;

SELECT io_dname AS �ŷ�ó��, io_ceo AS ��ǥ�ڸ� FROM tbl_iolist
GROUP BY io_dname, io_ceo;

CREATE TABLE tbl_dept(
    d_code	CHAR(5)		    PRIMARY KEY,
    d_name	nVARCHAR2(50)	NOT NULL,	
    d_ceo	nVARCHAR2(50)
);

SELECT * FROM tbl_dept;

DESC tbl_dept;

ALTER TABLE tbl_dept MODIFY d_name NULL ;

ALTER TABLE tbl_dept MODIFY d_name NOT NULL ;

-- �� SQL������ Ȯ���� LIST�� ��� ��ǰ���Ը��� ����� ���ͼ� �߸��� �����Ͱ� �ִ��� Ȯ���ϱ� ��ƴ�
-- ���� �� SQL���� ���� ���� �� �Ϻ� �����Ͱ� IOLIST���� ������ DEPT���� ������ D.D_NAME�� D.D_CEO�� NULL������ ��Ÿ�� ��
-- �� ������ �̿��Ͽ� D.D_NAME�̳� D.D_CEO�� NULL�� �͸� ã�ƺ��� ���� Ȯ���� �����ϴ�
SELECT I.io_dname, D.d_name, I.io_ceo, D.d_ceo
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dname = D.d_name AND I.io_ceo = D.d_ceo;

SELECT I.io_dname, D.d_name, I.io_ceo, D.d_ceo
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dname = D.d_name AND I.io_ceo = D.d_ceo
WHERE D.d_name IS NULL OR D.d_ceo IS NULL;
-- �� SQL�� ���� ���� �� LIST�� �ϳ��� ����� ����

SELECT io_dname
FROM tbl_iolist
WHERE io_dname IS NULL;
-- �ŷ�ó���� ������ ���� �ִ°�

SELECT io_dname FROM tbl_iolist
WHERE io_dname IS NOT NULL ;
-- �ŷ�ó���� ���� �׸��� �ִ°�?

SELECT io_price FROM tbl_iolist
WHERE io_price = 0;

SELECT io_price FROM tbl_iolist
WHERE io_price IS NULL;

SELECT I.io_dname, I.io_ceo, D.d_code
FROM tbl_iolist I, tbl_dept D ;

SELECT I.io_dname, I.io_ceo,
    (SELECT D.d_code FROM tbl_dept D
        WHERE I.io_dname = D.d_name AND I.io_ceo = D.d_ceo)
FROM tbl_iolist I;

ALTER TABLE tbl_iolist ADD io_dcode CHAR(5);

-- �ŷ�ó�������̺��� ��ǰ���Ը��� ���̺� �ִ� �ŷ�ó��� ��ǥ�ڸ��� ��ġ�ϴ� �����͸� ã�Ƽ� �ŷ�ó�ڵ带 ��ǰ���Ը��⿡ UDPATE
UPDATE tbl_iolist I
SET io_dcode = (
    SELECT D.d_code FROM tbl_dept D
        WHERE I.io_dname = D.d_name AND I.io_ceo = D.d_ceo);
        
SELECT io_dcode, io_dname, io_ceo
FROM tbl_iolist 
ORDER BY io_dcode;