--------------------------------------------------------------------------------------------
// 24 알고리즘 구현2


--------------------------------------------------------------------------------------------
// 예제 115. sql로 마름모 출력하기.
select lpad(' ', 5-level, ' ') || lpad('★', level, '★') as star
    from dual
    connect by level < 6
union all
select lpad(' ', level, ' ') || lpad('★', 5-level, '★') as star
    from dual 
    connect by level < 6;
    
// 원하는 숫자로 바꿔서 출력하기
undefine p_num
accept p_num prompt '숫자입력 : '

select lpad(' ', &p_num-level, ' ') || lpad('★', level, '★') as star
    from dual
    connect by level < &p_num
union all
select lpad(' ', level, ' ') || lpad('★', &p_num-level, '★') as star
    from dual 
    connect by level < &p_num;
    
// 문제 115. sql로 모래시계 출력하기.
undefine p_num
accept p_num prompt '숫자입력 : '

select lpad(' ', level, ' ') || lpad('★', &p_num-level, '★') as star
    from dual 
    connect by level < &p_num
union all
select lpad(' ', &p_num-level, ' ') || lpad('★', level, '★') as star
    from dual
    connect by level < &p_num;


--------------------------------------------------------------------------------------------
// 예제 116. sql로 사각형 출력하기.
undefine p_n1
undefine p_n2
accept p_n1 prompt '가로숫자를 입력하세요 : ' ;
accept p_n2 prompt '세로숫자를 입력하세요 : ' ;

with loop_table as (select level as num
                     from dual
                     connect by level <= &p_n2)
select lpad('★', &p_n1, '★') as star
    from loop_table;
    
// 문제 116-1. 숫자를 한번만 물어보게하고, 정사각형이 출력되게 하세요.
undefine length
accept length prompt '길이를 입력하세요: ';

with loop_table as (select level as num
                     from dual
                     connect by level <= &length)
select lpad('★', &&length, '★') as star
    from loop_table;
    // &&: 같은 undefine문에 대해 한번만 물어보도록 함.
    

--------------------------------------------------------------------------------------------
// 예제 117. 1부터 10까지 합 출력하기
undefine hap
accept hap prompt '숫자를 입력하세요 : ';

select sum(level)
    from dual
    connect by level <= &hap;
    
// 문제 117-1. 1부터 100까지의 숫자 중에서 짝수의 합을 구하세요.
undefine hap
accept hap prompt '숫자를 입력하세요 : ';

select sum(level)
    from dual
    where mod(level, 2) = 0
    connect by level <= &hap;

// 문제 117-2. 1부터 100까지의 숫자 중에서 홀수의 합을 구하세요.
undefine hap
accept hap prompt '숫자를 입력하세요 : ';

select sum(level)
    from dual
    where mod(level, 2) = 1
    connect by level <= &hap;
    
    
--------------------------------------------------------------------------------------------
// 예제 118. 1부터 10까지 곱 출력하기
undefine gop
accept gop prompt '숫자를 입력하세요: '

select round(exp(sum(ln(level)))) 곱
    from dual
    connect by level <= &gop;
    
// 문제 118. 1부터 100까지의 짝수의 곱을 구하세요.
undefine gop
accept gop prompt '숫자를 입력하세요: '

select round(exp(sum(ln(level)))) 곱
    from dual
    where mod(level, 2) = 0
    connect by level <= &gop;
    

--------------------------------------------------------------------------------------------
// 예제 119. 1부터 10까지 가로로 짝수만 출력하세요.
define num
accept num prompt '숫자를 입력하세요: '

select listagg(level, ', ') as 숫자
    from dual
    where mod(level, 2) = 0
    connect by level <= &num;
    // within group은 상황에 따라 쓰지 않아도 됨.
    
// 문제 119. 1부터 10까지 가로로 홀수만 출력하세요.
define num
accept num prompt '숫자를 입력하세요: '

select listagg(level, ', ') as 숫자
    from dual
    where mod(level, 2) = 1
    connect by level <= &num;
    // within group은 상황에 따라 쓰지 않아도 됨.
    

--------------------------------------------------------------------------------------------
// 예제 120. 1부터 10까지 소수만 출력.
with loop_table as (select level as num
                     from dual
                     connect by level <= 10)
select L1.num as 소수1
    from loop_table L1, loop_table L2
    where mod(L1.num, L2.num) = 0
    group by L1.num
    having count(L1.num) = 2;
    
// 문제 120-1. 1부터 10까지 소수의 합을 구하세요.
select sum(소수)
    from(
    with loop_table as (select level as num
                         from dual
                         connect by level <= 10)
    select L1.num as 소수
        from loop_table L1, loop_table L2
        where mod(L1.num, L2.num) = 0
        group by L1.num
        having count(L1.num) = 2);

// 문제 120-2. 1부터 10까지 소수의 곱을 구하세요.

select round(exp(sum(ln(소수)))) 곱
    from(
    with loop_table as (select level as num
                         from dual
                         connect by level <= 10)
    select L1.num as 소수
        from loop_table L1, loop_table L2
        where mod(L1.num, L2.num) = 0
        group by L1.num
        having count(L1.num) = 2);