CREATE TABLE PRIORITIES
(
    id_priority serial primary key,
    type_name varchar(20) NOT NULL
);

CREATE TABLE COUNTRIES
(
    id_country serial primary key,
    name varchar(20) NOT NULL
);

CREATE TABLE CONTACT_REQUEST
(
    id_email serial primary key,
    id_country integer NOT NULL,
    id_priority integer NOT NULL,
    name varchar(30) NOT NULL,
    detail varchar(30) NOT NULL,
    physical_address varchar(50) NOT NULL,
    foreign key (id_country) references countries (id_country),
    foreign key (id_priority) references priorities(id_priority) 
    
    
);

/*INSERT EN COUNTRIES*/
INSERT INTO countries(name) VALUES ('Venezuela'), ('Argentina') , ('Peru'),('Chile'), ('Estados Unidos');
select * from countries;
/*INSERT EN PRIORITIES*/
INSERT INTO PRIORITIES (type_name) VALUES ('Alta'), ('Media') , ('Baja');
select * from PRIORITIES;
/*INSERT EN CONTACT_REQUEST*/
insert into CONTACT_REQUEST (id_email, id_country, id_priority, name, detail, physical_address) 
values (1, 1, 1, 'Joan Barreto', 'joanbarreto1@gmail.com', 'Catia-Caracas'), 
       (2, 1, 2, 'Carlos Reyes', 'cccreyes@gmail.com', 'Las Mercedes-Caracas'), 
       (3, 4, 3, 'Jose Barreto', 'josebarreto@gmail.com', 'Santiago-Chile');
select * from contact_request;
/* delete ultimo usuario*/
delete from contact_request where id_email = 3;
/* update primer usuario*/
update contact_request set id_country = 5, physical_address = 'Michigan-Estados Unidos' where id_email = 1;
select * from contact_request;

select cr.id_email as id, cr.name, cr.detail as correo, cr.physical_address as ubicacion, c.name as pais
from contact_request cr inner join  countries c on cr.id_country = c.id_country; 




