USE Empresa;
GO

-- Paso 5: Índices
CREATE INDEX IX_Empleados_Nombre ON RecursosHumanos.Empleados(Nombre);
CREATE INDEX IX_Empleados_Salario ON RecursosHumanos.Empleados(Salario);
GO

-- Paso 6: Restricciones
ALTER TABLE RecursosHumanos.Empleados
ADD CONSTRAINT CK_Empleados_Salario CHECK (Salario >= 1000);

ALTER TABLE RecursosHumanos.Hijos
ALTER COLUMN NombreHijo NVARCHAR(50) NOT NULL;
GO

-- Paso 7: Agregar columna
ALTER TABLE RecursosHumanos.Empleados
ADD FechaContratacion DATE;
GO

-- Paso 8: Eliminar columna y tabla
ALTER TABLE RecursosHumanos.Empleados
DROP COLUMN FechaContratacion;

DROP TABLE RecursosHumanos.Estudios;
GO

-- Paso 9: Recrear Estudios asociada a Empleados
CREATE TABLE RecursosHumanos.Estudios (
    IdEstudio INT PRIMARY KEY,
    Descripcion NVARCHAR(100),
    IdEmpleado INT FOREIGN KEY REFERENCES RecursosHumanos.Empleados(IdEmpleado)
);
GO