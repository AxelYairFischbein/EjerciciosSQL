/* ============================================================
   Función: fn_VentasPorCliente
   Objetivo: Devolver el total facturado de un cliente puntual.
   Técnica:  ITVF (Inline Table-Valued Function), sin BEGIN/END.
   ============================================================ */

CREATE OR ALTER FUNCTION fn_VentasPorCliente (@ClienteID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        c.ID_Cliente,
        c.Nombre,
        SUM(f.Importe) AS TotalFacturado
    FROM Clientes c
        INNER JOIN Facturas f
            ON c.ID_Cliente = f.ID_Cliente
    WHERE c.ID_Cliente = @ClienteID
    GROUP BY
        c.ID_Cliente,
        c.Nombre
);
GO


-- Consulta de prueba
SELECT *
FROM fn_VentasPorCliente(1);
