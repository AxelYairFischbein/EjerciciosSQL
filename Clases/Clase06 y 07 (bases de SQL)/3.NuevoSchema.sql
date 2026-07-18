USE Empresa;
GO

/* ============================
   2. Crear un nuevo esquema
   ============================ */

CREATE SCHEMA Proyectos;
GO

/* ============================
   3. Crear tablas en el nuevo esquema
   ============================ */

CREATE TABLE Proyectos.Proyecto (
    IdProyecto INT PRIMARY KEY,
    NombreProyecto NVARCHAR(100) NOT NULL,
    Presupuesto DECIMAL(12,2) NOT NULL
);

CREATE TABLE Proyectos.Asignacion (
    IdAsignacion INT PRIMARY KEY,
    IdEmpleado INT NOT NULL,
    IdProyecto INT NOT NULL,
    Rol NVARCHAR(50),
    FOREIGN KEY (IdEmpleado) REFERENCES RecursosHumanos.Empleados(IdEmpleado),
    FOREIGN KEY (IdProyecto) REFERENCES Proyectos.Proyecto(IdProyecto)
);

-- Insertar datos en Proyecto
INSERT INTO Proyectos.Proyecto (IdProyecto, NombreProyecto, Presupuesto)
VALUES
(1, 'Implementación CRM', 100000),
(2, 'Migración SAP', 200000),
(3, 'Campaña Publicitaria', 50000);

-- Insertar datos en Asignacion
INSERT INTO Proyectos.Asignacion (IdAsignacion, IdEmpleado, IdProyecto, Rol)
VALUES
(1, 7, 1, 'Líder Técnico'),
(2, 8, 2, 'Gerente Proyecto'),
(3, 3, 3, 'Analista de Marketing'),
(4, 2, 3, 'Ejecutivo Comercial');