
USE Empresa;
GO

-- Primer consulta
-- Crea una vista de la tabla
-- Operador IN: Listar los nombres de empleados que trabajan
-- En los departamentos de “Ventas” o “Marketing”.
CREATE OR ALTER VIEW RecursosHumanos.VistaIn AS
SELECT Nombre
FROM RecursosHumanos.Empleados
WHERE IdDepartamento IN (3, 4); -- 3 = Ventas, 4 = Marketing
GO

-- Segunda consulta
-- Operador ANY: Mostrar empleados cuyo salario sea mayor
-- Que el de al menos un empleado de “Finanzas”.
CREATE OR ALTER VIEW RecursosHumanos.VistaAny AS
SELECT Nombre
FROM RecursosHumanos.Empleados
WHERE Salario > ANY(
    SELECT Salario
    FROM RecursosHumanos.Empleados
    WHERE IdDepartamento = 5);
GO

-- Tercer consulta
-- Operador ALL: Listar empleados cuyo salario supere al de todos los empleados de “Marketing”.
CREATE OR ALTER VIEW RecursosHumanos.VistaAll AS
SELECT Nombre
FROM RecursosHumanos.Empleados
WHERE Salario > ALL(
    SELECT Salario
    FROM RecursosHumanos.Empleados
    WHERE IdDepartamento = 4);
GO

-- Cuarta consulta
-- Operador EXISTS: Listar empleados que participan en al menos un proyecto.
CREATE OR ALTER VIEW RecursosHumanos.VistaExists AS
SELECT Nombre
FROM RecursosHumanos.Empleados AS e
WHERE EXISTS (
    SELECT 1
    FROM Proyectos.Asignacion AS a
    WHERE a.IdEmpleado = e.IdEmpleado
);
GO

-- Quinta consulta
-- Operador NOT EXISTS: Mostrar empleados que no estén asignados a ningún proyecto.
CREATE OR ALTER VIEW RecursosHumanos.VistaNotExists AS
SELECT Nombre
FROM RecursosHumanos.Empleados AS e
WHERE NOT EXISTS (
    SELECT 1
    FROM Proyectos.Asignacion AS a
    WHERE a.IdEmpleado = e.IdEmpleado
);
GO

-- Sexta consulta
-- Operador BETWEEN con subconsulta: Encontrar empleados cuyo salario esté entre el
-- Mínimo y máximo salario de los empleados en “Sistemas”.
CREATE OR ALTER VIEW RecursosHumanos.VistaBetween AS
SELECT Nombre
FROM RecursosHumanos.Empleados
WHERE Salario BETWEEN
    (SELECT MIN(Salario)
     FROM RecursosHumanos.Empleados
     WHERE IdDepartamento = 1) 
    AND
    (SELECT MAX(Salario)
     FROM RecursosHumanos.Empleados
     WHERE IdDepartamento = 1);
GO

-- Ultima consulta
-- Join con el nuevo esquema: Mostrar proyectos con el nombre de sus
-- Empleados asignados y el rol dentro del proyecto.
CREATE OR ALTER VIEW RecursosHumanos.VistaJoin AS
SELECT p.NombreProyecto, e.Nombre AS NombreEmpleado, a.Rol
FROM Proyectos.Proyecto AS p
JOIN Proyectos.Asignacion AS a ON a.IdProyecto = p.IdProyecto
JOIN RecursosHumanos.Empleados AS e ON e.IdEmpleado = a.IdEmpleado;
GO

-- Ver las vistas
--SELECT * FROM RecursosHumanos.VistaIn;
--SELECT * FROM RecursosHumanos.VistaAny;
--SELECT * FROM RecursosHumanos.VistaAll;
--SELECT * FROM RecursosHumanos.VistaExists;
SELECT * FROM RecursosHumanos.VistaNotExists;
--SELECT * FROM RecursosHumanos.VistaBetween;
--SELECT * FROM RecursosHumanos.VistaJoin;
