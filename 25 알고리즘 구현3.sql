--------------------------------------------------------------------------------------------
// 25 �˰��� ����3


--------------------------------------------------------------------------------------------
// ���� 121. 16, 24�� �ִ� ������� ���ϼ���.
with num_d as (select 16 as num1, 24 as num2
                from dual)
select max(level) �ִ�����
    from num_d
    where mod(num1, level) = 0
          and mod(num2, level)= 0
    connect by level <= num2;
    
// ���� 121. 16, 24, 48�� �ִ������� ���ϼ���.
select max(level) �ִ�����
    from dual
    where mod(16, level) = 0
          and mod(24, level)= 0
          and mod(48, level)= 0
    connect by level <= 48;
    
    
--------------------------------------------------------------------------------------------
// ���� 122. 16�� 24�� �ּҰ������ ���ϼ���.
select 16/max(level) * 24/max(level) * max(level) �ּҰ����
    from dual
    where mod(16, level) = 0
          and mod(24, level)= 0
    connect by level <= 24;
    
// ���� 122. 16, 24, 56�� �ּҰ������ ���ϼ���.
select 16/max(level) * 24/max(level) * 56/max(level) * max(level) �ּҰ����
    from dual
    where mod(16, level) = 0
          and mod(24, level)= 0
          and mod(56, level)= 0
    connect by level <= 56;
    

--------------------------------------------------------------------------------------------
// ���� 123. ��Ÿ����� ������ ���� ���� �ﰢ�� ���θ� �Ǵ��ϼ���.
accept a prompt '�غ��� ���̸� �Է��ϼ���. :'
accept b prompt '������ ���̸� �Է��ϼ���. :'
accept c prompt '������ ���̸� �Է��ϼ���. :'

select case when (power(&a, 2) + power(&b,2)) = power(&c,2)
            then '���� �ﰢ���� �½��ϴ�.'
            else '���� �ﰢ���� �ƴմϴ�.' end as "��Ÿ����� ����"
    from dual;
    
// ���� 123. ���� �ΰ��� �غ��� ���� ����� �ϰ�, ���ﰢ���� �´����� ���� ���θ� ����ϼ���.
accept a prompt '����1�� ���̸� �Է��ϼ���. :'
accept b prompt '����2�� ���̸� �Է��ϼ���. :'
accept c prompt '�غ��� ���̸� �Է��ϼ���. :'

select case when &a = &b 
             and &b = &c
            then '���ﰢ���� �½��ϴ�.'
            else '���ﰢ���� �ƴմϴ�.' end as "���ﰢ�� �Ǵ�"
    from dual;
    

--------------------------------------------------------------------------------------------
// ���� 124. ����ī���� �˰������� �������� �˾Ƴ�����.
select sum(case when (power(num1,2) + power(num2, 2)) <= 1 then 1
                 else 0 end) / 1000000 * 4 as "������"
    from (
          select dbms_random.value(0,1) as num1,
                 dbms_random.value(0,1) as num2
            from dual
            connect by level < 1000000
         );
         

--------------------------------------------------------------------------------------------
// ���� 125.  �ڿ���� e�� ���� �˾Ƴ�����.
select power(1+1/100000000, 100000000)
    from dual;
    