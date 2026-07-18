USE Empresa;
GO

CREATE TABLE PERSONA (
    IdPersona INT PRIMARY KEY,
    Nombre NVARCHAR(50),
);
GO

INSERT INTO PERSONA (IdPersona, Nombre)
VALUES 
(1, 'Ana'),
(2, 'Luis'),
(3, 'Carlos'),
(4, 'Marta'),
(5, 'Pedro'),
(6, 'Juan'),
(7, 'Lucía'),
(8, 'Elena');

DROP TABLE PERSONA;