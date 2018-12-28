-- ����� user1���� ������ ȭ���Դϴ�
-- tbl_addr�� �ϴ� ����
DROP TABLE tbl_addr;

-- tbl_addr ����
CREATE TABLE tbl_addr (
    id NUMBER PRIMARY KEY, -- �⺻Ű, PK
    st_name CHAR(50) NOT NULL, -- �̸��� ���� ��ĭ ����
    st_age NUMBER(3),
    st_addr VARCHAR2(125)
);

INSERT INTO tbl_addr
VALUES(0,'ȫ�浿',12,'�����');

INSERT INTO tbl_addr
VALUES(1,'ȫ�浿',12,'�����');

INSERT INTO tbl_addr
VALUES(2,'�̸���',16,'������');

-- �����͸� �߰��ϸ鼭 0�� �׸�� 1�� �׸���
-- �߸� Ȯ���Ͽ� ���� �������ΰ����� �ν��ϰ�
-- INSERT ó���� �� ���ȴ�.

SELECT * FROM tbl_addr ;
-- SELECT�� �����͸� Ȯ�� �ߴ��� �� ���� �����Ͱ�
-- �ѻ���� �����ͷ� �ߺ� �Ȱ��� Ȯ�� �Ǿ���.
-- �ٽ� ���� ������ �ô���
-- �ι�° ȫ�浿�� �ּҰ� ������ �ƴ� �λ��� ������ Ȯ��?�.
-- �׷���, �ι�° ȫ�浿�� �ּҸ� �λ����� �����Ϸ��� �Ѵ�.
-- �ٽ��ѹ� SELECT �ؼ� ȫ�浿�� �����͸� Ȯ������.
SELECT * 
FROM tbl_addr
WHERE st_name = 'ȫ�浿'; -- st_nameĮ���� ���� ȫ�浿 �ΰ�츸 ������

-- ������ ���� ����
UPDATE tbl_addr
SET st_addr = '�λ��'
WHERE id = 1;

-- Ȯ��
SELECT *
FROM tbl_addr ;


INSERT INTO tbl_addr
VALUES(3,'������',16,'�ͻ��');
INSERT INTO tbl_addr
VALUES(4,'������',16,'�ͻ��');
-- �Ǽ��� ������ �����͸� 2�� �ߺ� �Է��ߴ�
-- �׷��� ���߿� �Է��� �����͸� �����Ϸ��� �Ѵ�
SELECT * FROM tbl_addr ;

-- ������ ������(��)�� Ȯ���� ���� �Ѵ�
SELECT *
FROM tbl_addr
WHERE st_name = '������';

-- �������� 2��° �������� id�� 4�� �����͸� ����
DELETE FROM tbl_addr
WHERE id = 4;

SELECT *
FROM tbl_addr ;

-- DataBase�� Table �����Ҷ�
-- ����ϰ��� �ϴ� Į���߿� UNIQUE �� �׸��� �ִٸ�
-- �� Į���� PRIMARY KEY = PK �� �����ϴ� ���� ����
-- �׷��� ������ ��� Table���� id��� Į���� ���� �߰��ؼ�
-- �ش� Į���� PK�� ������ �ִ� ���� ����.


CREATE TABLE tbl_postno (
    postno CHAR(5) PRIMARY KEY, -- ��ü ���Ἲ �����
    street nVARCHAR2(125) NOT NULL UNIQUE,
    -- �����͸� ����ΰų� �̹� ���� ���� �ԷµǾ� ������
    -- �ٽ� �Էµ��� �ʵ��� �ϴ� �ɼ�
    addr nVARCHAR2(125)
);