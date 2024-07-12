--------------------------------------------------------------------------------------------
// 22 데이터 품질 높이기2


--------------------------------------------------------------------------------------------
// not null : null이 들어가지 못하게 함.
// 예제 106. 사원이름에 null값이 들어가지 못하게 하세요.
create table dept6
    (deptno number(10),
     dname varchar2(14),
     loc varchar2(10) constraint dept5_loc_nn not null);
     
insert into dept6(deptno, dname) values (50, 'TRANSFER');
//  에러 발생, 컬럼에 지정하여 값을 쓰지 않는 경우에 NULL값 삽입을 명령하는 것과 같음.

// 문제 106-1. 사원 테이블에 사원 이름에 null 값이 몇개 존재하는지 검색하세요.
select count(*)
    from emp
    where ename = null;

// 문제 106-2. 사원 테이블에 사원이름에 not null 제약을 거세요.
alter table emp
    modify ename constraint emp_ename_nn not null;

// 문제 106-3. 부서 테이블에 부서번호에 not null 제약을 거세요.
alter table dept
    modify deptno constraint dept_deptno_nn not null;


--------------------------------------------------------------------------------------------
// check : 컬럼에 제약조건 주는 방법.
// 예제 107. 월급 컬럼에 9000보다 큰 월급은 입력되지 못하게 하세요.
create table emp6
    (empno number(10),
     ename varchar2(20),
     sal number(10) constraint emp6_sal_ck check (sal between 0 and 6000));
     // between은 등호를 포함함.

insert into emp6 values(7839, 'KING', 5000);
insert into emp6 values(7698, 'BLAKE', 2850);
commit;

select * from emp6;
update emp6 set sal = 9000 where ename = 'KING';
// 체크 제약조건이 위배됨.

// 예제 107-1. 체크 제약족건을 제거하세요.
alter table emp6
    drop constraint emp6_sal_ck;
    
// 예제 107-2. 만들어진 테이블에 체크제약 걸기
//             사원 테이블에 월급에 체크제약을 거는데 월급이 0~9000 사이의 데이터만 입력되게 하세요.
alter table emp
    add constraint emp_sal_ck check(sal between 0 and 9000);

insert into emp(empno, ename, sal) values(1111, 'smith', 9500);
// 체크 제약조건 위배

// 문제 107-1. 사원 테이블의 부서번호에 부서번호가 10번, 20번, 30번만 입력, 수정되게 체크제약을 거세요.
alter table emp
    add constraint emp_deptno_ck check(deptno in (10, 20, 30));

insert into emp(empno, ename, sal) values(1111, 'smith', 9500);
// 체크 제약조건 위배

// 문제 107-2. 부서테이블의 부서위치에 NEW YORK, DALLAS, CHICAGO, BOSTON만 입력, 수정되게 체크제약을 거세요.
alter table dept
    add constraint dept_loc_ck check(loc in ('NEW YORK', 'DALLAS', 'CHICAGO', 'BOSTON'));
    
// 문제 107-3. 사원 테이블에 이메일 컬럼을 다음과 같이 추가하고 이메일에 @가 있어야 데이터가 입력 또는 수정되게 체크제약을 거세요.
alter table emp
    add email varchar2(50);

alter table emp
    add constraint emp_email_ck check(email like '%@%');


--------------------------------------------------------------------------------------------
// foreign key : primary key를 참조하여, 그외의 데이터는 입력되지 못하게 하는 제약.
// primary key는 foreign key에 참조되기 때문에, 단독으로 삭제가 불가능함.
// 따라서 foreign key를 먼저 삭제한 뒤 삭제하거나, cascade 옵션을 통해 모든 키를 삭제하는 방법을 사용해야 함.
// 예제108.
create table dept7
    (deptno number(10) constraint dept7_deptno_pk primary key,
     dname varchar2(14),
     loc varchar2(10));
     
create table emp7
    (empno number(10),
     ename varchar2(20),
     sal number(10),
     deptno number(10) constraint emp7_deptno_fk references dept7(deptno));

insert into dept7
    select deptno, dname, loc
    from dept;
    
insert into emp7
    select empno, ename, sal, deptno
    from emp;
    
insert into emp7 values(1111, 'jack', 3000, 80);
// 무결성 제약조건 위배 - 부모 키가 없음.

alter table dept7
    drop constraint dept7_deptno_pk;
    // 오류발생 - 고유/기본 키가 외부 키에 의해 참조됨.

alter table dept7
    drop constraint dept7_deptno_pk cascade;
    // 모든 키 삭제.

