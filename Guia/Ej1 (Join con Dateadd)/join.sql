SELECT  
    P.NombreProducto, 
    C.NombreCategoria, 
    SUM(V.Cantidad) AS TotalVendida 
FROM Ventas V 
INNER JOIN Productos P ON V.ID_Producto = P.ID_Producto 
INNER JOIN Categorias C ON P.ID_Categoria = C.ID_Categoria 
--DATEADD(unidad, cantidad, fecha)
WHERE V.FechaVenta >= DATEADD(MONTH, -1, GETDATE()) 
GROUP BY P.NombreProducto, C.NombreCategoria 
HAVING SUM(V.Cantidad) > 20; 