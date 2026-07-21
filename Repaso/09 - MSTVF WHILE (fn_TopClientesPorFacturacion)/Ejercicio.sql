/* ============================================================
   Función: fn_TopClientesPorFacturacion
   Objetivo: Devolver los clientes cuya facturación total supera
             un mínimo recibido por parámetro.
   Técnica:  MSTVF (Multi-Statement TVF) con bucle WHILE.
   ============================================================ */

CREATE OR ALTER FUNCTION fn_TopClientesPorFacturacion (@Minimo DECIMAL(18,2))
RETURNS @Resultado TABLE (
    ID_Cliente     INT,
    Nombre         NVARCHAR(100),
    TotalFacturado DECIMAL(18,2)
)
AS
BEGIN
    DECLARE @ID    INT = 1;
    DECLARE @MaxID INT = (SELECT MAX(ID_Cliente) FROM Clientes);

    WHILE @ID <= @MaxID
    BEGIN
        IF EXISTS (SELECT 1 FROM Clientes WHERE ID_Cliente = @ID)
        BEGIN
            DECLARE @Total DECIMAL(18,2);

            SELECT @Total = SUM(Importe)
            FROM Facturas
            WHERE ID_Cliente = @ID;

            IF @Total >= @Minimo
            BEGIN
                INSERT INTO @Resultado
                SELECT ID_Cliente, Nombre, @Total
                FROM Clientes
                WHERE ID_Cliente = @ID;
            END
        END

        SET @ID += 1;
    END

    RETURN;
END;
GO


-- Consulta de prueba
SELECT *
FROM fn_TopClientesPorFacturacion(100000);
