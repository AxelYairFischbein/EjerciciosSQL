CREATE FUNCTION dbo.ProductosSobrePromedioVendido()
RETURNS @Resultado TABLE (
 ID_Producto INT,
 NombreProducto VARCHAR(100),
 MontoTotalVendido DECIMAL(12,2)
)
AS
BEGIN
 ;WITH TotalesPorProducto AS (
 SELECT
 P.ID_Producto,
 P.NombreProducto,
 SUM(DV.Cantidad * DV.PrecioUnitario) AS MontoTotalVendido
 FROM Productos P
 INNER JOIN DetalleVentas DV
 ON P.ID_Producto = DV.ID_Producto
 GROUP BY
 P.ID_Producto,
 P.NombreProducto
 ),
 PromedioGeneral AS (
 SELECT
 AVG(MontoTotalVendido) AS PromedioVendido
 FROM TotalesPorProducto
 )
 INSERT INTO @Resultado (
 ID_Producto,
 NombreProducto,
 MontoTotalVendido
 )
 SELECT
 T.ID_Producto,
 T.NombreProducto,
 T.MontoTotalVendido
 FROM TotalesPorProducto T
 CROSS JOIN PromedioGeneral P
 WHERE T.MontoTotalVendido > P.PromedioVendido;
 RETURN;
END;
Consulta de prueba:
SELECT *
FROM dbo.ProductosSobrePromedioVendido();