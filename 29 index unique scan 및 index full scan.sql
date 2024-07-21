-------------------------------------------------------------------------------------------
// 29 index unique scan �� index full scan 


-------------------------------------------------------------------------------------------
-- index unique scan 
-- primary key ������ �ɸ� index�� �����ȴ�.
-- ����1. �����ȣ�� 7788���� ������� �����ȣ�� �̸��� ������ ����Ͻÿ�.
-- Ʃ���� : index range scan
create  index emp_empno  on  emp(empno);

select   /*+ gather_plan_statistics  */  empno, ename
 from emp
 where  empno = 7788;
 select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));
 
 -- Ʃ���� : index unique scan
drop index emp_empno;
create unique index emp_empno  on  emp(empno);

select   /*+ gather_plan_statistics  */  empno, ename
 from emp
 where  empno = 7788;
 select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));

-- ����2.  ��� �̸��� �ε����� �ɸ� ��Ƽ�������� �����ȣ�� �ε����� ������ �Ұ��ΰ� ��� �̸��� �ε����� ������ �Ұ��ΰ�
-- �� �ε��� �� unique index �켱 ���� ���
drop index emp_empno;
create unique index  emp_empno on emp(empno);
create index  emp_ename on emp(ename);

select   /*+ gather_plan_statistics  */  empno, ename
 from emp
 where  ename='SCOTT'  and  empno = 7788; 
 select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));
 
-- ����3. ��� ���̺� empno �� primary key ������ �ɰ� �����ȣ�� 7788 ���� �����ȣ�� �̸��� ����Ͻÿ�.
-- primary key �����, �ڵ����� unique index �����ǹǷ� �켱���� ���
alter  table  emp
  add  constraint  emp_empno_pk  primary key(empno);


select  /*+ gather_plan_statistics  */ empno, ename
 from emp
 where  ename='SCOTT'  and  empno = 7788; 


-- ����. �μ� ���̺� deptno �� primary key ������ �ɰ� �μ���ȣ�� 20���� �μ���ġ�� �μ����� ����Ͻÿ�.
alter table dept
    add constraint dept_deptno_pk primary key(deptno);
    
select /*+ gather_plan_statistics */loc, deptno
    from dept
    where deptno = 20;
 select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));

-------------------------------------------------------------------------------------------
-- index full scan 
-- : ���� �÷� �ε����� ù �÷��� �ƴ� �÷��� �����͸� �˻��� ��, �ε��� ��ü�� ��ĵ�ϸ鼭 ���ϴ� �����͸� �˻��ϴ� ��ĵ ���
-- table full scan : ���̺��� ó������ �������� �� ��ĵ�ϸ鼭 ���ϴ� �����͸� ã�� �˻� ���(����, ȿ�� �϶�)
-- ���� �÷� �ε��� : �ε����� �� �� �̻�
-- => �˻��ϰ��� �ϴ� �����Ͱ� �ε����� �� �����Ǿ� �ִٸ� ���̺� �������� ���� ����.

--1. table full scan �̶�?

select  /*+ gather_plan_statistics */ ename, sal
  from  emp
  where  sal = 3000;

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));

--2. ���� �÷� �ε����� �־����� 

create index emp_sal
 on emp(sal);

select  /*+ gather_plan_statistics */ ename, sal
  from  emp
  where  sal = 3000;

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));

drop index emp_sal;

--3. ���� �÷� �ε����� �����ߴٸ�?

create index emp_sal_ename
 on emp(sal, ename);

select  /*+ gather_plan_statistics */ ename, sal
  from  emp
  where  sal = 3000;

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));


--4. index full scan �̶�?

select  /*+ gather_plan_statistics */ ename, sal
  from  emp
  where  ename='JONES';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));


--Quize

-- ��� ���̺� �����ȣ+����̸�+�������� ���� �÷�
-- �ε����� �����ϰ�  ������ 1250�� ����� �̸��� ������ ����ϴµ� ���� ������ �ε����� 
-- ����ϰڱ� ��Ʈ�� �ְ� �����ϼ���. 


