#Prueba1 parte 2
create table reciclaje (
	id_reciclaje int, 
    fecha_reciclado date,
    centro_reciclaje varchar(45),
    estado varchar(45),
    id_ordenador int,
    id_componente int,
    primary key (id_reciclaje));
    
alter table reciclaje
	add constraint reciclaje_componente
    foreign key (id_ordenador, id_componente)
    references componentes (id_ordenador, id_componentes)
    on delete no action
    on update cascade;