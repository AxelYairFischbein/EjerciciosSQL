CREATE FUNCTION dbo.ClientesSinVentasCreditoAlto()
RETURNS TABLE
AS

RETURN
(
 SELECT
 C.ID_Cliente,
 C.NombreCliente,
 C.LimiteCredito
 FROM Clientes C
 WHERE NOT EXISTS (
 SELECT 1
 FROM Ventas V
 WHERE V.ID_Cliente = C.ID_Cliente
 )
 AND C.LimiteCredito > (
 SELECT AVG(LimiteCredito)
 FROM Clientes
 )
);
--Consulta de prueba:
SELECT *
FROM dbo.ClientesSinVentasCreditoAlto();
