-- EXERCICIO

-- 1. O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais importante 
--da empresa: Store. Utilize uma função SQL para fazer essas consultas no seu banco de dados. Obs: Faça essa análise considerando 
--a tabela FactSales.

SELECT TOP 10
	*
FROM
	FactSales

SELECT 
	*
FROM
	DimChannel


SELECT
	SUM(SalesQuantity) AS 'Quantidade Vendida',
	SUM(ReturnQuantity) AS 'Quantidade Devolvida'
FROM
	FactSales
Where
	channelKey = '1'

-- Para saber o canal de venda mais importante da empresa: Store. Temos que descobrir o número da sua chave na tabela DimChannel.
-- É o número 1
	


-- 2. Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes da empresa, mas apenas de ocupação 
--Professional. Utilize um comando SQL para atingir esse resultado.

SELECT
	AVG (YearlyIncome) AS 'Média Salarial de Clientes de Ocupação Professional '
FROM
	DimCustomer
WHERE
	Occupation = 'Professional'

-- 3. Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na empresa. 
--O seu gerente te pediu os seguintes números e informações:
-- a) Quantos funcionários tem a loja com mais funcionários?
-- b) Qual é o nome dessa loja?
-- c) Quantos funcionários tem a loja com menos funcionários?
-- d) Qual é o nome dessa loja?

-- a) Quantos funcionários tem a loja com mais funcionários?

SELECT  
	MAX (EmployeeCount) AS 'Maior Qtd. de Funcionários'
FROM 
	DimStore

-- b) Qual é o nome dessa loja?

SELECT TOP 1
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. Funcionários'
FROM 
	DimStore
Order BY 
	EmployeeCount DESC

-- c) Quantos funcionários tem a loja com menos funcionários?

SELECT  
	MIN (EmployeeCount) AS 'Maior Qtd. de Funcionários'
FROM 
	DimStore

-- d) Qual é o nome dessa loja?

SELECT TOP 1
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. Funcionários'
FROM 
	DimStore
WHERE
	EmployeeCount IS NOT NULL
Order BY 
	EmployeeCount ASC

-- Se essa letra d) fosse feita de maneira similar ao da letra b), o resultado estaria errado. Pela razão de que na coluna
-- EmployeeCount possui valores NULL, que para o SQL tem valor de 0. Logo a função IS NOT NULL é necessária.


SELECT 
	StoreName,
	EmployeeCount
FROM 
	DimStore
WHERE 
	EmployeeCount = (SELECT MIN(EmployeeCount) FROM DimStore);

-- 4. A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade total de funcionários do sexo Masculino 
-- e do sexo Feminino.
-- a) Descubra essas duas informações utilizando o SQL.
-- b) O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as seguintes informações de 
-- cada um deles: Nome, E-mail, Data de Contratação.

-- a) 
-- quantidade total de funcionários do sexo Masculino   

SELECT
	COUNT (FirstName) AS 'Numero de Funcionárias'
FROM 
	DimEmployee 
WHERE 
	Gender = 'M'

-- quantidade total de funcionários do sexo Feminino

SELECT
	COUNT (FirstName) AS 'Numero de Funcionárias'
FROM 
	DimEmployee 
WHERE 
	Gender LIKE 'F'

-- b)
-- O funcionário mais antigo

SELECT
	*
FROM 
	DimEmployee 

SELECT TOP 1
	FirstName AS 'Nome',
	EmailAddress,
	HireDate AS 'Data de Contratação'
FROM 
	DimEmployee
WHERE
	Gender = 'M'
ORDER BY
	HireDate ASC

-- A funcionária mais antiga:

SELECT TOP 1
	FirstName + LastName AS 'Nome Completo',
	EmailAddress,
	HireDate AS 'Data de Contratação'
FROM 
	DimEmployee
WHERE
	Gender = 'F'
ORDER BY
	HireDate ASC


-- 5. Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes informações:
-- a) Quantidade distinta de cores de produtos.
-- b) Quantidade distinta de marcas
-- c) Quantidade distinta de classes de produto
-- Para simplificar, você pode fazer isso em uma mesma consulta.

SELECT
	COUNT (DISTINCT ColorName) AS 'Ouantidade de Cores Diferentes',
	COUNT (DISTINCT BrandName) AS 'Ouantidade de Marcas Diferentes',
	COUNT (DISTINCT ClassName) AS 'Ouantidade de Classes Diferentes'
FROM
	DimProduct
