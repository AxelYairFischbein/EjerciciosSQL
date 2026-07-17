-- Ejercicio 2: Eliminando Database
-- Cambia tu conexión a la base de datos master
-- Para no estar "parado" en la base que querés borrar.
USE master;
GO

-- Pone la base en modo "un solo usuario": desconecta a todos los que estén
-- conectados ya mismo (ROLLBACK IMMEDIATE cancela sus operaciones a medias),
-- para que ninguna conexión bloquee el borrado.
ALTER DATABASE Empresa SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Borra la base de datos completa (tablas, datos y archivos en disco).
DROP DATABASE Empresa;