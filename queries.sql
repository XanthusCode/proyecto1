CREATE TABLE pais (
    id_pais INTEGER PRIMARY KEY,
    nombre_pais VARCHAR(50)
);

CREATE TABLE region (
    id_region INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    id_pais INTEGER
);

CREATE TABLE ciudad (
    id_ciudad INTEGER PRIMARY KEY,
    nombre_ciudad VARCHAR(50),
    id_region INTEGER
);

CREATE TABLE ubicacion (
    id_ubicacion INTEGER PRIMARY KEY,
    id_ciudad INTEGER,
    linea_direccion1 VARCHAR(50),
    linea_direccion2 VARCHAR(50),
    codigo_postal VARCHAR(50)
);

CREATE TABLE contacto (
    id_contacto INTEGER PRIMARY KEY,
    telefono VARCHAR(20),
    fax VARCHAR(20),
    extension VARCHAR(10),
    email VARCHAR(100)
);

CREATE TABLE oficina (
    codigo_oficina VARCHAR(10) PRIMARY KEY,
    codigo_postal VARCHAR(10),
    id_contacto INTEGER,
    id_ubicacion INTEGER
);

CREATE TABLE proveedor (
    id_proveedor INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    nombre_empresa VARCHAR(50),
    ubicacion VARCHAR(50)
);

CREATE TABLE dimensiones (
    id_dimensiones INTEGER PRIMARY KEY,
    alto DECIMAL(5,2),
    ancho DECIMAL(5,2),
    largo DECIMAL(10,5),
    peso DECIMAL(10,5)
);

CREATE TABLE stock (
    id_stock INTEGER PRIMARY KEY,
    stock_maximo INTEGER,
    stock_minimo INTEGER,
    stock_actual INTEGER
);

CREATE TABLE gama_producto (
    id_gama VARCHAR(50) PRIMARY KEY,
    descripcion_text TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256)
);

CREATE TABLE producto (
    id_producto VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(70),
    id_gama VARCHAR(50),
    id_dimensiones INTEGER NULL,
    id_proveedor INTEGER,
    descripcion TEXT,
    id_stock INTEGER,
    precio_venta DECIMAL(15,2)
);

CREATE TABLE estado (
    id_estado INTEGER PRIMARY KEY,
     nombre_estado VARCHAR(70) UNIQUE
);

CREATE TABLE credito (
    id_credito INTEGER PRIMARY KEY,
    limite_credito DECIMAL(15,2),
    id_estado INTEGER
);

CREATE TABLE cliente (
    codigo_cliente INTEGER PRIMARY KEY,
    nombre_cliente VARCHAR(50),
    nombre_contacto VARCHAR(30),
    apellido_contacto VARCHAR(30),
    codigo_empleado_rep INTEGER,
    id_credito INTEGER,
    id_ubicacion INTEGER
);

CREATE TABLE cliente_direccion (
    codigo_cliente INTEGER PRIMARY KEY,
    id_contacto INTEGER,
    id_ubicacion INTEGER
);


CREATE TABLE empleado (
    codigo_empleado INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    codigo_oficina VARCHAR(10),
    codigo_jefe INTEGER,
    puesto VARCHAR(50),
    email VARCHAR(100), 
    id_contacto INTEGER,
    nombre_jefe_del_jefe VARCHAR(50)
);


CREATE TABLE pedido (
    id_pedido INTEGER PRIMARY KEY,
    fecha_pedido DATE,
    fecha_esperada DATE,
    fecha_entrega DATE,
    id_estado INTEGER,
    comentarios TEXT,
    codigo_cliente INTEGER,
    metodo_pago VARCHAR(50)
);

CREATE TABLE detalle_pedido (
    id_pedido INTEGER,
    id_producto VARCHAR(15) NULL,
    cantidad INTEGER,
    numero_linea INTEGER,
    precio_unitario DECIMAL(15,2),
    PRIMARY KEY (id_pedido, numero_linea)
);

CREATE TABLE pago (
    id_pago INTEGER PRIMARY KEY,
    fecha_pago DATE,
    monto DECIMAL(15,2),
    id_pedido INTEGER
);


