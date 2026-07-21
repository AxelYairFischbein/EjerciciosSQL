/* ============================================================
   Ejercicio 1 – JOIN con condición lógica
   Objetivo: Productos con más de 20 unidades vendidas en el
             último mes, junto con su categoría.
   Técnica:  INNER JOIN + DATEADD/GETDATE + GROUP BY + HAVING.
   ============================================================ */

SELECT
    P.NombreProducto,
    C.NombreCategoria,
    SUM(V.Cantidad) AS TotalVendida
FROM Ventas V
    INNER JOIN Productos P
        ON V.ID_Producto = P.ID_Producto
    INNER JOIN Categorias C
        ON P.ID_Categoria = C.ID_Categoria
-- Solo ventas del último mes (desde hoy hacia atrás 30 días)
WHERE V.FechaVenta >= DATEADD(MONTH, -1, GETDATE())
GROUP BY
    P.NombreProducto,
    C.NombreCategoria
-- Filtra los grupos cuya cantidad total supera 20 unidades
HAVING SUM(V.Cantidad) > 20;
