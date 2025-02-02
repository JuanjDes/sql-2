/* RELACION TIPO 1:1 */

-- PASO 1 Crea una tabla usuarios y Añade valores a usuarios
	CREATE TABLE usuarios (
		id_usuario INT auto_increment PRIMARY KEY NOT NULL,
		nombre VARCHAR(50) NOT NULL,
		apellido VARCHAR(100) NOT NULL,
		email VARCHAR(100) NOT NULL,
		edad INT
	);

	INSERT INTO usuarios (nombre, apellido, email, edad) VALUES
	('Juan', 'Gomez', 'juan.gomez@example.com', 28),
	('Maria', 'Lopez', 'maria.lopez@example.com', 32),
	('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
	('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
	('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
	('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
	('Miguel', 'Perez', 'miguel.perez@example.com', 28),
	('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
	('Javier', 'Diaz', 'javier.diaz@example.com', 31),
	('Luis', 'Sanchez', 'luis.sanchez@example.com', 27),
	('Elena', 'Moreno', 'elena.moreno@example.com', 29),
	('Daniel', 'Romero', 'daniel.romero@example.com', 33),
	('Paula', 'Torres', 'paula.torres@example.com', 24),
	('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28),
	('Carmen', 'Vega', 'carmen.vega@example.com', 29),
	('Adrian', 'Molina', 'adrian.molina@example.com', 34),
	('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26),
	('Hector', 'Ortega', 'hector.ortega@example.com', 30),
	('Raquel', 'Serrano', 'raquel.serrano@example.com', 32),
	('Alberto', 'Reyes', 'alberto.reyes@example.com', 28);

	SELECT * FROM usuarios;

-- PASO 2 Crea una tabla de roles y Añade valores
	CREATE TABLE roles (
		id_rol INT auto_increment PRIMARY KEY,
		nombre_rol VARCHAR(50) NOT NULL
	);

	SELECT * FROM roles;

	INSERT INTO roles (nombre_rol) VALUES
	('Bronce'),
	('Plata'),
	('Oro'),
	('Platino');

-- PASO 3 Añade la columna id_rol a usuarios. Rellena cada rol con números asociados a la tabla de roles
-- Crea la clave foránea (FOREIGN)
	ALTER TABLE usuarios ADD id_rol INT NOT NULL;

	ALTER TABLE usuarios ADD foreign key (id_rol) REFERENCES roles(id_rol);

-- PASO 4 Haz un JOIN que saque usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email,
--  usuarios.edad, roles.nombre_rol de las dos tablas
	SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol
	  FROM usuarios JOIN roles ON usuarios.id_rol = roles.id_rol ORDER BY usuarios.id_usuario;
  
-- ------------------------------------------------------------------------------------------------------------------

/* RELACION TIPO 1:N */

-- PASO 1 Crea una tabla categorias y Añade datos
	CREATE TABLE categorias (
		id_categoria INT auto_increment PRIMARY KEY,
        nombre_categoria VARCHAR(100) NOT NULL
    );
    
    INSERT INTO categorias (nombre_categoria) VALUES
		('Electrónicos'),
		('Ropa y Accesorios'),
		('Libros'),
		('Hogar y Cocina'),
		('Deportes y aire libre'),
		('Salud y cuidado personal'),
		('Herramientas y mejoras para el hogar'),
		('Juguetes y juegos'),
		('Automotriz'),
		('Música y Películas');

-- PASO 2 Añadir a tabla usuarios columna id_categoria (tipo número)
	ALTER TABLE usuarios ADD COLUMN id_categoria INT;
    
-- PASO 3 Añadir categorias a varios usuarios
	UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (1, 2, 3, 4, 5);
    UPDATE usuarios SET id_categoria = 2 WHERE id_usuario IN (6, 7, 8, 9, 10);
    UPDATE usuarios SET id_categoria = 3 WHERE id_usuario IN (11, 12, 13, 14, 15);
    UPDATE usuarios SET id_categoria = 4 WHERE id_usuario IN (16, 17, 18, 19, 20);
    
-- PASO 4 Consulta para ver la unión de usuarios, roles y categorías
	SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad,
		roles.nombre_rol, categorias.nombre_categoria
		FROM usuarios
		JOIN roles ON usuarios.id_rol = roles.id_rol
		JOIN categorias ON usuarios.id_categoria = categorias.id_categoria
		ORDER BY usuarios.id_usuario;
        
-- ------------------------------------------------------------------------------------------------------------------

/*  RELACION TIPO N:M */

-- PASO 1 Crea una tabla intermedia llamada usuarios_categorias con 2 claves foráneas
    CREATE TABLE usuarios_categorias (
		id_usuario_categoria INT auto_increment PRIMARY KEY,
        id_usuario INT,
		id_categoria INT,
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
        FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
	);
    
-- PASO 2 Asocia usuarios a Categorías
	INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
		(1, 1), (1, 2), (1, 3),
		(2, 4), (2, 5),
		(3, 6), (3, 7),
		(4, 8), (4, 9), (4, 10);
        
-- PASO 3 Consulta para ver la unión de usuarios, roles, categorías, utilizando tabla usuarios_categorias como intermedia
	SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad,
		roles.nombre_rol, categorias.nombre_categoria
        FROM usuarios_categorias
        JOIN usuarios ON usuarios_categorias.id_usuario = usuarios.id_usuario
        JOIN roles ON usuarios.id_rol = roles.id_rol
        JOIN categorias ON usuarios_categorias.id_categoria = categorias.id_categoria;
        