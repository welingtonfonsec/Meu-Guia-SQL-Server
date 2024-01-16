
--1. 

--a) Fa�a um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal de vendas (ChannelName). Voc� deve ordenar 
--a tabela final de acordo com SalesQuantity, em ordem decrescente.

Select top 10 * From FactSales
Select top 10 * From DimChannel

SELECT 
	DimChannel.ChannelName AS 'Canal de Venda',
	SUM(FactSales.SalesQuantity) 'Quantidade Vendida'
FROM	
	FactSales
INNER JOIN DimChannel
	ON FactSales.channelKey = DimChannel.ChannelKey
GROUP BY
	DimChannel.ChannelName
ORDER BY 
	SUM(FactSales.SalesQuantity) DESC


--b) Fa�a um agrupamento mostrando a quantidade total vendida (Sales Quantity) e quantidade total devolvida (Return Quantity) 
--de acordo com o nome das lojas (StoreName).

Select top 10 * From FactSales
Select top 10 * From DimStore

SELECT 
	DimStore.StoreName AS 'Canal de Venda',
	SUM(FactSales.SalesQuantity) 'Quantidade Vendida',
	SUM(FactSales.ReturnQuantity) 'Quantidade Devolvida'
FROM	
	FactSales
INNER JOIN DimStore
	ON FactSales.StoreKey = DimStore.StoreKey
GROUP BY
	DimStore.StoreName
ORDER BY 
	DimStore.StoreName ASC

--c) Fa�a um resumo do valor total vendido (Sales Amount) para cada m�s (CalendarMonthLabel) e ano (CalendarYear).

Select top 10 * From FactSales
Select top 10 * From DimDate

SELECT
	DimDate.CalendarYear AS 'Ano',
	DimDate.CalendarMonthLabel AS 'M�s',
	SUM(FactSales.SalesAmount) 'Valor total Vendido'
FROM	
	FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.DateKey
GROUP BY
	DimDate.CalendarMonthLabel,
	DimDate.CalendarYear,
	DimDate.CalendarMonth
ORDER BY
	DimDate.CalendarMonth

--2. Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor total vendido (SalesAmount) 
--por produto.

Select top 10 * From FactSales
Select top 10 * From DimProduct

SELECT 
	DimProduct.ProductName,
	SUM(FactSales.SalesAmount) 'Valor total Vendido'
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY
	DimProduct.ProductName
ORDER BY
	SUM(FactSales.SalesAmount) DESC



--a) Descubra qual � a cor de produto que mais � vendida (de acordo com SalesQuantity).

Select top 10 * From FactSales
Select top 10 * From DimProduct

SELECT
	DimProduct.ColorName AS 'Cor',
	SUM(FactSales.SalesQuantity) 'Quantidade Vendida'
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY
	DimProduct.ColorName
ORDER BY
	SUM(FactSales.SalesQuantity) DESC

--b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.

SELECT
	DimProduct.ColorName AS 'Cor',
	SUM(FactSales.SalesQuantity) 'Quantidade Vendida'
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY
	DimProduct.ColorName
HAVING 
	SUM(FactSales.SalesQuantity) >= '3000000'
ORDER BY
	SUM(FactSales.SalesQuantity) DESC


--3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto (ProductCategoryName). 
--Obs: Voc� precisar� fazer mais de 1 INNER JOIN, dado que a rela��o entre FactSales e DimProductCategory n�o � direta.

Select top 10 * From FactSales
Select top 10 * From DimProduct
Select top 10 * From DimProductSubcategory
Select top 10 * From DimProductCategory

