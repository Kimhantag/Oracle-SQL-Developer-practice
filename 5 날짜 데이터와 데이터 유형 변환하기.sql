-------------------------------------------------------------------------------------------
// 5 날짜 데이터와 데이터 유형 변환하기 //

// months_between : 날짜 간 개월 수 출력하기, months_between(최신날짜, 과거날짜) //
// sysdate : 오늘 날짜 출력 //
// 문제 26. 내가 태어난 날부터 오늘까지 총 몇 달인지 출력하세요. //
select round(months_between(sysdate, '1999/08/29'))
    from dual;
    

// add_months : 개월 수 더한 날짜 출력하기, add_months(기준날짜, 더할 개월 수) //
// 문제 27. 오늘부터 100달 뒤의 날짜가 어떻게 되는지 출력하세요. //
select add_months(sysdate, 100)
    from dual;
    

// next_day : 특정날짜 뒤에 오는 요일의 날짜 출력하기, next_day(기준날짜, 앞으로 돌아올 요일) //
// 문제 28. 오늘부터 앞으로 돌아올 금요일의 날짜가 어떻게 되는지 출력하세요. //
select next_day(sysdate, '금요일')
    from dual;
    

// last_day : 특정 날짜가 있는 달의 마지막 날짜 출력하기 //
// 문제 29. 오늘부터 요번 달 말일까지 총 몇일 남았는지 출력하세요. //
select last_day(sysdate) - sysdate
    from dual;
    
select ename, hiredate, to_char(hiredate, 'RRRR'), to_char(hiredate, 'MON')
,to_char(hiredate, 'DD'), to_char(hiredate, 'DAY'), to_char(sal, '$9,999,999')
    from emp
    where ename='SCOTT';

//*******************************************************************************//
// to_char : 문자형으로 데이터 유형 변환하기 //
// 날짜형 => 문자형 //
// 숫자형 => 문자형 //
// to_char(날짜 컬럼명, 날짜 포멧//
// 날짜 포멧 => 년도 : RRRR, YYYY, RR, YY //
//              달 : MON, MM            //
//              일 : DD                 //
//             요일 : DAY, DY            //
//*******************************************************************************//


// 문제 30-1. 수요일에 입사한 사원들의 이름과 입사일과 입사한 요일을 출력하세요. //
select ename, hiredate, to_char(hiredate, 'DD')
    from emp
    where to_char(hiredate, 'DAY') = '수요일';

// 문제 30-2. 내가 태어날 생일의 요일을 출력하세요. //
select to_char(to_date('1999/08/29', 'RRRR/MM/DD'), 'DAY')
    from dual;
    
    
// nls_session_parameters : 현재 날짜의 세션형식 확인하기 //
select *
    from nls_session_parameters;
// to_date : 날짜형으로 데이터 유형 변환하기, 날짜의 형식과 관계없이 검색조건을 적용시키기 위해 사용 //
// 문제 31. 1981년도에 입사한 사원들의 이름과 입사일을 출력하는데 최근에 입사한 사원부터 출력하세요. //
select ename, hiredate
    from emp
    where to_char(to_date(hiredate, 'RRRR/MM/DD'), 'RRRR') = '1981'
    order by hiredate desc;
// 같은 표현식 //
select ename, hiredate
    from emp
    where hiredate between to_date('1981/01/01', 'RRRR/MM/DD')
                       and to_date('1981/12/31', 'RRRR/MM/DD')+1
    order by hiredate desc;
    
   
// 암시적 형 변환 이해하기 //
// 암시적 형변환 : Oracle DB에서 조건절의 데이터를 확인 후 자동으로 형 변환을 시행합니다. //
// 그러나 속도가 느려질 수 있으므로, 형태를 맞추는 것이 효율이 좋음 //
// 예시 - sal:숫자형, '3000':문자형 //
select ename, sal
    from emp
    where sal = '3000';
    
// Query 실행계획 : 질의문이 실행되는 순서와 정보를 출력 //
// explain plan for ~ from table(dbms_xplan.display) //
explain plan for
select ename, sal
    from emp
    where sal = '3000';
    
select * from table(dbms_xplan.display);

// 문제 32. 다음의 쿼리문은 실행이 될까요? //
// 실행은 되지만 sal 컬럼 전체를 문자형으로 변환하므로, 효율성이 좋다고 할 수 없다. //
// 따라서 처음부터 sal 컬럼을 문자형으로 작성하는 방법이 더 좋다고 할 수 있다. //
explain plan for 
select ename, sal
    from emp
    where sal like '30%';

select * from table(dbms_xplan.display);