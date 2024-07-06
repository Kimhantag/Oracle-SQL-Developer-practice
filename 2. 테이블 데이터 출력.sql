-------------------------------------------------------------------------------------------------
// 3 산술연산자, 비교연산자 //

// from, where, select 순서로 실행됨, 따라서 select의 alias는 order by 절의 제외한 다른 절에서 사용불가. //
// 문제9. 직업이 ANALYST 인 사원들의 이름과 연봉을 출력하세요. //
select ename, sal*12 as 연봉
    from emp
    where job = 'ANALYST';
    

// 문제10. 직업이 SALESMAN이 아닌 사원들의 이름과 직업을 출력하세요. //
select ename, job
    from emp
    where job != 'SALESMAN';
    

// 문제11-1. 월급이 1000에서 3000사이가 아닌 사원들의 이름과 월급을 출력하세요. //
select ename, sal
    from emp
    where sal not between 1000 and 3000; // == where sal < 1000 or sal > 3000;//
    
// 문제11-2. 1981년 11월 01일부터 1982년 05월 30일 사이에 입사한 사원들의 이름과 입사일을 출력하세요. //
select ename, hiredate
    from emp
    where hiredate between '81/11/01' and '1982/05/30';


// %:wild card, 이 자리에 뭐가 와도 관계없고 그 갯수가 몇개가 되든 관계없다.//
// _:under bar, 이 자리에 뭐가 와도 관계없고 자릿수는 하나여야 한다.// 
// 문제12-1. 이름의 끝글자가 T로 끝나는 사원들의 이름을 출력하세요. //
select ename
    from emp
    where ename like '%T';

    
// 문제12-2. 이름의 두번째 철자가 M인 사원들의 이름을 출력하세요. //
select ename
    from emp
    where ename like '_M%';


// null : 1. 데이터가 없는 상태, 2. 알 수 없는 값 -> 비교연산이 불가. //
// null과 0은 다름 //
// 문제 13. 커미션이 null이 아닌 사원들의 이름과 커미션을 출력하세요. // 
select ename, comm
    from emp
    where comm is not null;


// 여러 개를 비교할 때 '=' 대신에 in 연산자 사용. //
// 문제 14. 직업이 SALESMAN, ANALYST, MANAGER가 아닌 사원들의 이름과 월급과 직업을 출력하세요. //
select ename, sal, job
    from emp
    where job not in ('SALESMAN', 'ANALYST', 'MANAGER');


// 문제 15. 부서번호가 30번이고 커미션이 100이상인 사원들의 이름과 월급과 커미션을 출력하세요. //
select ename, sal, comm
    from emp
    where deptno = 30 and comm >= 100;
    

// lower : (컬럼명 또는 "문자열") , initcap : 첫자는 대문자 나머지는 소문자 //
// 문제 16. 이름이 scott인 사원의 이름과 월급을 출력하는데 소문자로 검색해도 결과가 출력되게 하세요.//
select ename, sal
    from emp
    where lower(ename)='scott';