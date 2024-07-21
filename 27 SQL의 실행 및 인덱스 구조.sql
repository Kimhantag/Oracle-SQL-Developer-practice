-------------------------------------------------------------------------------------------
// 27 SQL�� ���� �� �ε��� ����


-------------------------------------------------------------------------------------------
-- ����1. ���� �����ȹ Ȯ���ϴ� ���

explain  plan  for
    select   ename, sal
       from  emp
       where  sal = 1300;

select  * from  table( dbms_xplan.display );


-- ����2. ���� �����ȹ Ȯ���ϴ� ���

 select  /*+  gather_plan_statistics   */  ename, sal
       from  emp
       where  sal =  1300;

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- ����3. full table scan �϶�

 select  /*+  gather_plan_statistics   */  ename, sal
       from  emp
       where  sal =  1300;

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- ����4. �ε��� ��ĵ �϶� 

create  index  emp_sal
  on  emp(sal);

 select  /*+  gather_plan_statistics  index(emp emp_sal)  */  ename, sal
       from  emp
       where  sal =  1300;

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


--- ����. �Ʒ��� SQL�� Ʃ���Ͻÿ� !

select  empno,ename, sal, job
  from  emp
 where empno = 7788;

Ʃ����:   select /*+ gather_plan_statistics */  empno,ename, sal, job
              from  emp
              where  empno = 7788; 

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

Ʃ����:    create  index  emp_empno  on  emp(empno); 

  select /*+ gather_plan_statistics */  empno,ename, sal, job
              from  emp
              where  empno = 7788; 

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

----------------------------------------------------------------------------------------
-- �� ����2. �ε����� ������ �������� !

-- ����1.  ���޿� �ε����� �����ϰ� �ε����� ������ Ȯ���Ͻÿ� !

create  index  emp_sal
 on  emp(sal);

select  sal, rowid
  from emp
  where sal >= 0;


-- ����2. �̸��� �ε����� �����ϰ� �ε����� ������ Ȯ���Ͻÿ� !

create index emp_ename
 on emp(ename);

selecet  ename, rowid
  from emp
 where  ename >'  ';
 
 select /*+ gather_plan_statistics */ ename, rowid
    from emp
    where ename > ' ';

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- ����3. �Ի��Ͽ� �ε����� �����ϰ� �ε����� ������ Ȯ���Ͻÿ� !

create index emp_hiredate
 on emp(hiredate);

select hiredate, rowid
 from emp
 where hiredate <to_date('9999/12/31','RRRR/MM/DD');

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- ����. dept ���̺� loc �� �ε����� �����ϰ� �ε����� ������ Ȯ���Ͻÿ� !
select * from dept;

create index dept_loc
    on dept(loc);
    
select loc, rowid
    from dept
    where loc> ' ';
