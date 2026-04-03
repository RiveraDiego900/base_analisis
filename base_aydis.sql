-- Active: 1769988186095@@localhost@3306@sistema_escuela
create database sistema_escuela;

use sistema_escuela;

create table admins(
id_admin int not null primary key AUTO_INCREMENT, 
nombres_admin varchar (50) not null ,
apellidos varchar(50) not null
);

create table estudiante(
nro_cedula int not null primary key,
id_estudiantil int unique null,
nombres varchar(50),
apellido varchar(50) , 
nacionalidad varchar(20),
grado int not null, 
seccion varchar (1),
estado_pago varchar(20) DEFAULT 'PENDIENTE PAGO',
fecha_nacimiento date,
constraint check_estado check (estado_pago in ('PAGADO' , 'PENDIENTE DE REVISION' , 'PENDIENTE PAGO', 'MORA'))
);

create table tipo_pagos (
id_pago int not null primary key AUTO_INCREMENT,
nombre_pago varchar(20) 
);

create table concepto_pagos (  -- por si se pagan libros , utiles o matricula
id_concepto_p int not null primary key AUTO_INCREMENT ,
descrpcion varchar(30) not null   
);
create table comprobantes (
id_comprobante int not null primary key AUTO_INCREMENT, 
tipo_pago int not null ,
fecha_carga date not null ,
estudiante_id int not null , 
concepto_pago_id int not null , 
URL_comprobante varchar(100) not null ,
constraint estudiante_c  foreign key (estudiante_id) references estudiante(nro_cedula),
constraint pago_c  foreign key (tipo_pago) references tipo_pagos(id_pago),
constraint fk_concepto_pago  foreign key (concepto_pago_id) references concepto_pagos(id_concepto_p)

) ;

create table pasarela (
id_pasarela int not null primary key AUTO_INCREMENT ,
tipo_pago int not null ,
fecha_orden date not null ,
monto int not null ,
descripcion_orden varchar(60) null ,
concepto_pago_id int not null ,
constraint pago_p  foreign key (tipo_pago) references tipo_pagos(id_pago),
constraint fk_concepto_pago_p  foreign key (concepto_pago_id) references concepto_pagos(id_concepto_p)

);

create table orden_pago (
    orden_pago_id int not null PRIMARY key ,
    pasarela_id int null ,
    estudiante_id int not null ,
    cliente varchar(50) not null ,
);

 create table facturacion (
 factura_id int not null primary key AUTO_INCREMENT, 
 numero_orden int not null , 
 fecha_facturacion date not null , 
 autor int not null , 
 descripcion varchar(80) not null,
 tipo_pago int not null ,   -- por si fue por comprobante o de manera tradicicional 
constraint fk_factura_orden FOREIGN key (numero_orden) REFERENCES orden_pago(orden_pago_id),
constraint fk_factura_admin FOREIGN key (autor) REFERENCES admins(id_admin),
constraint fk_factura_pago FOREIGN key (tipo_pago) REFERENCES tipo_pagos(id_pago)

);

-- drop DATABASE sistema_escuela;