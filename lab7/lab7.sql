--decode
--case

-- decode(expresie, val1, rez1, val2, rez2, rezd)

/* aia cu venitul anual*/

select ename, 12 * (sal + nvl(comm, 0)) venit_anual, 
    decode(sign(12 * (sal + nvl(comm, 0)) - 20000), -1, 'BUN', 'FOARTE BUN')
    from emp;



select ename, 12 * (sal + nvl(comm, 0)) venit_anual, 
    decode(sign(12 * (sal + nvl(comm, 0)) - 20000), -1, 'BUN', 
        decode(sign(12 * (sal + nvl(comm, 0)) - 25000), -1, 'FOARTE BUN', 'EXCELENT'))
    from emp;



/*
case espresie
when val1 then rez1
when val2 then rez2
....
else rezd
end
*/

/*
sa se selecteze pt fiecare angajat numele, job-ul si o traducere in limba romana a job ului
*/
select ename, job, 
    case job 
    WHEN 'CLERK' then 'FUNCTIONAR'
    when 'MANAGER' then 'manager'
    when 'ANALYST' THEN 'analist'
    when 'SALESMAN' then 'vanzator'
    when 'PRESIDENT' then 'presedinte'
    end traducere
    from emp;


/*
case
    when expr1 then rez1
    when expr2 then rez2
    --------------------
    else 
    end

*/
select ename, 12 * (sal + nvl(comm, 0)) venit_anual, 
    case 
        when (12 * (sal + nvl(comm, 0)) - 20000 < 0) then 'bun'
        when (12 * (sal + nvl(comm, 0)) - 25000 < 0) then 'foarte bun'
        else 'excelent' end
    from emp;


/*
sa se afiseze pt toti ang ce primesc comision si au gr sal> 1:
numele, comision, gradul salarial, venitul si calificativul pt venit

calif = 
<=2500 -> bun
> 2500 -> foarte bun

*/
select a.ename, a.comm,
    b.grade, a.sal + nvl(a.comm, 0) venit,
    case 
        when (sal + nvl(comm, 0) <= 2500) then 'bun'
        else 'foarte bun' end calificativ
    from emp a, salgrade b
    where 
        a.sal >= b.losal and a.sal <= b.hisal;



select count(*) from emp;

/*
numaram pt fiecare dep cati angajati sunt
slect <functii de grup> -> in group by punem campurile alea ca altfel nu avem acces
-- sau count(<coloana>)
*/

select d.dname, count(*) , d.loc
from dept d join emp a on a.deptno = d.deptno
where a.sal >= 1000
group by d.dname, d.loc
having count(*) > 3;

/*
sa se efectueze o lista de premiere a angajatilor asftle
ang care au primit comision, primesc o prima = sal mediu pe companie
ang care nu au primit com -> prim = sal minim pe companie
presedintele si directorii (manager) nu primsc prima
*/

select a.ename, a.sal, a.job, min(c.sal), avg(c.sal),
    case 
      when a.job in ('PRESIDENT', 'MANAGER') then 0
      when nvl(a.comm, 0) = 0 then  min(c.sal)
      else avg(c.sal)
    end prima
    from emp a, emp c
    group by a.ename, a.sal, a.job, a.comm;


