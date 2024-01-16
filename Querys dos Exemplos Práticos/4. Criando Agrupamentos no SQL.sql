-- FACTSALES

--1. a) Faça um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas (channelkey).

SELECT 
	*
FROM
	DimChannel

SELECT
	channelKey AS 'ID do Canal de Vendas' ,
	SUM (SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactSales
GROUP BY 
	channelKey
ORDER BY
	SUM (SalesQuantity) DESC

--b) Faça um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade total devolvida 
-- (Return Quantity) de acordo com o ID das lojas (StoreKey).

SELECT 
	*
FROM
	DimStore

SELECT
	StoreKey AS 'ID da loja',
	SUM (SalesQuantity) AS 'Quantidade Vendida',
	SUM (ReturnQuantity) AS 'Quantidade Devolvida'
FROM
	FactSales
GROUP BY 
	StoreKey
ORDER BY
	StoreKey 


--c) Faça um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas para o ano de 2007.

SELECT 
	*
FROM
	DimChannel

SELECT
	channelKey AS 'ID do Canal de Vendas',
	SUM (SalesAmount) AS 'Valor Total Vendido'
FROM
	FactSales
WHERE
	DateKey BETWEEN '20070101' AND '20071231'
GROUP BY 
	channelKey 
ORDER BY
	SUM (SalesAmount) DESC



-- 2. Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor total vendido (SalesAmount) 
-- por produto (ProductKey).

--a) A tabela final deverá estar ordenada de acordo com a quantidade vendida e, além disso, mostrar apenas os 
-- produtos que tiveram um resultado final de vendas maior do que $5.000.000.

SELECT 
	*
FROM
	DimProduct

SELECT TOP 10
	*
FROM
	FactSales

SELECT 
	ProductKey AS 'ID do Produto',
	SUM (SalesQuantity) AS 'Quantidade Vendida',
	SUM(SalesAmount) AS 'Valor Total Vendido'
FROM
	FactSales
GROUP BY
	ProductKey
HAVING 
	SUM(SalesAmount) >= 5000000
ORDER BY 
	SUM (SalesQuantity) DESC


--b) Faça uma adaptação no exercício anterior e mostre os Top 10 produtos com mais vendas. Desconsidere o filtro de $5.000.000 aplicado.

SELECT TOP (10)
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Valor Total Vendido'
FROM
	FactSales
GROUP BY
	ProductKey
ORDER BY 
	SUM (SalesAmount) DESC

-- FACTONLINESALES

-- 3. 

--a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o ID (CustomerKey) do cliente que mais realizou 
-- compras online (de acordo com a coluna SalesQuantity).

SELECT TOP (1)
	CustomerKey AS 'ID do Cliente',
	SUM (SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactOnlineSales
GROUP BY
	CustomerKey
ORDER BY
	SUM (SalesQuantity) DESC


-- b) Feito isso, faça um agrupamento de total vendido (SalesQuantity) por ID do produto e descubra quais foram os top 3 produtos 
-- mais comprados pelo cliente da letra a).

SELECT TOP (3)
	CustomerKey AS 'ID do Cliente',
	SUM (SalesQuantity) AS 'Quantidade Vendida',
	ProductKey AS 'ID do Produto'
FROM
	FactOnlineSales
GROUP BY
	ProductKey,
	CustomerKey
HAVING
	 CustomerKey = '19037'
ORDER BY
	SUM (SalesQuantity) DESC

SELECT 
	* 
FROM 
	DimProduct
WHERE 
 ProductKey IN ('2515','2516','2506')

-- DIMPRODUCT

-- 4. 

-- a) Faça um agrupamento e descubra a quantidade total de produtos por marca.

SELECT 
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Quantidade de Produtos'
FROM 
	DimProduct
GROUP BY
	BrandName 
ORDER BY
	COUNT(BrandName) DESC

-- b) Determine a média do preço unitário (UnitPrice) para cada ClassName.
SELECT 
	ClassName AS 'Classe',
	AVG(UnitPrice) AS 'Preço Médio'
FROM 
	DimProduct
GROUP BY
	ClassName 
ORDER BY
	AVG(UnitPrice) DESC


-- c) Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui.

SELECT 
	ColorName AS 'Cor',
	SUM (Weight) AS 'Peso Total'
FROM 
	DimProduct
GROUP BY
	ColorName 
ORDER BY
	SUM (Weight) DESC

-- 5. Você deverá descobrir o peso total para cada tipo de produto (StockTypeName).
-- A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em ordem decrescente.

SELECT
	StockTypeName AS 'Tipo de Produto',
	SUM (Weight) AS 'Peso Total'
FROM
	DimProduct
WHERE 
	BrandName = 'Contoso'
GROUP BY
	StockTypeName,
	BrandName
ORDER BY
	SUM (Weight) DESC

-- 6. Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as 16 opções de cores?

SELECT
	COUNT(DISTINCT ColorName) AS 'Quantidade de Cores Diferentes'
FROM
	DimProduct

-- Faz a contagem de cores de produtos disponíveis no banco de dados. 16

SELECT
	BrandName,
	COUNT(DISTINCT ColorName) AS 'Quantidade de Cores Diferentes'
FROM
	DimProduct
GROUP BY
	BrandName
ORDER BY
	COUNT(DISTINCT ColorName) DESC

-- A conclusão: Nenhuma marca possui todas as 16 cores disponíveis para cada um de seus produtos.

-- DIMCUSTOMER

-- 7. Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média salarial de acordo com o Sexo. 
--Corrija qualquer resultado “inesperado” com os seus conhecimentos em SQL.

SELECT
	Gender AS 'Sexo',
	COUNT (Gender) 'Qtd Total de Clientes',
	AVG(YearlyIncome) AS 'Média Salarial'
FROM
	DimCustomer
WHERE
	Gender IS NOT NULL
GROUP BY
	Gender
ORDER BY
	AVG(YearlyIncome) DESC

--8. Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de acordo com o seu nível escolar. 
--Utilize a coluna Education da tabela DimCustomer para fazer esse agrupamento.

SELECT *
	FROM
	DimCustomer

SELECT
	Education AS 'Nível Educacional',
	COUNT(Education)'Número de Clientes',
	AVG(YearlyIncome) 'Média Salarial'
FROM
	DimCustomer
WHERE
	Gender IS NOT NULL
GROUP BY
	Education
ORDER BY
	AVG(YearlyIncome) DESC

--DIMEMPLOYEE

-- 9. Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o Departamento (DepartmentName). 
--Importante: Você deverá considerar apenas os funcionários ativos.

SELECT
	DepartmentName AS 'Departamento',
	COUNT(*) AS 'Número de Funcionários Atuais'
FROM
	DimEmployee
WHERE
	EndDate IS NULL
GROUP BY
	DepartmentName
ORDER BY
	COUNT(*)  DESC

-- Outra opção seria usar a coluna Status, e fazer um WHERE Status = 'Current'


-- 10. Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Você deve considerar apenas 
-- as mulheres, dos departamentos de Production, Marketing, Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000.

SELECT
	*
FROM
	DimEmployee


SELECT
	Title,
	SUM (VacationHours)
FROM
	DimEmployee
WHERE
	 Gender = 'F' AND DepartmentName  IN ('Production','Marketing','Engineering','Finance') AND HireDate BETWEEN '1999-01-01' AND '2000-12-31'
GROUP BY
	Title
ORDER BY
	SUM (VacationHours)