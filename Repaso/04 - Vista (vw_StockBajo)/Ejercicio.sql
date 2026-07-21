/* ============================================================
   Vista: vw_StockBajo
   Objetivo: Mostrar los productos con stock menor a 20 unidades
             junto con su categoría.
   Técnica:  CREATE VIEW con INNER JOIN y filtro.
   ============================================================ */

CREATE OR ALTER VIEW vw_StockBajo
AS
SELECT
    p.ID_Producto,
    p.Nombre,
    p.Stock,
    c.NombreCategoria
FROM Productos p
    INNER JOIN Categorias c
        ON p.ID_Categoria = c.ID_Categoria
WHERE p.Stock < 20;
GO


-- Consulta de prueba
SELECT *
FROM vw_StockBajo;
