/* ============================================================
   Función: fn_OcupacionPorHabitacion
   Objetivo: Devolver un registro por cada día del rango indicado
             marcando si la habitación tiene o no una reserva válida.
   Técnica:  ITVF (inline) con CTE recursiva para armar el calendario.
   ============================================================ */

IF OBJECT_ID('dbo.fn_OcupacionPorHabitacion', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_OcupacionPorHabitacion;
GO

CREATE FUNCTION dbo.fn_OcupacionPorHabitacion
(
    @ID_Habitacion INT,
    @FechaDesde    DATE,
    @FechaHasta    DATE
)
RETURNS TABLE
AS
RETURN
(
    -- 1) Calendario día por día.
    --    Si @FechaDesde >= @FechaHasta el caso base no genera filas
    --    y la función devuelve la tabla vacía (validación del rango).
    WITH CTE_Calendario AS
    (
        SELECT @FechaDesde AS Fecha
        WHERE @FechaDesde < @FechaHasta

        UNION ALL

        SELECT DATEADD(DAY, 1, Fecha)
        FROM CTE_Calendario
        WHERE DATEADD(DAY, 1, Fecha) < @FechaHasta
    )

    -- 2) Para cada día se evalua si existe una reserva válida.
    SELECT
        C.Fecha,
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM Reservas R
                WHERE R.ID_Habitacion = @ID_Habitacion
                  AND R.Estado IN ('Confirmada', 'Check-In', 'Check-Out')
                  AND C.Fecha >= R.FechaIngreso
                  AND C.Fecha <  R.FechaEgreso   -- egreso exclusivo
            )
            THEN 1
            ELSE 0
        END AS TieneReserva
    FROM CTE_Calendario AS C
);
GO


-- Consulta de prueba
SELECT *
FROM dbo.fn_OcupacionPorHabitacion(101, '2025-01-01', '2025-01-15')
ORDER BY Fecha ASC;
-- Si el rango supera 100 días agregar al final: OPTION (MAXRECURSION 0);
