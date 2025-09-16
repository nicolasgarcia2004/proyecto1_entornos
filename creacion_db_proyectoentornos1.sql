-- Create table USUARIOS
create table usuarios (
  id_usuario bigint primary key generated always as identity,
  nombre_completo text,
  correo_electronico text unique,
  telefono text,
  ciudad text,
  fecha_registro timestamp with time zone default current_timestamp,
  tipo_usuario text check (
    tipo_usuario in ('adoptante', 'voluntario', 'administrador')
  )
);

-- Create table MASCOTAS
create table mascotas (
  id_mascota bigint primary key generated always as identity,
  nombre text,
  especie text,
  raza text,
  edad int,
  descripcion text,
  estado_salud text,
  foto text,
  estado_publicacion text check (
    estado_publicacion in ('disponible', 'adoptado', 'pendiente')
  ),
  id_usuario_publica bigint,
  foreign key (id_usuario_publica) references usuarios (id_usuario)
);

-- Create table SOLICITUDES_ADOPCION
create table solicitudes_adopcion (
  id_solicitud bigint primary key generated always as identity,
  fecha_solicitud timestamp with time zone default current_timestamp,
  estado_solicitud text check (
    estado_solicitud in ('pendiente', 'aprobada', 'rechazada')
  ),
  id_mascota_solicitada bigint,
  id_usuario_adoptante bigint,
  mensaje_adoptante text,
  fecha_resolucion timestamp with time zone,
  foreign key (id_mascota_solicitada) references mascotas (id_mascota),
  foreign key (id_usuario_adoptante) references usuarios (id_usuario)
);

-- Create table ADOPCIONES
create table adopciones (
  id_adopcion bigint primary key generated always as identity,
  id_mascota bigint,
  id_adoptante bigint,
  fecha_adopcion timestamp with time zone,
  foreign key (id_mascota) references mascotas (id_mascota),
  foreign key (id_adoptante) references usuarios (id_usuario)