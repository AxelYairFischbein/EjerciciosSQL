/* ============================================================
   Ejercicio 4 – Función escalar con lógica condicional
   Objetivo: Clasificar al cliente en Bronce / Plata / Oro según
             su total de compras.
   Técnica:  Función escalar con expresión CASE.
   ============================================================ */

CREATE OR ALTER FUNCTION fn_CalcularCategoriaCliente(@TotalCompras DECIMAL(10, 2))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Categoria VARCHAR(20);

    SET @Categoria =
        CASE
            WHEN @TotalCompras < 10000                        THEN 'Bronce'
            WHEN @TotalCompras BETWEEN 10000 AND 50000        THEN 'Plata'
            ELSE 'Oro'
        END;

    RETURN @Categoria;
END;
GO


-- Consulta de prueba
SELECT
    dbo.fn_CalcularCategoriaCliente(5000)  AS Cat_Bronce,
    dbo.fn_CalcularCategoriaCliente(30000) AS Cat_Plata,
    dbo.fn_CalcularCategoriaCliente(80000) AS Cat_Oro;
