-- @C:\Users\Alexandra\Desktop\3sem2\BD\lab6\test.sql

/*

toti angajatii
din departamentele cu numele diferit de o val citita de la tastatura
ang care contin in numele lor litera C, si care nu primesc comision

afisare: sal, comision in val rotunjite la zeci + ename, dname

 in 2 moduri cu cel putin 2 dif
*/

select a.ename, d.dname, round(a.sal, -1) "salariu", round(nvl(a.comm, 0), -1) comision
from emp a, dept d
WHERE
    a.deptno=d.deptno and
    d.dname != '&&dep' and 
    a.ename like '%C%' and
    nvl(a.comm,0)=0;


select a.ename, d.dname, trunc(a.sal, -1) "salariu", trunc(nvl(a.comm, 0), -1) comision
from emp a join dept d using (deptno)
WHERE
    d.dname != '&&dep' and 
    a.ename like '%C%' and
    (a.comm=0 or a.comm is null);

undefine dep;