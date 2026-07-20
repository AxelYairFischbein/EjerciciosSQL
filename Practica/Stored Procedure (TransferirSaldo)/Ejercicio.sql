CREATE PROCEDURE dbo.TransferirSaldo
 @CuentaOrigen INT,
 @CuentaDestino INT,
 @Monto DECIMAL(12,2)
AS
BEGIN
 BEGIN TRY
 BEGIN TRAN;
 IF NOT EXISTS (
 SELECT 1
 FROM Cuentas
 WHERE ID_Cuenta = @CuentaOrigen
 )
 BEGIN
 ROLLBACK TRAN;
 THROW 50001, 'La cuenta origen no existe.', 1;
 END;
 IF NOT EXISTS (
 SELECT 1
 FROM Cuentas
 WHERE ID_Cuenta = @CuentaDestino
 )
 BEGIN
 ROLLBACK TRAN;
 THROW 50002, 'La cuenta destino no existe.', 1;
 END;
 IF @CuentaOrigen = @CuentaDestino
 BEGIN
 ROLLBACK TRAN;
 THROW 50003, 'La cuenta origen y destino no pueden ser la misma.', 1;
 END;
 IF @Monto <= 0
 BEGIN
 ROLLBACK TRAN;
 THROW 50004, 'El monto debe ser mayor que cero.', 1;
 END;
 IF EXISTS (
 SELECT 1
 FROM Cuentas
 WHERE ID_Cuenta = @CuentaOrigen
 AND Saldo < @Monto
 )
 BEGIN
 ROLLBACK TRAN;
 THROW 50005, 'Saldo insuficiente.', 1;
 END;
 UPDATE Cuentas
 SET Saldo = Saldo - @Monto
 WHERE ID_Cuenta = @CuentaOrigen;
 UPDATE Cuentas
 SET Saldo = Saldo + @Monto
 WHERE ID_Cuenta = @CuentaDestino;
 COMMIT TRAN;
 END TRY
 BEGIN CATCH
 IF @@TRANCOUNT > 0
 ROLLBACK TRAN;
 THROW;
 END CATCH
END;

EXEC dbo.TransferirSaldo
 @CuentaOrigen = 1,
 @CuentaDestino = 2,
 @Monto = 15