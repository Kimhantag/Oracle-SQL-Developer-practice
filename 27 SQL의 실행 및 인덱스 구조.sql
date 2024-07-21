-------------------------------------------------------------------------------------------
// 27 SQL의 실행 및 인덱스 구조


-------------------------------------------------------------------------------------------
-- 예제1. 예상 실행계획 확인하는 방법

explain  plan  for
    select   ename, sal
       from  emp
       where  sal = 1300;

select  * from  table( dbms_xplan.display );


-- 예제2. 실제 실행계획 확인하는 방법

 select  /*+  gather_plan_statistics   */  ename, sal
       from  emp
       where  sal =  1300;

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- 예제3. full table scan 일때

 select  /*+  gather_plan_statistics   */  ename, sal
       from  emp
       where  sal =  1300;

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- 예제4. 인덱스 스캔 일때 

create  index  emp_sal
  on  emp(sal);

 select  /*+  gather_plan_statistics  index(emp emp_sal)  */  ename, sal
       from  emp
       where  sal =  1300;

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


--- 문제. 아래의 SQL을 튜닝하시오 !

select  empno,ename, sal, job
  from  emp
 where empno = 7788;

튜닝전:   select /*+ gather_plan_statistics */  empno,ename, sal, job
              from  emp
              where  empno = 7788; 

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

튜닝후:    create  index  emp_empno  on  emp(empno); 

  select /*+ gather_plan_statistics */  empno,ename, sal, job
              from  emp
              where  empno = 7788; 

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

----------------------------------------------------------------------------------------
-- ■ 예제2. 인덱스의 구조를 이해하자 !

-- 예제1.  월급에 인덱스를 생성하고 인덱스의 구조를 확인하시오 !

create  index  emp_sal
 on  emp(sal);

select  sal, rowid
  from emp
  where sal >= 0;


-- 예제2. 이름에 인덱스를 생성하고 인덱스의 구조를 확인하시오 !

create index emp_ename
 on emp(ename);

selecet  ename, rowid
  from emp
 where  ename >'  ';
 
 select /*+ gather_plan_statistics */ ename, rowid
    from emp
    where ename > ' ';

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- 예제3. 입사일에 인덱스를 생성하고 인덱스의 구조를 확인하시오 !

create index emp_hiredate
 on emp(hiredate);

select hiredate, rowid
 from emp
 where hiredate <to_date('9999/12/31','RRRR/MM/DD');

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- 문제. dept 테이블에 loc 에 인덱스를 생성하고 인덱스의 구조를 확인하시오 !
select * from dept;

create index dept_loc
    on dept(loc);
    
select loc, rowid
    from dept
    where loc> ' ';
