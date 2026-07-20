SELECT
 C.NombreCliente,
 SUM(P.ImporteTotal) AS TotalComprado
FROM Clientes C
INNER JOIN Pedidos P ON C.ID_Cliente = P.ID_Cliente
GROUP BY C.NombreCliente
HAVING SUM(P.ImporteTotal) > (
 SELECT AVG(TotalPorCliente)
 FROM (
 SELECT ID_Cliente, SUM(ImporteTotal) AS TotalPorCliente
 FROM Pedidos
 GROUP BY ID_Cliente
 ) AS Totales
);
