--sa se selecteze toti angajatii
--care fac parte dintr-un dep citit de la tastatura 
-- si nu il au sef pe BLAKE
-- nume, den depart si numele sefului
-- 3 metode

select a.ename, '&&dept_name' "departament", s.ename "sef"
from emp a, dept d, emp s
where 
    a.deptno = d.deptno and
    d.dname = '&dept_name' and
    a.mgr = s.empno and
    s.ename != 'BLAKE';

select a.ename, '&&dept_name' "departament", s.ename "sef"
from emp a join dept d on
    a.deptno = d.deptno, emp s 
    where
        d.dname = '&dept_name' and
        a.mgr = s.empno and
        s.ename not like 'BLAKE';

select a.ename, '&&dept_name' "departament", s.ename "sef"
from emp a join dept d using(deptno), emp s 
    where
        d.dname = '&dept_name' and
        a.mgr = s.empno and
        s.ename != '&sef';

undefine dept_name;