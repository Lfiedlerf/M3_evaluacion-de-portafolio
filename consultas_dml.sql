-- INSERTAR nuevo producto
INSERT INTO productos (nombre, descripcion, precio, cantidad_inventario)
VALUES ('Impresora', 'Impresora láser multifuncional', 79990, 30);

-- ACTUALIZAR dirección de un proveedor
UPDATE proveedores
SET direccion = 'Calle Nueva 123, Santiago'
WHERE id_proveedor = 1;

-- ELIMINAR transacción ficticia (ejemplo: ID inexistente)
DELETE FROM transacciones
WHERE id_transaccion = 999;