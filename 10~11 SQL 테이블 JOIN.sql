//---------------------------------------------------------------------------------------//
// 10~11 SQL 테이블 JOIN //

select *
    from emp;

select *
    from dept;

// equl join : 여러 테이블의 조인해서 출력하기. //
// join 시 컬럼을 확인할 때, 컬럼명 앞에 테이블 명(테이블 별칭)을 붙이는 것이 효과적임. //
// 문제 58-1. 직업이 SALESMAN인 사원들의 이름과 직업과 부서위치를 출력하세요. //
select ename, e.job, d.loc
    from emp e, dept d
    where e.deptno = d.deptno and e.job = 'SALESMAN';
    
// 문제 58-2. DALLAS에서 근무하는 사원들의 이름과 월급과 부서위치를 출력하세요. //
select e.ename, e.sal, d.loc
    from emp e, dept d
    where e.deptno = d.deptno and d.loc = 'DALLAS';
    
 
 
// 급여 등급 테이블 생성 //
create table salgrade
( grade   number(10),
  losal   number(10),
  hisal   number(10) );
 
insert into salgrade  values(1,700,1200);
insert into salgrade  values(2,1201,1400);
insert into salgrade  values(3,1401,2000);
insert into salgrade  values(4,2001,3000);
insert into salgrade  values(5,3001,9999);
 
commit;

select *
    from salgrade;   
// non equl join : 공통된 컬럼이 없는 여러 테이블을 조인하기. //
// 예제 59. 사원 테이블과 급여 테이블을 조인하여 이름과 월급, 월급에 대한 등급을 출력하세요. //
select e.ename, e.sal, s.grade
    from emp e, salgrade s
    where e.sal between s.losal and s.hisal;

// 문제 59. 급여등급이 4등급인 사원들의 이름과 월급을 출력하는데 월급이 높은 사원부터 출력하세요. //
select e.ename, e.sal
    from emp e, salgrade s
    where e.sal between s.losal and s.hisal
          and s.grade = 4
    order by e.sal desc;



// outer join : 여러 테이블을 조인하되, 조인하는 컬럼의 특정 테이블 값을 모두 출력함. //
// equi join은 join 기준 컬럼에 공통으로 존재하는 값에 대해서만 join함. //
// 문제 60. 사원테이블 전체에 이름과 부서위치를 출력하는데 JACK도 출력되게 하세요. //
insert into emp(empno, ename, sal, deptno)
    values(7122, 'JACK', 30000, 70);

select *
    from emp;
    
select e.ename, d.loc
    from emp e, dept d
    where e.deptno = d.deptno(+);
    
    
// self join : 같은 테이블 끼리 조인 //
// 문제 61. 사원이름과 직업을 출력하고 관리자 이름과 직업을 출력하세요. //
//         그리고 관리자인 사원들보다 더 많은 월급을 받는 사원의 데이터만 출력하세요. //
select 사원.ename 사원이름, 사원.job 사원직업, 사원.sal 사원월급,
       관리자.ename 관리자이름, 관리자.job 관리자직업, 관리자.sal 관리자월급
    from emp 사원, emp 관리자
    where 사원.mgr = 관리자.empno
          and 사원.sal > 관리자.sal;
          

// 조인 문법 1. 오라클 조인 문법  //
//           1) equi join / 2) non equi join / 3) outer join / 4) self join //
//          2. 1999 ansi 조인 문법 //

// on절 : 1999ansi의 조인 문법
// from 테이블1 join 테이블2 //
// on (테이블1.컬럼1 = 테이블2.컬럼2) // 
// 문제 62. 월급이 1000에서 3000사이인 사원들의 이름과 월급과 부서 위치를 on절을 사용한 조인 문법으로 출력하세요. //
select e.ename, e.sal, d.loc
    from emp e join dept d
    on (e.deptno = d.deptno)    
    where e.sal between 1000 and 3000;
    

// using절 : using절에 table 별칭(alias)을 적지 않는다. //
// 문제 63. using 절을 사용한 조인 문법으로 부서위치가 DALLAS인 사원들의 이름과 월급과 부서위치를 출력하세요. //
select e.ename, e.sal, d.loc
    from emp e join dept d
    using (deptno)
    where d.loc = 'DALLAS';
    
    
// natural join : on, using절보다 간단하게 조인하는 방식 //
// using 절과 마찬가지로 공통 컬럼 앞에 테이블 별칭을 쓰면 안됨 //
// 문제 64. 직업이 SALESMAN이고 부서번호가 30번인 사원들의 이름과 직업과 월급과 부서 위치를 출력하세요.
select e.ename, e.job, e.sal, d.loc
    from emp e natural join dept d
    where e.job = 'SALESMAN' and
          deptno = 30;
          
          
// left, right outer join //
// 문제 66. 다음의 데이터를 사원 테이블에 입력하고 1999ansi 조인 문법을 사용하여 이름과 직업, 월급과 부서위치를 //
//         출력하는데 사원테이블에 JACK도 출력될 수 있도록 하세요. //
insert into emp(empno, ename, sal, job, deptno)
    values(8282, 'JACK', 3000, 'ANALYST', 50);
commit;

select e.ename, e.job, e.sal, d.loc
    from emp e left outer join dept d
    on (e.deptno = d.deptno);
    
    
// full outer join : SQL join에는 존재하지 않는 형식 //
// 문제 66. 직업이 ANALYST 이거나 부서위치가 BOSTON인 사원들의 이름, 직업, 월급, 부서위치를 출력하는데 //
//          full outer join을 사용하여 출력하세요. //
select e.ename, e.job, e.sal, d.loc
    from emp e full outer join dept d
    on (e.deptno = d.deptno)
    where e.job = 'ANALYST' or d.loc = 'BOSTON';