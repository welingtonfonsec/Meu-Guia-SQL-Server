-- EXERCICIO

-- 1. O gerente comercial pediu a voc� uma an�lise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais importante 
--da empresa: Store. Utilize uma fun��o SQL para fazer essas consultas no seu banco de dados. Obs: Fa�a essa an�lise considerando 
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

-- Para saber o canal de venda mais importante da empresa: Store. Temos que descobrir o n�mero da sua chave na tabela DimChannel.
-- � o n�mero 1
	


-- 2. Uma nova a��o no setor de Marketing precisar� avaliar a m�dia salarial de todos os clientes da empresa, mas apenas de ocupa��o 
--Professional. Utilize um comando SQL para atingir esse resultado.

SELECT
	AVG (YearlyIncome) AS 'M�dia Salarial de Clientes de Ocupa��o Professional '
FROM
	DimCustomer
WHERE
	Occupation = 'Professional'

-- 3. Voc� precisar� fazer uma an�lise da quantidade de funcion�rios das lojas registradas na empresa. 
--O seu gerente te pediu os seguintes n�meros e informa��es:
-- a) Quantos funcion�rios tem a loja com mais funcion�rios?
-- b) Qual � o nome dessa loja?
-- c) Quantos funcion�rios tem a loja com menos funcion�rios?
-- d) Qual � o nome dessa loja?

-- a) Quantos funcion�rios tem a loja com mais funcion�rios?

SELECT  
	MAX (EmployeeCount) AS 'Maior Qtd. de Funcion�rios'
FROM 
	DimStore

-- b) Qual � o nome dessa loja?

SELECT TOP 1
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. Funcion�rios'
FROM 
	DimStore
Order BY 
	EmployeeCount DESC

-- c) Quantos funcion�rios tem a loja com menos funcion�rios?

SELECT  
	MIN (EmployeeCount) AS 'Maior Qtd. de Funcion�rios'
FROM 
	DimStore

-- d) Qual � o nome dessa loja?

SELECT TOP 1
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. Funcion�rios'
FROM 
	DimStore
WHERE
	EmployeeCount IS NOT NULL
Order BY 
	EmployeeCount ASC

-- Se essa letra d) fosse feita de maneira similar ao da letra b), o resultado estaria errado. Pela raz�o de que na coluna
-- EmployeeCount possui valores NULL, que para o SQL tem valor de 0. Logo a fun��o IS NOT NULL � necess�ria.


SELECT 
	StoreName,
	EmployeeCount
FROM 
	DimStore
WHERE 
	EmployeeCount = (SELECT MIN(EmployeeCount) FROM DimStore);

-- 4. A �rea de RH est� com uma nova a��o para a empresa, e para isso precisa saber a quantidade total de funcion�rios do sexo Masculino 
-- e do sexo Feminino.
-- a) Descubra essas duas informa��es utilizando o SQL.
-- b) O funcion�rio e a funcion�ria mais antigos receber�o uma homenagem. Descubra as seguintes informa��es de 
-- cada um deles: Nome, E-mail, Data de Contrata��o.

-- a) 
-- quantidade total de funcion�rios do sexo Masculino   

SELECT
	COUNT (FirstName) AS 'Numero de Funcion�rias'
FROM 
	DimEmployee 
WHERE 
	Gender = 'M'

-- quantidade total de funcion�rios do sexo Feminino

SELECT
	COUNT (FirstName) AS 'Numero de Funcion�rias'
FROM 
	DimEmployee 
WHERE 
	Gender LIKE 'F'

-- b)
-- O funcion�rio mais antigo

SELECT
	*
FROM 
	DimEmployee 

SELECT TOP 1
	FirstName AS 'Nome',
	EmailAddress,
	HireDate AS 'Data de Contrata��o'
FROM 
	DimEmployee
WHERE
	Gender = 'M'
ORDER BY
	HireDate ASC

-- A funcion�ria mais antiga:

SELECT TOP 1
	FirstName + LastName AS 'Nome Completo',
	EmailAddress,
	HireDate AS 'Data de Contrata��o'
FROM 
	DimEmployee
WHERE
	Gender = 'F'
ORDER BY
	HireDate ASC


-- 5. Agora voc� precisa fazer uma an�lise dos produtos. Ser� necess�rio descobrir as seguintes informa��es:
-- a) Quantidade distinta de cores de produtos.
-- b) Quantidade distinta de marcas
-- c) Quantidade distinta de classes de produto
-- Para simplificar, voc� pode fazer isso em uma mesma consulta.

SELECT
	COUNT (DISTINCT ColorName) AS 'Ouantidade de Cores Diferentes',
	COUNT (DISTINCT BrandName) AS 'Ouantidade de Marcas Diferentes',
	COUNT (DISTINCT ClassName) AS 'Ouantidade de Classes Diferentes'
FROM
	DimProduct
