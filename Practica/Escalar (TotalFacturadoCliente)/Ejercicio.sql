CREATE FUNCTION dbo.TotalFacturadoCliente (
 @ID_Cliente INT
)
RETURNS DECIMAL(12,2)
AS
BEGIN
 DECLARE @Total DECIMAL(12,2);
 SELECT
 @Total = COALESCE(SUM(DV.Cantidad * DV.PrecioUnitario), 0)
 FROM Ventas V
 INNER JOIN DetalleVentas DV
 ON V.ID_Venta = DV.ID_Venta
 WHERE V.ID_Cliente = @ID_Cliente;
 RETURN @Total;
END;
Consulta de prueba:
SELECT dbo.TotalFacturadoCliente(1) AS TotalFacturado;