# Esquema de Base de Datos: Note Management

Este archivo SQL define el esquema de la base de datos para el sistema de gestión de notas. Incluye la creación de tablas, relaciones y atributos necesarios para manejar usuarios, estudiantes, administradores, matrículas, materias, actividades, notas, comentarios, notificaciones y bitácoras.

## Tablas y Descripción

### 1. **Usuarios**
- Almacena la información básica de todos los usuarios (administradores y estudiantes).
- **Atributos:**
  - `id_usuario`: Identificador único del usuario.
  - `nombre`: Nombre del usuario.
  - `apellido`: Apellido del usuario.
  - `correo`: Correo electrónico único.
  - `contraseña`: Contraseña encriptada.
  - `rol`: Rol del usuario (`admin` o `estudiante`).
  - `estado`: Indica si el usuario está activo o inactivo (eliminación lógica).
  - `ultima_conexion`: Fecha y hora de la última conexión.

### 2. **Estudiantes**
- Relaciona a los estudiantes con la tabla `Usuarios`.
- **Atributos:**
  - `id_estudiante`: Identificador único del estudiante.
  - `id_usuario`: Relación con la tabla `Usuarios`.

### 3. **Administradores**
- Relaciona al administrador con la tabla `Usuarios`.
- **Atributos:**
  - `id_admin`: Identificador único del administrador.
  - `id_usuario`: Relación con la tabla `Usuarios`.

### 4. **Matrícula**
- Registra la información de matrícula de los estudiantes.
- **Atributos:**
  - `id_matricula`: Identificador único de la matrícula.
  - `id_estudiante`: Relación con la tabla `Estudiantes`.
  - `periodo_academico`: Periodo académico del estudiante (por ejemplo, "2025-1").
  - `seccion`: Sección del estudiante (por ejemplo, "A", "B").
  - `estado`: Indica si la matrícula está activa o inactiva (eliminación lógica).

### 5. **Materias**
- Almacena las materias disponibles en el sistema.
- **Atributos:**
  - `id_materia`: Identificador único de la materia.
  - `nombre_materia`: Nombre de la materia.
  - `descripcion`: Descripción de la materia.

### 6. **Relación Matrícula-Materias**
- Relaciona las matrículas con las materias en las que están inscritos los estudiantes.
- **Atributos:**
  - `id_matricula`: Relación con la tabla `Matrícula`.
  - `id_materia`: Relación con la tabla `Materias`.

### 7. **Actividades**
- Almacena las actividades creadas por el administrador.
- **Atributos:**
  - `id_actividad`: Identificador único de la actividad.
  - `nombre_actividad`: Nombre de la actividad.
  - `descripcion`: Descripción de la actividad.
  - `fecha_creacion`: Fecha de creación de la actividad.

### 8. **Notas**
- Registra las notas obtenidas por los estudiantes en las actividades.
- **Atributos:**
  - `id_nota`: Identificador único de la nota.
  - `id_actividad`: Relación con la tabla `Actividades`.
  - `id_estudiante`: Relación con la tabla `Estudiantes`.
  - `nota_obtenida`: Nota obtenida en la actividad.

### 9. **Comentarios**
- Permite la comunicación entre usuarios (estudiantes y administradores).
- **Atributos:**
  - `id_comentario`: Identificador único del comentario.
  - `id_usuario`: Relación con la tabla `Usuarios`.
  - `mensaje`: Contenido del comentario.
  - `fecha_hora`: Fecha y hora del comentario.

### 10. **Notificaciones**
- Almacena las notificaciones enviadas a los usuarios.
- **Atributos:**
  - `id_notificacion`: Identificador único de la notificación.
  - `id_usuario`: Relación con la tabla `Usuarios`.
  - `mensaje`: Contenido de la notificación.
  - `fecha_hora`: Fecha y hora de la notificación.
  - `estado`: Indica si la notificación ha sido leída o no.

### 11. **Bitácora**
- Registra las acciones realizadas por los usuarios en el sistema.
- **Atributos:**
  - `id_accion`: Identificador único de la acción.
  - `id_usuario`: Relación con la tabla `Usuarios`.
  - `accion_realizada`: Descripción de la acción.
  - `fecha_hora`: Fecha y hora de la acción.

---

## Relación entre Tablas
- **Usuarios** es la tabla central que conecta con `Estudiantes`, `Administradores`, `Comentarios`, `Notificaciones` y `Bitácora`.
- **Matrícula** se relaciona con `Estudiantes` y `Materias` mediante una tabla intermedia (`Matricula_Materias`).
- **Notas** conecta `Estudiantes` con `Actividades`.

---

> **Cesar-Dev**
