/* ============================================================
   Ejercicio 3 – Procedimiento almacenado con validación
   Objetivo: Registrar un nuevo pedido validando que el cliente exista.
   Técnica:  IF NOT EXISTS + RAISERROR + INSERT.
   ============================================================ */

CREATE OR ALTER PROCEDURE sp_RegistrarNuevoPedido
    @ID_Cliente   INT,
    @FechaPedido  DATE,
    @ImporteTotal DECIMAL(10, 2)
AS
BEGIN
    -- 1) Validar que el cliente exista; si no, cancelar
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE ID_Cliente = @ID_Cliente)
    BEGIN
        RAISERROR('El cliente no existe.', 16, 1);
        RETURN;
    END;

    -- 2) Cliente válido: insertar el pedido
    INSERT INTO Pedidos (ID_Cliente, FechaPedido, ImporteTotal)
    VALUES (@ID_Cliente, @FechaPedido, @ImporteTotal);

    PRINT 'Pedido registrado correctamente.';
END;
GO


-- Ejemplo de ejecución
EXEC sp_RegistrarNuevoPedido
    @ID_Cliente   = 1,
    @FechaPedido  = '2024-05-10',
    @ImporteTotal = 25000;
