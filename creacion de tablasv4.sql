CREATE TABLE estado_estadia(
cve_estado_estadia serial primary key,
descripcion text,
activo boolean
);

CREATE TABLE tipo_archivo(
cve_tipo_archivo serial primary key,
descripcion varchar (50)
);

CREATE TABLE numero_avance_estadia(
cve_numero_avance_estadia serial primary key,
descripcion varchar (20)
);

CREATE TABLE tipo_carta_estadia(
cve_tipo_carta_estadia serial primary key,
descripcion varchar (35)
);

CREATE TABLE estadia_alumno( --tabla modificada post revision
cve_estadia_alumno serial primary key,
cve_persona int,
cve_coordinador int,
cve_alumno_grupo int,
fecha_registros date,
numero_avance int,
activo boolean,
asesor_empresarial varchar(120),
empresa varchar (60),
puesto_asesor_empresarial varchar(20),
FOREIGN KEY (cve_asesor) REFERENCES persona(cve_persona),
FOREIGN KEY (cve_alumno_grupo) REFERENCES alumno_grupo(cve_alumno_grupo),
FOREIGN KEY (cve_coordinador) REFERENCES persona(cve_persona),
FOREIGN KEY (numero_avance) REFERENCES numero_avance_estadia(cve_numero_avance_estadia)
);

CREATE TABLE estadia_archivo(
cve_estadia_archivo serial primary key,
cve_alumno_grupo integer,
cve_archivo integer,
tipo_archivo integer,
nombre_proyecto varchar (50),
FOREIGN KEY (cve_alumno_grupo) REFERENCES alumno_grupo(cve_alumno_grupo),
FOREIGN KEY(cve_archivo) REFERENCES archivo(cve_archivo),
FOREIGN KEY (tipo_archivo) REFERENCES tipo_archivo(cve_tipo_archivo)
);

CREATE TABLE estadia_estado(
cve_estadia_estado serial primary key,
cve_estado_estadia integer,
cve_estadia_archivo integer,
cve_persona integer,
comentario text,
fecha_alta date,
activo boolean,
FOREIGN KEY (cve_estado_estadia) REFERENCES estado_estadia(cve_estado_estadia),
FOREIGN KEY (cve_persona) REFERENCES persona(cve_persona),
FOREIGN KEY (cve_estadia_archivo) REFERENCES estadia_archivo(cve_estadia_archivo) 
);


-- Insercciones

-- tabla tipo de archivo
INSERT INTO public.tipo_archivo(descripcion)
VALUES
('Carta de Conclusion'),
('Memoria de Estadia'),
('Carta de Aceptacion');

-- Numero Avance
INSERT INTO numero_avance_estadia(descripcion)
VALUES ('Sin Entregar'),
('Primer'),
('Segundo'),
('Tecer');

-- Estado Estadia
INSERT INTO public.estado_estadia(descripcion, activo)
VALUES ('Pendiente', True),
('Aprobada',False),
('Rechazada',False),
('Validada por el asesor',True),
('Autorizada por el Director',True),
('Verificada por Servicios Escolares',True);
('Rechazada por el Asesor',True);
('Rechazada por el Director',True);
('Rechazada por Servicios Escolares',True);

INSERT INTO tipo_carta_estadia(descripcion)
VALUES ('Carta de presentación'),
('Carta de liberación de memoria');
