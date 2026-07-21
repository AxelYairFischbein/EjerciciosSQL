-- 1. Crear la base
CREATE DATABASE TiendaGuitarras;
GO

-- Cambiar a la base recién creada
USE TiendaGuitarras;
GO

-- 2. Crear tablas
CREATE TABLE marcas (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE guitarras (
    id INT IDENTITY(1,1) PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    marca_id INT FOREIGN KEY REFERENCES marcas(id),
    precio DECIMAL(10,2),
    stock INT DEFAULT 0
);

-- 3. Insertar datos
INSERT INTO marcas (nombre) VALUES
('Gibson'),
('Fender'),
('Epiphone'),
('Ibanez');

INSERT INTO guitarras (modelo, marca_id, precio, stock) VALUES
('Les Paul Standard', 1, 2800.00, 3),
('Stratocaster Player', 2, 850.00, 5),
('Les Paul Custom', 3, 650.00, 8),
('Telecaster', 2, 900.00, 2),
('RG550', 4, 1100.00, 0);