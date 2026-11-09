#1
select l.titulo as 'Titulo', e.nombre as 'Nombre de editorial'
from libro l
inner join editorial e
on e.CIF = l.CIF
order by l.titulo asc;

#2
select a.nombre as 'Nombre', count(e.ISBN) as 'Libros escritos'
from autor a
inner join escribe e
on e.codAutor = a.codAutor
group by a.nombre
order by sum(e.ISBN) desc;

#3
select nombre
from socio
where DNI in (select DNI
				from prestamo
                where fechadevolucion is null);
                
#4
select e.nombre 'Nombre', avg(l.anioPublicacion) as 'Año medio'
from editorial e
inner join libro l
on e.CIF = l.CIF
group by e.CIF, e.nombre
having count(l.ISBN) > 2;

#5
insert into prestamo (DNI, ISBN, numEjemplar, fechaPrestamo, fechaDevolucion)
values ('11111111A',
		(select ISBN
        from libro
        where titulo = 'Cien años de soledad'),
        2,
        '2026-10-29',
        null
);

#6
update ejemplar
set estado = 'Deteriorado'
where ISBN in (select ISBN
					from libro
                    where titulo = 'Cien años de soledad');

#7
delete from prestamo
where ISBN in (select ISBN
				from libro
                where CIF in (select CIF
								from editorial
                                where nombre = 'Planeta'));

#Consultas extra
#8
select l.titulo as 'Título del libro', a.nombre as 'Nombre del autor'
from libro l
inner join escribe e
on e.ISBN = l.ISBN
inner join autor a
on a.codAutor = e.codAutor
order by l.titulo asc;

#9
select titulo as 'Libro que nunca se han prestado'
from libro
where ISBN in (select ISBN
				from ejemplar
                where (ISBN, numEjemplar) not in (select ISBN, numEjemplar
													from prestamo));

#10
select s.nombre as 'Socios', count(p.DNI) as 'Número de préstamos realizados'
from socio s
left join prestamo p
on s.DNI = p.DNI
group by s.nombre, s.nombre;

#11
select titulo
from libro
where titulo like 'La%'
order by titulo asc;

#12
select count(ISBN) as 'Número de ejemplares', estado as 'Estado'
from ejemplar
group by estado
order by count(ISBN) desc;

#13
select titulo as 'Título', anioPublicacion as 'Año de publación'
from libro
order by anioPublicacion asc
limit 1;

#14
select s.nombre as 'Nombre del socio', l.titulo as 'Título del libro', p.fechaPrestamo as 'Fecha de préstamo'
from socio s
inner join prestamo p
on s.DNI = p.DNI
inner join ejemplar e
on e.ISBN = p.ISBN and e.numEjemplar = p.numEjemplar
inner join libro l
on e.ISBN = l.ISBN
order by p.fechaPrestamo asc;

#15
select a.nombre as 'Nombre', count(l.ISBN) as 'Cantidad de libros escritos'
from autor a
inner join escribe e
on e.codAutor = a.codAutor
inner join libro l
on l.ISBN = e.ISBN
group by a.nombre;

#16
select titulo as 'Libros que no son novelas ni ensayos'
from libro
where ISBN not in (select ISBN from novela) and ISBN not in (select ISBN from ensayo);

#17
select l.titulo as 'Título de la novela', n.genero as 'Genero'
from libro l
inner join novela n
on n.ISBN = l.ISBN
order by titulo asc;

#18
