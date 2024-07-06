--------------------------------------------------------------------------------------------------
// 7~8 데이터 분석 함수 //

// rank : 데이터 분석 함수로 순위 출력하기. //
// rank() over(order by 컬럼명 asc(or desc) )
// 문제 41. 부서번호가 20번인 사원들의 이름과 부서번호와 월급과 월급에 대한 순위를 출력하세요. //
select ename, deptno, sal, rank() over(order by sal desc) as 순위
    from emp
    where deptno = 20;


// dense_rank : 데이터 분석 함수로 순위 출력하기(순위가 동일한 경우, 다음 순위를 표현) //
// rank() over(partition by 컬럼1명 order by 컬럼2명 asc(or desc)) : partition by에 의해 컬럼1별로 order by 조건
// 문제 42-1. 직업, 이름, 순위를 출력하는데 순위가 직업별로 각각 월급이 높은 사원순으로 순위를 부여하세요. //
select job, ename, sal, dense_rank() over(partition by job
                                          order by sal desc) as 순위
    from emp;

// dense_rank(기준값) within group(order by 컬럼) : 기준값의 해당 컬럼에서의 순위 //
// 문제 42-2. 월급이 2945인 사원은 사원 테이블에서 월급의 순위가 몇위인가요? //
select dense_rank(2945) within group(order by sal desc)
    from emp;
    

// ntile : 데이터 분석 함수로 등급 출력하기. //
// ntile(n) over(order by 컬럼명 asc(or desc)) : 컬럼을 n개의 등급으로 나누어 매김//
// 문제 43. 이름, 입사일, 입사한 사원 순으로 등급을 나누는데 등급을 5등급으로 나눠서 출력하세요. //
select ename, hiredate, ntile(5) over(order by hiredate asc) 등급
    from emp;
    
    
// cume_dist : 순위의 비율 출력하기. //
// cume_dist() over(order by 컬럼명 asc(or desc) : 컬럼에서의 순위를 비율로 나타냄//
// 문제 44. 부서번호, 이름, 월급과 월급의 순위에 대한 비율을 출력하세요. 순위 비율이 부서번호별 각각 출력되도록 하세요. //
select deptno, ename, sal, round(cume_dist() over(partition by deptno
                                                  order by sal desc),2) as 비율
    from emp;
    
    
// listagg : 데이터를 가로로 출력하기. //
// listagg(컬럼명, 구분자 또는 기호) within group(order by 기준 컬럼 asc(or desc)) // 
// : 기준 칼럼의 정렬에 따라 구분자(또는 기호)로 분리된 컬럼의 값들을 가로로 출력 //
// * group by 절이 꼭 함께 쓰여야 함. //
// 문제 45. 직업, 직업별로 속한 사원들의 이름을 가로로 출력하는데 가로로 출력될 떄에 월급이 높은 사원부터 출력되게 하세요. //
select job, listagg(ename, '/') within group(order by sal desc) 
    from emp
    group by job;
    

// lag, lead : 바로 전행과 다음행 출력하기. //
// lag(컬럼명, 행번호) over(order by 기준 컬럼 asc(or desc)) //
// lead(컬럼명, 행번호) over(order by 기준 컬럼 asc(or desc)) //
// 문제 46. 이름, 입사일, 바로 전에 입사한 사원과의 간격일을 출력하세요. //
select ename, hiredate, hiredate - lag(hiredate, 1) over(order by hiredate asc) as 간격
    from emp;
    
    
// sum over : 누적 데이터 출력하기. //
// sum(컬럼명) over(order by 기준컬럼) //
// = sum(컬럼명) over(order by 기준컬럼 rows between unbounded preceding and current row) //
// 예제50. 직업이 ANALYST, MANAGER인 사우너들의 사원번호, 사원이름, 월급, 월급에 대한 누적치를 출력하세요. //
select empno, ename, sal, sum(sal) over(order by empno)누적
    from emp
    where job in ('ANALYST', 'MANAGER');

// 문제 50. 부서번호가 20번인 사원들의 사원이름, 월급, 월급에 대한 누적치가 출력되게 하세요. //
select ename, sal, sum(sal) over(order by sal)누적
    from emp
    where deptno = 20;


// ratio_to_report : 비율 출력하기. //
// ratio_to_report(컬럼명) over()
// 문제 51. 부서번호가 20번인 사원들의 사원번호, 이름, 월급, 월급에 대한 비율을 출력하세요. //
select empno, ename, sal, round(ratio_to_report(sal) over(),2 ) 비율
    from emp
    where deptno = 20;

    
// rollup : 집계 결과를 아래에 출력하기. //
// group by rollup(컬럼명) //
// 문제 52. 부서번호, 부서번호별 토탈월급을 출력하는데 맨 아래에 전체 토탈월급이 출력되게 하세요. //
select deptno, sum(sal)
    from emp
    group by rollup(deptno);
    

// cube : 집계 결과를 위에 출력하기. //
// group by cube(컬럼명) //
// 문제 53. 입사한 년도(4자리), 입사한 년도별 토탈월급을 출력하는데 맨위에 사원 테이블의 전체 토탈월급이 출려되게 하세요. //
select to_char(hiredate, 'RRRR') 입사년도, sum(sal)
    from  emp
    group by cube(to_char(hiredate, 'RRRR'));
    
    
// grouping sets : 컬럼별 집계결과 출력하기. //
// grouping sets(컬럼명1, 컬럼명2, ()) : ()는 전체 집계 결과 //
// grouping sets((컬럼명1, 컬럼명2), ()) : 컬럼1, 컬럼2에 동시에 속하는 집계 결과 //
select deptno, job, sum(sal)
    from emp
    group by grouping sets(deptno, job, ());
    
select deptno, job, sum(sal)
    from emp
    group by grouping sets((deptno, job), ());
    
// 문제 54. 입사한 년도(4자리)별 토탈월급과 직업별 토탈월급을 위아래로 같이 출력하세요. //
select to_char(hiredate, 'RRRR'), job, sum(sal)
    from emp
    group by grouping sets(to_char(hiredate, 'RRRR'), job);
    
    
// row_number : 출력결과 넘버링 하기. //
// row_number() over(order by 컬럼명 asc(or desc)) : 컬럼명을 기준으로 행의 넘버링을 함. //
// 문제 55. 월급이 1000에서 3000사이인 사원들의 이름과 월급을 출력하는데 출력하는 결과 맨 끝에 번호를 넘버링해서 출력하세요. //
select ename, sal, row_number() over(order by empno) 번호
    from emp
    where sal between 1000 and 3000;
    

// rownum : 출력되는 행 제한하기. //
// select rownum, ... where rownum < n : rownum은 항상 존재하지만 생략처리되어 있으므로 사용하고자하면 입력해주고 사용하면 된다. //
// rownum = 1은 가능하지만 rownum = n은 불가능, rownum <= n의 형태로 확인하여야 함. //
// 문제 56. 직업이 SALESMAN인 사원들의 이름과 월급과 직업을 출력하는데 맨위의 행 2개만 출력하세요. //
select rownum, ename, sal, job
    from emp
    where rownum <= 2 and job = 'SALESMAN';
    

// simple top-n queries : 정렬 후 출력되는 행 제한하기. //
// order by 컬럼명 asc(or desc) fetch first n rows only : 컬럼 기준으로 정렬 후 처음부터 n 행까지 출력//
// 문제 57. 최근에 입사한 사원순으로 이름, 입사일과 월급을 출력하는데 맨위의 5명만 출력하세요. //
select ename, hiredate, sal
    from emp
    order by hiredate desc fetch first 5 rows only;