SELECT
	DimProductCategory.ProductCategoryName AS 'Categoria',
	SUM(FactSales.SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactSales
INNER JOIN DimProduct 
	ON FactSales.ProductKey = DimProduct.ProductKey
		INNER JOIN DimProductSubcategory
			ON DimProduct.ProductSubCategoryKey = DimProductSubcategory.ProductSubCategoryKey
				INNER JOIN DimProductCategory
					ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
GROUP BY
	DimProductCategory.ProductCategoryName


--FACTONLINESALES
--4. 
--a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o nome completo do cliente (Pessoa F�sica) 
--que mais realizou compras online (de acordo com a coluna SalesQuantity).


Select top 10 * From FactOnlineSales
Select top 10 * From DimCustomer

SELECT  
	DimCustomer.CustomerKey AS 'ID Pessoa F�sica',
	DimCustomer.FirstName AS 'Nome',
	DimCustomer.LastName AS 'Sobrenome',
	SUM(FactOnlineSales.SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactOnlineSales
INNER JOIN DimCustomer
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE DimCustomer.CustomerType = 'Person'
GROUP BY
	DimCustomer.CustomerKey, 
	DimCustomer.FirstName, 
	DimCustomer.LastName
ORDER BY 
	SUM(FactOnlineSales.SalesQuantity) DESC

--b) Feito isso, fa�a um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da 
--letra a, considerando o nome do produto.

Select top 10 * From FactOnlineSales
Select top 10 * From DimCustomer
Select top 10 * From DimProduct

SELECT TOP 10
	DimCustomer.FirstName,
	DimCustomer.LastName,
	DimProduct.ProductName,
	SUM(FactOnlineSales.SalesQuantity) AS 'Qtd. Vendida'
FROM
	FactOnlineSales
INNER JOIN DimCustomer
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
		INNER JOIN DimProduct
			ON FactOnlineSales.ProductKey = DimProduct.ProductKey
WHERE
	DimCustomer.CustomerKey = 7665
GROUP BY
	DimCustomer.FirstName,
	DimProduct.ProductName,
	DimCustomer.LastName
ORDER BY 
	SUM(FactOnlineSales.SalesQuantity) DESC

--FACTONLINESALES
--5. Fa�a um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o sexo dos clientes.

Select top 10 * From FactOnlineSales
Select top 10 * From DimCustomer

SELECT
	DimCustomer.Gender AS 'G�nero',
	SUM(FactOnlineSales.SalesQuantity) AS 'Qtd. Comprada'
FROM
	FactOnlineSales
INNER JOIN DimCustomer
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE
	DimCustomer.Gender IS NOT NULL
GROUP BY
	DimCustomer.Gender
ORDER BY
	SUM(FactOnlineSales.SalesQuantity)

--FACTEXCHANGERATE
--6. Fa�a uma tabela resumo mostrando a taxa de c�mbio m�dia de acordo com cada CurrencyDescription. 
--A tabela final deve conter apenas taxas entre 10 e 100.

Select top 10 * From FACTEXCHANGERATE
Select top 10 * From DimCurrency

SELECT
	DimCurrency.CurrencyDescription AS 'Moeda',
	AVG(FactExchangeRate.AverageRate) AS 'Taxa de C�mbio M�dia'
FROM
	FactExchangeRate
INNER JOIN DimCurrency
	ON FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY
	DimCurrency.CurrencyDescription
HAVING 
	AVG(FactExchangeRate.AverageRate) BETWEEN 10 AND 100



--FACTSTRATEGYPLAN
--7. Descubra o valor total na tabela FactStrategyPlan destinado aos cen�rios: Actual e Budget.

Select top 10 * From FactStrategyPlan
Select top 10 * From DimScenario

SELECT
	DimScenario.ScenarioName AS 'Cen�rio',
	SUM(FactStrategyPlan.Amount) AS 'Total'
FROM 
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
GROUP BY
	DimScenario.ScenarioName
HAVING
	DimScenario.ScenarioName = 'Actual' OR DimScenario.ScenarioName = 'Budget'

--FACTSTRATEGYPLAN
--8. Fa�a uma tabela resumo mostrando o resultado do planejamento estrat�gico por ano.

Select top 10 * From FactStrategyPlan
Select top 10 * From DimDate

SELECT
	DimDate.CalendarYear AS 'Ano',
	SUM(FactStrategyPlan.Amount) AS 'Total'
FROM
	FactStrategyPlan
INNER JOIN DimDate
	ON FactStrategyPlan.Datekey = DimDate.Datekey
GROUP BY
	DimDate.CalendarYear

--DIMPRODUCT/DIMPRODUCTSUBCATEGORY
--9. Fa�a um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em considera��o em sua an�lise 
--apenas a marca Contoso e a cor Silver.

Select top 10 * From DimProduct
Select top 10 * From DimProductSubcategory
Select top 10 * From DimProductCategory


SELECT
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	DimProduct.BrandName AS 'Marca',
	DimProduct.ColorName AS 'Cor',
	COUNT(DimProduct.BrandName) AS 'Qnt. de Produtos'
FROM
	DimProductSubcategory
INNER JOIN DimProduct
	ON DimProductSubcategory.ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
WHERE
	DimProduct.BrandName = 'Contoso' AND DimProduct.ColorName = 'Silver'
GROUP BY 
	DimProductSubcategory.ProductSubcategoryName,
	DimProduct.BrandName,
	DimProduct.ColorName
ORDER BY
	COUNT(DimProduct.BrandName) DESC


--DIMPRODUCT/DIMPRODUCTSUBCATEGORY
--10. Fa�a um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName. A tabela final dever� ser 
--ordenada de acordo com a coluna BrandName.

Select top 10 * From DimProduct
Select top 10 * From DimProductSubcategory
Select top 10 * From DimProductCategory

SELECT
	DimProduct.BrandName AS 'Marca',
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	COUNT(DimProduct.BrandName) AS 'Qnt. de Produtos'
FROM
	DimProductSubcategory
INNER JOIN DimProduct
	ON DimProductSubcategory.ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
GROUP BY
	DimProduct.BrandName, 
	DimProductSubcategory.ProductSubcategoryName
ORDER BY 
	DimProduct.BrandName ASC
