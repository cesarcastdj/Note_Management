# MER

![MER](https://drive.google.com/uc?id=12wlpZdQVpPgiNPotr6InbZI0m5nZWWtg)


# Documentación del Esquema de Base de Datos

## Descripción General

Este archivo SQL define el esquema de la base de datos para el sistema escolar. Contiene las tablas, relaciones y restricciones necesarias para gestionar las funcionalidades del sistema.

El esquema SQL define una base de datos relacional para gestionar un sistema escolar. Su diseño se basa en claves primarias y foráneas para asegurar la integridad referencial y optimizar la organización de la información académica y administrativa.

Gestión Geográfica: Registra la ubicación de los estudiantes y usuarios con tablas para estados, ciudades, municipios, parroquias y direccion.

Gestión de Usuarios: Define usuarios con niveles jerárquicos (nivel) y administra administradores en usuario_administradores.

Estructura Académica: Organiza materias (materias), secciones (seccion), y períodos (periodo) para estructurar la inscripción de los estudiantes (matricula).

Registro de Actividades y Notas: actividades almacena tareas y evaluaciones, mientras que notas gestiona calificaciones.

Seguimiento y Comunicación: Incluye comentarios, notificaciones, y bitacora para registro de interacciones y eventos.

Módulo de Cursos: cursos y matricula_curso permiten la inscripción en programas educativos adicionales.

## El diseño está optimizado para:

Organizar la información de usuarios, ubicación y jerarquía administrativa.

Facilitar la inscripción y gestión académica, desde materias hasta periodos escolares.

Registrar evaluaciones, notas y actividades, manteniendo el rendimiento de los estudiantes.

Mejorar la comunicación mediante notificaciones y comentarios.

Mantener seguridad y auditoría mediante bitácoras y control de accesos.

---

## Estructura del Esquema

### 1. Información Geográfica

- **`estados`**: Almacena los estados con su código ISO-3166-2.
- **`ciudades`**: Relaciona las ciudades con los estados.
- **`municipios`**: Relaciona los municipios con los estados.
- **`parroquias`**: Relaciona las parroquias con los municipios.
- **`direccion`**: Almacena direcciones específicas, relacionando ciudades y parroquias.

### 2. Gestión de Usuarios

- **`usuarios`**: Almacena información de los usuarios, incluyendo su nivel, dirección y rol.
- **`nivel`**: Define los niveles jerárquicos de los administradores.
- **`usuario_administradores`**: Relaciona los usuarios con sus niveles jerárquicos.

### 3. Gestión Académica

- **`materias`**: Almacena las materias disponibles.
- **`seccion`**: Define las secciones o grupos.
- **`periodo`**: Define los periodos académicos.
- **`matricula`**: Relaciona estudiantes con periodos y secciones.
- **`matricula_materias`**: Relaciona matrículas con materias.
- **`cursos`**: Almacena la información de los cursos disponibles.
- **`matricula_curso`**: Relaciona los cursos con las matrículas de estudiantes.

### 4. Funcionalidades Adicionales

- **`actividades`**: Almacena actividades académicas.
- **`notas`**: Registra las notas obtenidas por los estudiantes en las actividades.
- **`comentarios`**: Permite a los usuarios dejar comentarios.
- **`notificaciones`**: Almacena notificaciones enviadas a los usuarios.
- **`bitacora`**: Registra las acciones realizadas por los usuarios.

---

## Relaciones Clave

1. **Usuarios y Direcciones**: Cada usuario está relacionado con una dirección específica.
2. **Usuarios y Niveles**: Los administradores tienen niveles jerárquicos definidos en la tabla `nivel`.
3. **Estudiantes y Matrículas**: Los estudiantes están relacionados con periodos, secciones y materias a través de la tabla `matricula`.
4. **Cursos y Matrículas**: Se ha añadido la relación entre cursos y estudiantes mediante `matricula_curso`.
5. **Actividades y Notas**: Las notas están vinculadas a actividades específicas realizadas por los estudiantes.

---

## Restricciones y Consideraciones

- **Integridad Referencial**: Todas las relaciones están definidas con claves foráneas para garantizar la consistencia de los datos.
- **Eliminación Lógica**: Algunas tablas, como `usuarios` y `matricula`, utilizan un campo `estado` para manejar eliminaciones lógicas.
- **Mejoras en Índices**: Se han agregado índices en las tablas clave para optimizar consultas.

---

## Ejemplo de Consultas SQL

### Obtener las notas de un estudiante:

```sql
SELECT
    u.primer_nombre,
    u.apellido,
    a.nombre_actividad,
    n.nota_obtenida
FROM
    notas n
JOIN
    actividades a ON n.id_actividad = a.id_actividad
JOIN
    estudiantes e ON n.id_estudiante = e.id_estudiante
JOIN
    usuarios u ON e.id_usuario = u.id_usuario
WHERE
    u.id_usuario = 1;

SELECT
    m.nombre_materia
FROM
    matricula_materias mm
JOIN
    materias m ON mm.id_materia = m.id_materia
WHERE
    mm.id_matricula = 1;


## Ejemplo de Datos Ficticios

### Tabla: Usuarios

| id_usuario | primer_nombre | segundo_nombre | primer_apellido | segundo_apellido | correo                | rol        | estado | ultima_conexion     |
| ---------- | ------------- | -------------- | --------------- | ---------------- | --------------------- | ---------- | ------ | ------------------- |
| 1          | Juan          | Carlos         | Pérez           | Gómez            | juan.perez@gmail.com  | estudiante | 1      | 2025-04-30 10:00:00 |
| 2          | María         | Fernanda       | López           | Rodríguez        | maria.lopez@gmail.com | admin      | 1      | 2025-04-29 15:30:00 |

### Tabla: Materias

| id_materia | nombre_materia | descripcion                    |
| ---------- | -------------- | ------------------------------ |
| 1          | Matemáticas    | Cálculo diferencial e integral |
| 2          | Historia       | Historia universal moderna     |

### Tabla: Matrícula

| id_matricula | id_estudiante | id_periodo | id_seccion | estado |
| ------------ | ------------- | ---------- | ---------- | ------ |
| 1            | 1             | 1          | A          | 1      |
| 2            | 1             | 2          | B          | 1      |

### Tabla: Notas

| id_nota | id_actividad | id_estudiante | nota_obtenida |
| ------- | ------------ | ------------- | ------------- |
| 1       | 1            | 1             | 18.5          |
| 2       | 2            | 1             | 20.0          |

### Tabla: Actividades

| id_actividad | nombre_actividad | descripcion                     | fecha_creacion |
| ------------ | ---------------- | ------------------------------- | -------------- |
| 1            | Examen Parcial   | Evaluación del primer parcial   | 2025-04-15     |
| 2            | Proyecto Final   | Presentación del proyecto final | 2025-05-01     |

### Tabla: Bitácora

| id_accion | id_usuario | accion_realizada          | fecha_hora          |
| --------- | ---------- | ------------------------- | ------------------- |
| 1         | 1          | Inicio de sesión          | 2025-04-30 10:05:00 |
| 2         | 2          | Creación de nueva materia | 2025-04-29 16:00:00 |

### Tabla: Nivel

| id_nivel | tipo_nivel | descripcion              |
| -------- | ---------- | ------------------------ |
| 1        | super      | Administrador principal  |
| 2        | normal     | Administrador secundario |

### Tabla: Dirección

| id_direccion | calle            | numero | id_ciudad | id_parroquia |
| ------------ | ---------------- | ------ | --------- | ------------ |
| 1            | Av. Principal    | 123    | 1         | 1            |
| 2            | Calle Secundaria | 456    | 2         | 2            |

### Tabla: Estados

| id_estado | nombre_estado | codigo_iso |
| --------- | ------------- | ---------- |
| 1         | Amazonas      | VE-X       |
| 2         | Anzoátegui    | VE-B       |
| 3         | Apure         | VE-C       |
| 4         | Aragua        | VE-D       |
| 5         | Barinas       | VE-E       |

### Tabla: Municipios

| id_municipio | id_estado | nombre_municipio |
| ------------ | --------- | ---------------- |
| 1            | 1         | Alto Orinoco     |
| 2            | 1         | Atabapo          |
| 3            | 2         | Anaco            |
| 4            | 2         | Aragua           |
| 5            | 3         | Achaguas         |

### Tabla: Parroquias

| id_parroquia | id_municipio | nombre_parroquia     |
| ------------ | ------------ | -------------------- |
| 1            | 1            | Huachamacare Acanaña |
| 2            | 1            | Marawaka Toky        |
| 3            | 2            | Ucata Laja Lisa      |
| 4            | 3            | San Joaquín          |
| 5            | 3            | El Yagual            |

### Tabla: Ciudades

| id_ciudad | nombre_ciudad         | es_capital | id_estado |
| --------- | --------------------- | ---------- | --------- |
| 1         | Puerto Ayacucho       | TRUE       | 1         |
| 2         | Maroa                 | FALSE      | 1         |
| 3         | Barcelona             | TRUE       | 2         |
| 4         | Puerto La Cruz        | FALSE      | 2         |
| 5         | San Fernando de Apure | TRUE       | 3         |

### Tabla: Dirección

| id_direccion | calle          | numero | id_ciudad | id_parroquia |
| ------------ | -------------- | ------ | --------- | ------------ |
| 1            | Av. Bolívar    | 101    | 1         | 1            |
| 2            | Calle Sucre    | 202    | 2         | 2            |
| 3            | Av. Principal  | 303    | 3         | 3            |
| 4            | Calle Miranda  | 404    | 4         | 4            |
| 5            | Av. Libertador | 505    | 5         | 5            |

### Tabla: Cursos

| id_curso | nombre_curso   | descripcion              |
| -------- | -------------- | ------------------------ |
| 1        | Programación   | Desarrollo de software   |
