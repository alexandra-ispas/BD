/**
sa se acorde o prima pt fiecare sef care are cel putin 3 subalterni
afisandu-se numele, den departamentului din care face parte, prima
si nr subalterni

prima = 1/2 din salariu trunchiata la valori intregi
*/


select a.ename, d.dname, trunc(1 / 2 * a.sal) prima,
    count(*) nr_subalterni
from emp a join emp b on a.empno = b.mgr, dept d
where 
    a.deptno = d.deptno
    group by a.ename, d.dname, a.sal
    having count(*) >= 3;