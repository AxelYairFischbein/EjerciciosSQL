CREATE FUNCTION dbo.ResumenFacturacionClientes (
 @FechaDesde DATE,
 @FechaHasta DATE
)
RETURNS @Resultado TABLE (
 ID_Cliente INT,
 NombreCliente VARCHAR(100),
 MontoFacturado DECIMAL(12,2),
 CategoriaCliente VARCHAR(20)
)
AS
BEGIN
 IF @FechaDesde > @FechaHasta
 BEGIN
 RETURN;
 END;
 INSERT INTO @Resultado (
 ID_Cliente,
 NombreCliente,
 MontoFacturado,
 CategoriaCliente
 )
 SELECT
 C.ID_Cliente,
 C.NombreCliente,
 COALESCE(SUM(DV.Cantidad * DV.PrecioUnitario), 0) AS MontoFacturado,
 'Pendiente' AS CategoriaCliente
 FROM Clientes C
 LEFT JOIN Ventas V
 ON C.ID_Cliente = V.ID_Cliente
 AND V.Fecha >= @FechaDesde
 AND V.Fecha <= @FechaHasta
 LEFT JOIN DetalleVentas DV
 ON V.ID_Venta = DV.ID_Venta
 GROUP BY
 C.ID_Cliente,
 C.NombreCliente;
 UPDATE @Resultado
 SET CategoriaCliente =
 CASE
 WHEN MontoFacturado = 0 THEN 'Sin ventas'
 WHEN MontoFacturado <= 100000 THEN 'Bajo'
 WHEN MontoFacturado <= 500000 THEN 'Medio'
 ELSE 'Alto'
 END;
 RETURN;
END;

SELECT *
FROM dbo.ResumenFacturacionClientes('2026-01-01', '2026-12-31');