--------------------------------------------------------------------------------------------------
// 17 계층형 질의문과 테이블 생성하기


--------------------------------------------------------------------------------------------------
// 계층형 질의문으로 서열을 주고 데이터 출력하기1
// start with 적용 조건 connect by prior 서열 조건 
// 예제 89. 사원 테이블의 서열(level)을 출력하세요.
select ename, level, sal, job
    from emp
    start with ename ='KING'
    connect by prior empno = mgr;
    
// level에 따른 차등 표현
select rpad(' ', level*3) || ename, sal, job
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr;
    
// 문제 89. 서열이 2위인 사원들의 이름과 서열과 직업을 출력하세요.
select ename, level, job
    from emp
    where level = 2
    start with ename = 'KING'
    connect by prior empno = mgr;
    // start with ~ 절보다 where절이 먼저 입력되더라도 level에 관련된 조건이 실행됨.
    

-------------------------------------------------------------------------------------------------- 
// 계층형 질의문으로 서열을 주고 데이터 출력하기2
// 예제 90. 서열 순서를 유지한 상태에서 BLAKE와 그 팀원들이 출력되지 않게 하세요.
select *
    from emp
    where ename != 'BLAKE'
    start with ename = 'KING'
    connect by prior empno = mgr and ename != 'BLAKE';
    // 서열을 매기는데 상위 서열의 mgr과 하위 서열의 empno을 이용하되,
    // BLAKE 사원은 서열 매기는 것에서 제외하여, 그로 인해 매겨지는 하위 서열의 사원들도 제외함.

// 문제 90. 사원 테이블에서 서열 순서대로 이름과 월급과 직업을 출력하는데
//         SCOTT과 그 팀원, FORD와 그 팀원들이 출력되지 않도록 하세요.
select *
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr and ename not in ('SCOTT', 'FORD');
    
    
--------------------------------------------------------------------------------------------------    
// 계층형 질의문으로 서열을 주고 데이터 출력하기3
// order siblings by 컬럼 asc(or desc) : 서열을 유지한 상태에서 컬럼에 따라 정력
// 예제 91. 서열 순서를 유지한 상태에서 월급이 높은 순서대로 출력하세요.
select rpad(' ', level*3) || ename employee, level, sal, job
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr
    order siblings by sal desc;
    
// 문제 91. BLAKE와 그 팀원들만 출력하는데 서열을 유지한 상태에서 월급이 낮은 사원부터 출력하세요.
select rpad(' ', level*3) || ename employee, level, sal, job
    from emp
    start with ename = 'BLAKE'
    connect by prior empno = mgr 
    order siblings by sal asc;
    

--------------------------------------------------------------------------------------------------
// 계층형 질의문으로 서열을 주고 데이터 출력하기4
// sys_connect_by_path(컬럼, 기호) : 서열을 기준으로 컬럼의 값을 기호로 구분하여 가로로 나타냄.
// 예제 92. 자기의 서열 순서가 어떻게 되는지 출력하세요.
select ename, sys_connect_by_path(ename, '/') path
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr;
    
// 문제 92. 자신의 이름과 월급의 순서가 어떻게 되는지 출력하세요.
select ename || '(' ||ename|| ')' as info, sys_connect_by_path(ename || '(' ||ename|| ')', '/') path
    from emp
    start with ename = 'KING'
    connect by prior empno = mgr
    

--------------------------------------------------------------------------------------------------
// create table : 일반 테이블 생성하기
// create table 테이블명 (컬럼1 자료형1, 컬럼2 자료형2, ... )
// 데이터 유형(자료형) 3가지 : 1) 문자형 : varchar2
//                          2) 숫자형 : number
//                          3) 날짜형 : date
// 오라클에 데이터를 저장할 테이블을 생성하세요. (empno, ename, sal, hiredate 컬럼 포함)
create table emp93
    (empno number(10),
     ename varchar2(10),
     sal number(10, 2),
     hiredate date);
     // number(10, 2)는 10자리의 숫자 중 2자리는 소수점 아래의 자리를 부여함을 의미한다.
select * from emp93;

insert into emp93(empno, ename, sal, hiredate)
    values(7788, 'SCOTT', 3000.00, to_date('81/12/21', 'RR/MM/DD'));
select * from emp93;
drop table emp93;

// 문제 93. 다음의 테이블을 생성하세요.
//         (테이블명 : emp50, 컬럼명 : empno, ename, sal, job, deptno)
create table emp50
    (empno number(10),
     ename varchar2(10),
     sal number(10),
     job varchar2(10),
     deptno number(10));
select * from emp50;
drop table emp50;


--------------------------------------------------------------------------------------------------
// create temporay table : 임시테이블 생성하기
// 임시테이블이 필요한 경우 => 데이터베이스에 영구히 저장할 필요가 없는 경우 잠시 사용하는 용도
//                          commit하게되면, 임시테이블의 데이터는 사라짐.(구조는 존재)
// create global temporary table 테이블명 ... on commit delete rows;
// 1) on commit delete rows : 커밋하면 데이터를 지움.
// 2) on commit preserve rows : 커밋해도 데이터를 지우지 않으나, 세션을 종료하면 데이터를 지움.
// 예제 94. 다음과 같이 테이블을 만들과 데이터를 저장하는데 commit을 하면 데이터가 사라지게 하세요.
create global temporary table emp37
    (empno number(10),
     ename varchar2(10),
     sal number(10))
     on commit delete rows;
     
insert into emp37 values(1111, 'SCOTT', 3000);
insert into emp37 values(2222, 'SMITH', 4000);
select * from emp37;
commit;

select * from emp37;

// 문제 94. 세션을 종료하면 데이터가 사라지는 임시테이블을 생성하세요.
//         (테이블명 : emp94, 컬럼명 : empno, ename, sal)
create global temporary table emp94
    (empno number(10),
     ename varchar2(10),
     sal number(10))
     on commit preserve rows;

insert into emp94 values(1111, 'SCOTT', 3000);
insert into emp94 values(2222, 'SMITH', 4000);
select * from emp94;
commit;

select * from emp94;
