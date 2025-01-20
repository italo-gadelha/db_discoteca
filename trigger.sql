DELIMITER //
CREATE TRIGGER tr_calculate_total_time AFTER INSERT ON musica
FOR EACH ROW
BEGIN
    UPDATE disco 
    SET tempo_disco = (SELECT SUM(tempo_musica) FROM musica WHERE id_disco = NEW.id_disco) 
    WHERE id_disco = NEW.id_disco;
END //
DELIMITER ;