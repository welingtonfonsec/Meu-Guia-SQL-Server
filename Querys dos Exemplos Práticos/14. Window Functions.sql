-- WINDOWS FUNCTIONS

-- Þara resolver os exercícios 1 a 4, crie uma View chamada vwProdutos, que contenha o agrupamento das colunas BrandName, ColorName e os totais de quantidade vendida por marca/cor e também o total de receita por marca/cor.

select * from vwProdutos

CREATE VIEW vwProdutos AS
SELECT
	BrandName AS 'Marca', 
	ColorName AS 'Cor',
	COUNT(*) AS 'Quantidade_Vendida',
	ROUND(SUM(SalesAmount), 2) AS 'Receita_Total'
FROM DimProduct
INNER JOIN FactSales
		ON DimProduct.ProductKey = FactSales.ProductKey
GROUP BY BrandName, ColorName; 

SELECT * FROM vwProdutos


-- 1. Utilize a View vwProdutos para criar uma coluna extra calculando a quantidade total vendida dos produtos.

SELECT 
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Quantidade_Total_Vendida'
FROM 
	vwProdutos


-- 2. Crie mais uma coluna na consulta anterior, Incluindo o total de produtos vendidos para cada marca

SELECT 
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Quantidade_Total_Vendida',
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Quantidade_Total_Vendida_por_Marca'
FROM 
	vwProdutos


-- 3.Calcule o % de participação do total de vendas de produtos por marca

-- Ex: A marca A. Datum teve uma quantidade total de vendas de 199 041 de um total de 3.406.089 de vendas. Isso significa que a da marca A. Datum é 199.041/3.406.089-5,84%

SELECT 
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Quantidade_Total_Vendida',
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Quantidade_Total_Vendida_por_Marca',
	FORMAT(CAST(SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS DECIMAL(18, 2)) / CAST(SUM(Quantidade_Vendida) OVER() AS DECIMAL(18, 2)), '0.00%') AS '% do Total'
FROM
	vwProdutos;

-- O "CAST" é uma função que está sendo usada para converter (ou "castar") o resultado da soma (SUM) da quantidade vendida para um tipo de dado específico. 
-- Neste caso, estamos convertendo para o tipo de dado "DECIMAL" com precisão de 18 dígitos, dos quais 2 estão à direita do ponto decimal.

-- O DECIMAL(18, 2) é apenas um tipo de dados que representa números com até 18 dígitos no total, dos quais 2 são após o ponto decimal.

-- O FORMAT '0.00%' está transformando o valor encontrado na divisão em percentual


-- 4. Crie uma consulta à View vwProdutos, selecionando as colunas Marca, Cor, Quantidade Por Produto e também criando uma coluna extra de 
-- Rank para descobrir a posição de cada Marca/Cor. Sua consulta deve ser filtrada para apenas mostrar resultados da marca Contoso.

SELECT
	Marca, 
	Cor,
	SUM(Quantidade_Vendida) AS 'Quantidade_Por_Produto',
	RANK() OVER(ORDER BY SUM(Quantidade_Vendida) DESC) AS 'Ranking'
FROM
	vwProdutos
GROUP BY
	Marca, Cor
HAVING 
	Marca = 'Contoso'

SELECT * FROM vwProdutos

-- Exercicio Desafio 1.

-- Para responder os próximos 2 exercicios, você precisará criar uma View auxiliar. Diferente do que foi feito anteriormente, 
-- você não terá acesso ao código dessa view antes do gabarito.

-- A sua view deve se chamar vwHistoricoLojas e deve conter um histórico com a quantidade de lojas abertas a cada Ano/Mês. Os desafios são:

-- (1) Criar uma coluna de ID para essa View

-- (2) Relacionar as tabelas DimDate e DimStore

-- Dicas:

-- 1. A coluna de ID será criada a partir de uma função de janela. Você deverá se atentar a forma como essa coluna deverá ser ordenada, 
--pensando que queremos visualizar uma ordem de Ano/Més que seja: 2005/january, 2005/February... e não 2005/April, 2005/August...

-- 2. As colunas Ano, Més e Otd Lojas correspondem, respectivamente, as seguintes colunas: Calendar Year e Calendar MonthLabel da 
-- tabela DimDate e uma contagem da coluna OpenDate da tabela Dimstore

CREATE VIEW vwHistoricoLojas AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY CalendarMonth) AS 'ID',
	CalendarYear AS 'Ano',
	CalendarMonthLabel AS 'Mês',
	COUNT(OpenDate) AS 'Qtd_Lojas'
FROM DimDate
LEFT JOIN DimStore
	ON DimDate.Datekey = DimStore.OpenDate
GROUP BY CalendarYear, CalendarMonthLabel, CalendarMonth

SELECT * FROM vwHistoricoLojas 


-- 5. A partir da view criada no exercicio anterior, você deverá fazer uma soma móvel considerando sempre o mês atual +2 meses atrás

