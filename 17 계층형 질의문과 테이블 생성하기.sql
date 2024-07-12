--------------------------------------------------------------------------------------------------
// 17 ������ ���ǹ��� ���̺� �����ϱ�


--------------------------------------------------------------------------------------------------
// ������ ���ǹ����� ������ �ְ� ������ ����ϱ�1
// start with ���� ���� connect by prior ���� ���� 
// ���� 89. ��� ���̺��� ����(level)�� ����ϼ���.
select ename, level, sal, job
    from emp
    start with ename ='KING'
    connect by prior empno = mgr;
    
// level�� ���� ���� ǥ��
select rpad(' ', level*3) || ename, sal, job
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr;
    
// ���� 89. ������ 2���� ������� �̸��� ������ ������ ����ϼ���.
select ename, level, job
    from emp
    where level = 2
    start with ename = 'KING'
    connect by prior empno = mgr;
    // start with ~ ������ where���� ���� �ԷµǴ��� level�� ���õ� ������ �����.
    

-------------------------------------------------------------------------------------------------- 
// ������ ���ǹ����� ������ �ְ� ������ ����ϱ�2
// ���� 90. ���� ������ ������ ���¿��� BLAKE�� �� �������� ��µ��� �ʰ� �ϼ���.
select *
    from emp
    where ename != 'BLAKE'
    start with ename = 'KING'
    connect by prior empno = mgr and ename != 'BLAKE';
    // ������ �ű�µ� ���� ������ mgr�� ���� ������ empno�� �̿��ϵ�,
    // BLAKE ����� ���� �ű�� �Ϳ��� �����Ͽ�, �׷� ���� �Ű����� ���� ������ ����鵵 ������.

// ���� 90. ��� ���̺��� ���� ������� �̸��� ���ް� ������ ����ϴµ�
//         SCOTT�� �� ����, FORD�� �� �������� ��µ��� �ʵ��� �ϼ���.
select *
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr and ename not in ('SCOTT', 'FORD');
    
    
--------------------------------------------------------------------------------------------------    
// ������ ���ǹ����� ������ �ְ� ������ ����ϱ�3
// order siblings by �÷� asc(or desc) : ������ ������ ���¿��� �÷��� ���� ����
// ���� 91. ���� ������ ������ ���¿��� ������ ���� ������� ����ϼ���.
select rpad(' ', level*3) || ename employee, level, sal, job
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr
    order siblings by sal desc;
    
// ���� 91. BLAKE�� �� �����鸸 ����ϴµ� ������ ������ ���¿��� ������ ���� ������� ����ϼ���.
select rpad(' ', level*3) || ename employee, level, sal, job
    from emp
    start with ename = 'BLAKE'
    connect by prior empno = mgr 
    order siblings by sal asc;
    

--------------------------------------------------------------------------------------------------
// ������ ���ǹ����� ������ �ְ� ������ ����ϱ�4
// sys_connect_by_path(�÷�, ��ȣ) : ������ �������� �÷��� ���� ��ȣ�� �����Ͽ� ���η� ��Ÿ��.
// ���� 92. �ڱ��� ���� ������ ��� �Ǵ��� ����ϼ���.
select ename, sys_connect_by_path(ename, '/') path
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr;
    
// ���� 92. �ڽ��� �̸��� ������ ������ ��� �Ǵ��� ����ϼ���.
select ename || '(' ||ename|| ')' as info, sys_connect_by_path(ename || '(' ||ename|| ')', '/') path
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr
    

--------------------------------------------------------------------------------------------------
// create table : �Ϲ� ���̺� �����ϱ�
// create table ���̺�� (�÷�1 �ڷ���1, �÷�2 �ڷ���2, ... )
// ������ ����(�ڷ���) 3���� : 1) ������ : varchar2
//                          2) ������ : number
//                          3) ��¥�� : date
// ����Ŭ�� �����͸� ������ ���̺��� �����ϼ���. (empno, ename, sal, hiredate �÷� ����)
create table emp93
    (empno number(10),
     ename varchar2(10),
     sal number(10, 2),
     hiredate date);
     // number(10, 2)�� 10�ڸ��� ���� �� 2�ڸ��� �Ҽ��� �Ʒ��� �ڸ��� �ο����� �ǹ��Ѵ�.
select * from emp93;

insert into emp93(empno, ename, sal, hiredate)
    values(7788, 'SCOTT', 3000.00, to_date('81/12/21', 'RR/MM/DD'));
select * from emp93;
drop table emp93;

// ���� 93. ������ ���̺��� �����ϼ���.
//         (���̺�� : emp50, �÷��� : empno, ename, sal, job, deptno)
create table emp50
    (empno number(10),
     ename varchar2(10),
     sal number(10),
     job varchar2(10),
     deptno number(10));
select * from emp50;
drop table emp50;


--------------------------------------------------------------------------------------------------
// create temporay table : �ӽ����̺� �����ϱ�
// �ӽ����̺��� �ʿ��� ��� => �����ͺ��̽��� ������ ������ �ʿ䰡 ���� ��� ��� ����ϴ� �뵵
//                          commit�ϰԵǸ�, �ӽ����̺��� �����ʹ� �����.(������ ����)
// create global temporary table ���̺�� ... on commit delete rows;
// 1) on commit delete rows : Ŀ���ϸ� �����͸� ����.
// 2) on commit preserve rows : Ŀ���ص� �����͸� ������ ������, ������ �����ϸ� �����͸� ����.
// ���� 94. ������ ���� ���̺��� ����� �����͸� �����ϴµ� commit�� �ϸ� �����Ͱ� ������� �ϼ���.
create global temporary table emp37
    (empno number(10),
     ename varchar2(10),
     sal number(10))
     on commit delete rows;
     
insert into emp37 values(1111, 'SCOTT', 3000);
insert into emp37 values(2222, 'SMITH', 4000);
select * from emp37;
commit;

select * from emp37;

// ���� 94. ������ �����ϸ� �����Ͱ� ������� �ӽ����̺��� �����ϼ���.
//         (���̺�� : emp94, �÷��� : empno, ename, sal)
create global temporary table emp94
    (empno number(10),
     ename varchar2(10),
     sal number(10))
     on commit preserve rows;

insert into emp94 values(1111, 'SCOTT', 3000);
insert into emp94 values(2222, 'SMITH', 4000);
select * from emp94;
commit;

select * from emp94;
