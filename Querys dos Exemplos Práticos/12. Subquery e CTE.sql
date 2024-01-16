-- 1. Para fins fiscais, a contabilidade da empresa precisa de uma tabela contendo todas as vendas referentes � loja 'Contoso Orlando Store'. Isso
-- porque essa loja encontra-se em uma regi�o onde a tributa��o foi modificada recente.

-- Portanto, crie uma consulta ao Banco de Dados para obter uma tabela FactSales contendo todas as vendas desta loja.


SELECT * FROM FactSales
WHERE StoreKey = 
	(SELECT StoreKey FROM DimStore
		WHERE StoreName = 'Contoso Orlando Store')


-- 2. O setor de controle de produtos quer fazer uma an�lise para descobrir quais s�o os produtos que possuem um UnitPrice maior que o UnitPrice do produto
-- de ID igual a 1893.

-- a) A sua consulta resultante deve conter as colunas ProductKey, ProductName e UnitPrice da Tabela DimProduct

-- b) Nessa Query voc� tamb�m deve retornar uma coluna extra, que informe o UnitPrice do produto 1893

WITH pre�o_acima_do_ID_1893 AS (
    SELECT
        ProductKey,
        ProductName AS 'Produtos com Pre�o acima do ID 1893',
        UnitPrice
    FROM
        DimProduct
    WHERE
        UnitPrice > (
            SELECT 
                UnitPrice
            FROM
                DimProduct
            WHERE 
                ProductKey = 1893
        )
),
pre�o_ID_1893 AS (
SELECT
	UnitPrice AS 'Pre�o ID 1893'
FROM
    DimProduct
WHERE ProductKey = 1893
)

SELECT
	*
FROM
	pre�o_acima_do_ID_1893,
	pre�o_ID_1893 


-- 3. A empresa Contoso criou um programa de bonifica��o chamado "Todos por 1". Este programa consistia no seguinte: 1 funcion�rio 
-- seria escolhido ao final do ano como o funcion�rio destaque, s� que a bonifica��o seria recebida por todos da �rea daquele funcion�rio 
-- em particular. O objetivo desse programa seria o de incentivar a colabora��o coletiva entre os funcion�rios de uma mesma �rea. 
-- Desta forma, o funcion�rio destaque beneficiaria n�o s� a si, mas tamb�m a todos os colegas de sua �rea.

-- Ao final do ano, o funcion�rio escolhido como destaque foi o Miguel Severino. Isso significa que todos os funcion�rios da �rea do Miguel 
-- seriam beneficiados com o programa.

 -- O seu objetivo � realizar uma consulta � tabela DimEmployee e retornar todos os funcion�rios da �rea "vencedora" para que o setor Financeiro 
 -- possa realizar os pagamentos das bonifica��es.


 SELECT  -- Primeiro o descobrir qual � o nome do departamento
	DepartmentName
FROM
	DimEmployee
WHERE FirstName = 'Miguel' AND LastName = 'Severino'


SELECT * FROM DimEmployee -- Agora anexar a consulta anterior como subquery e receber o nome as pessoas que fazem parte
WHERE DepartmentName = 
	(SELECT DepartmentName FROM DimEmployee WHERE FirstName = 'Miguel' AND LastName = 'Severino')


-- 4. Fa�a uma query que retorne os clientes que recebem um salario anual acima da m�dia. A sua query deve retornar as colunas
-- CustomerKey, FirstName, LastName, EmailAddress e YearlyIncome

-- Obs: Considere apenas os clientes que s�o 'Pessoas F�sicas'

SELECT  -- Primeiro o descobrir qual m�dia
	AVG(YearlyIncome)
FROM
	DimCustomer
WHERE
	CustomerType = 'Person'

SELECT -- Agora anexar a consulta anterior como subquery e receber o nome as pessoas que recebem mais
	CustomerKey,
	FirstName,
	LastName,
	EmailAddress,
	YearlyIncome,
	CustomerType
FROM DimCustomer 
WHERE CustomerType ='Person' AND YearlyIncome > 
	(SELECT AVG(YearlyIncome) FROM DimCustomer WHERE CustomerType = 'Person')

	


-- 5. A a��o de desconto da Asian Holiday Promotion foi uma das mais bem sucedidas da empresa. Agora, a Contoso quer entender um pouco melhor
-- sobre o perfil dos clientes que compraram produtos nessa promo��o.

-- Seu trabalho � criar uma query que retorne a lista de clientes que compraram nessa promo��o


SELECT				-- TERCEIRO PASSO E ULTIMO PASSO - COM OS ID DOS CLIENTES, ENCONTRE TODAS AS INFORMA��ES CADASTRADAS
	*				
