-- Paso 1: Crear Base de datos "Empresa"
CREATE DATABASE Empresa;
GO

-- Paso 2: Usar la base de datos creada
USE Empresa;
GO

-- Paso 3: Crear esquema
CREATE SCHEMA RecursosHumanos;
GO

-- Paso 4: Crear tablas
CREATE TABLE RecursosHumanos.Departamento (
    IdDepartamento INT PRIMARY KEY,
    NombreDepartamento NVARCHAR(50) NOT NULL
);

CREATE TABLE RecursosHumanos.Categoria (
    IdCategoria INT PRIMARY KEY,
    NombreCategoria NVARCHAR(50) NOT NULL
);

CREATE TABLE RecursosHumanos.Empleados (
    IdEmpleado INT PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Salario DECIMAL(10,2),
    IdDepartamento INT FOREIGN KEY REFERENCES RecursosHumanos.Departamento(IdDepartamento),
    IdCategoria INT FOREIGN KEY REFERENCES RecursosHumanos.Categoria(IdCategoria)
);

CREATE TABLE RecursosHumanos.Hijos (
    IdHijo INT PRIMARY KEY,
    IdEmpleado INT FOREIGN KEY REFERENCES RecursosHumanos.Empleados(IdEmpleado),
    NombreHijo NVARCHAR(50),
    FechaNacimiento DATE
);

CREATE TABLE RecursosHumanos.Estructura (
    IdEstructura INT PRIMARY KEY,
    Descripcion NVARCHAR(100)
);

CREATE TABLE RecursosHumanos.Estudios (
    IdEstudio INT PRIMARY KEY,
    Descripcion NVARCHAR(100)
);
GO