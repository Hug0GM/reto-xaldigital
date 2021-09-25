

/*
Consulta para obtener el aeropuerto con mayor número de vuelos durante el año.
Si se quiere obtener el número de vuelos para un año distinto a 2021, 
es necesario cambiar en la linea "WHERE A.ANO = '2021'" 2021 por cualquier
otro año.
*/
SELECT NOMBRE_AEROPUERTO AS 'AEROPUERTOS CON MÁS MOVIMIENTOS DURANTE EL AÑO 2021'
FROM aeropuertos
WHERE ID_AEROPUERTO IN (
    SELECT A.ID_AEROPUERTO
    FROM (
        SELECT ID_AEROPUERTO, COUNT(ID_AEROPUERTO) AS VUELOS, DATE_FORMAT(DIA, '%Y') AS ANO
        FROM vuelos
        GROUP BY ID_AEROPUERTO, DATE_FORMAT(DIA, '%Y')
    ) A
    WHERE A.ANO = '2021' 
    AND A.VUELOS = (
        SELECT MAX(M.VUELOS)
        FROM (
            SELECT ID_AEROPUERTO, COUNT(ID_AEROPUERTO) AS VUELOS, DATE_FORMAT(DIA, '%Y') AS ANO
            FROM vuelos
            GROUP BY ID_AEROPUERTO, DATE_FORMAT(DIA, '%Y')
        ) M
        WHERE M.ANO = '2021'
    )
);



/*
Consulta para obtener la aerolínea con mayor número de vuelos durante el año.
Si se quiere obtener el número de vuelos para un año distinto a 2021, 
es necesario cambiar en la linea "WHERE A.ANO = '2021'" 2021 por cualquier
otro año.
*/
SELECT NOMBRE_AEROLINEA AS 'AEROLÍNEAS CON MAYOR NÜMERO DE VUELOS DURANTE 2021'
FROM aerolineas
WHERE ID_AEROLINEA IN (
    SELECT V.ID_AEROLINEA
    FROM (
        SELECT ID_AEROLINEA, COUNT(ID_AEROLINEA) AS VUELOS, DATE_FORMAT(DIA, '%Y') as ANO
        FROM vuelos
        GROUP BY ID_AEROLINEA, DATE_FORMAT(DIA, '%Y')
    ) V
    WHERE V.ANO = '2021'
    AND V.VUELOS = (
        SELECT MAX(MOVS.VUELOS)
        FROM (
            SELECT ID_AEROLINEA, COUNT(ID_AEROLINEA) AS VUELOS, DATE_FORMAT(DIA, '%Y') as ANO
            FROM vuelos
            GROUP BY ID_AEROLINEA, DATE_FORMAT(DIA, '%Y')
        ) MOVS
        WHERE MOVS.ANO = '2021'
    )
);

/*
Consulta para obtener el día con el mayor número de vuelos.
*/
SELECT M.FECHA AS 'DIA DE MAYOR NÚMERO DE VUELOS'
FROM (
    SELECT DATE_FORMAT(DIA, '%b %d %Y') AS FECHA, COUNT(DATE_FORMAT(DIA, '%d')) AS VUELOS
	FROM vuelos
	GROUP BY DATE_FORMAT(DIA, '%d'),DATE_FORMAT(DIA, '%b %d %Y')
) M
WHERE M.VUELOS = (
    SELECT MAX(V.VUELOS)
    FROM (
        SELECT DATE_FORMAT(DIA, '%b %d %Y') AS FECHA, COUNT(DATE_FORMAT(DIA, '%d')) AS VUELOS
        FROM vuelos
        GROUP BY DATE_FORMAT(DIA, '%d'),DATE_FORMAT(DIA, '%b %d %Y')
    ) V
);


/*
Consulta para obtener las aerolíneas con más de dos vuelos por día.
*/
SELECT NOMBRE_AEROLINEA AS 'AEROLÍNEAS CON MÁS DE DOS VUELOS POR DÍA'
FROM aerolineas
WHERE ID_AEROLINEA IN (
SELECT V.ID_AEROLINEA 
FROM (
	SELECT ID_AEROLINEA, COUNT(DATE_FORMAT(DIA, '%d')) AS VUELOS, DIA
    FROM vuelos
    GROUP BY ID_AEROLINEA, DIA
) V
WHERE V.VUELOS > 2
);