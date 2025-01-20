# db_discoteca

## Sobre o Projeto
Este projeto é um banco de dados que tem como objetivo gerir as informações de uma gravadora. As informações são organizadas em tabelas que representam as principais entidades do negócio.
____________________________________________
Abaixo você encontrá uma breve apresentação do banco.

# MODELO CONCEITUAL

![Conceitual](https://user-images.githubusercontent.com/86980974/212477679-22a8521a-9e19-4968-81c8-2b80ce0fbe93.PNG)


# MODELO LOGICO  

![db_discoteca](https://user-images.githubusercontent.com/86980974/212477764-7b61d409-4274-4bce-9dd4-0003df84c580.png)


_______________________________________________

# ESTRUTURA DO BANCO DE DADOS 
			
![image](https://user-images.githubusercontent.com/86980974/212478469-4c9bb88a-4682-4470-86ae-6b8720ecfa46.png)

_______________________________________________

# As principais tabelas do banco são:

- `Tabela 1`: artista: tabela que contém as informações dos artistas contratados pela gravadora, como nome, nacionalidade, data de nascimento, entre outros.
- `Tabela 2`: disco: tabela que contém as informações dos discos produzidos pela gravadora, como título, tempo total, ano de lançamento, entre outros.
- `Tabela 3`: gravadora: tabela que contém as informações da própria gravadora, como nome, país de origem, data de fundação, entre outros.
- `Tabela 4`: genero: tabela que contém as informações dos gêneros musicais, como nome e descrição.
- `Tabela 5`: musica: tabela que contém as informações das músicas, como título, tempo, letra, entre outros.

# Funtion:
`Function 1`: fn_acento: remove os acentos das palavras quando chamado. 

# Views:
- `View 1`: vw_gravadora: Contém id, nome e total de discos.
- `View 2`: vw_disco: Contém todos os dados do disco, com as foreign_key substituidas pelo nome do item que a mesma representa.
- `View 3`: vw_artista: Contém id, nome completo, total de discos.
- `View 4`: vw_musicas:  Contém nome da musica, duração, o disco e o artista.

# Procedures:
### Procedures de INSERT
- `Procedure 1`: sp_insert_artista: Insere um novo artista na tabela tb_artista, verificando se os dados de entrada (nome, ano_nascimento) são válidos. Caso não sejam, a procedure não realiza a inserção e retorna uma mensagem de erro.
- `Procedure 2`: sp_insert_disco: Insere um novo disco na tabela tb_disco, verificando se os dados de entrada (titulo_disco, tempo_disco, ano_lancamento, id_artista, id_gravadora, id_genero) são válidos e não nulos. Para garantir que o tempo total do disco seja a soma do tempo das músicas que o compõem, a procedure realiza uma soma do tempo das músicas com o mesmo id_disco do disco a ser inserido e compara com o valor passado como parâmetro. Caso os dados de entrada não sejam válidos, a procedure não realiza a inserção e retorna uma mensagem de erro.
- `Procedure 3`: sp_insert_gravadora: Insere uma nova gravadora na tabela tb_gravadora, verificando se os dados de entrada (nome_gravadora, id_pais) são válidos e não nulos. Caso não sejam, a procedure não realiza a inserção e retorna uma mensagem de erro.
- `Procedure 4`: sp_insert_genero: Insere um novo gênero musical na tabela tb_genero, verificando se os dados de entrada (nome_genero) são válidos e não nulos. Caso não sejam, a procedure não realiza a inserção e retorna uma mensagem de erro.
- `Procedure 5`: sp_insert_musica: Insere uma nova música na tabela tb_musica, verificando se os dados de entrada (nome_musica, tempo_musica, id_disco) são válidos e não nulos. Caso não sejam, a procedure não realiza a inserção e retorna uma mensagem de erro.
### Procedures de DELETE
- `Procedure 6`: sp_delete_artista: Deleta um artista da tabela artista, pelo o id do artista.
- `Procedure 7`: sp_delete_gravadora: Deleta uma gravadora da tabela gravadora, pelo o id da gravadora.
- `Procedure 8`: sp_delete_genero: Deleta um gênero da tabela tb_genero, verificando se o id do gênero é válido.
- `Procedure 9`: sp_delete_disco: Deleta um disco da tabela tb_disco, verificando se o id do disco é válido e não nulo. Caso não seja, a procedure não realiza a exclusão e retorna uma mensagem de erro.
- `Procedure 10`: sp_delete_musica: Deleta uma música da tabela tb_musica, verificando se o id da música é válido e não nulo. Caso não seja, a procedure não realiza a exclusão e retorna uma mensagem de erro.
### Procedures de UPDATE
- `Procedure 11`: sp_update_artista: Atualiza as informações de um artista na tabela tb_artista. Verifica se os dados de entrada (nome_artista, ano_nascimento, id_pais) são válidos e não nulos. Impede a inserção de caracteres numéricos no nome do artista e garante que as datas sejam inseridas corretamente.
- `Procedure 12`: sp_update_disco: Atualiza as informações de um disco na tabela tb_disco. Verifica se os dados de entrada (titulo_disco, tempo_disco, ano_lancamento, id_artista, id_gravadora, id_genero) são válidos e não nulos. Impede a inserção de caracteres numéricos no título do disco e garante que o tempo total do disco seja a soma do tempo das músicas que o compõem.
- `Procedure 13`: sp_update_genero: Atualiza as informações de um gênero na tabela tb_genero. Verifica se os dados de entrada (nome_genero) são válidos e não nulos. Impede a inserção de caracteres numéricos no nome do gênero.
- `Procedure 14`: sp_update_gravadora: Atualiza as informações de uma gravadora na tabela tb_gravadora. Verifica se os dados de entrada (nome_gravadora) são válidos e não nulos. Impede a inserção de caracteres numéricos no nome da gravadora.
- `Procedure 15`: sp_update_musica: Atualiza as informações de uma música na tabela tb_musica. Verifica se os dados de entrada (titulo_musica, duracao_musica, id_disco, id_genero) são válidos e não nulos. Impede a inserção de caracteres numéricos no título da música e garante que a duração da música seja inserida corretamente.

# Trigger:

- `Trigger`: trigger_insert_tb_musica: Atua sobre a tabela 'musica', executando uma série de ações quando uma nova linha é inserida na tabela. A trigger atualiza o campo tempo_disco na tabela 'disco', somando o tempo da nova música inserida ao tempo já existente do disco. Além disso, a trigger verifica se o tempo total do disco após a inserção da nova música é menor ou igual a 80 minutos. Caso ultrapasse esse limite, a trigger remove a última música inserida e atualiza novamente o campo tempo_disco na tabela tb_disco. Isso garante que o tempo total do disco nunca ultrapasse o limite de 80 minutos.

______________________________________________

# Tecnologias Utilizadas
O banco de dados foi desenvolvido utilizando o sistema de gerenciamento de banco de dados MySQL. Para criar as procedures, foram utilizadas a linguagem SQL e as sintaxes específicas do MySQL.
