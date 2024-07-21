-------------------------------------------------------------------------------------------
// 29 index unique scan 및 index full scan 


-------------------------------------------------------------------------------------------
-- index unique scan 
-- primary key 제약을 걸면 index가 생성된다.
-- 예제1. 사원번호가 7788번인 사원들의 사원번호와 이름과 월급을 출력하시오.
-- 튜닝전 : index range scan
create  index emp_empno  on  emp(empno);

select   /*+ gather_plan_statistics  */  empno, ename
 from emp
 where  empno = 7788;
 select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));
 
 -- 튜닝후 : index unique scan
drop index emp_empno;
create unique index emp_empno  on  emp(empno);

select   /*+ gather_plan_statistics  */  empno, ename
 from emp
 where  empno = 7788;
 select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));

-- 예제2.  사원 이름에 인덱스를 걸면 옵티마이져는 사원번호의 인덱스를 엑세스 할것인가 사원 이름에 인덱스를 엑세스 할것인가
-- 두 인덱스 중 unique index 우선 순위 사용
drop index emp_empno;
create unique index  emp_empno on emp(empno);
create index  emp_ename on emp(ename);

select   /*+ gather_plan_statistics  */  empno, ename
 from emp
 where  ename='SCOTT'  and  empno = 7788; 
 select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));
 
-- 예제3. 사원 테이블에 empno 에 primary key 제약을 걸고 사원번호가 7788 번인 사원번호와 이름을 출력하시오.
-- primary key 제약시, 자동으로 unique index 생성되므로 우선으로 사용
alter  table  emp
  add  constraint  emp_empno_pk  primary key(empno);


select  /*+ gather_plan_statistics  */ empno, ename
 from emp
 where  ename='SCOTT'  and  empno = 7788; 


-- 문제. 부서 테이블에 deptno 에 primary key 제약을 걸고 부서번호가 20번인 부서위치와 부서명을 출력하시오.
alter table dept
    add constraint dept_deptno_pk primary key(deptno);
    
select /*+ gather_plan_statistics */loc, deptno
    from dept
    where deptno = 20;
 select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));

-------------------------------------------------------------------------------------------
-- index full scan 
-- : 결합 컬럼 인덱스의 첫 컬럼이 아닌 컬럼의 데이터를 검색할 때, 인덱스 전체를 스캔하면서 원하는 데이터를 검색하는 스캔 방법
-- table full scan : 테이블의 처음부터 끝까지를 다 스캔하면서 원하는 데이터를 찾는 검색 방법(성능, 효율 하락)
-- 결합 컬럼 인덱스 : 인덱스가 두 개 이상
-- => 검색하고자 하는 데이터가 인덱스에 다 구성되어 있다면 테이블 엑세스를 하지 않음.

--1. table full scan 이란?

select  /*+ gather_plan_statistics */ ename, sal
  from  emp
  where  sal = 3000;

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));

--2. 단일 컬럼 인덱스만 있었을때 

create index emp_sal
 on emp(sal);

select  /*+ gather_plan_statistics */ ename, sal
  from  emp
  where  sal = 3000;

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));

drop index emp_sal;

--3. 결합 컬럼 인덱스를 생성했다면?

create index emp_sal_ename
 on emp(sal, ename);

select  /*+ gather_plan_statistics */ ename, sal
  from  emp
  where  sal = 3000;

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));


--4. index full scan 이란?

select  /*+ gather_plan_statistics */ ename, sal
  from  emp
  where  ename='JONES';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));


--Quize

-- 사원 테이블에 사원번호+사원이름+월급으로 결합 컬럼
-- 인덱스를 생성하고  월급이 1250인 사원의 이름과 월급을 출력하는데 지금 생성한 인덱스를 
-- 사용하겠금 힌트를 주고 실행하세요. 


