/* ============================================================
   Procedimiento: sp_TransferirSaldo
   Objetivo: Transferir un monto entre dos cuentas validando saldo.
   Técnica:  Transacción + TRY...CATCH + RAISERROR con mensaje custom.
   ============================================================ */

CREATE OR ALTER PROCEDURE sp_TransferirSaldo
    @Origen  INT,
    @Destino INT,
    @Monto   DECIMAL(18,2)
AS
BEGIN TRY
    BEGIN TRAN;

    DECLARE @SaldoOrigen DECIMAL(18,2);

    SELECT @SaldoOrigen = Saldo
    FROM Cuentas
    WHERE ID_Cuenta = @Origen;

    IF @SaldoOrigen < @Monto
        RAISERROR('Saldo insuficiente en la cuenta origen.', 16, 1);

    UPDATE Cuentas SET Saldo = Saldo - @Monto WHERE ID_Cuenta = @Origen;
    UPDATE Cuentas SET Saldo = Saldo + @Monto WHERE ID_Cuenta = @Destino;

    COMMIT TRAN;
    SELECT 'Transferencia realizada correctamente' AS Mensaje;
END TRY
BEGIN CATCH
    ROLLBACK TRAN;
    SELECT 'Error: ' + ERROR_MESSAGE() AS Mensaje;
END CATCH;
GO


-- Ejemplo de ejecución
EXEC sp_TransferirSaldo
    @Origen  = 1,
    @Destino = 2,
    @Monto   = 15000;
