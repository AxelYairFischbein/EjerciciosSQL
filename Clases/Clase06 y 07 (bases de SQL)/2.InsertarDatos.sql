-- Clase07 Ejercicio Subconsultas y Operadores
-- Usar la base de datos creada en la Clase 06
USE Empresa;
GO

/* ============================
   1. Insertar datos en esquema RecursosHumanos
   ============================ */

-- Departamentos
INSERT INTO RecursosHumanos.Departamento (IdDepartamento, NombreDepartamento)
VALUES 
(1, 'Sistemas'),
(2, 'RRHH'),
(3, 'Ventas'),
(4, 'Marketing'),
(5, 'Finanzas');

-- Categorías
INSERT INTO RecursosHumanos.Categoria (IdCategoria, NombreCategoria)
VALUES
(1, 'Analista'),
(2, 'Jefe'),
(3, 'Junior'),
(4, 'SemiSenior'),
(5, 'Senior'),
(6, 'Gerente');

-- Empleados
INSERT INTO RecursosHumanos.Empleados (IdEmpleado, Nombre, Salario, IdDepartamento, IdCategoria)
VALUES
(1, 'Ana', 3000, 3, 1),
(2, 'Luis', 3500, 3, 2),
(3, 'Carlos', 4000, 4, 5),
(4, 'Marta', 4500, 4, 6),
(5, 'Pedro', 2500, 5, 1),
(6, 'Juan', 2800, 5, 2),
(7, 'Lucía', 3200, 2, 5),
(8, 'Elena', 5000, 2, 6);

-- Hijos
INSERT INTO RecursosHumanos.Hijos (IdHijo, IdEmpleado, NombreHijo, FechaNacimiento)
VALUES
(1, 2, 'Tomás', '2012-09-20'),
(2, 4, 'Valentina', '2018-11-05'),
(3, 6, 'Mateo', '2020-01-15');

-- Estudios
INSERT INTO RecursosHumanos.Estudios (IdEstudio, Descripcion, IdEmpleado)
VALUES
(1, 'Licenciatura en Administración', 1),
(2, 'MBA', 4),
(3, 'Ingeniería en Sistemas', 7),
(4, 'Contador Público', 5);

-- Estructura
INSERT INTO RecursosHumanos.Estructura (IdEstructura, Descripcion)
VALUES
(1, 'Planta Permanente'),
(2, 'Planta Permanente'),
(3, 'Contrato Temporal'),
(4, 'Outsourcing');

GO