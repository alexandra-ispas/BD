/*

sa se select care este seful diferit de BLAKE
care are cei mai multi subordonati

numele sefuluiu, nr de subord

*/

select a.ename sef, count(b.empno) subordonati
from emp a, emp b
where b.mgr = a.empno 
    and a.ename != 'BLAKE'
group by a.ename
having count(b.empno) = (select max(count(c.empno))
                    from emp c, emp d
                    where  c.mgr = d.empno and d.ename != 'BLAKE'
                    group by c.mgr);

