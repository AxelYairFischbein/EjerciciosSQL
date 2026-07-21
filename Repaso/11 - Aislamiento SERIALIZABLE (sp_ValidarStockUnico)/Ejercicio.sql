/* ============================================================
   Procedimiento: sp_ValidarStockUnico
   Objetivo: Insertar un producto solo si no existe otro con el
             mismo nombre, evitando lecturas fantasmas.
   Técnica:  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE.
   ============================================================ */

CREATE OR ALTER PROCEDURE sp_ValidarStockUnico
    @NombreProducto VARCHAR(100),
    @Precio         DECIMAL(10,2)
AS
BEGIN TRY
    -- SERIALIZABLE impide que otra transacción inserte el mismo
    -- producto mientras esta lo está validando (evita phantom reads).
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    BEGIN TRAN;

    IF EXISTS (SELECT 1 FROM Productos WHERE Nombre = @NombreProducto)
    BEGIN
        ROLLBACK TRAN;
        SELECT 'El producto ya existe' AS Mensaje;
        RETURN;
    END

    INSERT INTO Productos (Nombre, Precio)
    VALUES (@NombreProducto, @Precio);

    COMMIT TRAN;
    SELECT 'Producto creado correctamente' AS Mensaje;
END TRY
BEGIN CATCH
    ROLLBACK TRAN;
    SELECT 'Error: ' + ERROR_MESSAGE() AS Mensaje;
END CATCH;
GO


-- Ejemplo de ejecución
EXEC sp_ValidarStockUnico
    @NombreProducto = 'Teclado Mecánico',
    @Precio         = 25000;