FROM
	DimCustomer
WHERE CustomerKey IN (
	SELECT          -- SEGUNDO PASSO - ENCONTRE QUAL O ID DOS CLIENTES
		DISTINCT CustomerKey
	FROM 
		FactOnlineSales
	WHERE PromotionKey IN (
			SELECT   -- PRIMEIRO PASSO - ENCONTRE QUAL O ID DESSA PROMO��O
				PromotionKey
			FROM 
				DimPromotion
			WHERE PromotionName = 'asian holiday promotion' 
)
)


-- 6. A empresa emplementou um programa de fideliza��o de clientes empresariais. Todos aqueles que comprarem mais de 3000 unidades de 
-- um mesmo produto receber� descontos em outras compras.

-- Voc� dever� descobrir as informa��es de CustomerKey e CompanyName


SELECT
	*
FROM
	DimCustomer
WHERE CustomerKey IN (
	SELECT
		CustomerKey
	FROM 
		FactOnlineSales
	WHERE CustomerKey IN (
		SELECT				
			CustomerKey				
		FROM
			DimCustomer
		WHERE
			CustomerType = 'Company'
	) 
GROUP BY 
	CustomerKey
HAVING 
	SUM(SalesQuantity) > 3000
);


-- 7. Voc� dever� criar uma consulta para o setor de vendas que mostre as seguintes colunas da tabela DimProduct:
-- ProductKey, ProductName, BrandName, UnitPrice, M�dia de UnitPrice

SELECT
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice,
	(SELECT AVG(UnitPrice) FROM DimProduct) AS 'UnitPrice (AVG)'
FROM
	DimProduct

-- 8. Fa�a uma consulta para descobrir os seguintes indicadores dos seus produtos

-- Maior quantidade de produtos por marca
-- Menor quantidade de produtos por marca
-- M�dia de produtos por marca

SELECT 
	MAX(Quantidade) AS 'Maximo',
	MIN(Quantidade) AS 'Minimo',
	AVG(Quantidade) AS 'M�dia'
FROM ( 
	SELECT 
		BrandName,
		COUNT(*) AS 'Quantidade'
	FROM
		DimProduct
	GROUP BY 
		BrandName ) AS T


-- 9. Crie uma CTE que seja o agrupamento da tabela DimProduct, armazenando o total de produtos por marca. Em seguida, fa�a um SELECT nessa CTE 
-- descobrindo qual � a quantidade m�xima de produtos para uma marca. Chame esta CTE de CTE_QntProdutosPorMarca.

WITH CTE_QntProdutosPorMarca AS (
SELECT 
	BrandName,
	COUNT(*) AS 'Quantidade'
FROM
	DimProduct
GROUP BY 
	BrandName
)	

SELECT
	MAX(Quantidade) AS 'M�ximo'
FROM 
	CTE_QntProdutosPorMarca
	
-- 10. Crie duas CTE's 
-- (i) A primeira deve conter as colunas ProductKey, ProductName, ProductSubcategoryKey, BrandName e UnitPrice, da tabela DimProduct, mas
-- apenas os produtos da marca Adventure Works. Chame esse CTE de CTE_produtosAdventureWorks

-- (ii) A segunda deve conter as colunas ProductSubcategoryKey, ProductSubcategoryName, da tabela DimProductSubcategory mas apenas para as 
-- subcategorias 'Televisions e Monitors'. Chame esse CTE de CTE_categoriaTelevisionseRadios

-- Fa�a uma JOIN entre as duas CTE's, e o resultado deve ser uma query contendo todas as colunas das duas tabelas. 


WITH CTE_produtosAdventureWorks AS (
	SELECT
		ProductKey, 
		ProductName, 
		ProductSubcategoryKey, 
		BrandName, 
		UnitPrice
	FROM
		DimProduct
	WHERE BrandName = 'Adventure Works'
),
CTE_categoriaTelevisionseMonitors AS (
	SELECT
		ProductSubcategoryKey, 
		ProductSubcategoryName 
	FROM
		DimProductSubcategory
	WHERE ProductSubcategoryName IN('Televisions','Monitors')
)

SELECT 
	CTE_produtosAdventureWorks.*,
	CTE_categoriaTelevisionseMonitors.ProductSubcategoryName
FROM 
	CTE_produtosAdventureWorks
INNER JOIN CTE_categoriaTelevisionseMonitors
	ON CTE_produtosAdventureWorks.ProductSubcategoryKey = CTE_categoriaTelevisionseMonitors.ProductSubcategoryKey


