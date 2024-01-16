-- 1. 
--a) A partir da tabela DimProduct, crie uma View contendo as informa��es de ProductName, ColorName, UnitPrice e UnitCost, da tabela 
--DimProduct. Chame essa View de vwProdutos.

GO
CREATE VIEW vwProdutos AS
SELECT 
	ProductName AS 'Nome do Produto',
	ColorName AS 'Cor',
	UnitPrice AS 'Pre�o Unit�rio',
	UnitCost AS 'Custo unit�rio'
FROM
	DimProduct
GO

SELECT * FROM vwProdutos

--b) A partir da tabela DimEmployee, crie uma View mostrando FirstName, BirthDate, DepartmentName. Chame essa View de vwFuncionarios.

GO
CREATE VIEW vwFuncionarios AS
SELECT 
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nasc',
	DepartmentName AS 'Departamento'
FROM
	DimEmployee
GO

SELECT * FROM vwFuncionarios


--c) A partir da tabela DimStore, crie uma View mostrando StoreKey, StoreName e OpenDate. Chame essa View de vwLojas.

GO
CREATE VIEW vwLojas AS
SELECT 
	StoreKey AS 'ID da Loja',
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de abertura'
FROM
	DimStore
GO

SELECT * FROM vwLojas


-- 2.
-- Crie uma View contendo as informa��es de Nome Completo (FirstName + LastName), G�nero (por extenso), 
-- E-mail e Renda Anual (formatada com R$). Utilize a tabela DimCustomer. Chame essa View de vwClientes.

GO
CREATE VIEW vwClientes AS
SELECT 
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		ELSE 'Feminino'
	END AS 'G�nero',
	EmailAddress AS 'E-mail',
	FORMAT(YearlyIncome, 'C') AS 'Renda anual'
FROM	
	DimCustomer
GO

SELECT * FROM vwClientes

-- 3. 

-- a) A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Fa�a um SELECT de todas as colunas. 
-- Chame essa View de vwLojasAtivas.

GO
CREATE VIEW vwLojasAtivas AS
SELECT 
	* 
FROM 
	DimStore
WHERE CloseDate IS NULL
GO

SELECT * FROM vwLojasAtivas


-- b) A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os funcion�rios da �rea de Marketing. 
-- Fa�a um SELECT das colunas: FirstName, EmailAddress e DepartmentName. Chame essa de vwFuncionariosMkt.

GO
CREATE VIEW vwFuncionariosMkt AS
SELECT
	FirstName AS 'Nome', 
	EmailAddress AS 'E-mail',
	DepartmentName AS 'Departamento'
FROM
	DimEmployee
WHERE
	DepartmentName = 'Marketing'
GO

SELECT * FROM vwFuncionariosMkt


--c) Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e Litware. Al�m disso, a sua View deve 
-- considerar apenas os produtos de cor Silver. Fa�a um SELECT de todas as colunas da tabela DimProduct. Chame essa View de 
-- vwContosoLitwareSilver.

GO
CREATE VIEW vwContosoLitwareSilver AS
SELECT
	*
FROM
	DimProduct
WHERE (BrandName = 'Contoso' OR BrandName = 'Litware') AND ColorName = 'Silver'
GO	

SELECT * FROM vwContosoLitwareSilver

-- 4. 

-- Crie uma View que seja o resultado de um agrupamento da tabela FactSales. Este agrupamento deve considerar o SalesQuantity 
-- (Quantidade Total Vendida) por Nome do Produto. Chame esta View de vwTotalVendidoProdutos.
-- OBS: Para isso, voc� ter� que utilizar um JOIN para relacionar as tabelas FactSales e DimProduct.

GO
CREATE VIEW vwTotalVendidoProdutos AS
SELECT
	DimProduct.ProductName AS 'Nome do Produto',
	SUM(FactSales.SalesQuantity) AS 'Quantidade Total Vendida'
FROM 
	FactSales
INNER JOIN DimProduct
ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY 
	DimProduct.ProductName
GO

SELECT * FROM vwTotalVendidoProdutos

-- 5. 

-- Fa�a as seguintes altera��es nas tabelas da quest�o 1.

-- a. Na View criada na letra a da quest�o 1, adicione a coluna de BrandName.

GO
ALTER VIEW vwProdutos AS
SELECT 
	ProductName AS 'Nome do Produto',
	ColorName AS 'Cor',
	UnitPrice AS 'Pre�o Unit�rio',
	UnitCost AS 'Custo unit�rio',
	BrandName AS 'Marca'
FROM
	DimProduct
GO

SELECT * FROM vwProdutos

-- b. Na View criada na letra b da quest�o 1, fa�a um filtro e considere apenas os funcion�rios do sexo feminino.

GO
ALTER VIEW vwFuncionarios AS
SELECT 
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nasc',
	DepartmentName AS 'Departamento',
	Gender AS 'Sexo'
FROM
	DimEmployee
WHERE 
	Gender = 'F'
GO

SELECT * FROM vwFuncionarios

-- c. Na View criada na letra c da quest�o 1, fa�a uma altera��o e filtre apenas as lojas ativas.

GO
ALTER VIEW vwLojas AS
SELECT 
	StoreKey AS 'ID da Loja',
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de abertura',
	CloseDate AS 'Data de Fechamento'
FROM
	DimStore
WHERE
	CloseDate IS NULL
GO

SELECT * FROM vwLojas

-- 6. 

-- a)  Crie uma View que seja o resultado de um agrupamento da tabela DimProduct. O resultado esperado da consulta dever� ser o 
-- total de produtos por marca. Chame essa View de vw_6a.

GO
CREATE VIEW vw_6a AS
SELECT
	BrandName AS 'Marca',
	Count(*) AS 'Qtd de Produtos'
FROM 
	DimProduct
GROUP BY
	BrandName
GO

SELECT * FROM vw_6a

-- b) Altere a View criada no exerc�cio anterior, adicionando o peso total por marca. Aten��o: sua View final dever� ter ent�o 3 
-- colunas: Nome da Marca, Total de Produtos e Peso Total.
GO
ALTER VIEW vw_6a AS
SELECT
	BrandName AS 'Marca',
	Count(*) AS 'Qtd de Produtos',
	ROUND(SUM(Weight), 0) AS 'Peso Total'
FROM 
	DimProduct
GROUP BY
	BrandName
GO

SELECT * FROM vw_6a

c) Exclua a View vw_6a.

DROP VIEW vw_6a 

