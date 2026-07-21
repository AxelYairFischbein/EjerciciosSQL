/* ============================================================
   Consulta: Jerarquía de empleados con nivel
   Objetivo: Listar cada empleado con su nivel jerárquico
             (1 = jefe máximo).
   Técnica:  CTE recursiva (caso base + UNION ALL recursivo).
   ============================================================ */

WITH Jerarquia AS (
    -- Caso base: el jefe máximo (sin jefe asignado)
    SELECT
        ID,
        Nombre,
        ID_Jefe,
        1 AS Nivel
    FROM Empleados
    WHERE ID_Jefe IS NULL

    UNION ALL

    -- Paso recursivo: empleados que dependen del nivel anterior
    SELECT
        e.ID,
        e.Nombre,
        e.ID_Jefe,
        j.Nivel + 1
    FROM Empleados e
        INNER JOIN Jerarquia j
            ON e.ID_Jefe = j.ID
)
SELECT *
FROM Jerarquia
ORDER BY Nivel, Nombre;
