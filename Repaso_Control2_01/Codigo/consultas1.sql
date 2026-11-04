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