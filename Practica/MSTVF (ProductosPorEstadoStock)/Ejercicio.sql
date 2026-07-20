CREATE FUNCTION dbo.ProductosPorEstadoStock (
 @StockCritico INT,
 @StockMedio INT
)
RETURNS @Resultado TABLE (
 ID_Producto INT,
 NombreProducto VARCHAR(100),
 Stock INT,
 EstadoStock VARCHAR(20)
)
AS
BEGIN
 IF @StockCritico < 0 OR @StockMedio < @StockCritico
 BEGIN
 RETURN;
 END;
 INSERT INTO @Resultado (
 ID_Producto,
 NombreProducto,
 Stock,
 EstadoStock
 )
 SELECT
 ID_Producto,
 NombreProducto,
 Stock,
 CASE
 WHEN Stock = 0 THEN 'Sin stock'
 WHEN Stock > 0 AND Stock <= @StockCritico THEN 'Crítico'
 WHEN Stock > @StockCritico AND Stock <= @StockMedio THEN 'Medio'
 ELSE 'Normal'
 END AS EstadoStock
 FROM Productos;
 RETURN;
END;

SELECT *
FROM dbo.ProductosPorEstadoStock(5, 20);