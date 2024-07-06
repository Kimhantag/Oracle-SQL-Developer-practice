// 12~13 집합 연산자와 서브쿼리 //

// union all : 집합연산자로 데이터를 위아래로 연결하기. //
// 연결하는 테이블의 출력하는 컬럼의 각각의 데이터 형식을 일치시켜야 함. //
// 예제 67. 부서번호와 부서번호별 토탈 월급을 출력하는데 다음과 같이 맨 아래에 전체 토탈 월급도 출력하세요. //
select deptno, sum(sal)
    from emp
    group by deptno
union all
select to_number(null) as deptno, sum(sal)
    from emp
    order by deptno asc;
    
// 문제 67. 직업과 직업별 토탈월급을 출력하는데 맨 아래에 전체 토탈월급도 출력하세요. //
select job, sum(sal)
    from emp
    group by job
union all
select to_char(null) job, sum(sal)
    from emp
    order by job asc;
 
// rollup을 이용하여 출력하는 것도 가능함.//
select job, sum(sal)
    from emp
    group by rollup(job)
    order by job asc;


// union : 조건 컬럼을 기준으로 정렬하여 데이터를 연결함. //
// 문제 68. 입사한 년도, 입사한 년도별 토탈월급을 출력하는데 맨 아래에 전체 토탈 월급이 출력되게 하세요. //
//         입사한 년도는 정렬이 되어서 출력되게 하세요. //
select to_char(hiredate,'RRRR') 입사년도, sum(sal)
    from emp
    group by hiredate
union
select to_char(null) 입사년도, sum(sal)
    from emp
    order by 입사년도 asc;
    

// intersect : 데이터를 교집합을 출력하기. //
// intersect는 중복되는 행을 출력할 뿐만 아니라 첫 컬럼을 기준으로 정렬하여 출력한다. //
// 문제 69. 사원 테이블과 부서 테이블과의 공통된 부서번호가 무엇인지 출력하세요. //

select deptno
    from emp
intersect
select deptno
    from dept;
    

// minus : 데이터의 차집합을 출력하기. //
// 문제 70. 부서테이블에는 존재하는데 사원 테이블에는 존재하지 않는 부서번호는? //
select deptno
    from dept
minus
select deptno
    from emp;
    

// 단일행 서브쿼리. //
// 예제 71. JONES보다 더 많은 월급을 받는 사원들의 이름과 월급을 출력하세요. //
select ename, sal
    from emp
    where sal > (select sal 
                 from emp 
                 where ename = 'JONES');

// 문제 71. ALLEN보다 더 늦게 입사한 사원들의 이름과 월급을 출력하세요. //
select ename, hiredate, sal
    from emp
    where hiredate > (select hiredate
                      from emp
                      where ename = 'ALLEN');
                      
                      
// 다중행 서브쿼리. //
// 단일 행 서브쿼리 : 서브 쿼리에 의해 메인쿼리에 리턴되는 값이 한개임 따라서 >, <, =, !=  사용 //
// 다중 행 서브쿼리 : 서브 쿼리에 의해 메인쿼리에 리턴되는 값이 여러개임 //
// 따라서 in, not in, >all, <all, >any, <any 사용, 부등호 및 등호 사용불가 //
// 예제 72. 직업이 SALESMAN인 사원들과 같은 월급을 받는 사원들의 이름과 월급을 출력하세요. //
select ename, sal
    from emp
    where sal in (select sal
                  from emp
                  where job = 'SALESMAN');
                  // 직업이 SALESMAN인 사원의 월급은 여러개의 행을 가짐 //

// 문제 72. 부서번호가 20번인 사원들과 같은 직업을 갖는 사원들의 이름과 직업을 출력하세요. //
select ename, job
    from emp
    where job in (select job
                  from emp
                  where deptno = 20);
                  

// not in 연산자를 사용한 서브쿼리 사용하기. //
// 문제 73. 관리자가 아닌 사원들의 이름을 출력하세요. //

// false case : null이 포함되어 있을 경우, not in을 사용하면 null을 위한 조건을 추가해야함. //
// select ename                      //
//   from emp                        //
//    where empno not in (select mgr // 
//                        from emp); //

select ename
    from emp
    where empno not in (select mgr
                        from emp
                        where mgr is not null);
                        // select nvl(mgr, -1)도 가능 //
                        
                        
// exists, not exist //
// exists문은 메인쿼리부터 실행되는 특징을 가짐. //
// 문제 74. 부서테이블에 존재하지 않는 부서번호, 이름, 지역을 출력하세요. //
select *
    from dept 
    where not exists (select *
                      from emp
                      where emp.deptno = dept.deptno);
                      

// having절 서브 쿼리 //
// 그룹 함수 group by에 검색조건을 주고 싶으면 having절을 사용해야함. where절은 사용불가. //
// 문제 75. 부서번호, 부서번호 별 인원수를 출력하는데 10번 부서번호의 인원수보다 더 큰 것만 출력하세요. //
select deptno, count(*) 부서인원
    from emp
    group by deptno
    having count(*) > (select count(*)
                            from emp
                            where deptno = 10);
                            

// from절 서브 쿼리 //
// rank over()와 같이 주로 select문에서 출력되는 컬럼들에 대해 where문에서 조건을 주고 싶을 때 // 
// from절을 이용한 하위쿼리 작성 //
// 문제 76. 직업이 SALESMAN인 사원들 중에서 가장 먼저 입사한 사원의 이름과 입사일을 출력하세요. //
select ename, hiredate
    from (select ename, hiredate, rank() over(order by hiredate asc) rnk
          from emp
          where job = 'SALESMAN')
    where rnk = 1;

// 같은 결과를 출력하는 쿼리 //
select ename, hiredate
    from (select *
          from emp
          where job = 'SALESMAN'
          order by hiredate asc)
    where rownum = 1
    

// select절의 서브 쿼리 //
// select절의 where 절의 조건과 select 절의 서브쿼리 where절의 조건을 모두 작성할 수 있도록 한다. //
// 예제 77. 직업이 SALESMAN인 사원들의 이름과 월급을 출력하고, 최대월급과 최소월급도 함꼐 출력하세요. //
select ename, sal, (select max(sal) from emp where job = 'SALESMAN') 최대월급,
                   (select min(sal) from emp where job = 'SALESMAN') 최소월급
    from emp
    where job = 'SALESMAN';

// 문제 77. 부서번호가 20번인 사원들의 이름과 월급을 출력하고 그 옆에 20번 부서번호인 사원들의 평균월급이 출력되게 하세요. //
select ename, sal, (select avg(sal) from emp where deptno = 20) 평균월급
    from emp
    where deptno = 20;

// **** select 문의 6가지절 *********** //
//  순서  |   절   |  서브쿼리 가능유무  //
//   5     select         가능        //
//   1      from          가능        //
//   2      where         가능        //
//   3     group by      불가능       //
//   4      having        가능        //
//   6     order by       가능        //