-- PRIMER COMMIT
-- Crear la base de datos
CREATE DATABASE M3_EVMOD;
USE M3_EVMOD;

-- Crear tabla de productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    cantidad_inventario INT NOT NULL CHECK (cantidad_inventario >= 0)
);

-- Crear tabla de proveedores
CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- Crear tabla de transacciones
CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('compra', 'venta') NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    id_producto INT,
    id_proveedor INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Insertar proveedores
INSERT INTO proveedores (nombre, direccion, telefono, email)
VALUES 
('MundoTech', 'Av. Américo Vespucio 123', '+56945678901', 'hola@mundotech.com'),
('ConnectStore', 'Avenida Providencia 234', '+56956789012', 'info@connectstore.cl');

-- Insertar productos
INSERT INTO productos (nombre, descripcion, precio, cantidad_inventario)
VALUES 
('Laptop', 'Laptop 14 pulgadas entry', 459990, 15),
('Mouse', 'Mouse óptico USB básico', 8990, 100),
('Teclado', 'Teclado mecánico', 59990, 50),
('Cámara web', 'Cámara web HD y bluetooth', 19990, 25);

-- Insertar transacciones 
INSERT INTO transacciones (tipo, fecha, cantidad, id_producto, id_proveedor) 
VALUES  
('compra', '2025-07-15', 10, 1, 1), 
('venta', '2025-07-20', 2, 1, 1), 
('compra', '2025-07-25', 50, 2, 2), 
('venta', '2025-07-28', 5, 2, 2), 
('compra', '2025-08-01', 100, 4, 1), 
('venta', '2025-08-05', 50, 4, 1);

-- Consultas de prueba
SELECT * FROM productos;
SELECT * FROM proveedores;
SELECT * FROM transacciones;

-- SEGUNDO COMMIT
-- Consultas SQL solicitadas en la evaluación
-- 1era | Productos disponibles
SELECT * FROM productos WHERE cantidad_inventario > 0;
-- 2da | Proveedores de un producto específico
SELECT DISTINCT p.nombre
FROM proveedores p
JOIN transacciones t ON p.id_proveedor = t.id_proveedor
WHERE t.id_producto = 2;
-- 3era | Transacciones por fecha
SELECT * FROM transacciones WHERE fecha = '2025-07-20';
-- 4ta | Total de productos vendidos
SELECT id_producto, SUM(cantidad) AS total_vendido
FROM transacciones
WHERE tipo = 'venta'
GROUP BY id_producto;

-- TRANSACCIÓN
START TRANSACTION;
UPDATE productos
SET cantidad_inventario = cantidad_inventario - 3
WHERE id_producto = 3;

INSERT INTO transacciones (tipo, fecha, cantidad, id_producto, id_proveedor)
VALUES ('venta', CURDATE(), 3, 3, 1);

COMMIT;