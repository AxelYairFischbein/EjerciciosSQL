CREATE OR ALTER FUNCTION fn_MozoMayorFacturacion()
RETURNS @Resultado TABLE (
 ID_Mozo INT,
 Nombre NVARCHAR(100),
 Apellido NVARCHAR(100),
 TotalFacturado DECIMAL(18, 2)
)
AS
BEGIN
 -- CTE para calcular el total facturado por cada mozo
 WITH TotalesMozo AS (
 SELECT
 M.ID_Mozo,
 M.Nombre,
 M.Apellido,
SUM(F.Importe) AS TotalFacturado
 FROM Mozos M
JOIN Facturas F ON M.ID_Mozo = F.ID_Mozo
 GROUP BY M.ID_Mozo, M.Nombre, M.Apellido
 )
 -- Insertar solo el primero ordenado descendentemente
 INSERT INTO @Resultado
 SELECT TOP 1 *
 FROM TotalesMozo
 ORDER BY TotalFacturado DESC;
 RETURN;
END;