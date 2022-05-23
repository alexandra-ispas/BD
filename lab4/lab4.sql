-- C:\Users\Alexandra\Desktop\3sem2\BD\lab4.sql

select ename, sal
from emp
where
    sal > 1000
    and
        hiredate >= to_date('01-01-1981', 'DD-MM-YYYY') 
        and hiredate <= to_date('31-12-1981', 'dd-mm-yyyy');


-- sau
-- folosind between
select ename, sal
from emp
where
    sal > 1000
    and
        hiredate between to_date('01-01-1981', 'DD-MM-YYYY') 
            and to_date('31-12-1981', 'dd-mm-yyyy');


-- sau
-- pt a sorta data scrisa in string, trebuie sa fie formatata yyyymmdd

select ename, sal
from emp
where
    sal > 1000
    and
        to_char(hiredate,'yyyymmdd') 
            between '19810101' 
                and '19811231';



-- sau iau doar anul

select ename, sal
from emp
where
    sal > 1000
    and
        to_char(hiredate,'yyyy')  = '1981';

-- toti angajatii care au venit (sal + comision) > 1000
-- nvl(x, y) = x, x!= null
            -- y, x == null


select ename, sal+nvl(comm, 0) venit
from emp
    where
        sal+nvl(comm, 0)>1000;

create table venituri as
select ename, sal+nvl(comm, 0) venit
from emp
    where
        nvl(comm, 0) = 0; 
        -- is not null

drop table venituri;

-- toti ang care au comision, afisant numele, sal, comm
create table ang_com as
select ename, sal, comm
    from emp
    where
        nvl(comm, 0) != 0;

drop table ang_com;

-- toti ang al carui nume incepe cu 'a'
select ename 
from emp
    where
        ename like 'A%';

-- 2 litere inaintea lui a
select ename 
from emp
    where
        ename like '__a%';

-- identitate clara
select ename 
from emp
    where
        ename like 'ALLEN';
        




