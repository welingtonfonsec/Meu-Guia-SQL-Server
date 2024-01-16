-- 1. a) Crie um banco de dados chamado BD_Teste.

CREATE DATABASE BD_Teste

--b) Exclua o banco de dados criado no item anterior.

DROP DATABASE BD_Teste

--c) Crie um banco de dados chamado Exercicios.

CREATE DATABASE Exercicios

-- 2. No banco de dados criado no exerc�cio anterior, crie 3 tabelas, cada uma contendo as seguintes colunas:
/*
Tabela 1: dCliente
- ID_Cliente
- Nome_Cliente
- Data_de _Nascimento
Tabela 2: dGerente
- ID_Gerente
- Nome_Gerente
- Data_de_Contratacao
- Salario
Tabela 3: fContratos
- ID_Contrato
- Data_de_Assinatura
- ID_Cliente
- ID_Gerente
- Valor_do_Contrato
Lembre-se dos seguintes pontos:
a) Garantir que o Banco de Dados Exercicios est� selecionado.
b) Definir qual ser� o tipo de dados mais adequado para cada coluna das tabelas. Lembrando que os tipos de dados mais comuns s�o: INT, FLOAT, VARCHAR e DATETIME.
Por fim, fa�a um SELECT para visualizar cada tabela. */

USE Exercicios

--Tabela 1: dCliente
CREATE TABLE dCliente(
	ID_Cliente INT, 
	Nome_Cliente VARCHAR(200), 
	Data_de_Nascimento DATETIME
)

SELECT * FROM dCliente

--Tabela 2: dGerente

CREATE TABLE dGerente(
	ID_Gerente INT, 
	Nome_Gerente VARCHAR(200), 
	Data_de_Contratacao DATETIME,
	Salario FLOAT
)

SELECT * FROM dGerente

--Tabela 3: fContratos

CREATE TABLE fContratos(
	ID_Contrato INT,
	Data_de_Assinatura DATETIME,
	ID_Cliente INT,
	ID_Gerente INT, 
	Valor_do_Contrato FLOAT 
	
)

SELECT * FROM dGerente
SELECT * FROM dCliente
SELECT * FROM fContratos


-- 3. Em cada uma das 3 tabelas, adicione os seguintes valores:

--Tabela 1: dCliente
INSERT INTO dCliente(ID_Cliente, Nome_Cliente, Data_de_Nascimento)
VALUES 
	(1, 'Andr� Martins', '12/02/1989'),
	(2, 'B�rbara Campos', '07/05/1992'),
	(3, 'Carol Freitas', '23/04/1985'),
	(4, 'Diego Cardoso', '11/10/1994'),
	(5, 'Eduardo Pereira', '09/11/1988'),
	(6, 'Gustavo Barbosa', '27/06/1993'),
	(7, 'Helen Viana', '11/02/1990')

SELECT * FROM dCliente


--Tabela 2: dGerente

INSERT INTO dGerente(ID_Gerente, Nome_Gerente, Data_de_Contratacao, Salario)
VALUES 
	(1, 'Lucas Sampaio', '21/03/2015', 6700),
	(2, 'Mariana Padilha', '10/01/2011', 9900),
	(3, 'Nath�lia Santos', '03/10/2018', 7200),
	(4, 'Ot�vio Costa', '18/04/2017', 11000)

SELECT * FROM dGerente


--Tabela 3: fContratos

INSERT INTO fContratos(ID_Contrato, Data_de_Assinatura, ID_Cliente, ID_Gerente, Valor_do_Contrato)
VALUES 
	(1, '12/01/2019', 8, 1, 23000),
	(2, '10/02/2019', 3, 2, 15500),
	(3, '07/03/2019', 7, 2, 6500),
	(4, '15/03/2019', 1, 3, 33000),
	(5, '21/03/2019', 5, 4, 11100),
	(6, '23/03/2019', 4, 2, 5500),
	(7, '28/03/2019', 9, 3, 55000),
	(8, '04/04/2019', 2, 1, 31000),
	(9, '05/04/2019', 10, 4, 3400),
	(10, '05/04/2019', 6, 2, 9200)

SELECT * FROM fContratos


-- 4. Novos dados dever�o ser adicionados nas tabelas dCliente, dGerente e fContratos. Fique livre para adicionar uma nova linha 
-- em cada tabela contendo, respectivamente,


--(1) um novo cliente (id cliente, nome e data de nascimento)


INSERT INTO dCliente(ID_Cliente, Nome_Cliente, Data_de_Nascimento)
VALUES 
	(8, 'Lionel Messi', '24/06/1987')

SELECT * FROM dCliente


--(2) um novo gerente (id gerente, nome, data de contrata��o e sal�rio)


INSERT INTO dGerente(ID_Gerente, Nome_Gerente, Data_de_Contratacao, Salario)
VALUES 
	(5, 'Welington Fonseca', '03/04/1992', 5500)

DELETE -- Precisei apagar uma linha duplicada que criei erroneamente
FROM dGerente
WHERE ID_Gerente = 1 AND Nome_Gerente = 'Welington Fonseca'

SELECT * FROM dGerente


--(3) um novo contrato (id, data assinatura, id cliente, id gerente, valor do contrato)


INSERT INTO fContratos(ID_Contrato, Data_de_Assinatura, ID_Cliente, ID_Gerente, Valor_do_Contrato)
VALUES 
	(11, '07/12/2023', 2, 5, 100000)

SELECT * FROM fContratos


-- 5. O contrato de ID igual a 4 foi registrado com alguns erros na tabela fContratos. Fa�a uma altera��o na tabela atualizando 
--os seguintes valores:
--Data_de_Assinatura: 17/03/2019
--ID_Gerente: 2
--Valor_do_Contrato: 33500

UPDATE fContratos
SET Data_de_Assinatura = '17/03/2019', ID_Gerente = 2, Valor_do_Contrato = 33500
WHERE ID_Contrato = 4

SELECT * FROM fContratos


-- 6. Delete a linha da tabela fContratos que voc� criou na quest�o 4.

DELETE 
FROM fContratos
WHERE ID_Contrato = 11

SELECT * FROM fContratos
