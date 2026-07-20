CREATE PROCEDURE dbo.RegistrarVenta
 @ID_Cliente INT,
 @ID_Producto INT,
 @Cantidad INT
AS
BEGIN
 BEGIN TRY
 BEGIN TRAN;
 IF NOT EXISTS (
 SELECT 1
 FROM Clientes
 WHERE ID_Cliente = @ID_Cliente
 )
 BEGIN
 ROLLBACK TRAN;
 THROW 50001, 'El cliente no existe.', 1;
 END;
 IF NOT EXISTS (
 SELECT 1
 FROM Productos
 WHERE ID_Producto = @ID_Producto
 )
 BEGIN
 ROLLBACK TRAN;
 THROW 50002, 'El producto no existe.', 1;
 END;
 IF @Cantidad <= 0
 BEGIN
 ROLLBACK TRAN;
 THROW 50003, 'La cantidad debe ser mayor que cero.', 1;
 END;
 IF EXISTS (
 SELECT 1
 FROM Productos
 WHERE ID_Producto = @ID_Producto
 AND Stock < @Cantidad
 )
 BEGIN
 ROLLBACK TRAN;
 THROW 50004, 'Stock insuficiente.', 1;
 END;
 DECLARE @PrecioUnitario DECIMAL(10,2);
 DECLARE @ID_Venta INT;
 SELECT @PrecioUnitario = Precio
 FROM Productos
 WHERE ID_Producto = @ID_Producto;
 INSERT INTO Ventas (ID_Cliente, Fecha)
 VALUES (@ID_Cliente, GETDATE());
 SET @ID_Venta = SCOPE_IDENTITY();
 INSERT INTO DetalleVentas (
 ID_Venta,
 ID_Producto,
 Cantidad,
 PrecioUnitario
 )
 VALUES (
 @ID_Venta,
 @ID_Producto,
 @Cantidad,
 @PrecioUnitario
 );
 UPDATE Productos
 SET Stock = Stock - @Cantidad
 WHERE ID_Producto = @ID_Producto;
 COMMIT TRAN;
 END TRY
 BEGIN CATCH
 IF @@TRANCOUNT > 0
 ROLLBACK TRAN;
 THROW;
 END CATCH
END;
EXEC dbo.RegistrarVenta
 @ID_Cliente = 1,
 @ID_Producto = 3,
 @Cantidad = 2;