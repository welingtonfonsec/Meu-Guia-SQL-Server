-- FACTSALES

--1. a) Fa�a um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas (channelkey).

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

--b) Fa�a um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade total devolvida 
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


--c) Fa�a um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas para o ano de 2007.

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



-- 2. Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor total vendido (SalesAmount) 
-- por produto (ProductKey).

--a) A tabela final dever� estar ordenada de acordo com a quantidade vendida e, al�m disso, mostrar apenas os 
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


--b) Fa�a uma adapta��o no exerc�cio anterior e mostre os Top 10 produtos com mais vendas. Desconsidere o filtro de $5.000.000 aplicado.

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

--a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o ID (CustomerKey) do cliente que mais realizou 
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


-- b) Feito isso, fa�a um agrupamento de total vendido (SalesQuantity) por ID do produto e descubra quais foram os top 3 produtos 
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

-- a) Fa�a um agrupamento e descubra a quantidade total de produtos por marca.

SELECT 
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Quantidade de Produtos'
FROM 
	DimProduct
GROUP BY
	BrandName 
ORDER BY
	COUNT(BrandName) DESC

-- b) Determine a m�dia do pre�o unit�rio (UnitPrice) para cada ClassName.
SELECT 
	ClassName AS 'Classe',
	AVG(UnitPrice) AS 'Pre�o M�dio'
FROM 
	DimProduct
GROUP BY
	ClassName 
ORDER BY
	AVG(UnitPrice) DESC


-- c) Fa�a um agrupamento de cores e descubra o peso total que cada cor de produto possui.

SELECT 
	ColorName AS 'Cor',
	SUM (Weight) AS 'Peso Total'
FROM 
	DimProduct
GROUP BY
	ColorName 
ORDER BY
	SUM (Weight) DESC

-- 5. Voc� dever� descobrir o peso total para cada tipo de produto (StockTypeName).
-- A tabela final deve considerar apenas a marca �Contoso� e ter os seus valores classificados em ordem decrescente.

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

-- 6. Voc� seria capaz de confirmar se todas as marcas dos produtos possuem � disposi��o todas as 16 op��es de cores?

SELECT
	COUNT(DISTINCT ColorName) AS 'Quantidade de Cores Diferentes'
FROM
	DimProduct

-- Faz a contagem de cores de produtos dispon�veis no banco de dados. 16

SELECT
	BrandName,
	COUNT(DISTINCT ColorName) AS 'Quantidade de Cores Diferentes'
FROM
	DimProduct
GROUP BY
	BrandName
ORDER BY
	COUNT(DISTINCT ColorName) DESC

-- A conclus�o: Nenhuma marca possui todas as 16 cores dispon�veis para cada um de seus produtos.

-- DIMCUSTOMER

-- 7. Fa�a um agrupamento para saber o total de clientes de acordo com o Sexo e tamb�m a m�dia salarial de acordo com o Sexo. 
--Corrija qualquer resultado �inesperado� com os seus conhecimentos em SQL.

SELECT
	Gender AS 'Sexo',
	COUNT (Gender) 'Qtd Total de Clientes',
	AVG(YearlyIncome) AS 'M�dia Salarial'
FROM
	DimCustomer
WHERE
	Gender IS NOT NULL
GROUP BY
	Gender
ORDER BY
	AVG(YearlyIncome) DESC

--8. Fa�a um agrupamento para descobrir a quantidade total de clientes e a m�dia salarial de acordo com o seu n�vel escolar. 
--Utilize a coluna Education da tabela DimCustomer para fazer esse agrupamento.

SELECT *
	FROM
	DimCustomer

SELECT
	Education AS 'N�vel Educacional',
	COUNT(Education)'N�mero de Clientes',
	AVG(YearlyIncome) 'M�dia Salarial'
FROM
	DimCustomer
WHERE
	Gender IS NOT NULL
GROUP BY
	Education
ORDER BY
	AVG(YearlyIncome) DESC

--DIMEMPLOYEE

-- 9. Fa�a uma tabela resumo mostrando a quantidade total de funcion�rios de acordo com o Departamento (DepartmentName). 
--Importante: Voc� dever� considerar apenas os funcion�rios ativos.

SELECT
	DepartmentName AS 'Departamento',
	COUNT(*) AS 'N�mero de Funcion�rios Atuais'
FROM
	DimEmployee
WHERE
	EndDate IS NULL
GROUP BY
	DepartmentName
ORDER BY
	COUNT(*)  DESC

-- Outra op��o seria usar a coluna Status, e fazer um WHERE Status = 'Current'


-- 10. Fa�a uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Voc� deve considerar apenas 
-- as mulheres, dos departamentos de Production, Marketing, Engineering e Finance, para os funcion�rios contratados entre os anos de 1999 e 2000.

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