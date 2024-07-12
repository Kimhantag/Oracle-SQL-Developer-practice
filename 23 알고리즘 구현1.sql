--------------------------------------------------------------------------------------------
// 23 �˰��� ����1


--------------------------------------------------------------------------------------------
// ���� 111. sql�� 1���� 10���� ����ϰ� ������ 2�� ����ϱ�.
select level as num
    from dual
    connect by level <= 10;
    
with loop_table as (select level as num
                     from dual
                     connect by level <= 10)
select '2'||'x'||num||'='|| 2*num as "2��"
    from loop_table;

// ���� 111-1. 1���� 100������ ���� ���ΰ���?
select sum(level)
    from dual
    connect by level <= 100;
    
// ���� 111-2. 1���� 100���� �տ��� ���� 55�� ������ ���� ���ΰ���?
select sum(level)
    from dual
    where level != 55
    connect by level <= 100;


// ���� 111-3. 1���� 100���� ¦���� ���� ���ΰ���?
select sum(level)
    from dual
    where mod(level,2) = 0
    connect by level <= 100;
    

--------------------------------------------------------------------------------------------
// ���� 112. ������ ��ü�� sql�� ����ϼ���.
with loop_table as (select level+1 as num
                     from dual 
                     connect by level <= 8),
     gugu_table as (select level as gugu
                     from dual
                     connect by level <= 9 )
select to_char(a.num)||'x'||to_char(b.gugu)||'='||to_char(b.gugu*a.num) as ������
    from loop_table a, gugu_table b;
    // where�� ���� ���εǾ��� ������ ���� ���ε�.
    
// ���� 112-1. ���� ������� 2, 5, 7�ܸ� ����ϼ���.
with loop_table as (select level as num
                     from dual 
                     connect by level <= 9),
     gugu_table as (select level  as gugu
                     from dual
                     connect by level <= 9 )
select to_char(a.num)||'x'||to_char(b.gugu)||'='||to_char(b.gugu*a.num) as ������
    from loop_table a, gugu_table b
    where a.num in (2, 5, 7);
    
// ���� 112-2. ������ ��ü���� ¦���ܸ� ����ϼ���.
with loop_table as (select level as num
                     from dual 
                     connect by level <= 9),
     gugu_table as (select level  as gugu
                     from dual
                     connect by level <= 9 )
select to_char(a.num)||'x'||to_char(b.gugu)||'='||to_char(b.gugu*a.num) as ������
    from loop_table a, gugu_table b
    where mod(a.num, 2) = 0;
    
    
--------------------------------------------------------------------------------------------
// ���� 113. ���� �ﰢ���� SQL�� ����ϼ���.
with loop_table as (select level as num
                     from dual
                     connect by level <= 8)
select lpad('��', num, '��') as �����ﰢ��
    from loop_table;
    // lpad('��', N, '��'): N��° �ڸ��� ���� �ְ� ���ʺκ��� �ڸ���(N-1, N-2, ... 1)�� ���� ä��

// ���� 113-1. �������� ���� �ﰢ���� ����ϼ���.
with loop_table as (select 9-level as num
                     from dual
                     connect by level <= 8)
select lpad('��', num, '��') as �������ﰢ��
    from loop_table;
    
// ���� 113-2. ����113, ����113-1�� ���Ʒ��� ������ ������ ����ϼ���.
with loop_table as (select level as num
                     from dual
                     connect by level <= 8)
select lpad('��', num, '��') as star
    from loop_table
union all
select lpad('��', 9-num, '��') as star 
    from loop_table;
    
    
--------------------------------------------------------------------------------------------
// ����114. �ﰢ���� SQL�� ����ϼ���.
with loop_table as (select level as num
                     from dual
                     connect by level <= 8)
select lpad(' ', 10-num, ' ') || lpad('��', num, '��') as triangle
    from loop_table;
    
// ����114. ���ﰢ���� SQL�� ����ϼ���.
with loop_table as (select level as num
                     from dual
                     connect by level <= 8)
select  lpad(' ', num, ' ')  || lpad('��', 9-num, '��')  as triangle
    from loop_table;
    // ||�� �������� ������ ������ ���� ���̰� �߻��Կ� ����.