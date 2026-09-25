USE AkirasBoutiques;
GO

-- 1. La cantidad de clientes en el año 2021 (en base a fecha de factura)
SELECT COUNT(DISTINCT Id_Cliente) AS Clientes_2021
FROM Factura
WHERE YEAR(Fecha) = 2021;

-- 2. La cantidad de clientes en lo que va del año 2022
SELECT COUNT(DISTINCT Id_Cliente) AS Clientes_2022
FROM Factura
WHERE YEAR(Fecha) = 2022;

-- 3. Los clientes que tuvieron en diciembre de 2021
SELECT c.Id_Cliente, c.Nombre, c.Apellido, f.Fecha
FROM Cliente c
JOIN Factura f ON c.Id_Cliente = f.Id_Cliente
WHERE YEAR(f.Fecha) = 2021 AND MONTH(f.Fecha) = 12;

-- 4. ¿Qué compras han realizado algunos clientes en específico?
SELECT CONCAT (c.Nombre, ' ' ,c.Apellido) AS Cliente, p.Nombre AS Producto, d.Cantidad, d.Precio, f.Fecha
FROM Cliente c
JOIN Factura f ON c.Id_Cliente = f.Id_Cliente
JOIN Detalle d ON f.Id_Detalle = d.Id_Detalle
JOIN Producto p ON d.Id_Producto = p.Id_Producto
WHERE CONCAT (c.Nombre, ' ' ,c.Apellido) IN (
'Valentina Anastasia Huerta Corral',
'Zayra Manuela Gómez López',
'Dante Eduardo Dolores Meza',
'Ana Maribel Cedillo Núñez',
'Rodrigo Ismael Silva Ugarte'
);

-- 5. ¿Qué producto es el que más ventas ha tenido?
SELECT TOP 1 CAST(p.Nombre AS VARCHAR(100)) AS Nombre, SUM(d.Cantidad) AS Total_Vendido
FROM Detalle d
JOIN Producto p ON d.Id_Producto = p.Id_Producto
GROUP BY CAST(p.Nombre AS VARCHAR(100))
ORDER BY Total_Vendido DESC;

-- 6. ¿Qué producto tiene más cantidad en stock?
SELECT TOP 1 Nombre, Stock FROM Producto ORDER BY Stock DESC;

-- 7. Ordenar por fecha las compras que ha habido en la tienda (antigua a más reciente)
SELECT f.Id_Factura, c.Nombre, f.Fecha
FROM Factura f
JOIN Cliente c ON f.Id_Cliente = c.Id_Cliente
ORDER BY f.Fecha ASC;

-- 8. Ordenar alfabéticamente los nombres de los clientes
SELECT * FROM Cliente ORDER BY CAST(Nombre AS VARCHAR(100)) ASC;

-- 9. Seleccionar cuántos productos hay en cada categoría
SELECT CAST(cat.Nombre AS VARCHAR(100)) AS Categoria, COUNT(p.Id_Producto) AS Total_Productos
FROM Categoria cat
LEFT JOIN Producto p ON cat.Id_Categoria = p.Id_Categoria
GROUP BY CAST(cat.Nombre AS VARCHAR(100));

-- 10. ¿Cuáles son los encargados en cada sucursal de Akira's Boutique?
SELECT Id_Sucursal, Nombre_Sucursal, Encargado, Ciudad FROM Sucursales;

-- 11. ¿Cuáles son los empleados que trabajan en la sucursal Constitución?
SELECT e.* 
FROM Empleados e
JOIN Sucursales s ON e.Id_Sucursal = s.Id_Sucursal
WHERE s.Nombre_Sucursal LIKE '%Constitu%';

-- 12. ¿Cuáles clientes son mayores de 30 años?
SELECT Nombre, Apellido, Fec_Nac, DATEDIFF(YEAR, Fec_Nac, GETDATE()) AS Edad
FROM Cliente
WHERE DATEDIFF(YEAR, Fec_Nac, GETDATE()) > 30; 