-- Modificación de la tabla region para agregar restricción de clave foránea
ALTER TABLE region ADD CONSTRAINT FK_Region_Pais FOREIGN KEY (id_pais) REFERENCES pais (id_pais);

-- Modificación de la tabla ciudad para agregar restricción de clave foránea
ALTER TABLE ciudad ADD CONSTRAINT FK_Ciudad_Region FOREIGN KEY (id_region) REFERENCES region (id_region);

-- Modificación de la tabla ubicacion para agregar restricción de clave foránea
ALTER TABLE ubicacion ADD CONSTRAINT FK_Ubicacion_Ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad);

-- Modificación de la tabla oficina para agregar restricción de clave foránea
ALTER TABLE oficina ADD CONSTRAINT FK_Oficina_Contacto FOREIGN KEY (id_contacto) REFERENCES contacto (id_contacto);
ALTER TABLE oficina ADD CONSTRAINT FK_Oficina_Ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicacion (id_ubicacion);

-- Modificación de la tabla producto para agregar restricción de clave foránea
ALTER TABLE producto ADD CONSTRAINT FK_Producto_Gama FOREIGN KEY (id_gama) REFERENCES gama_producto (id_gama);
ALTER TABLE producto ADD CONSTRAINT FK_Producto_Dimensiones FOREIGN KEY (id_dimensiones) REFERENCES dimensiones (id_dimensiones);
ALTER TABLE producto ADD CONSTRAINT FK_Producto_Proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedor (id_proveedor);
ALTER TABLE producto ADD CONSTRAINT FK_Producto_Stock FOREIGN KEY (id_stock) REFERENCES stock (id_stock);

-- Modificación de la tabla credito para agregar restricción de clave foránea
ALTER TABLE credito ADD CONSTRAINT FK_Credito_Estado FOREIGN KEY (id_estado) REFERENCES estado (id_estado);

-- Modificación de la tabla cliente para agregar restricción de clave foránea
ALTER TABLE cliente ADD CONSTRAINT FK_Cliente_Credito FOREIGN KEY (id_credito) REFERENCES credito (id_credito);
ALTER TABLE cliente ADD CONSTRAINT FK_Cliente_Ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicacion (id_ubicacion);


-- Modificación de la tabla cliente_direccion para agregar restricción de clave foránea
ALTER TABLE cliente_direccion ADD CONSTRAINT FK_Cliente_Direccion_Contacto FOREIGN KEY (id_contacto) REFERENCES contacto (id_contacto);
ALTER TABLE cliente_direccion ADD CONSTRAINT FK_Cliente_Direccion_Ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicacion (id_ubicacion);

-- Modificación de la tabla empleado para agregar restricción de clave foránea
ALTER TABLE empleado ADD CONSTRAINT FK_Empleado_Contacto FOREIGN KEY (id_contacto) REFERENCES contacto (id_contacto);
ALTER TABLE empleado ADD CONSTRAINT FK_Empleado_Jefe FOREIGN KEY (codigo_jefe) REFERENCES empleado (codigo_empleado);

-- Modificación de la tabla pedido para agregar restricción de clave foránea
ALTER TABLE pedido ADD CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente);
ALTER TABLE pedido ADD CONSTRAINT FK_Pedido_Estado FOREIGN KEY (id_estado) REFERENCES estado (id_estado);

-- Modificación de la tabla detalle_pedido para agregar restricción de clave foránea
ALTER TABLE detalle_pedido ADD CONSTRAINT FK_Detalle_Pedido_Producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto);
ALTER TABLE detalle_pedido ADD CONSTRAINT FK_Detalle_Pedido_Pedido FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido);

-- Modificación de la tabla pago para agregar restricción de clave foránea
ALTER TABLE pago ADD CONSTRAINT FK_Pago_Pedido FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido);


-- Inserción de datos para la tabla estado
INSERT INTO estado (id_estado, nombre_estado) VALUES
(1, 'Activo'),
(5, 'En espera de pago'),
(10, 'Completado');

