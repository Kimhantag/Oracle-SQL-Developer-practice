--------------------------------------------------------------------------------------------
// 25 알고리즘 구현3


--------------------------------------------------------------------------------------------
// 예제 121. 16, 24의 최대 공약수를 구하세요.
with num_d as (select 16 as num1, 24 as num2
                from dual)
select max(level) 최대공약수
    from num_d
    where mod(num1, level) = 0
          and mod(num2, level)= 0
    connect by level <= num2;
    
// 문제 121. 16, 24, 48의 최대공약수를 구하세요.
select max(level) 최대공약수
    from dual
    where mod(16, level) = 0
          and mod(24, level)= 0
          and mod(48, level)= 0
    connect by level <= 48;
    
    
--------------------------------------------------------------------------------------------
// 예제 122. 16과 24의 최소공배수를 구하세요.
select 16/max(level) * 24/max(level) * max(level) 최소공배수
    from dual
    where mod(16, level) = 0
          and mod(24, level)= 0
    connect by level <= 24;
    
// 문제 122. 16, 24, 56의 최소공배수를 구하세요.
select 16/max(level) * 24/max(level) * 56/max(level) * max(level) 최소공배수
    from dual
    where mod(16, level) = 0
          and mod(24, level)= 0
          and mod(56, level)= 0
    connect by level <= 56;
    

--------------------------------------------------------------------------------------------
// 예제 123. 피타고라스의 정리를 통해 직각 삼각형 여부를 판단하세요.
accept a prompt '밑변의 길이를 입력하세요. :'
accept b prompt '높이의 길이를 입력하세요. :'
accept c prompt '빗변의 길이를 입력하세요. :'

select case when (power(&a, 2) + power(&b,2)) = power(&c,2)
            then '직각 삼각형이 맞습니다.'
            else '직각 삼각형이 아닙니다.' end as "피타고라스의 정리"
    from dual;
    
// 문제 123. 빗변 두개와 밑변을 각각 물어보게 하고, 정삼각형이 맞는지에 대한 여부를 출력하세요.
accept a prompt '빗변1의 길이를 입력하세요. :'
accept b prompt '빗변2의 길이를 입력하세요. :'
accept c prompt '밑변의 길이를 입력하세요. :'

select case when &a = &b 
             and &b = &c
            then '정삼각형이 맞습니다.'
            else '정삼각형이 아닙니다.' end as "정삼각형 판단"
    from dual;
    

--------------------------------------------------------------------------------------------
// 예제 124. 몬테카를로 알고리즘으로 원주율을 알아내세요.
select sum(case when (power(num1,2) + power(num2, 2)) <= 1 then 1
                 else 0 end) / 1000000 * 4 as "원주율"
    from (
          select dbms_random.value(0,1) as num1,
                 dbms_random.value(0,1) as num2
            from dual
            connect by level < 1000000
         );
         

--------------------------------------------------------------------------------------------
// 예제 125.  자연상수 e의 값을 알아내세요.
select power(1+1/100000000, 100000000)
    from dual;
    