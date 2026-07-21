CREATE SCHEMA Ventas;
GO
-- Crear la tabla "Clientes" dentro del esquema "Ventas"
CREATE TABLE Ventas.Clientes (
ClienteID INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único de cliente
Nombre NVARCHAR(50) NOT NULL, -- Nombre del cliente
Apellido NVARCHAR(50) NOT NULL, -- Apellido del cliente
Ciudad NVARCHAR(100) NOT NULL -- Ciudad del cliente
);
GO
-- Crear la tabla "Pedidos" dentro del esquema "Ventas"
CREATE TABLE Ventas.Pedidos (
PedidoID INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único del pedido
ClienteID INT NOT NULL, -- Identificador del cliente (clave foránea)
FechaPedido DATE NOT NULL, -- Fecha del pedido
Importe DECIMAL(10, 2) NOT NULL, -- Importe total del pedido
FOREIGN KEY (ClienteID) REFERENCES Ventas.Clientes(ClienteID) -- Relación con la tabla Clientes
);
GO
-- Insertar registros en la tabla "Clientes"
INSERT INTO Ventas.Clientes VALUES
(1, 'Juan', 'Pérez', 'Buenos Aires'),
(2, 'María', 'López', 'Córdoba');
-- Insertar registros en la tabla "Pedidos"
INSERT INTO Ventas.Pedidos VALUES
(1, 1, '2024-11-01', 1500.50),
(2, 2, '2024-11-02', 2000.00),
(3, 1, '2024-11-03', 1800.75),
(4, 2, '2024-11-04', 2200.00),
(5, 1, '2024-11-05', 3000.00);
-- Consultar los clientes con pedidos superiores al promedio de importes
SELECT
 C.Nombre,
 C.Apellido
FROM Ventas.Clientes C
WHERE C.ClienteID IN (
SELECT P.ClienteID
FROM Ventas.Pedidos P
WHERE P.Importe > (
SELECT AVG(Importe)
FROM Ventas.Pedidos
)
);