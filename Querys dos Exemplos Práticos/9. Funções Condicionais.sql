--1. O setor de vendas decidiu aplicar um desconto aos produtos de acordo com a sua classe. O percentual aplicado dever� ser de:
--Economy -> 5%
--Regular -> 7%
--Deluxe -> 9%

--a) Fa�a uma consulta � tabela DimProduct que retorne as seguintes colunas: ProductKey, ProductName, e outras duas colunas que dever�o retornar o % de Desconto e UnitPrice com desconto.

SELECT * FROM DimProduct

SELECT 
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	ClassName AS 'Classe',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE	
		WHEN ClassName = 'Economy' THEN 0.05
		WHEN ClassName = 'Regular' THEN 0.07
		ELSE 0.09
	END AS 'Desconto',
	CASE	
		WHEN ClassName = 'Economy' THEN (1 - 0.05) * UnitPrice
		WHEN ClassName = 'Regular' THEN (1 - 0.07) * UnitPrice
        ELSE (1 - 0.09) * UnitPrice
	END AS 'Pre�o com Desconto'
FROM 
    DimProduct


--b) Fa�a uma adapta��o no c�digo para que os % de desconto de 5%, 7% e 9% sejam facilmente modificados (dica: utilize vari�veis).

DECLARE @varDescEco FLOAT, @varDescReg FLOAT, @varDescDel FLOAT
SET @varDescEco = 0.05
SET @varDescReg = 0.07
SET @varDescDel = 0.09
	
SELECT 
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	ClassName AS 'Classe',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE	
		WHEN ClassName = 'Economy' THEN 0.05
		WHEN ClassName = 'Regular' THEN 0.07
		ELSE 0.09
	END AS 'Desconto',
	CASE	
		WHEN ClassName = 'Economy' THEN (1 - @varDescEco) * UnitPrice
		WHEN ClassName = 'Regular' THEN (1 - @varDescReg) * UnitPrice
        ELSE (1 - @varDescDel) * UnitPrice
	END AS 'Pre�o com Desconto'
FROM 
    DimProduct



--2. Voc� ficou respons�vel pelo controle de produtos da empresa e dever� fazer uma an�lise da quantidade de produtos por Marca.
--A divis�o das marcas em categorias dever� ser a seguinte:
--CATEGORIA A: Mais de 500 produtos
--CATEGORIA B: Entre 100 e 500 produtos
--CATEGORIA C: Menos de 100 produtos
--Fa�a uma consulta � tabela DimProduct e retorne uma tabela com um agrupamento de Total de Produtos por Marca, al�m da coluna de 
--Categoria, conforme a regra acima.

SELECT
	BrandName AS 'Marca',
	COUNT(*) AS 'Qnt de Produtos',
	CASE
		WHEN COUNT(*) >= 500 THEN 'Categoria A'
		WHEN COUNT(*) >= 100 THEN 'Categoria B'
		ELSE 'Categoria C'
	END AS 'Categoria'
FROM 
	DimProduct
GROUP BY 
	BrandName


-- 3. Ser� necess�rio criar uma categoriza��o de cada loja da empresa considerando a quantidade de funcion�rios de cada uma. 
--A l�gica a ser seguida ser� a l�gica abaixo:

--EmployeeCount >= 50; 'Acima de 50 funcion�rios'
--EmployeeCount >= 40; 'Entre 40 e 50 funcion�rios'
--EmployeeCount >= 30; 'Entre 30 e 40 funcion�rios'
--EmployeeCount >= 20; 'Entre 20 e 30 funcion�rios'
--EmployeeCount >= 40; 'Entre 10 e 20 funcion�rios'
--Caso contr�rio: 'Abaixo de 10 funcion�rios'

--Fa�a uma consulta � tabela DimStore que retorne as seguintes informa��es: StoreName, EmployeeCount e a coluna de categoria, 
--seguindo a regra acima.

SELECT
	StoreName AS 'Nome da Loja', 
	EmployeeCount AS 'Qtd de Funcion�rios',
	CASE 
		WHEN EmployeeCount >= 50 THEN 'Acima de 50 funcion�rios'
		WHEN EmployeeCount >= 40 THEN 'Entre 40 e 50 funcion�rios'
		WHEN EmployeeCount >= 30 THEN 'Entre de 30 e 40 funcion�rios'
		WHEN EmployeeCount >= 20 THEN 'Entre de 20 e 30 funcion�rios'
		ELSE 'Entre de 10 e 20 funcion�rios'
	END AS 'Categoria'
FROM
	DimStore
GROUP BY
	StoreName,
	EmployeeCount


