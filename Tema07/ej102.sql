SELECT NUMPEDIDO, FAB, PRODUCTO, CANT, IMPORTE, IMPORTE/CANT as Precio_Unitario
FROM PEDIDOS
ORDER BY NUMPEDIDO;