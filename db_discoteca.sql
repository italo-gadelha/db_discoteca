CREATE DATABASE db_discoteca CHARSET utf8mb4 COLLATE utf8mb4_general_ci;
USE db_discoteca;

CREATE TABLE IF NOT EXISTS gravadora (
	id_gravadora INT NOT NUll,
    nome VARCHAR(20) NOT NULL,
PRIMARY KEY (id_gravadora)
);
CREATE TABLE IF NOT EXISTS artista (
	id_artista INT NOT NUll,
    nome VARCHAR(50) NOT NULL,
    dt_nascimento DATE,
PRIMARY KEY (id_artista)
);
CREATE TABLE IF NOT EXISTS genero (
	id_genero INT NOT NUll,
    nome VARCHAR(20),
PRIMARY KEY (id_genero)
);
CREATE TABLE IF NOT EXISTS disco (
	id_disco INT NOT NULL,
    titulo_disco INT NOT NULL,
    tempo_disco FLOAT NOT NULL,
    ano_lancamento YEAR NOT NULL,
    id_artista INT NOT NULL,
    id_gravadora INT NOT NULL,
    id_genero INT NOT NULL,
PRIMARY KEY (id_disco),
CONSTRAINT fk_id_artista FOREIGN KEY (id_artista) REFERENCES artista (id_artista),
CONSTRAINT fk_id_gravadora FOREIGN KEY (id_gravadora) REFERENCES gravadora (id_gravadora),
CONSTRAINT fk_id_genero FOREIGN KEY (id_genero) REFERENCES genero (id_genero)
);

CREATE TABLE IF NOT EXISTS musica (
	id_musica INT NOT NUll,
    nome VARCHAR(50) NOT NULL,
    tempo_musica FLOAT,
    id_disco INT NOT NULL,
PRIMARY KEY (id_musica),
CONSTRAINT fk_id_disco FOREIGN KEY (id_disco) REFERENCES disco (id_disco)
);


-- INCREMENT PARA ARTISTA

ALTER TABLE disco
DROP CONSTRAINT fk_id_artista;

ALTER TABLE artista
MODIFY id_artista INT NOT NULL AUTO_INCREMENT;

ALTER TABLE disco
ADD CONSTRAINT fk_id_artista FOREIGN KEY (id_artista) REFERENCES artista (id_artista);

-- INCREMENT PARA GENERO

ALTER TABLE disco
DROP CONSTRAINT fk_id_genero;

ALTER TABLE genero
MODIFY id_genero INT NOT NULL AUTO_INCREMENT;

ALTER TABLE disco
MODIFY titulo_disco VARCHAR(40) NOT NULL;

ALTER TABLE disco
ADD CONSTRAINT fk_id_genero FOREIGN KEY (id_genero) REFERENCES genero (id_genero);

-- INCREMENT PARA DISCO

ALTER TABLE musica
DROP CONSTRAINT fk_id_disco;

ALTER TABLE disco
MODIFY id_disco INT NOT NULL AUTO_INCREMENT;

ALTER TABLE musica
ADD CONSTRAINT fk_id_disco FOREIGN KEY (id_disco) REFERENCES disco (id_disco);

-- INCREMENT PARA GRAVADORA

ALTER TABLE gravadora
MODIFY id_gravadora INT NOT NULL AUTO_INCREMENT;
