
/*
1. Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct
*/

SELECT TOP 10 * FROM DimProduct

SELECT TOP 10 * FROM DimProductSubcategory

SELECT
	DimProduct.Productkey AS 'ID Produto', 
	DimProduct.ProductName AS 'Produto', 
	DimProduct.ProductSubcategorykey AS 'Subcategoria',
	DimProductSubcategory.ProductSubcategoryName
FROM 
	DimProduct
INNER JOIN DimProductSubcategory
ON 	DimProduct.ProductSubcategorykey = DimProductSubcategory.ProductSubcategorykey 


/*
2. Identifique uma coluna em comum entre as tabelas DimProductSubcategory e DimProductCategory. Utilize essa coluna para 
--complementar informações na tabela DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN.
*/

SELECT TOP 10 * FROM DimProductSubcategory

SELECT TOP 10 * FROM DimProductCategory

SELECT
	DimProductSubcategory.ProductSubcategoryKey AS 'ID Subproduto', 
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	DimProductCategory.ProductCategoryName AS 'Categoria'
FROM 
	DimProductSubcategory
LEFT JOIN DimProductCategory
ON 	DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey 


/* 
3. Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados (de acordo com DimGeography). 
--Seu SELECT final deve conter apenas as seguintes colunas: StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. 
-- Utilize o LEFT JOIN neste exercício.
*/

SELECT TOP 10 * FROM DimStore
SELECT TOP 10 * FROM DimGeography

SELECT
	DimStore.StoreKey AS 'ID loja', 
	DimStore.StoreName AS 'Loja', 
	DimStore.EmployeeCount AS 'Qtd. Funcionários',
	DimGeography.ContinentName AS 'Continente', 
	DimGeography.RegionCountryName AS 'País'
FROM
	DimStore
LEFT JOIN DimGeography
ON 	DimStore.GeographyKey = DimGeography.GeographyKey

/*
4. Complementa a tabela DimProduct com a informação de ProductCategoryDescription. Utilize o LEFT JOIN e retorne em seu SELECT 
 apenas as 3 colunas que considerar mais relevantes.
 */

SELECT TOP 10 * FROM DimProduct
SELECT TOP 10 * FROM DimProductCategory
SELECT TOP 10 * FROM DimProductSubcategory
-- MULTIPLOS JOINS - PQ A COLUNA ProductCategoryDescription NÃO ESTA RELACIONADA DIRETAMENTE COM DimProduct e DimProductCategory. 
-- Nesse sentido, é necessário usar a tabela intermediária DimProductSubcategory que possui a ProductCategoryDescription

SELECT
	DimProduct.ProductName AS 'Produto', 
	DimProduct.ClassName AS 'Classe do Produto',
	DimProductCategory.ProductCategoryDescription AS 'Categoria'
FROM
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategorykey = DimProductSubcategory.ProductSubcategorykey
		LEFT JOIN DimProductCategory
			ON DimProduct.ProductSubcategorykey = DimProductSubcategory.ProductSubcategorykey


/*
5. A tabela FactStrategyPlan resume o planejamento estratégico da empresa. Cada linha representa um montante destinado a uma determinada 
AccountKey.
a) Faça um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela.
*/

SELECT TOP 100 * FROM FactStrategyPlan


/*
b) Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada AccountKey da tabela FactStrategyPlan. O seu SELECT final deve 
conter as colunas:
• StrategyPlanKey
• DateKey
• AccountName
• Amount 
*/

SELECT TOP 100 * FROM FactStrategyPlan
SELECT TOP 100 * FROM DimAccount

SELECT
	FactStrategyPlan.StrategyPlanKey,
	FactStrategyPlan.DateKey,
	FactStrategyPlan.Amount,
	DimAccount.AccountName
FROM
	FactStrategyPlan
INNER JOIN DimAccount
	ON FactStrategyPlan.AccountKey = DimAccount.AccountKey


/*
6. Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que identifica o tipo de conta, há também uma outra 
coluna chamada ScenarioKey. Essa coluna possui a numeração que identifica o tipo de cenário: Real, Orçado e Previsão.
Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey da tabela FactStrategyPlan. 
O seu SELECT final deve conter as colunas:
• StrategyPlanKey
• DateKey
• ScenarioName
• Amount
*/

SELECT TOP 100 * FROM FactStrategyPlan
SELECT TOP 100 * FROM DimScenario

SELECT
	FactStrategyPlan.StrategyPlanKey,
	FactStrategyPlan.DateKey,
	DimScenario.ScenarioName,
	FactStrategyPlan.Amount
FROM
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey

/*
7. Algumas subcategorias não possuem nenhum exemplar de produto. Identifique que subcategorias são essas.
*/

SELECT TOP 100 * FROM DimProduct
SELECT TOP 100 * FROM DimProductSubcategory

SELECT
	DimProductSubcategory.ProductSubcategoryName
FROM 
	DimProductSubcategory
LEFT JOIN DimProduct
ON DimProductSubcategory.ProductSubcategorykey = DimProduct.ProductSubcategorykey
WHERE DimProduct.Productkey IS NULL;


/*
8. tabela abaixo mostra a combinação entre Marca e Canal de Venda, para as marcas Contoso, Fabrikam e Litware. 
Crie um código SQL para chegar no mesmo resultado.
*/

SELECT TOP 10 * FROM FactSales
SELECT TOP 10 * FROM DimProduct
SELECT TOP 10 * FROM DimChannel

SELECT
	DISTINCT DimProduct.BrandName,
	DimChannel.ChannelName
FROM
	DimProduct CROSS JOIN DimChannel
WHERE BrandName IN ('Contoso', 'Fabrikam', 'Litware')


/*
9. Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion. Identifique a coluna que as duas tabelas 
têm em comum e utilize-a para criar esse relacionamento.
Retorne uma tabela contendo as seguintes colunas:
• OnlineSalesKey
• DateKey
• PromotionName
• SalesAmount
A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com desconto (PromotionName <> ‘No Discount’).
Além disso, você deverá ordenar essa tabela de acordo com a coluna DateKey, em ordem crescente.
*/


SELECT TOP 10 * FROM DimPromotion
SELECT TOP 10 * FROM FactOnlineSales
SELECT TOP 10 * FROM DimChannel

SELECT TOP (1000)
	OnlineSalesKey,
	DateKey,
	PromotionName,
	SalesAmount	
FROM 
	FactOnlineSales
INNER JOIN DimPromotion
	ON FactOnlineSales.PromotionKey = DimPromotion.PromotionKey
WHERE PromotionName <> 'No Discount'
ORDER BY DateKey ASC


/*
10. A tabela abaixo é resultado de um Join entre a tabela FactSales e as tabelas: DimChannel, DimStore e DimProduct.
Recrie esta consulta e classifique em ordem decrescente de acordo com SalesAmount.
*/

SELECT TOP 10 * FROM FactSales
SELECT TOP 10 * FROM DimProduct
SELECT TOP 10 * FROM DimChannel
SELECT TOP 10 * FROM DimStore

SELECT TOP 100
	FactSales.SalesKey,
	DimChannel.ChannelName,
	DimStore.StoreName,
	DimProduct.ProductName,
	FactSales.SalesAmount
FROM
	FactSales
INNER JOIN DimChannel
	ON FactSales.channelKey = DimChannel.ChannelKey
		INNER JOIN DimStore
			ON FactSales.StoreKey = DimStore.StoreKey
				INNER JOIN DimProduct
					ON FactSales.ProductKey = DimProduct.ProductKey
ORDER BY
	FactSales.SalesAmount DESC