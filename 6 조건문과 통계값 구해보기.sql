------------------------------------------------------------------------------------------------
// 06 조건문과 통계값 구해보기 // 


// nvl,nvl2 : NULL 값 대신 다른 데이터 출력하기, nvl(컬럼명, 변경값) //
// 변경하는 컬럼과 변경값은 서로 형태가 같아야함. // 
// 문제 33. 이름과 커미션을 출력하는데 커미션이 null인 사원들은 no comm이라는 글씨로 출력되게 하세요. //
select ename, nvl(to_char(comm), 'no comm')
    from emp; 
    

// decode를 통해 SQL에서 if문 구현하기 //
// decode( 조건 컬럼, 조건1, 결과1, 조건2, 결과2, ... , 나머지) // 
// 문제 34. 이름, 직업, 보너스를 출력하는데 직업이 SALESMAN이면 6000을 출력하고 직업이 ANALYST면 //
//         3000을 출력하고 직업이 MANAGER면 2000을 출력하고 나머지 직업은 0으로 출력되게 하시오. //
select ename, job, decode(job, 'SALESMAN', 6000,
                                'ANALYST', 3000,
                                'MANAGER', 2000, 0) as 보너스
    from emp;
    
    
// case를 통해 SQL에서 if문을 구현하기 //
// case when 컬럼명, 조건1 then 변경값1 when 컬럼명 조건2 then 변경값2 ... else 나머지값 end //
// 문제 35. 이름, 월급, 보너스를 출력하는데 //
//         월급이 3000이상이면 보너스를 9000을 출력하고, //
//         월급이 2000이상이면(2000이상이면서 3000보다 작으면) 8000을 출력하고 //
//         나머지(2000보다 작은 사원들)는 0을 출력하시오. //

select ename, sal, case when sal >= 3000 then 9000
                        when sal >= 2000 then 8000
                        else 0 end as 보너스
    from emp;
    

// max : 최대값 출력하기 //
// 문제 36-1. 직업이 SALESMAN인 사원들 중에서의 최대월급을 출력하세요.//
select max(sal)
    from emp
    where job = 'SALESMAN';
    
// 문제 36-2. 직업이 SALESMAN인 사원들 중에서의 최대월급을 출력하는데 아래와 같이 직업도 출력하세요. //
select job, max(sal)
    from emp
    where job = 'SALESMAN'
    group by job;
    // from - where - group by - select절 순서로 진행, group by를 통해 //
    // job은 'SALESMAN'를 대표하는 하나의 값을 가짐.// 
    

// min : 최소값 출력하기 //
// 문제 37-1. 부서번호가 20번인 사원들 중에서 최소 월급을 출력하세요. //
select min(sal)
    from emp
    where deptno = 20;
    
// 문제 37-2. 부서번호와 부서번호별 최소월급을 출력하세요. //
select deptno, min(sal)
    from emp
    group by deptno;


// avg : 평균값 구하기 //
// 문제 38-1. 직업과 직업별 평균 월급을 출력하는데 직업별 평균 월급이 높은 것부터 출력하세요. //
select job, round(avg(sal))
    from emp
    group by job
    order by 2 desc;
    // from - group by - select - order by 순서로 실행 //
    
// 문제 38-2. 부서번호, 부서번호 별 평균 월급을 출력하느데 부서번호 별 평균월급을 출력할 때 천단위를 표시하시오. //
select deptno, to_char(round(avg(sal)), '999999,999') as 평균월급
    from emp
    group by deptno;
    

// sum : 합계 구하기 //
// 문제 39-1. 1981년도에 이사한 사원들의 월급의 토탈값을 출력하세요. //
select sum(sal)
    from emp
    where to_char(hiredate, 'RRRR') = '1981';
    
// 문제 39-2. 직업과 직업별 토탈월급을 출력하는데 직업별 토탈월급이 6000이상인 것만 출력하세요. //
select job, sum(sal)
    from emp
    group by job
    having sum(sal)>=6000;
    // group 함수에 검색조건을 줄 때는 where이 아니라 having 절에 작성해야 함.//


// count : 건 수 출력하기, count(*) : 행 전체를 셈 //
// count 함수는 그룹함수로, null 값을 제외하고 셈, avg, sum 또한 마찬가지 //
// 문제 40-1. 부서번호, 부서번호 별 인원수를 출력하세요. //
select deptno, count(*)
    from emp
    group by deptno;
    
// 문제 40-2. 직업과 직업별 인원수를 출력하는데 직업이 SALESMAN은 제외하고 출력하고 직업별 인원수가 //
//            3명 이상인 것만 출력하세요. //
select job, count(*)
    from emp
    where job != 'SALESMAN'
    group by job
    having count(*) >= 3;
    // 위와 아래는 결과가 같은 쿼리이나 having 절이 아닌 where절을 통해 먼저 필터링하는 것이 효과적임. //
    // = select job, count(*)
    //     from emp
    //     group by job
    //     having job!='SALESMAN' and count(*) >= 3; //