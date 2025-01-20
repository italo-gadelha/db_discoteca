-- REMOVE ACENTO    
DELIMITER $$
CREATE FUNCTION fn_acento (texto VARCHAR (50))
RETURNS VARCHAR (50)
READS SQL DATA 
	BEGIN
	SET texto = REPLACE(texto, 'á', 'a'), 
    texto = REPLACE(texto, 'à', 'a'),
	texto = REPLACE(texto, 'ã', 'a'),
    texto = REPLACE(texto, 'â', 'a'),
    texto = REPLACE(texto, 'Á', 'A'),
    texto = REPLACE(texto, 'À', 'A'),
    texto = REPLACE(texto, 'Ã', 'A'),
    texto = REPLACE(texto, 'Â', 'A'),
    texto = REPLACE(texto, 'é', 'e'),
    texto = REPLACE(texto, 'ê', 'e'),
    texto = REPLACE(texto, 'É', 'E'),
    texto = REPLACE(texto, 'Ê', 'E'),
    texto = REPLACE(texto, 'í', 'i'),
    texto = REPLACE(texto, 'Í', 'I'),
    texto = REPLACE(texto, 'ó', 'o'),
    texto = REPLACE(texto, 'ô', 'o'),
    texto = REPLACE(texto, 'õ', 'o'),
    texto = REPLACE(texto, 'Ó', 'O'),
    texto = REPLACE(texto, 'Ô', 'O'),
    texto = REPLACE(texto, 'Õ', 'O'),
    texto = REPLACE(texto, 'ú', 'u'),
    texto = REPLACE(texto, 'Ú', 'U');
	RETURN texto;
END $$
DELIMITER ;