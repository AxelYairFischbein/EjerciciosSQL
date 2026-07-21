/* ============================================================
   Ejercicio 2 – Subconsulta anidada y funciones agregadas
   Objetivo: Clientes cuyo total comprado supera el promedio
             de los totales por cliente.
   Técnica:  GROUP BY + HAVING con subconsulta anidada (AVG).
   ============================================================ */

SELECT
    C.NombreCliente,
    SUM(P.ImporteTotal) AS TotalComprado
FROM Clientes C
    INNER JOIN Pedidos P
        ON C.ID_Cliente = P.ID_Cliente
GROUP BY C.NombreCliente
-- Compara el total del cliente contra el promedio de los totales por cliente
HAVING SUM(P.ImporteTotal) > (
    SELECT AVG(TotalPorCliente)
    FROM (
        SELECT ID_Cliente, SUM(ImporteTotal) AS TotalPorCliente
        FROM Pedidos
        GROUP BY ID_Cliente
    ) AS Totales
);
