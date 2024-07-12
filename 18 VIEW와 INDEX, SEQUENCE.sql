-----------------------------------------------------------------------------------------
// 18 VIEW와 INDEX, SEQUENCE


-----------------------------------------------------------------------------------------
// view : 테이블에서 일부 데이터만 볼 수 있도록 만드는 테이블
//       V 1) 보안상의 이유로 시용
//         2) 복잡한 쿼리문을 간단하게 검색하기 위해 사용
// view에서 데이터를 업데이트하면, 원본 테이블도 업데이트 됨.
// 예제 95. 사원 테이블에서 직업이 SALESMAN인 사원들의 사원번호, 사원이름, 직업, 관리자번호, 부서번호만
//          바라볼 수 있는 view를 만드세요.
create view emp_view
    as 
    select empno, ename, sal, job, deptno
    from emp
    where job = 'SALESMAN';
select * from emp_view;

// 문제 95. 사원 테이블에서 부서번호가 20번인 사원들의 사원번호와 사원이름, 직업, 월급을 볼 수 있는 뷰를 생성하세요.
create view emp_view2
    as
    select empno, ename, job, sal
    from emp
    where deptno = 20;
select * from emp_view2;
drop view emp_view2;  
    
-----------------------------------------------------------------------------------------
// view : 테이블에서 일부 데이터만 볼 수 있도록 만드는 테이블
//         1) 보안상의 이유로 시용
//       V 2) 복잡한 쿼리문을 간단하게 검색하기 위해 사용    
create view emp_view2
    as
    select deptno, round(avg(sal)) as avgsal
    from emp
    group by deptno;
    // view 생성할 때, 꼭 컬럼 alias를 지정해야 됨.
    select * from emp_view2;
    
// 문제 96. 직업, 직업별 토탈월급을 출력하는 view를 emp_view96으로 생성하세요.
create view emp_view96
    as
    select job, sum(sal) as 직업별월급총계
    from emp
    group by job;
select * from emp_view96;


-----------------------------------------------------------------------------------------
// index : 검색속도를 높이는 데이터베이스 객체
//         대용량의 데이터에서 작성된 쿼리 실행에 속도저하방지(full table scan 방지)
// 객체 : 테이블, 뷰, 인덱스
// 예제 97. 월급이 3000인 사원의 이름과 월급을 인덱스를 통해서 빠르게 검색하세요.
explain plan for
select ename, sal
    from emp
    where sal = 3000;
select * from table(dbms_xplan.display);

create index emp_sal
    on emp(sal);
    // sal을 index로 생성
    
explain plan for
select ename, sal
    from emp
    where sal = 3000;
select * from table(dbms_xplan.display);

select rowid, empno, ename
    from emp;
    // rowid : 행의 주소, file번호 + 블럭번호 + row번호 로 구성됨.
    
// 문제 97. 사원테이블에 직업의 인덱스를 생성하세요.
create index emp_job
    on emp(job);
    
explain plan for
    select ename, job
    from emp
    where job = 'SALESMAN';
select * from table(dbms_xplan.display);


-----------------------------------------------------------------------------------------
// sequence : 중복되지 않는 유일값들을 생성
// create sequence 시퀀스명
// 예제 98. 사원번호에 입력할 때, 데이터가 중복되지 않고 순서대로 입력되게 하세요.
create sequence seql;

select seql.nextval
    from dual;
    
create sequence seq2
    start with 1
    maxvalue 100
    increment by 1
    nocycle;
    // start with n : n부터 시작
    // maxvalue N : 최대 N까지 생성
    // increment by k : k씩 증가
    // nocycle : n부터 N까지 생성 후에 다시 n부터 시작하는 반복을 취소함. 생략시 반복 시행
    
create table emp500
    (empno number(10),
     ename varchar2(10) );
select * from emp500;

insert into emp500
    values(seq2.nextval, 'SMITH');
select * from emp500;

// 문제 98. dept테이블에 부서번호를 50번부터 입력하고 10씩 증가되는 시퀀스를 생성하세요.(시퀀스 이름:dept_seq1)
create sequence dept_seq1
    start with 50
    increment by 10;
 
insert into dept(deptno, dname, loc)
    values(dept_seq1.nextval, 'CHOICE', 'SEOUL');
select * from dept;

rollback;