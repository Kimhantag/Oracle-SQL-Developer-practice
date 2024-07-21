-------------------------------------------------------------------------------------------
// 28 index range scan 및 where 절의 좌변


-------------------------------------------------------------------------------------------
--예제1.  월급이 1600 인 사원들의 이름과 월급을 출력하시오 

create  index emp_sal  on  emp(sal);

select  /*+ gather_plan_statistics  */   ename, sal
 from emp
 where sal = 1600; 

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

--unique 제약이 없으므로, 중복된 값이 있을 수 있음 => 따라서 인덱스를 통해 검색
--예제2. 이름이 SCOTT 인 사원의 이름과 월급을 출력하시오 

create  index emp_ename  on  emp(ename);

select  /*+ gather_plan_statistics */   ename, sal
 from emp
 where ename='SCOTT';

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


--예제3. 직업이 MANAGER 인 사원들의 이름과 월급을 출력하시오.

create index  emp_job  on  emp(job);

select /*+ gather_plan_statistics */ ename, sal
 from emp
 where job='MANAGER';

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


-- 문제. 사원 테이블의 입사일에 인덱스를 생성하고 입사일이 81년 11월 17일에 입사한 사원들의 이름과 입사일을 출력하시오.
create index emp_hiredate
    on emp(hiredate);
    
select /*+ gather_plan_statistics index(emp emp_hiredate) */ ename, hiredate
    from emp
    where hiredate = to_date('1981/11/17');

SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


-------------------------------------------------------------------------------------------
-- 1. 숫자형 컬럼 인덱스 컬럼이 가공된다면
--  => full range scan으로 실행됨

-- 예제1. 연봉(sal*12) 이 36000 인 사원들의 이름과 연봉을 출력하는 다음 SQL을 튜닝하시오 !  

-- 튜닝전 : full table scan
create  index emp_sal  on emp(sal); 

SELECT   /*+ gather_plan_statistics  */   ename, sal*12
        FROM  emp
        WHERE   sal * 12 = 36000; 
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- 튜닝후 : index range scan
SELECT   /*+ gather_plan_statistics  */   ename, sal
        FROM  emp
        WHERE   sal = 36000/12; 
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


-- 예제2. 직업의 첫번째 부터 5번째의 자리가 SALES인 사원들의 이름과 직업을  출력하는 아래의  SQL 을 튜닝하세요.
-- 튜닝전 : full table scan
create  index  emp_job  on  emp(job);

SELECT  /*+ gather_plan_statistics  */   e ename,  job
           FROM  emp
           WHERE   substr(job,1,5) ='SALES';
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- 튜닝후 : index range scan
create  index  emp_job  on  emp(job);

SELECT  /*+ gather_plan_statistics  */   ename,  job
           FROM  emp
           WHERE job like 'SALES%';
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));
           
           
-- 예제3. 1981년도에 입사한 사원들의 이름과 입사일을 출력하는 다음의 SQL을 튜닝하세요.
-- 튜닝전 : full table scan
create  index emp_hiredate  on  emp(hiredate); 

SELECT /*+ gather_plan_statistics  */   ename, hiredate
                FROM  emp
                WHERE   to_char(hiredate, 'RRRR') ='1981';
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- 튜닝후 : index range scan
create  index emp_hiredate  on  emp(hiredate); 

SELECT /*+ gather_plan_statistics  */   ename, hiredate
                FROM  emp
                WHERE hiredate between to_date('1981/01/01', 'RRRR/MM/DD')
                                   and to_date('1981/12/31', 'RRRR/MM/DD') +1;
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


-- 문제. 다음의 SQL을 튜닝하시오 
create index emp_ename on  emp(ename);
create index emp_sal on  emp(sal);

-- 튜닝전: full table scan
select /*+ gather_plan_statistics  */ ename, sal, job
  from emp
 where  ename || sal ='SCOTT3000';
 
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

-- 튜닝후: index table scan
select  ename, sal, job
  from emp
 where  ename ='SCOTT' and sal = 3000;
 
SELECT * FROM TABLE(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));