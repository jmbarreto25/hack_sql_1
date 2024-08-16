--Creando todas las tablas
CREATE TABLE COUNTRIES(
    id_country serial primary key,
    name varchar(20) NOT NULL
);

CREATE TABLE DISCOUNTS(
    id_discount serial primary key,
	status varchar(20) not null,
    percentage numeric (3) not null
);

create table OFFERS(
	id_offer serial primary key,
	status varchar(10) not null
	
);

create table TAXES(
	id_tax serial primary key,
	percentage numeric(3) not null
);

create table ROLES(
	id_role serial primary key,
	name varchar(20)not null
);

create table payments(
	id_payment serial primary key,
	type varchar(20) not null
);

create table invoice_status(
	id_invoice_status serial primary key,
	status varchar (10) not null
);


create table CUSTOMERS(
	id_customer serial primary key,
	id_country integer not null,
	id_role integer not null,
	email varchar (20) not null,
	name varchar (20) not null,
	age numeric (3) not null,
	password varchar (20) not null,
	physical_address varchar (30) not null,
	foreign key (id_country) references countries (id_country),
	foreign key (id_role) references roles (id_role)
	
);

create table PRODUCTS(
	id_product serial primary key,
	id_discount integer not null,
	id_offer integer not null,
	id_tax integer not null,
	name varchar(20) not null,
	details varchar(30) not null,
	minimun_stock numeric(5) not null,
	maximun_stock numeric(5) not null,
	current_stock numeric(5) not null,
	price numeric (20) not null,
	price_with_tax numeric (20) not null,
	foreign key (id_discount) references DISCOUNTS (id_discount),
	foreign key (id_offer) references offers (id_offer),
	foreign key (id_tax) references taxes (id_tax)
	
);


create table INVOICES(
	id_invoice serial primary key,
	id_customer integer not null,
	id_payment integer not null,
	id_invoice_status integer not null,
	date varchar(10) not null,
	total_to_pay numeric (20) not null,
	foreign key (id_customer) references customers (id_customer),
	foreign key (id_payment) references payments (id_payment),
	foreign key (id_invoice_status) references invoice_status  (id_invoice_status)
);

create table ORDERS(
	id_order serial primary key,
	id_invoice integer not null,
	id_product integer not null,
	detail varchar(20) not null,
	amount numeric(20) not null,
	price numeric(20) not null,
	foreign key (id_invoice) references invoices (id_invoice),
	foreign key (id_product) references products (id_product)
);

create table products_customers(
	id_product integer not null,
	id_customer integer not null,
	foreign key (id_product)  references products (id_product),
	foreign key (id_customer) references customers (id_customer),
	PRIMARY KEY (id_customer, id_product)
);

--Insertando todos los datos en todas las tablas
INSERT INTO countries(
	id_country, name)
	VALUES (1, 'Venezuela'), (2, 'USA'), (3, 'Colombia');

INSERT INTO discounts(
	id_discount, status, percentage)
	VALUES (1, 'Sin descuento', 0), (2, 'Mitad de precio', 50), (3, '25% Menos', 25);

INSERT INTO offers(
	id_offer, status)
	VALUES (1, 'Sin oferta'), (2, '50%'), (3, '25%');

INSERT INTO taxes(
	id_tax, percentage)
	VALUES (1, 17), (2, 4), (3, 11);

INSERT INTO roles(
	id_role, name)
	VALUES (1, 'VIP'), (2, 'Regular'), (3, 'Mayorista');

INSERT INTO payments(
	id_payment, type)
	VALUES (1, 'Efectivo'), (2, 'Punto de venta'), (3, 'Online');

INSERT INTO invoice_status(
	id_invoice_status, status)
	VALUES (1, 'Fisico'), (2, 'Delivery'), (3, 'Pickup');

INSERT INTO products(
	id_product, id_discount, id_offer, id_tax, name, details, minimun_stock, maximun_stock, current_stock, price, price_with_tax)
	VALUES 
	(1, 1, 1, 1, 'Cerveza Zulia', 'Caja de 36 Unidades', 10, 100, 50, 16, 18),
	(2, 3, 3, 1, 'Cerveza Polar', 'Caja de 36 Unidades', 10, 100, 50, 14, 16),
	(3, 2, 2, 1, 'Cerveza Morena', 'Caja de 6 Unidades', 10, 100, 50, 4, 5);

INSERT INTO customers(
	id_customer, id_country, id_role, email, name, age, password, physical_address)
	VALUES 
	(1, 1, 1, 'correo1@gmail.com', 'Joan', 29, 'Solera', 'Caracas'),
	(2, 2, 3, 'correo2@gmail.com', 'Carlos', 50, 'Zulia', 'Estados Unidos'),
	(3, 3, 2, 'correo3@gmail.com', 'Jose', 32, 'Polar', 'Colombia'),
	(4, 3, 3, 'correo4@gmail.com', 'Juan', 15, 'Solera', 'Colombia');

INSERT INTO invoices(
	id_invoice, id_customer, id_payment, id_invoice_status, date, total_to_pay)
	VALUES 
	(1, 1, 1, 1, '09/08/2024', 36),
	(2, 2, 3, 2, '10/08/2024', 160),
	(3, 3, 3, 2, '12/08/2024', 10);

INSERT INTO products_customers(
	id_product, id_customer)
	VALUES (1,1), (2,2);

INSERT INTO orders(
	id_order, id_invoice, id_product, detail, amount, price)
	VALUES 
	(1, 1, 1, '2 Cajas de Zulia', 2, 36),
	(2, 2, 2, '10 Cajas de Polar', 10, 160),
	(3, 3, 3, '2 Cajas de Morena', 2, 10);

--eliminando el ultimo usuario
DELETE FROM customers WHERE id_customer = 4;

--actualizando el ultimo usuario
UPDATE customers SET password = 'CERVEZA' WHERE id_customer = 3;

--actualizando todos los taxes
UPDATE taxes
SET percentage = 
    CASE 
        WHEN id_tax = 1 THEN 16 
        WHEN id_tax = 2 THEN 3
        WHEN id_tax = 3 THEN 10
    END
WHERE id_tax IN (1, 2, 3);

--actualizando todos los precios

UPDATE products
SET price = 
    CASE 
        WHEN id_product = 1 THEN 17 
        WHEN id_product = 2 THEN 15
        WHEN id_product = 3 THEN 5
    END,
    price_with_tax = 
    CASE 
        WHEN id_product = 1 THEN 20
        WHEN id_product = 2 THEN 18
        WHEN id_product = 3 THEN 6
        END
WHERE id_product IN (1, 2, 3);




