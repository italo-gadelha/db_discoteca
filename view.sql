-- VIEWS 

-- vw_gravadora - deve conter id, nome e total de discos

CREATE VIEW vw_gravadora AS
SELECT g.id_gravadora, g.nome, COUNT(d.id_disco) discos FROM disco d
JOIN gravadora g
	ON g.id_gravadora = d.id_gravadora
GROUP BY g.nome;


SELECT * FROM vw_gravadora;

-- vw_disco - deve conter todos os dados do disco, porem as fks devem ser substituidas pelo nome do item que a mesma representa.
SELECT * FROM disco;

CREATE VIEW vw_disco AS
SELECT d.id_disco, d.titulo_disco, d.tempo_disco, d.ano_lancamento, a.nome Artista, g.nome Gravadora, s.nome Genero FROM disco d
JOIN gravadora g
	ON g.id_gravadora = d.id_gravadora
JOIN artista a
	ON a.id_artista = d.id_artista
JOIN genero s
	ON s.id_genero = d.id_genero;

SELECT * FROM vw_disco;


-- vw_artista - deve conter id, nome completo, total de discos
SELECT * FROM artista;

CREATE VIEW vw_artista AS
SELECT a.id_artista,nome, COUNT(d.id_disco) Discos FROM artista a
LEFT JOIN disco d
	ON d.id_artista = a.id_artista
GROUP BY a.id_artista;

SELECT * FROM vw_artista;

-- vw_musicas - deve conter nome da musica, duração, o disco e o artista.
SELECT * FROM musica;

CREATE VIEW vw_musicas AS
SELECT m.nome Musica, m.tempo_musica, d.titulo_disco, a.nome Artista FROM musica m
JOIN disco d
	ON d.id_disco = m.id_disco
JOIN artista a
	ON a.id_artista = d.id_disco;
    
SELECT * FROM vw_musicas;