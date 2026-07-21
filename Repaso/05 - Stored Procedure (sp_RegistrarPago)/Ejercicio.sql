/* ============================================================
   Procedimiento: sp_RegistrarPago
   Objetivo: Registrar un pago y descontar la deuda del cliente
             dentro de una transacción con manejo de errores.
   Técnica:  BEGIN TRAN / COMMIT / ROLLBACK + TRY...CATCH.
   ============================================================ */

CREATE OR ALTER PROCEDURE sp_RegistrarPago
    @ID_Cliente INT,
    @Importe    DECIMAL(10,2)
AS
BEGIN TRY
    BEGIN TRAN;

    INSERT INTO Pagos (ID_Cliente, Importe, Fecha)
    VALUES (@ID_Cliente, @Importe, GETDATE());

    UPDATE Clientes
    SET Deuda = Deuda - @Importe
    WHERE ID_Cliente = @ID_Cliente;

    COMMIT TRAN;
    SELECT 'Pago registrado correctamente' AS Mensaje;
END TRY
BEGIN CATCH
    ROLLBACK TRAN;
    SELECT 'Error al registrar el pago: ' + ERROR_MESSAGE() AS Mensaje;
END CATCH;
GO


-- Ejemplo de ejecución
EXEC sp_RegistrarPago
    @ID_Cliente = 1,
    @Importe    = 5000;
