-------------------------------------------------------------------------------------------
// 28 index range scan �� where ���� �º�


-------------------------------------------------------------------------------------------
--����1.  ������ 1600 �� ������� �̸��� ������ ����Ͻÿ� 

create  index emp_sal  on  emp(sal);

select  /*+ gather_plan_statistics  */   ename, sal
 from emp
 where sal = 1600; 

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

--unique ������ �����Ƿ�, �ߺ��� ���� ���� �� ���� => ���� �ε����� ���� �˻�
--����2. �̸��� SCOTT �� ����� �̸��� ������ ����Ͻÿ� 

create  index emp_ename  on  emp(ename);

select  /*+ gather_plan_statistics */   ename, sal
 from emp
 where ename='SCOTT';

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


--����3. ������ MANAGER �� ������� �̸��� ������ ����Ͻÿ�.

create index  emp_job  on  emp(job);

select /*+ gather_plan_statistics */ ename, sal
 from emp
 where job='MANAGER';

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


-- ����. ��� ���̺��� �Ի��Ͽ� �ε����� �����ϰ� �Ի����� 81�� 11�� 17�Ͽ� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�.
create index emp_hiredate
    on emp(hiredate);
    
select /*+ gather_plan_statistics index(emp emp_hiredate) */ ename, hiredate
    from emp
    where hiredate = to_date('1981/11/17');

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


-------------------------------------------------------------------------------------------
-- 1. ������ �÷� �ε��� �÷��� �����ȴٸ�
--  => full range scan���� �����

-- ����1. ����(sal*12) �� 36000 �� ������� �̸��� ������ ����ϴ� ���� SQL�� Ʃ���Ͻÿ� !  

-- Ʃ���� : full table scan
create  index emp_sal  on emp(sal); 

SELECT   /*+ gather_plan_statistics  */   ename, sal*12
        FROM  emp
        WHERE   sal * 12 = 36000; 
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- Ʃ���� : index range scan
SELECT   /*+ gather_plan_statistics  */   ename, sal
        FROM  emp
        WHERE   sal = 36000/12; 
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


-- ����2. ������ ù��° ���� 5��°�� �ڸ��� SALES�� ������� �̸��� ������  ����ϴ� �Ʒ���  SQL �� Ʃ���ϼ���.
-- Ʃ���� : full table scan
create  index  emp_job  on  emp(job);

SELECT  /*+ gather_plan_statistics  */   e ename,  job
           FROM  emp
           WHERE   substr(job,1,5) ='SALES';
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- Ʃ���� : index range scan
create  index  emp_job  on  emp(job);

SELECT  /*+ gather_plan_statistics  */   ename,  job
           FROM  emp
           WHERE job like 'SALES%';
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));
           
           
-- ����3. 1981�⵵�� �Ի��� ������� �̸��� �Ի����� ����ϴ� ������ SQL�� Ʃ���ϼ���.
-- Ʃ���� : full table scan
create  index emp_hiredate  on  emp(hiredate); 

SELECT /*+ gather_plan_statistics  */   ename, hiredate
                FROM  emp
                WHERE   to_char(hiredate, 'RRRR') ='1981';
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- Ʃ���� : index range scan
create  index emp_hiredate  on  emp(hiredate); 

SELECT /*+ gather_plan_statistics  */   ename, hiredate
                FROM  emp
                WHERE hiredate between to_date('1981/01/01', 'RRRR/MM/DD')
                                   and to_date('1981/12/31', 'RRRR/MM/DD') +1;
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


-- ����. ������ SQL�� Ʃ���Ͻÿ� 
create index emp_ename on  emp(ename);
create index emp_sal on  emp(sal);

-- Ʃ����: full table scan
select /*+ gather_plan_statistics  */ ename, sal, job
  from emp
 where  ename || sal ='SCOTT3000';
 
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- Ʃ����: index table scan
select  ename, sal, job
  from emp
 where  ename ='SCOTT' and sal = 3000;
 
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));