SELECT
	*,
	SUM(Qtd_Lojas) OVER (ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Móvel'
FROM
	vwHistoricoLojas

-- 6. Utilize a vwHistoricoLojas para calcular o acumulado de lojas abertas a cada ano/mês.

SELECT
	*,
	SUM(Qtd_Lojas) OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado'
FROM
	vwHistoricoLojas

-- Exercicio Desafio 2

-- Neste desafio, você terá que criar suas próprias tabelas e views para conseguir resolver os exercícios 7 e 8. Os próximos exercícios envolverão análises 
-- de novos clientes. Para isso, será necessário criar uma nova tabela e uma nova view.

-- Abaixo, temos um passo a passo para resolver o problema por partes.

-- PASSO 1: Crle um novo banco de dados chamado Desafio e selecione esse banco de dados criado.

CREATE DATABASE Desafio

USE Desafio

-- PASSO 2: Crie uma tabela de datas entre o dia 1 de janeiro do ano com a compra (DateFirstPurchase) mais antiga e o dia 31 de 
--dezembro do ano com a compra mais recente.

-- Obs1: Chame essa tabela de Calendario.

-- Obs2: A princípio, essa tabela deve conter apenas 1 coluna, chamada data e do tipo DATE.

CREATE TABLE Calendario (
	data DATE 
)
DECLARE @varAnoInicial INT = YEAR((SELECT MIN(DateFirstPurchase) FROM 
ContosoRetailDW.dbo.DimCustomer))
DECLARE @varAnoFinal INT = YEAR((SELECT MAX(DateFirstPurchase) FROM
ContosoRetailDW.dbo.DimCustomer))

DECLARE @varDataInicial DATE = DATEFROMPARTS(@varAnoInicial, 1, 1)
DECLARE @varDataFinal DATE = DATEFROMPARTS(@varAnoFinal, 12, 31)

WHILE @varDataInicial <= @varDataFinal
BEGIN 
	INSERT INTO Calendario(data) VALUES(@varDataInicial)
	SET @varDataInicial = DATEADD(DAY, 1, @varDataInicial)
END

SELECT * FROM Calendario





-- PASSO 3: Crie colunas auxiliares na tabela Calendario chamadas: Ano, Mes, Dia, AnoMes e NomeMes. Todas do tipo INT

ALTER TABLE Calendario
ADD Ano INT,
	Mes INT,
	Dia INT,
	AnoMes INT,
	NomeMes VARCHAR(50)

-- PASSO 4: Adicione na tabela os valores de Ano, Més, Dia, AnoMes e NomeMes (nome do měs em português). 
-- Dica: utilize a instrução CASE para verificar o mês e retomar o nome certo.

UPDATE Calendario SET Ano = YEAR(data)

UPDATE Calendario SET Mes = MONTH(data)

UPDATE Calendario SET Dia = DAY(data)

UPDATE Calendario SET AnoMes = CONCAT(YEAR(data), FORMAT(MONTH(data), '00'))

UPDATE Calendario SET NomeMes = 

			CASE
					WHEN MONTH(data) = 1 THEN 'Janeiro'
					WHEN MONTH(data) = 2 THEN 'Fevereiro'
					WHEN MONTH(data) = 3 THEN 'Março'
					WHEN MONTH(data) = 4 THEN 'Abril'
					WHEN MONTH(data) = 5 THEN 'Mato'
					WHEN MONTH(data) = 6 THEN 'Junho'
					WHEN MONTH(data) = 7 THEN 'Julho'
					WHEN MONTH(data) = 8 THEN 'Agosto'
					WHEN MONTH(data) = 9 THEN 'Setembro'
					WHEN MONTH(data) = 10 THEN 'Outubro'
					WHEN MONTH(data) = 11 THEN 'Novembro'
					WHEN MONTH(data) = 12 THEN 'Dezembro'

			END

-- PASSO 5: Crie a View vw Novos Clientes, que deve ter as colunas mostradas abaixo.

CREATE VIEW vwNovosClientes AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY AnoMes) AS 'ID',
	Ano,
	NomeMes,
	COUNT(DimCustomer.DateFirstPurchase) AS 'Novos Clientes'
FROM Calendario
LEFT JOIN ContosoRetailDW.dbo.DimCustomer
	ON Calendario.data = DimCustomer.DateFirstPurchase
GROUP BY Ano, NomeMes, AnoMes

SELECT * FROM vwNovosClientes

-- 7.

-- a) Faça um cálculo de soma móvel de novos clientes nos últimos 2 meses.

SELECT
	*,
	SUM([Novos Clientes]) OVER (ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Móvel'
FROM
	vwNovosClientes

-- b) Faça um cálculo de média móvel de novos clientes nos últimos 2 meses. I

SELECT
	*,
	SUM([Novos Clientes]) OVER (ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Móvel',
	AVG([Novos Clientes]) OVER (ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Média Móvel'
FROM
	vwNovosClientes

-- c) Faça um cálculo de acumulado dos novos clientes ao longo do tempo.

SELECT
	*,
	SUM([Novos Clientes]) OVER (ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Móvel',
	AVG([Novos Clientes]) OVER (ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Média Móvel',
	SUM([Novos Clientes]) OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado'
FROM
	vwNovosClientes

-- d) Faça um cálculo de acumulado intra-ano, ou seja, um acumulado que vai de janeiro a dezembro de cada ano, e volta a fazer o cálculo de acumulado no ano seguinte.

SELECT 
	*,
	SUM([Novos Clientes]) OVER(PARTITION BY Ano) AS 'acumulado intra-ano'
FROM
	vwNovosClientes

OU

SELECT 
	*,
	SUM([Novos Clientes]) OVER(PARTITION BY Ano ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'acumulado intra-ano'
FROM
	vwNovosClientes


-- 8. Faça os cálculos de MoM e YoY para avaliar o percentual de crescimento de novos clientes, entre o mês atual e o més anterior, e entre um més atual e 
--o mesmo mês do ano anterior.

SELECT
    *,
    LAG([Novos Clientes], 1) OVER (ORDER BY ID) AS Lag_Novos_Clientes,
	FORMAT(1.0*[Novos Clientes]/NULLIF(LAG([Novos Clientes], 1) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '%MoM',
	FORMAT(1.0*[Novos Clientes]/NULLIF(LAG([Novos Clientes], 12) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '%YoY'
FROM
    vwNovosClientes;