-- Inserción de datos para la tabla contacto
INSERT INTO contacto (id_contacto, telefono, fax, extension, email) VALUES
(1, '+34 123 456 789', '+34 987 654 321', NULL, 'info@empresa.com'),
(2, '+33 1 23 45 67 89', NULL, NULL, 'info@entreprise.fr'),
(3, '+49 89 12345678', '+49 89 98765432', NULL, 'info@unternehmen.de');

-- Inserción de datos para la tabla dimensiones
INSERT INTO dimensiones (id_dimensiones, alto, ancho, largo, peso) VALUES
(1, 10.5, 5.2, 8.3, 1.5),
(2, 15.0, 7.8, 12.1, 2.8),
(3, 20.2, 10.6, 18.4, 4.2);

-- Inserción de datos para la tabla proveedor
INSERT INTO proveedor (id_proveedor, nombre, apellido1, apellido2, nombre_empresa, ubicacion) VALUES
(1, 'Juan', 'García', 'Pérez', 'Proveedor 1', 'Sevilla'),
(2, 'Marie', 'Dupont', NULL, 'Fournisseur 2', 'París'),
(3, 'Klaus', 'Schmidt', NULL, 'Lieferant 3', 'Múnich');

-- Inserción de datos para la tabla stock
INSERT INTO stock (id_stock, stock_maximo, stock_minimo, stock_actual) VALUES
(1, 200, 50, 150),
(2, 150, 30, 75),
(3, 200, 40, 160);

-- Inserción de datos para la tabla gama_producto
INSERT INTO gama_producto (id_gama, descripcion_text, descripcion_html, imagen) VALUES
('Ornamentales', 'Productos ornamentales para decoración.', '<p>Productos ornamentales para decoración.</p>', 'ornamentales.jpg'),
('Frutales', 'Productos frutales frescos y deliciosos.', '<p>Productos frutales frescos y deliciosos.</p>', 'frutales.jpg'),
('Electrodomésticos', 'Electrodomésticos para el hogar.', '<p>Electrodomésticos para el hogar.</p>', 'electrodomesticos.jpg');

-- Inserción de datos para la tabla producto
INSERT INTO producto (id_producto, nombre, id_gama, id_dimensiones, id_proveedor, descripcion, id_stock, precio_venta) VALUES
('PROD1', 'Planta Ornamental', 'Ornamentales', 1, 1, 'Planta ornamental de interior.', 1, 15.99),
('PROD2', 'Manzana', 'Frutales', 2, 2, 'Manzana fresca de temporada.', 2, 0.75),
('PROD3', 'Nevera', 'Electrodomésticos', 3, 3, 'Nevera de gran capacidad.', 3, 599.99),
('OR4', 'Florero Ornamental', 'Ornamentales', 3, 3, 'Florero ornamental de cristal.', 1, 29.99),
('OR5', 'Orquídea', 'Ornamentales', 1, 1, 'Orquídea tropical de colores vivos.', 1, 39.99);

-- Inserción de datos para la tabla pais
INSERT INTO pais (id_pais, nombre_pais) VALUES
(1, 'España'),
(2, 'Francia'),
(3, 'Alemania');

-- Inserción de datos para la tabla region
INSERT INTO region (id_region, nombre, id_pais) VALUES
(1, 'Andalucía', 1),
(2, 'Île-de-France', 2),
(3, 'Baviera', 3);

-- Inserción de datos para la tabla ciudad
INSERT INTO ciudad (id_ciudad, nombre_ciudad, id_region) VALUES
(1, 'Fuenlabrada', 1),
(2, 'París', 2),
(3, 'Madrid', 3);

-- Inserción de datos para la tabla ubicacion
INSERT INTO ubicacion (id_ubicacion, id_ciudad, linea_direccion1, linea_direccion2, codigo_postal) VALUES
(1, 1, 'Calle Principal 123', 'Edificio A', '41001'),
(2, 2, 'Avenue des Champs-Élysées 456', 'Apartamento 2B', '75008'),
(3, 3, 'Hauptstraße 789', NULL, '80331');

-- Inserción de datos para la tabla oficina
INSERT INTO oficina (codigo_oficina, codigo_postal, id_contacto, id_ubicacion) VALUES
('OF1', '41001', 1, 1),
('OF2', '75008', 2, 2),
('OF3', '80331', 3, 3);


