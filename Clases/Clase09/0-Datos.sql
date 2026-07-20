
-- CREACIÓN DE TABLAS PARA LA TAREA DE JOINs (Clase 08)
IF DB_ID('TareaJoin') IS NULL
    CREATE DATABASE TareaJoin;
GO
USE TareaJoin;
GO

-- Tabla C09Clientes
CREATE TABLE C09Clientes (
    ID_Cliente INT PRIMARY KEY,
    NombreCliente VARCHAR(100),
    Ciudad VARCHAR(100)
);

-- Tabla C09Sucursales
CREATE TABLE C09Sucursales (
    ID_Sucursal INT PRIMARY KEY,
    NombreSucursal VARCHAR(100),
    Ciudad VARCHAR(100)
);

-- Tabla C09Productos
CREATE TABLE C09Productos (
    ID_Producto INT PRIMARY KEY,
    NombreProducto VARCHAR(100),
    PrecioUnitario DECIMAL(10, 2)
);

-- Tabla C09Pedidos (Cabecera)
CREATE TABLE C09Pedidos (
    ID_Pedido INT PRIMARY KEY,
    FechaPedido DATE,
    ID_Cliente INT,
    ID_Sucursal INT,
    FOREIGN KEY (ID_Cliente) REFERENCES C09Clientes(ID_Cliente),
    FOREIGN KEY (ID_Sucursal) REFERENCES C09Sucursales(ID_Sucursal)
);

-- Tabla DetalleC09Pedidos
CREATE TABLE DetalleC09Pedidos (
    ID_Detalle INT PRIMARY KEY,
    ID_Pedido INT,
    ID_Producto INT,
    Cantidad INT,
    PrecioUnitario DECIMAL(10, 2),
    FOREIGN KEY (ID_Pedido) REFERENCES C09Pedidos(ID_Pedido),
    FOREIGN KEY (ID_Producto) REFERENCES C09Productos(ID_Producto)
);

-- Insertar datos en las tablas:
-- Insertar datos en C09Clientes
INSERT INTO C09Clientes (ID_Cliente, NombreCliente, Ciudad) VALUES
(1, 'Juan Pérez', 'Buenos Aires'),
(2, 'María García', 'Córdoba'),
(3, 'Pedro Gómez', 'Rosario');

INSERT INTO C09Clientes (ID_Cliente, NombreCliente, Ciudad) VALUES
(4, 'Carlos Rodriguez', 'Buenos Aires');

INSERT INTO C09Clientes (ID_Cliente, NombreCliente, Ciudad) VALUES
(5, 'Andres Riccard', 'Rio Negro');

-- Insertar datos en C09Sucursales
INSERT INTO C09Sucursales (ID_Sucursal, NombreSucursal, Ciudad) VALUES
(1, 'Sucursal Centro', 'Buenos Aires'),
(2, 'Sucursal Norte', 'Córdoba'),
(3, 'Sucursal Sur', 'Mendoza');

INSERT INTO C09Sucursales (ID_Sucursal, NombreSucursal, Ciudad) VALUES
(4, 'Sucursal Centro', 'Santa Fe'),
(5, 'Sucursal Norte', 'La Pampa');

-- Insertar datos en C09Productos
INSERT INTO C09Productos (ID_Producto, NombreProducto, PrecioUnitario) VALUES
(1, 'Smartphone', 500),
(2, 'Laptop', 1000),
(3, 'Tablet', 300);

-- Insertar datos en C09Pedidos
INSERT INTO C09Pedidos (ID_Pedido, FechaPedido, ID_Cliente, ID_Sucursal) VALUES
(1, '2024-10-01', 1, 1),
(2, '2024-10-02', 2, 2),
(3, '2024-10-03', 3, 3);

-- Insertar datos en DetalleC09Pedidos
INSERT INTO DetalleC09Pedidos (ID_Detalle, ID_Pedido, ID_Producto, Cantidad, PrecioUnitario) VALUES
(1, 1, 1, 2, 500),  -- Juan compró 2 Smartphones
(2, 2, 2, 1, 1000), -- María compró 1 Laptop
(3, 3, 3, 3, 300);  -- Pedro compró 3 Tablets