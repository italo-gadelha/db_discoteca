-- INSERTS
-- sp_insert_gravadora
DELIMITER //
CREATE PROCEDURE sp_insert_gravadora(dado VARCHAR(20))
BEGIN
	INSERT INTO gravadora (nome) VALUES (fn_acento(dado));
END //
DELIMITER ;

CALL sp_insert_gravadora('áÁáãÂ');
SELECT * FROM gravadora;

-- sp_insert_genero
DELIMITER //
CREATE PROCEDURE sp_insert_genero(dado VARCHAR(20))
BEGIN
	INSERT INTO genero (nome) VALUES (fn_acento(dado));
END //
DELIMITER ;


-- sp_insert_artista
DELIMITER //
CREATE PROCEDURE sp_insert_artista (
    IN nome_in VARCHAR(20),
    IN dt_nascimento_in DATE
)
BEGIN
    DECLARE idade INT;
    -- Calcula a idade com base na data de nascimento
    SET idade = TIMESTAMPDIFF(YEAR, dt_nascimento_in, CURDATE());
    
    -- Verifica se o nome não é nulo ou vazio e se a data de nascimento não é nula
    IF (nome_in IS NOT NULL AND CHAR_LENGTH(nome_in) > 0 AND dt_nascimento_in IS NOT NULL) THEN
        IF idade >= 12 THEN
            INSERT INTO artista (nome, dt_nascimento)
            VALUES (fn_acento(nome_in), dt_nascimento_in);
        ELSE
            SELECT 'Idade mínima do artista é 12 anos.' AS mensagem;
        END IF;
    ELSE
        SELECT 'Erro, dados inválidos: Nome ou data de nascimento estão incorretos.' AS mensagem;
    END IF;
END //
DELIMITER ;
CALL sp_insert_artista('Alô','2005-08-11');
SELECT * FROM artista;


-- DELETE
-- sp_delete_artista

DELIMITER //
CREATE PROCEDURE sp_delete_artista(IN artista_id INT)
BEGIN
DELETE FROM artista WHERE id_artista = artista_id;
END //
DELIMITER ;
SELECT * FROM artista;
CALL sp_delete_artista('21');

-- sp_delete_genero
DELIMITER //
CREATE PROCEDURE sp_delete_genero(IN genero_id INT)
BEGIN
DELETE FROM genero WHERE id_genero = genero_id;
END //
DELIMITER ;

-- sp_delete_gravadora
DELIMITER //
CREATE PROCEDURE sp_delete_gravadora(IN gravadora_id INT)
BEGIN
DELETE FROM gravadora WHERE id_gravadora = gravadora_id;
END //
DELIMITER ;

-- sp_delete_disco
DELIMITER //
CREATE PROCEDURE sp_delete_disco(IN disco_id INT)
BEGIN
DELETE FROM disco WHERE id_disco = disco_id;
END //
DELIMITER ;

-- sp_delete_musica
DELIMITER //
CREATE PROCEDURE sp_delete_musica(IN musica_id INT)
BEGIN
DELETE FROM musica WHERE id_musica = musica_id;
END //
DELIMITER ;

-- UPDATE
DELIMITER //
CREATE PROCEDURE sp_update_artista(
IN id_artista INT,
IN nome VARCHAR(20),
IN dt_nascimento DATE
)
BEGIN
DECLARE strError VARCHAR(255);
-- Verifica se os parâmetros são válidos e não nulos
IF (nome REGEXP '[0-9]' OR nome = '') THEN
    SET strError = 'O nome do artista é inválido.';
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = strError;
END IF;

IF (dt_nascimento IS NULL) THEN
    SET strError = 'A data de nascimento do artista não pode ser nula.';
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = strError;
END IF;

-- Verifica se o artista com o id informado existe na tabela
IF (NOT EXISTS (SELECT * FROM artista WHERE id_artista = id_artista)) THEN
    SET strError = CONCAT('O artista com o id ', id_artista, ' não existe na tabela.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = strError;
END IF;

-- Atualiza as informações do artista com os novos valores
UPDATE artista SET nome = nome, dt_nascimento = dt_nascimento WHERE id_artista = id_artista;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_disco(
  IN p_id_disco INT,
  IN p_titulo_disco VARCHAR(100),
  IN p_tempo_disco TIME,
  IN p_ano_lancamento DATE,
  IN p_id_artista INT,
  IN p_id_gravadora INT,
  IN p_id_genero INT
)
BEGIN
  DECLARE v_num_rows INT;
  DECLARE v_total_tempo TIME;
  
  SELECT COUNT(*) INTO v_num_rows FROM disco WHERE id_disco = p_id_disco;
  
  IF v_num_rows = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Disco não encontrado.';
  ELSEIF p_titulo_disco REGEXP '[0-9]' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O título do disco não pode conter números.';
  ELSEIF p_ano_lancamento >= CURRENT_DATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A data de lançamento não pode ser igual ou posterior à data atual.';
  ELSE
    SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(tempo_musica))) INTO v_total_tempo FROM musica WHERE id_disco = p_id_disco;
    
    IF v_total_tempo <> p_tempo_disco THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O tempo total do disco deve ser igual à soma dos tempos das músicas.';
    ELSE
      UPDATE disco SET titulo_disco = p_titulo_disco, tempo_disco = p_tempo_disco, ano_lancamento = p_ano_lancamento, id_artista = p_id_artista, id_gravadora = p_id_gravadora, id_genero = p_id_genero WHERE id_disco = p_id_disco;
    END IF;
  END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_genero(
    IN p_id_genero INT,
    IN p_nome_genero VARCHAR(20)
)
BEGIN
    IF p_nome_genero REGEXP '^[a-zA-Z]+$' THEN
        UPDATE genero SET nome = p_nome_genero
        WHERE id_genero = p_id_genero;
        SELECT 'Dados atualizados com sucesso!';
    ELSE
        SELECT 'Erro: Dados inválidos!';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_update_gravadora(
  IN p_id_gravadora INT,
  IN p_nome_gravadora VARCHAR(100)
)
BEGIN
  DECLARE v_num_rows INT;
  
  SELECT COUNT(*) INTO v_num_rows FROM gravadora WHERE id_gravadora = p_id_gravadora;

IF v_num_rows = 0 THEN
	SELECT 'Gravadora não encontrada' AS error;
ELSEIF p_nome_gravadora REGEXP '^[a-zA-ZÀ-ÿ]+[a-zA-ZÀ-ÿ\s]*$' = 0 THEN
	SELECT 'Nome da gravadora inválido' AS error;
ELSE
	UPDATE gravadora SET nome = p_nome_gravadora WHERE id_gravadora = p_id_gravadora;
	SELECT 'Gravadora atualizada com sucesso' AS success;
END IF;

END//

DELIMITER ;