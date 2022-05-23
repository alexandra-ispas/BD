select ename, sal
from emp a, dept d
where
    a.deptno = d.deptno -- conditia de join ('n' tabele in clauza from -> n-1 conditii de join)
    and
    d.loc='CHICAGO';

-------------sau
select a.ename, a.sal
from emp a join dept d on
    a.deptno = d.deptno 
where
    d.loc='CHICAGO';


--------------sau (pt ca se numeste la fel coloana si in emp si in dept)
select a.ename, a.sal
from emp a join dept d 
using (deptno)
where loc = 'CHICAGO';

------------ sau    ASA NU!!
select a.ename, a.sal
from emp a natural join dept d --face egelitate intre coloanele cu acceasi denumire din tabele
where loc = 'CHICAGO';


--sa se selecteze toti angajatii care nu fac parte din dep SALES si care au venit in firma inainte de 1-DEC-81
-- prin toate cele 4 metodele
select a.ename, a.sal, d.dname, a.hiredate
from emp a, dept d
where 
    a.deptno = d.deptno and
    hiredate < '1-DEC-81' and
    d.dname != 'SALES';


select a.ename, a.sal, d.dname, a.hiredate
from emp a join dept d on
    a.deptno = d.deptno 
    where 
        hiredate < '1-DEC-81' and
        d.dname != 'SALES';

select a.ename, a.sal, d.dname, a.hiredate
from emp a join dept d 
using (deptno)
where 
    hiredate < '1-DEC-81' and
    d.dname != 'SALES';

select a.ename, a.sal, d.dname, a.hiredate
from emp a natural join dept d --face egalitate intre coloanele cu aceeasi denumire din tabele
where hiredate < '1-DEC-81' and
    d.dname != 'SALES';


-- angajatii care au salariu mai mare decat seful lor
select a.ename, a.sal, s.ename, s.sal
from emp a, emp s
where a.mgr = s.empno and
    a.sal > s.sal;

select a.ename, a.sal, s.ename, s.sal
from emp a join emp s on
    a.mgr = s.empno
    where
        a.sal > s.sal;

-- vreau sa afisez si presedintele
select a.ename, a.sal, s.ename, s.sal, k.ename
from emp a, emp s, emp k
where a.mgr = s.empno 
    and k.mgr is null and
    a.sal > s.sal;

select a.ename, a.sal, s.ename, s.sal, k.ename
from emp a join emp s on
    a.mgr = s.empno, emp k
    where
        k.mgr is null and
        a.sal > s.sal;

-- non equi join

-- select a.ename, a.sal, s.grade
-- from emp a, salgrade s
--     where 
--         a.sal >= s.losal and a.sal <= s.hisal;


select a.ename, a.sal, s.grade
from emp a, salgrade s
    where 
        a.sal between s.losal and s.hisal;
        

select a.ename, a.sal, s.grade
from emp a join salgrade s on
    a.sal between s.losal and s.hisal;

--- join orizontal
-- toti angajatii care nu fac parte din SALES
select a.ename, a.sal
from emp a natural join dept b
where
    b.dname not like 'SALES'
UNION
    select c.ename, c.sal
    from emp c
    where
        c.sal > 2000
    order by 2;


