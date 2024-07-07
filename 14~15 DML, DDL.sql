---------------------------------------------------------------------------------------------
// 14~15 DML, DDL //

// SQL�� ����
// 1. query�� : select, from, where, group by, having, order by
// 2. DML��(Data Manipulate Language): insert, update, delete, merge
// 3. DDL��
// 4. DCL��
// 5. TCL��

---------------------------------------------------------------------------------------------
// insert : ������ �Է� 
// ���� 77. ������ �����͸� �߰��ϼ���. 
insert into emp(empno, ename, sal, job, hiredate)
    values(2812, 'JACK', 3500, 'ANALYST', to_date('2019/06/05', 'RRRR/MM/DD'));
                                          // ��¥�� �Է��� ��, to_date�� ���� �Է��ؾ� �� ��. //

select * from emp;
    
rollback; // ������ �۾��� �������� �ǵ��� 

// ���� 78. �μ����̺� �Ʒ��� �����͸� �Է��ϼ���. 
// �μ���ȣ:50, �μ��̸�:RESEARCH, �μ���ġ:SEOUL 
insert into dept(deptno, dname, loc)
    values(50, 'RESEARCH', 'SEOUL');
    
select * from dept;

rollback;


---------------------------------------------------------------------------------------------
// commit : ������ ����, commit �ڿ� rollbackd�� �ص� commit �������� ���ư��� ����.
// rollback : ������ ���� ���
insert into emp(empno, ename, sal, deptno)
    values(9382, 'jack', 3000, 10);
    
select * from emp; 

rollback;

select * from emp;


---------------------------------------------------------------------------------------------
// update : ������ �����ϱ�
// ���� 79. SCOTT�� ������ 3200���� �����ϼ���. 
update emp
    set sal = 3200
    where ename = 'SCOTT';
    
select *
    from emp;
    
// ���� 79. ������ SALESMAN�� ������� Ŀ�̼��� 7000���� �����ϼ���.
update emp
    set comm = 7000
    where job = 'SALESMAN';
    
select * from emp;

rollback;

---------------------------------------------------------------------------------------------
// delete, truncate, drop : ������ �����ϱ�
// ----------------------------------------------
//           |  ������  |  �������  |  ���屸��  |
// ----------------------------------------------
// delete   |   ����   |    ����    |    ����    |    
// truncate |   ����   |    ����    |    ����    |
// drop     |   ����   |    ����    |    ����    |

// delete from ���̺�
// rollback�� ������.
// ���� 80. SCOTT�� �����͸� �����ϼ���.
delete from emp
    where ename = 'SCOTT';
    
select * from emp;

rollback;

// ���� 80-1. ������ 3000�̻��� ������� �����ϼ���.
delete from emp
    where sal >= 3000;
    
select * from emp;

rollback;

// truncate table ���̺�
// rollback�� �Ұ�����. �ٷ� commit�� �Ǳ� ����.
// drop�� �����뿡�� ������ �� �ִµ�, truncate�� �ٽ� ������ �� �ִ� ����� ���� ������ ���� �����ؼ� ����ؾ� ��.
// ���� 80-2. �μ����̺��� ����µ� ������ ����� �� �����ϼ���. 
truncate table dept;

select * from dept;

rollback;

alter session set nls_Date_format='RR/MM/DD';
drop table emp;
drop table dept;


CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );


INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );


INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-09',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);


commit;

select * from emp;
select * from dept;


---------------------------------------------------------------------------------------------
// merge : ������ �Է�, ����, ���� �ѹ��� �ϱ�
// ���� 82. ��� ���̺��� �μ� ��ġ �÷��� �����ϼ���. ���� �μ� ���̺� �ִ� �μ���ȣ�� ������̺� �Է��ϼ���.
alter table emp
    add loc varchar2(10);
    // loc �÷��� �����ϰ�, �ԷµǴ� ������ �������� ���̸� 10�ڱ��� �Է��� ������.
select * from emp;

merge into emp e
    using dept d
    on (e.deptno = d.deptno)
    when matched then 
    update set e.loc = d.loc
    when not matched then
    insert (e.empno, e.deptno, e.loc) values(1111, d.deptno, d.loc);

select * from emp;

alter session set nls_Date_format='RR/MM/DD';
drop table emp;
drop table dept;


CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );


INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );


INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-09',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);


commit;

select * from emp;
select * from dept;

// ����82. ������̺� �μ��� �÷��� �߰��ϰ� �ش� ����� �μ������� ���� �����ϼ���.
alter table emp
    add dname varchar2(10);
select * from emp;

merge into emp e
    using dept d
    on (e.deptno = d.deptno)
    when matched then 
    update set e.dname = d.dname;
select * from emp;

alter session set nls_Date_format='RR/MM/DD';
drop table emp;
drop table dept;


CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );


INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );


INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-09',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);


commit;


---------------------------------------------------------------------------------------------
// lock : �������� �ϰ����� �����ϱ� ����, �� ���ǿ��� ������Ʈ�� ���ÿ� ������ ��, 
//        �켱���� ������Ʈ�� ������ ���ǿ����� �������� ����Ǹ�, �ٸ� ���ǿ��� ������Ʈ �� �� ������ �ϴ� ���
//        ù ���ǿ��� ������Ʈ ���� commit�� �����ϸ�, lock�� Ǯ���ԵǾ�, �ٸ� ���ǿ��� ������Ʈ�� ��������.
//        �ٸ� ���ǿ��� ������Ʈ�� �߰��� �ϴ��� commit�� �����ؾ� ���������� ������Ʈ�� �ݿ���.

// ���� 83. SCOTT���� ������ â 2���� ������� ���¿��� �ϳ��� â���� ALLEN�� ������ 2000���� �����ϰ�,
//         commit�� ���� ���¿��� �ٸ� â���� ALLEN�� �μ���ȣ�� 10������ �����ϸ� ������ ������ �ɱ�?

// => �������� ����, ù��° ���ǿ��� commit ���� �ʾұ� ������, ��ü �࿡ LOCK�� �ɸ��� ��.

