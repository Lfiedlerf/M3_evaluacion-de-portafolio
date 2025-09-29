-- 1. Productos disponibles
SELECT * FROM productos WHERE cantidad_inventario > 0;

-- 2. Proveedores de un producto específico (por ejemplo, producto con ID = 2)
SELECT DISTINCT p.nombre
FROM proveedores p
JOIN transacciones t ON p.id_proveedor = t.id_proveedor
WHERE t.id_producto = 2;

-- 3. Transacciones en fecha específica
SELECT * FROM transacciones WHERE fecha = '2025-07-20';

-- 4. Total de productos vendidos (agrupados)
SELECT id_producto, SUM(cantidad) AS total_vendido
FROM transacciones
WHERE tipo = 'venta'
GROUP BY id_producto;
