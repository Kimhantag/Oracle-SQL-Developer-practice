--------------------------------------------------------------------------------------------------
// 16 서브쿼리 사용하기2


--------------------------------------------------------------------------------------------------
// select for update절 : 서로 다른 세션에서 업데이트가 각각 진행되려할 때, 먼저 업데이트를 진행한 세션에서,
//                       다른 세션에서 업데이트 하지 못하게 lock을 걸어버리는 방법.
select *
    from emp
    where e.name = 'JONES'
    for update;

// 문제 84. 부서번호가 10, 20번인 사원들의 이름과 직업과 부서번호를 조회하는 동안,
//          다른 세션에서 부서번호 10번, 20번인 사원들의 데이터를 갱신하지 못하게 하세요.
select ename, job, deptno
    from emp
    where deptno in (10, 20)
    for update;
    

--------------------------------------------------------------------------------------------------    
// 서브쿼리를 사용하여 데이터 입력하기
// 예제 85. 사원테이블과 같은 구조의 새로운 테이블을 생성하고,
//          사원테이블에서 부서번호가 10번인 사원들의 사원번호, 이름, 월급, 부서번호를 생성한 테이블을 입력하세요.
create table emp2
    as
    select *
        from emp;
        // emp테이블과 동일한 emp2테이블을 생성함.
select * from emp2;
drop table emp2;

create table emp2
    as
    select *
        from emp
        where 1 = 2;
        // 1=2를 만족하는 행은 존재하지 않기 떄문에, emp와 구조(컬럼)만 같은 emp2테이블이 생성됨.

// values가 없음에 유의해야 함.
insert into emp2(empno, ename, sal, deptno)
    select empno, ename, sal, deptno
        from emp
        where deptno = 10;

select * from emp2;

// 문제 85. 부서 테이블과 같은 구조의 테이블을 DEPT2라는 이름으로 생성하고,
//         부서번호가 20번, 30번의 모든 컬럼의 데이터를 DEPT2에 입력하세요.
create table dept2
    as
    select *
        from dept
        where 1 = 2;

insert into dept2
    select *
    from dept
    where deptno in (20, 30);
select * from dept2;


--------------------------------------------------------------------------------------------------
// 서브쿼리를 사용하여 데이터 수정하기
// 예제 86. 직업이 SALESMAN인 사원들의 월급을 ALLEN의 월급으로 수정하세요.
update emp
    set sal = (select sal
                 from emp
                 where ename = 'ALLEN')
    where job = 'SALESMAN';
select * from emp;
rollback;

// 문제 86. 부서번호가 30번인 사원들의 직업을 MARTIN의 직업으로 변경하세요.
update emp
    set job = (select job
                 from emp
                 where ename = 'MARTIN')
    where deptno = 30;
select * from emp;
rollback;


--------------------------------------------------------------------------------------------------
// 서브쿼리를 사용하여 데이터 삭제하기
// 예제 87. SCOTT보다 더 많은 월급을 받는 사원들을 삭제하세요.
delete from emp
    where sal > (select sal
                   from emp
                   where ename = 'SCOTT');
select * from emp;
rollback;

// 문제 87. ALLEN보다 늦게 입사한 사원들의 모든 행을 지우세요.
delete from emp
    where hiredate > (select hiredate
                        from emp
                        where ename = 'ALLEN');
select * from emp;
rollback;


--------------------------------------------------------------------------------------------------
// 서브쿼리를 사용하여 데이터 합치기
// 예제 88. 다음과 같이 부서테이블에 부서번호별 토탈월급 데이터가 입력되게 하세요.
alter table dept
    add sumsal number(10);

// merge문 작성 시, alias는 매우 중요함.
// into절의 테이블 값(혹은 서브쿼리), using절의 테이블 값(혹은 서브쿼리) alias 작성은 구분이 쉽게 작성
merge into dept d
    using ( select deptno, sum(sal) as sumsal
              from emp
           group by deptno) v
    on (d.deptno = v.deptno)
    when matched then
    update set d.sumsal = v.sumsal;
select * from dept;
rollback;

// 문제 88. 부서 테이블에 cnt라는 컬럼을 추가하고, 해당 부서번호의 인원수로 값을 갱신하시오.
alter table dept
    add cnt number(10);
    
merge into dept d
    using (select deptno, count(*) cnt
             from emp 
         group by deptno) e
    on (d.deptno = e.deptno)
    when matched then
    update set d.cnt = e.cnt; 

select * from dept;
rollback;