select a.constraint_name, a.constraint_type, b.column_name
    from user_constraints a, user_cons_columns b
    where a.table_name in ('DEPT7', 'EMP7') 
          and a.constraint_name = b.constraint_name;
    // 키 삭제 확인.
    
// 문제 108-1. 사원 테이블의 empno에 primary key를 거세요.
alter table emp
    add constraint emp_empno_pk primary key(empno);

// 문제 108-2. 사원 테이블에 관리자 번호에 foreign key 제약을 걸고 사원 테이블에 사원번호에 있는 컬럼을
//             참조하게 하여, 관리자 번호가 사원 테이블에 있는 사원번호에 해당하는 사원들만 관리자 번호로 입력 또는 수정될 수 있도록 하세요.
alter table emp
    add constraint emp_mgr_fk foreign key(mgr) references emp(empno);


--------------------------------------------------------------------------------------------
// with ~ as : 검색이 오래걸리는 대용량 데이터 베이스에서, 쿼리문이 반복되는 경우(같은 쿼리문이 서브쿼리에서 사용되는 경우 등),
//             를 해소하기 위해 사용하는 방식. 따라서 튜닝을 통한 성능 향상에 도움됨.
// 예시

//1) 아래의 쿼리는 20분이 걸리는 쿼리임
select job, sum(sal) as 토탈
    from emp
    group by job;
    
//2) 해당 쿼리는 1)와 비슷한 쿼리가 서브쿼리에도 존재하기 때문에 총 40분이 걸리게 됨.
select job, sum(sal) as 토탈
    from emp
    group by job
    having sum(sal) > (select job, sum(sal) as 토탈
                        from emp
                        group by job);
                        
                        
//3) with ~ as 절을 사용한 쿼리는 1)과 같은 쿼리를 20분을 소요하여 임시테이블을 만듦
with job_sumsal as (select job, sum(sal) as 토탈
                  from emp
                  group by job);
                
//4) 2)와 같은 결과를 나타내는 해당 쿼리는, with ~ as절을 이용하여 생성된 임시테이블을 사용하기 때문에,
//   2)보다 훨씬 적은 소요시간을 소비하게 됨.
select job, 토탈
    from job_sumsal
    where 토탈 > (select avg(토탈)
                 from job_sumsal);

// 3), 4)는 함께 실행해야 됨.                
with job_sumsal as (select job, sum(sal) as 토탈
                  from emp
                  group by job)
select job, 토탈
    from job_sumsal
    where 토탈 > (select avg(토탈)
                 from job_sumsal);
                 
/ 문제 109-1. 부서번호별 토탈월급을 출력하는데 부서번호별 토탈월급의 평균값보다 더 큰 것만 출력하세요.
with dept_sumsal as (select deptno, sum(sal) as total
                     from emp
                     group by deptno)
select deptno, total
    from dept_sumsal
    where total > (select avg(total)
                    from dept_sumsal);

// 같은 결과 출력
select deptno, sum(sal)
    from emp
    group by deptno
    having sum(sal) > (select avg(sum(sal))
                        from emp
                        group by deptno);
                        
// 문제 109-2. 부서위치, 부서위치별 토탈월급을 출력하는데 부서위치별 토탈월급의 평귭값보다 더 큰 것만 출력하세요.
with loc_sal as (select d.loc as loc,sum(e.sal) as total_salary
                  from emp e join dept d
                  on (e.deptno=d.deptno)
                  group by d.loc)
select loc,total_salary
    from loc_sal
    where total_salary > (select avg(total_salary)
                           from loc_sal);
                           

--------------------------------------------------------------------------------------------
// with ~ as절2 => subquery factoring 
// 예제 110.
with job_sumsal as (select job, sum(sal) 토탈
                     from emp
                     group by job),
     deptno_sumsal as (select deptno, sum(sal) 토탈
                       from emp
                       group by deptno
                       having sum(sal) > (select avg(토탈) + 3000
                                           from job_sumsal))
select deptno, 토탈
    from deptno_sumsal;
    
// 문제 110. 입사한 년도와 입사한 년도별 토탈월급을 출력하는데 부서번호별 토탈월급들의 평균값보다 더 큰 것만 출력하세요.
with deptno_total as (select deptno, sum(sal) total
                     from emp
                     group by deptno),
     hiredate_total as (select to_char(hiredate, 'RRRR') as 입사년도, sum(sal) as total
                         from emp
                         group by to_char(hiredate, 'RRRR')
                         having sum(sal) > (select avg(total)
                                             from deptno_total))
select 입사년도, total
    from hiredate_total;
    
