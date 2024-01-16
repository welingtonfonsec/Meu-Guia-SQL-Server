-- 1. Quando estamos manipulando tabelas, é importante pensar em como os dados serão apresentados em um relatório. 
-- Imagine os nomes dos produtos da tabela DimProduct. Os textos são bem grandes e pode ser que mostrar os nomes 
-- completos dos produtos não seja a opção mais interessante, pois provavelmente não vão caber em um gráfico e a visualização ficará ruim.

-- a) Seu gestor te pede para listar todos os produtos para que seja criado um gráfico para ser apresentado na reunião diária de equipe. 
--Faça uma consulta à tabela DimProduct que retorne (1) o nome do produto e (2) a quantidade de caracteres que cada produto tem, e ordene 
--essa tabela do produto com a maior quantidade de caracteres para a menor.


SELECT
	ProductName AS 'Nome do Produto',
	LEN (ProductName) AS 'Qtd. Caracteres'  -- Apenas conta caracteres
FROM DimProduct
ORDER BY 
	LEN (ProductName) DESC
	
-- ou 

SELECT
	ProductName AS 'Nome do Produto',
	DATALENGTH (ProductName) AS 'Qtd. Caracteres'  -- Caracteres e espaços
FROM DimProduct
ORDER BY 
	DATALENGTH (ProductName) DESC

-- b) Qual é a média de caracteres dos nomes dos produtos?

SELECT
	AVG (LEN (ProductName)) AS 'Qtd Média de Caracteres'  -- Apenas conta caracteres
FROM DimProduct

-- ou

SELECT
	AVG (DATALENGTH (ProductName)) AS 'Qtd Média de Caracteres'  -- Caracteres e espaços
FROM 
	DimProduct

-- c) Analise a estrutura dos nomes dos produtos e verifique se seria possível reduzir o tamanho do nome dos produtos. 
-- (Dica: existem informações redundantes nos nomes dos produtos? Seria possível substituí-las?)

-- É IDENTIFICADO QUE AS INFORMAÇÕES DE BrandName e ColorName são redundantes na coluna de nomes de produtos, pois ja existem colunas 
-- específicas para isso

SELECT
	ProductName,
	BrandName,
	ColorName,
	REPLACE(REPLACE(ProductName, BrandName, ''), ColorName, '')  AS 'Nome do Produto - Limpo'
FROM 
	DimProduct



-- d) Qual é a média de caracteres nesse novo cenário?

SELECT
	AVG(LEN(REPLACE(REPLACE(ProductName, BrandName, ''), ColorName, ''))) AS 'Nome do Produto - Limpo'
FROM 
	DimProduct



-- 2. A coluna StyleName da tabela DimProduct possui alguns códigos identificados por números distintos, que vão de 0 até 9, 
--como pode ser visto no exemplo abaixo.

-- Porém, o setor de controle decidiu alterar a identificação do StyleName, e em vez de usar números, a ideia agora é passar a usar 
-- letras para substituir os números, conforme exemplo abaixo:
-- 0 -> A, 1 -> B, 2 -> C, 3 -> D, 4 -> E, 5 -> F, 6 -> G, 7 -> H, 8 -> I, 9 - J
-- É de sua responsabilidade alterar os números por letras na coluna StyleName da tabela DimProduct. Utilize uma função que permita 
-- fazer essas substituições de forma prática e rápida.

SELECT StyleName FROM DimProduct

SELECT 
	ProductName AS 'Nome do Produto',
	StyleName AS 'ID',
	TRANSLATE(StyleName, '0123456789', 'ABCDEFGHIJ') AS	'Novo ID'
FROM DimProduct

-- 3. O setor de TI está criando um sistema para acompanhamento individual de cada funcionário da empresa Contoso. 
-- Cada funcionário receberá um login e senha. O login de cada funcionário será o ID do e-mail, como no exemplo abaixo:

-- Já a senha será o FirtName + o dia do ano em que o funcionário nasceu, em MAIÚSCULA. Por exemplo, o funcionário com 
--E-mail: mark0@contoso.com e data de nascimento 15/01/1990 deverá ter a seguinte senha:
--Login: mark0
--Senha: MARK15
--O responsável pelo TI pediu a sua ajuda para retornar uma tabela contendo as seguintes colunas da tabela DimEmployee: Nome completo 
-- (FirstName + LastName), E-mail, ID do e-mail e Senha.

SELECT * FROM DimEmployee

SELECT 
    CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
    EmailAddress AS 'E-mail',
    LEFT(EmailAddress, CHARINDEX('@', EmailAddress) - 1) AS 'Login', 
    UPPER(FirstName + DATENAME(DAYOFYEAR, BirthDate)) AS 'Senha'
FROM 
	DimEmployee


-- 4. A tabela DimCustomer possui o primeiro registro de vendas no ano de 2001.
--Como forma de reconhecer os clientes que compraram nesse ano, o setor de Marketing solicitou a você que retornasse 
--uma tabela com todos os clientes que fizeram a sua primeira compra neste ano para que seja enviado uma encomenda com 
--um presente para cada um.
-- Para fazer esse filtro, você pode utilizar a coluna DateFirstPurchase, que contém a informação da data da primeira 
-- compra de cada cliente na tabela DimCustomer.
-- Você deverá retornar as colunas de FirstName, EmailAddress, AddressLine1 e DateFirstPurchase da tabela DimCustomer, 
-- considerando apenas os clientes que fizeram a primeira compra no ano de 2001.

SELECT * FROM DimCustomer

SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	AddressLine1 AS	'Endereço',
	DateFirstPurchase AS 'Data Primeira Compra'
FROM 
	DimCustomer
Where
	DATENAME(YEAR, DateFirstPurchase) = 2001

-- 5. A tabela DimEmployee possui uma informação de data de contratação (HireDate). A área de RH, no entanto, precisa das informações 
--dessas datas de forma separada em dia, mês e ano, pois será feita uma automatização para criação de um relatório de RH, e facilitaria
--muito se essas informações estivessem separadas em uma tabela.
--Você deverá realizar uma consulta à tabela DimEmployee e retornar uma tabela contendo as seguintes informações: FirstName, 
--EmailAddress, HireDate, além das colunas de Dia, Mês e Ano de contratação.
--Obs1: A coluna de Mês deve conter o nome do mês por extenso, e não o número do mês.
--Obs2: Lembre-se de nomear cada uma dessas colunas em sua consulta para garantir que o entendimento de cada informação ficará 100% claro.


SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	DAY(HireDate) AS 'Dia',
	FORMAT(CAST(HireDate AS DATETIME), 'MMMM') AS 'Mês',
	YEAR (HireDate) AS 'Ano'
FROM 
	DimEmployee

-- 6. Descubra qual é a loja que possui o maior tempo de atividade (em dias). 
-- Você deverá fazer essa consulta na tabela DimStore, e considerar a coluna OpenDate como referência para esse cálculo.
-- Considerando apenas as lojas que ainda estão funcionando.

SELECT
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura',
	CloseDate AS 'Data de Fechamento',
	DATEDIFF(DAY, OpenDate, GETDATE()) AS 'Dias em Atividade'
FROM 
	DimStore
WHERE 
	CloseDate IS NULL 
ORDER BY 
	DATEDIFF(DAY, OpenDate, GETDATE()) DESC

