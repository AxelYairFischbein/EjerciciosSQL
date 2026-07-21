/* ============================================================
   Consulta: Productos por encima del precio promedio global
   Técnica:  Subconsulta escalar en el WHERE con AVG().
   ============================================================ */

SELECT
    p.ID_Producto,
    p.Nombre,
    p.Precio
FROM Productos p
WHERE p.Precio > (
    SELECT AVG(Precio)
    FROM Productos
);
