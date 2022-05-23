create table strada
(
id_strada number(4),
denumire varchar2(30),
nr_imobile number(3),
-- primary key pe coloana id_strada
constraint pk_strada primary key (id_strada) 
);

desc strada

create table imobil
(
id_imobil number(5) primary key,
denumire varchar2(10),
id_strad number(4),
numar number(4),
data_constructie date,
-- foreign key pe coloana id_strad, preluata din table strada, coloana id_strada
constraint fk_imobil_strada foreign key (id_strad) references strada (id_strada)
);

desc imobil

-- recomandat
insert into strada(id_strada, denumire, nr_imobile)
values(1,'strada nr 1', 20);

-- nerecomandat
insert into strada
values(2,'strada nr 2', 15);

-- omitere o coloana
insert into strada(id_strada, denumire)
values(3,'strada nr 3');

-- afisare toate coloanele
select * from strada;

-- afisare o coloana / mai multe coloane
select denumire, nr_imobile from strada; 

insert into imobil
values( 1, 'imobil1', 2, 15, to_date('09-03-2022','DD-MM_YYYY')); 

select * from imobil;

drop table imobil;
drop table strada;

/*
to_date -> transformare string in date
*/