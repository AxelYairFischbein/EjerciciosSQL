/* ============================================================
   Ejercicio 5 – Creación de vista con filtros
   Objetivo: Mostrar nombre y email de los clientes que hicieron
             al menos un pedido durante 2024.
   Técnica:  CREATE VIEW con INNER JOIN, DISTINCT y YEAR().
   ============================================================ */

CREATE OR ALTER VIEW vw_ClientesActivos2024
AS
SELECT DISTINCT
    C.NombreCliente,
    C.Email
FROM Clientes C
    INNER JOIN Pedidos P
        ON C.ID_Cliente = P.ID_Cliente
-- Solo pedidos cuyo año sea 2024
WHERE YEAR(P.FechaPedido) = 2024;
GO


-- Consulta de prueba
SELECT *
FROM vw_ClientesActivos2024;