--4. O setor de log�stica dever� realizar um transporte de carga dos produtos que est�o no dep�sito de Seattle para o dep�sito de Sunnyside.
-- N�o se tem muitas informa��es sobre os produtos que est�o no dep�sito, apenas se sabe que existem 100 exemplares de cada Subcategoria. 
-- Ou seja, 100 laptops, 100 c�meras digitais, 100 ventiladores, e assim vai.
-- O gerente de log�stica definiu que os produtos ser�o transportados por duas rotas distintas. 
-- Al�m disso, a divis�o dos produtos em cada uma das rotas ser� feita de acordo com as subcategorias (ou seja, todos os produtos de 
-- uma mesma subcategoria ser�o transportados pela mesma rota):
--Rota 1: As subcategorias que tiverem uma soma total menor que 1000 kg dever�o ser transportados pela Rota 1.
--Rota 2: As subcategorias que tiverem uma soma total maior ou igual a 1000 kg dever�o ser transportados pela Rota 2.
--Voc� dever� realizar uma consulta � tabela DimProduct e fazer essa divis�o das subcategorias por cada rota. Algumas dicas:
-- - Dica 1: A sua consulta dever� ter um total de 3 colunas: Nome da Subcategoria, Peso Total e Rota.
-- - Dica 2: Como n�o se sabe quais produtos existem no dep�sito, apenas que existem 100 exemplares de cada subcategoria, voc� 
-- dever� descobrir o peso m�dio de cada subcategoria e multiplicar essa m�dia por 100, de forma que voc� descubra aproximadamente 
-- qual � o peso total dos produtos por subcategoria.
-- - Dica 3: Sua resposta final dever� ter um JOIN e um GROUP BY.

SELECT 
	ProductSubCategoryName AS 'Nome da Subcategoria',
	ROUND(AVG(Weight), 2) AS 'Peso M�dio', -- Coloquei essa coluna apenas com a inten��o de organiza��o
	ROUND(AVG(Weight) * 100, 2) AS 'Peso Total', -- Multiplica por 100 pelo motivo de existirem 100 produtos para cada categoria
	CASE 
		WHEN ROUND(AVG(Weight) * 100, 2) >= 1000 THEN '2'
		ELSE '1'
	END AS 'Rota'
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductCategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
GROUP BY
	ProductSubCategoryName


--5. O setor de marketing est� com algumas ideias de a��es para alavancar as vendas em 2021. Uma delas consiste em realizar 
-- sorteios entre os clientes da empresa.
--Este sorteio ser� dividido em categorias:
--�Sorteio M�e do Ano�: Nessa categoria v�o participar todas as mulheres com filhos.
--�Sorteio Pai do Ano�: Nessa categoria v�o participar todos os pais com filhos.
--�Caminh�o de Pr�mios�: Nessa categoria v�o participar todas os demais clientes (homens e mulheres sem filhos).
--Seu papel ser� realizar uma consulta � tabela DimCustomer e retornar 3 colunas:
-- - FirstName AS �Nome�
-- - Gender AS �Sexo�
-- - TotalChildren AS �Qtd. Filhos�
-- - EmailAdress AS �E-mail�
-- - A��o de Marketing: nessa coluna voc� dever� dividir os clientes de acordo com as categorias �Sorteio M�e do Ano�, 
--�Sorteio Pai do Ano� e �Caminh�o de Pr�mios�.


SELECT
	CONCAT(FirstName,' ',LastName) AS 'Nome Completo',
	Gender AS 'Sexo',
	TotalChildren AS 'Qtd. Filhos',
	EmailAddress AS 'E-mail',
	CASE
		WHEN TotalChildren >= 1 AND Gender = 'F' THEN 'Sorteio M�e do Ano'
		WHEN TotalChildren >= 1 AND Gender = 'M' THEN 'Sorteio Pai do Ano'
		ELSE 'Caminh�o de Pr�mios'
	END AS 'A��o de Marketing'
FROM 
	DimCustomer


-- 6. Descubra qual � a loja que possui o maior tempo de atividade (em dias). Voc� dever� fazer essa consulta na tabela DimStore, 
-- e considerar a coluna OpenDate como refer�ncia para esse c�lculo.
-- Aten��o: lembre-se que existem lojas que foram fechadas.

-- OBSERVA��O: Essa resolu��o � um aprimoramento do exerc�cio do assunto anterior. Note que ele n�o leva
-- em considera��o as empresas que t�m data de fechamento. veja abaixo: primeiro a resolu��o antiga e depois o aprimoramento



-- Resolu��o antiga. 294 linhas (N�o levou em considera��o as empresas que fecharam as portas)

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



-- Resolu��o aprimorada. 306 linhas (leva em conta as empresas que fecharam as portas

SELECT
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura',
	CloseDate AS 'Data de Fechamento',
	CASE
		WHEN CloseDate IS NULL THEN DATEDIFF(DAY, OpenDate, GETDATE()) -- leva em conta apenas a data de abertura e a data de hoje
		ELSE DATEDIFF(DAY, OpenDate, CloseDate) -- leva em conta a data de abertura e a data de fechamento
	END 'Dias em Atividade'
FROM 
	DimStore
