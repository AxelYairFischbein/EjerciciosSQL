/* ============================================================
   Consulta: Productos que nunca fueron vendidos
   Técnica:  Subconsulta correlacionada con NOT EXISTS.
   ============================================================ */

SELECT
    p.ID_Producto,
    p.Nombre
FROM Productos p
WHERE NOT EXISTS (
    SELECT 1
    FROM Ventas v
    WHERE v.ID_Producto = p.ID_Producto
);