INSERT INTO credito (id_credito, limite_credito, id_estado) VALUES
(1, 5000.00, 1),
(2, 8000.00, 5),
(3, 10000.00, 10);

-- Inserción de datos para la tabla cliente
INSERT INTO cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, codigo_empleado_rep, id_credito, id_ubicacion) VALUES
(1, 'Pedro', 'Contacto 1', 'Apellido 1', NULL, 1, 1),
(2, 'Martha', 'Contacto 2', 'Santos 2', 2, 2, 2),
(3, 'Sara', 'Contacto 3', 'Apellido 3', NULL, 3, 3),
(100, 'Juan Jose', 'Contacto', 'Basto', 1, 1, 1),
(101, 'Anatulia', 'Contacto Nuevo', 'Apellido Nuevo', 2, 2, 2);

-- Inserción de datos para la tabla cliente_direccion
INSERT INTO cliente_direccion (codigo_cliente, id_contacto, id_ubicacion) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Inserción de datos para la tabla empleado
INSERT INTO empleado (codigo_empleado, nombre, apellido1, apellido2, codigo_oficina, codigo_jefe, puesto, email, id_contacto, nombre_jefe_del_jefe) VALUES
(1, 'Antonia', 'Juarez', NULL, NULL, NULL, 'Representante de Ventas', 'empleado1@empresa.com', 1, 'Juan'),
(2, 'Juan', 'Perez', 'Mantila', 'OF2', 1, 'Jefe', 'JuanMantilla@empresa.com', 2, 'Antonia'),
(3, 'María', 'González', 'Martínez', 'OF3', 1, 'Asistente Administrativo', 'empleado3@empresa.com', 3, 'Alberto Soria');

-- Inserción de datos para la tabla pedido
INSERT INTO pedido (id_pedido, fecha_pedido, fecha_esperada, fecha_entrega, id_estado, comentarios, codigo_cliente, metodo_pago) VALUES
(1, '2008-04-19', '2024-01-25', '2024-01-25', 1, 'Coment 1', 1, 'Tarjeta de crédito'),
(5, '2008-04-19', '2010-04-25', '2010-04-26', 5, 'Comentario 5', 1, 'Paypal'),
(7, '2008-04-19', '2010-04-25', '2010-04-27', 5, 'Comentario 7', 1, 'Transferencia bancaria'),
(9, '2008-04-19', '2010-04-25', '2010-04-28', 5, 'Comentario 9', 1, 'Efectivo'),
(2, '2009-04-18', '2009-04-24', '2009-04-24', 10, 'Coment 2', 2, 'Cheque'),
(6, '2008-06-15', '2008-07-01', '2008-07-02', 1, 'Comentario 6', 2, 'Paypal'),
(8, '2008-07-20', '2008-08-05', '2008-08-06', 1, 'Comentario 8', 3, 'Paypal'),
(11, '2024-04-18', '2024-04-20', '2024-04-18', 1, 'Nuevo pedido', 2, 'Tarjeta de crédito'),
(3, '2008-04-17', '2024-01-23', '2024-04-20', 1, 'Comentario 3', 3, 'Transferencia bancaria'),
(10, '2024-04-20', '2024-04-20', '2024-04-20', 1, 'Pedido finalizado', 1, 'Tarjeta de crédito');

-- Inserción de datos para la tabla detalle_pedido
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, numero_linea, precio_unitario) VALUES
(1, 'PROD1', 2, 1, 15.99),
(5, 'PROD2', 5, 1, 0.75),
(7, 'PROD3', 1, 1, 599.99),
(9, 'OR4', 3, 1, 3000.00),
(2, NULL, 2, 1, 19.99);

-- Inserción de datos para la tabla pago
INSERT INTO pago (id_pago, fecha_pago, monto, id_pedido) VALUES
(1, '2024-04-22', 100.00, 2),
(2, '2024-04-25', 50.00, 5),
(3, '2024-04-26', 75.00, 7),
(4, '2024-04-27', 120.00, 9),
(5, '2024-04-24', 200.00, 11),
(6, '2024-04-19', 150.00, 10),
(7, '2024-04-20', 0.00, 12),
(8, '2024-04-21', 0.00, 13);








