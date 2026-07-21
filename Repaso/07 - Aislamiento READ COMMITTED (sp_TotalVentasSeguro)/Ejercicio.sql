/* ============================================================
   Procedimiento: sp_TotalVentasSeguro
   Objetivo: Calcular el total de ventas evitando lecturas sucias.
   Técnica:  SET TRANSACTION ISOLATION LEVEL READ COMMITTED.
   ============================================================ */

CREATE OR ALTER PROCEDURE sp_TotalVentasSeguro
AS
BEGIN
    SET NOCOUNT ON;

    -- Evita lecturas sucias (no lee datos no confirmados)
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    DECLARE @Total DECIMAL(18,2);

    SELECT @Total = SUM(Importe)
    FROM Ventas;

    SELECT 'Total de ventas (sin lecturas sucias): '
           + CAST(@Total AS VARCHAR(50)) AS Mensaje;
END;
GO


-- Ejemplo de ejecución
EXEC sp_TotalVentasSeguro;
