/* ============================================================
   Función: ProductosSobrePromedioVendido
   Objetivo: Devolver los productos cuyo monto total vendido
             supera el promedio de ventas de todos los productos.
   Técnica:  CTE (Common Table Expressions)
   ============================================================ */

CREATE FUNCTION dbo.ProductosSobrePromedioVendido()
RETURNS @Resultado TABLE (
    ID_Producto        INT,
    NombreProducto     VARCHAR(100),
    MontoTotalVendido  DECIMAL(12,2)
)
AS
BEGIN

    -- 1) Monto total vendido por cada producto
    ;WITH TotalesPorProducto AS (
        SELECT
            P.ID_Producto,
            P.NombreProducto,
            SUM(DV.Cantidad * DV.PrecioUnitario) AS MontoTotalVendido
        FROM Productos P
            INNER JOIN DetalleVentas DV
                ON P.ID_Producto = DV.ID_Producto
        GROUP BY
            P.ID_Producto,
            P.NombreProducto
    ),

    -- 2) Promedio general de los montos calculados arriba
    PromedioGeneral AS (
        SELECT
            AVG(MontoTotalVendido) AS PromedioVendido
        FROM TotalesPorProducto
    )

    -- 3) Insertar solo los productos por encima del promedio
    INSERT INTO @Resultado (
        ID_Producto,
        NombreProducto,
        MontoTotalVendido
    )
    SELECT
        T.ID_Producto,
        T.NombreProducto,
        T.MontoTotalVendido
    FROM TotalesPorProducto T
        CROSS JOIN PromedioGeneral P
    WHERE T.MontoTotalVendido > P.PromedioVendido;

    RETURN;
END;
GO


SELECT *
FROM dbo.ProductosSobrePromedioVendido();
