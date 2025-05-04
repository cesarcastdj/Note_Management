-- Borrar la base de datos si existe
DROP SCHEMA IF EXISTS `sistema_escolar`;

-- Crear la base de datos
CREATE SCHEMA IF NOT EXISTS `sistema_escolar` DEFAULT CHARACTER SET utf8;

-- Usar la base de datos
USE `sistema_escolar`;

-- Tabla `actividades`
CREATE TABLE IF NOT EXISTS `actividades` (
  `id_actividad` INT NOT NULL AUTO_INCREMENT,
  `nombre_actividad` VARCHAR(150) CHARACTER SET 'utf8' NOT NULL,
  `descripcion` TEXT CHARACTER SET 'utf8',
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id_actividad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla `nivel`
CREATE TABLE IF NOT EXISTS `nivel` (
  `id_nivel` INT NOT NULL AUTO_INCREMENT,
  `tipo_nivel` ENUM('super','normal') CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id_nivel`)
) ENGINE=InnoDB;

-- Tabla `estados`
CREATE TABLE IF NOT EXISTS `estados` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `estados` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `iso-3166-2` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB;

-- Tabla `ciudades`
CREATE TABLE IF NOT EXISTS `ciudades` (
  `id_ciudad` INT NOT NULL AUTO_INCREMENT,
  `id_estado` INT NOT NULL,
  `ciudades` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  CONSTRAINT `fk_ciudades_estados`
    FOREIGN KEY (`id_estado`)
    REFERENCES `estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;
CREATE INDEX `id_estado_idx` ON `ciudades` (`id_estado` ASC) VISIBLE;

-- Tabla `direccion`
CREATE TABLE IF NOT EXISTS `direccion` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `id_ciudad` INT NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_direccion`),
  CONSTRAINT `fk_direccion_ciudades`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `ciudades` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccion_estados`
    FOREIGN KEY (`id_estado`)
    REFERENCES `estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;
CREATE INDEX `id_ciudad_idx` ON `direccion` (`id_ciudad` ASC) VISIBLE;
CREATE INDEX `id_estado_idx` ON `direccion` (`id_estado` ASC) VISIBLE;

-- Tabla `usuarios`
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `id_nivel` INT NOT NULL,
  `id_direccion` INT NOT NULL,
  `primer_nombre` VARCHAR(85) CHARACTER SET 'utf8' NOT NULL,
  `segundo_nombre` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `primer_apellido` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `segundo_apellido` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `correo` VARCHAR(60) CHARACTER SET 'utf8' NOT NULL UNIQUE,
  `contraseña` VARCHAR(34) NOT NULL,
  `rol` ENUM('admin','estudiante') NOT NULL,
  `estado` TINYINT(1) DEFAULT '1',
  `ultima_conexion` DATETIME,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `fk_usuarios_nivel`
    FOREIGN KEY (`id_nivel`)
    REFERENCES `nivel` (`id_nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_direccion`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX `id_nivel_idx` ON `usuarios` (`id_nivel` ASC) VISIBLE;
CREATE INDEX `id_direccion_idx` ON `usuarios` (`id_direccion` ASC) VISIBLE;

-- Tabla `usuario_administradores`
CREATE TABLE IF NOT EXISTS `usuario_administradores` (
  `id_admin` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `id_nivel` INT NOT NULL,
  `contraseña` VARCHAR(34) NOT NULL,
  PRIMARY KEY (`id_admin`),
  CONSTRAINT `fk_usuario_administradores_nivel`
    FOREIGN KEY (`id_nivel`)
    REFERENCES `nivel` (`id_nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_administradores_usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX `id_nivel_idx` ON `usuario_administradores` (`id_nivel` ASC) VISIBLE;
CREATE INDEX `id_usuario_idx` ON `usuario_administradores` (`id_usuario` ASC) VISIBLE;

-- Tabla `bitacora`
CREATE TABLE IF NOT EXISTS `bitacora` (
  `id_accion` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `accion_realizada` TEXT CHARACTER SET 'utf8' NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id_accion`),
  CONSTRAINT `fk_bitacora_usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX `id_usuario` ON `bitacora` (`id_usuario` ASC) VISIBLE;

-- Tabla `comentarios`
CREATE TABLE IF NOT EXISTS `comentarios` (
  `id_comentario` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `mensaje` TEXT CHARACTER SET 'utf8' NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id_comentario`),
  CONSTRAINT `fk_comentarios_usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX `id_usuario` ON `comentarios` (`id_usuario` ASC) VISIBLE;

-- Tabla `estudiantes`
CREATE TABLE IF NOT EXISTS `estudiantes` (
  `id_estudiante` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_estudiante`),
  CONSTRAINT `fk_estudiantes_usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX `id_usuario` ON `estudiantes` (`id_usuario` ASC) VISIBLE;

-- Tabla `materias`
CREATE TABLE IF NOT EXISTS `materias` (
  `id_materia` INT NOT NULL AUTO_INCREMENT,
  `nombre_materia` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `descripcion` TEXT CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla `seccion`
CREATE TABLE IF NOT EXISTS `seccion` (
  `id_seccion` INT NOT NULL AUTO_INCREMENT,
  `seccion` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id_seccion`)
) ENGINE=InnoDB;

-- Tabla `periodo`
CREATE TABLE IF NOT EXISTS `periodo` (
  `id_periodo` INT NOT NULL AUTO_INCREMENT,
  `periodo` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFinal` DATE NOT NULL,
  PRIMARY KEY (`id_periodo`)
) ENGINE=InnoDB;

-- Tabla `matricula`
CREATE TABLE IF NOT EXISTS `matricula` (
  `id_matricula` INT NOT NULL AUTO_INCREMENT,
  `id_estudiante` INT NOT NULL,
  `id_periodo` INT NOT NULL,
  `id_seccion` INT NOT NULL,
  `estado` TINYINT(1) DEFAULT '1',
  PRIMARY KEY (`id_matricula`),
  CONSTRAINT `fk_matricula_estudiantes`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `estudiantes` (`id_estudiante`),
  CONSTRAINT `fk_matricula_seccion`
    FOREIGN KEY (`id_seccion`)
    REFERENCES `seccion` (`id_seccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_periodo`
    FOREIGN KEY (`id_periodo`)
    REFERENCES `periodo` (`id_periodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX `id_estudiante` ON `matricula` (`id_estudiante` ASC) VISIBLE;
CREATE INDEX `id_seccion_idx` ON `matricula` (`id_seccion` ASC) VISIBLE;
CREATE INDEX `id_periodo_idx` ON `matricula` (`id_periodo` ASC) VISIBLE;

-- Tabla `matricula_materias`
CREATE TABLE IF NOT EXISTS `matricula_materias` (
  `id_matricula` INT NOT NULL,
  `id_materia` INT NOT NULL,
  PRIMARY KEY (`id_matricula`, `id_materia`),
  CONSTRAINT `fk_matricula_materias_matricula`
    FOREIGN KEY (`id_matricula`)
    REFERENCES `matricula` (`id_matricula`),
  CONSTRAINT `fk_matricula_materias_materias`
    FOREIGN KEY (`id_materia`)
    REFERENCES `materias` (`id_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX `id_materia` ON `matricula_materias` (`id_materia` ASC) VISIBLE;

-- Tabla `notas`
CREATE TABLE IF NOT EXISTS `notas` (
  `id_nota` INT NOT NULL AUTO_INCREMENT,
  `id_actividad` INT NOT NULL,
  `id_estudiante` INT NOT NULL,
  `nota_obtenida` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id_nota`),
  CONSTRAINT `fk_notas_actividades`
    FOREIGN KEY (`id_actividad`)
    REFERENCES `actividades` (`id_actividad`),
  CONSTRAINT `fk_notas_estudiantes`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `estudiantes` (`id_estudiante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX `id_actividad` ON `notas` (`id_actividad` ASC) VISIBLE;
CREATE INDEX `id_estudiante` ON `notas` (`id_estudiante` ASC) VISIBLE;

-- Tabla `notificaciones`
CREATE TABLE IF NOT EXISTS `notificaciones` (
  `id_notificacion` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `mensaje` TEXT CHARACTER SET 'utf8' NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `estado` TINYINT(1) DEFAULT '0',
  PRIMARY KEY (`id_notificacion`),
  CONSTRAINT `fk_notificaciones_usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX `id_usuario` ON `notificaciones` (`id_usuario` ASC) VISIBLE;

-- Tabla `cursos`
CREATE TABLE IF NOT EXISTS `cursos` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `nombre_curso` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB;

-- Tabla `matricula_curso`
CREATE TABLE IF NOT EXISTS `matricula_curso` (
  `id_curso` INT NOT NULL,
  `id_matricula` INT NOT NULL,
  PRIMARY KEY (`id_curso`, `id_matricula`),
  CONSTRAINT `fk_matricula_curso_cursos`
    FOREIGN KEY (`id_curso`)
    REFERENCES `cursos` (`id_curso`),
  CONSTRAINT `fk_matricula_curso_matricula`
    FOREIGN KEY (`id_matricula`)
    REFERENCES `matricula` (`id_matricula`)
) ENGINE=InnoDB;
CREATE INDEX `id_matricula_idx` ON `matricula_curso` (`id_matricula` ASC) VISIBLE;
