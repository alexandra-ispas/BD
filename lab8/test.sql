/*

    pt fiecare angajat care nu face parte din dept angajatului
    cu cel mai mic salariu
    si nu s-a angajat in luna februarie
    selectatt: numele, den depart, data angajarii,si numele sefului

*/

select a.ename, b.dname, a.hiredate, sef.ename
from emp a join dept b on a.deptno = b.deptno, emp sef
WHERE
    a.deptno != (select c.deptno 
                from emp c
                WHERE   
                    c.sal = (select min(sal) from emp)) and
    extract (month FROM a.hiredate) != 2 and
    sef.empno = a.mgr;