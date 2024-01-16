--1 -  Voc� � o gerente da �rea de compras e precisa criar um relat�rio com as TOP 100 vendas, de acordo com a quantidade vendida. Voc� precisa fazer isso em 10min pois o diretor de compras solicitou essa informa��o para apresentar em uma reuni�o.
--Utilize seu conhecimento em SQL para buscar essas TOP 100 vendas, de acordo com o total vendido (SalesAmount).

SELECT 
	TOP (100) *
FROM 
	FactSales
ORDER BY 
	SalesAmount DESC

--2 - Os TOP 10 produtos com maior UnitPrice possuem exatamente o mesmo pre�o. Por�m, a empresa quer diferenciar esses pre�os de acordo com o peso (Weight) 
-- de cada um.
-- O que voc� precisar� fazer � ordenar esses top 10 produtos, de acordo com a coluna de UnitPrice e, al�m disso, estabelecer um crit�rio de desempate, 
-- para que seja mostrado na ordem, do maior para o menor.
-- Caso ainda assim haja um empate entre 2 ou mais produtos, pense em uma forma de criar um segundo crit�rio de desempate (al�m do peso).

SELECT TOP 10
	ProductName AS 'Nome do Produto',
	UnitPrice AS 'Pre�o Unitario',
	Weight AS 'Peso',
	Size As 'Tamanho' 
FROM 
	DimProduct
ORDER BY UnitPrice DESC, Weight DESC, Size DESC
-- EXISTIRAM PRODUTOS COM O MESMO PESO, USEI A COLUNA Size (tamanho) como mais crit�rio de desempate


--3 - Voc� � respons�vel pelo setor de log�stica da empresa Contoso e precisa dimensionar o transporte de todos os produtos em categorias, 
-- de acordo com o peso.
-- Os produtos da categoria A, com peso acima de 100kg, dever�o ser transportados na primeira leva.
-- Fa�a uma consulta no banco de dados para descobrir quais s�o estes produtos que est�o na categoria A.

--a) Voc� dever� retornar apenas 2 colunas nessa consulta: Nome do Produto e Peso.
--b) Renomeie essas colunas com nomes mais intuitivos.
--c) Ordene esses produtos do mais pesado para o mais leve.

SELECT
	ProductName As 'Nome do Produto',
	Weight As 'Peso'
FROM
	DimProduct
WHERE 
	Weight > 100 
ORDER BY
	Weight DESC


--4. Voc� foi alocado para criar um relat�rio das lojas registradas atualmente na Contoso.
--a) Descubra quantas lojas a empresa tem no total. Na consulta que voc� dever� fazer � tabela DimStore, 
--retorne as seguintes informa��es: StoreName, OpenDate, EmployeeCount
--b) Renomeeie as colunas anteriores para deixar a sua consulta mais intuitiva.
--c) Dessas lojas, descubra quantas (e quais) lojas ainda est�o ativas.

SELECT 
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura',
	EmployeeCount AS 'Qtd Funcionarios'
FROM
	DimStore
WHERE
	StoreType = 'Store' AND Status = 'On'

--5. O gerente da �rea de controle de qualidade notificou � Contoso que todos os produtos Home Theater da marca Litware, 
--disponibilizados para venda no dia 15 de mar�o de 2009, foram identificados com defeitos de f�brica.
--O que voc� dever� fazer � identificar os ID�s desses produtos e repassar ao gerente para que ele possa notificar as lojas 
--e consequentemente solicitar a suspens�o das vendas desses produtos.

SELECT
	*
FROM 
	DimProduct 
WHERE 
	ProductName LIKE '%Home Theater%' 
	AND BrandName = 'Litware' 
	AND AvailableForSaleDate = '20090315';	
-- Normalmente seria usada a data nesse formato 2009-03-15 se o formato da coluna for apenas yyyy-mm-dd, 
--por�m a coluna consultada � do tipo data-hora: yyyy-mm-dd hh:mm:ss.ccc.
-- Nesse caso, o SQL n�o ir� funcionar da forma com '-'. 
--Se for retirado os '-' e a data for consultada assim yyyymmdd, funcionar�. 
	
--6. Imagine que voc� precise extrair um relat�rio da tabela DimStore, com informa��es de lojas. Mas voc� precisa apenas das lojas que 
--n�o est�o mais funcionando atualmente.
--a) Utilize a coluna de Status para filtrar a tabela e trazer apenas as lojas que n�o est�o mais funcionando.

SELECT 
	*
FROM
	DimStore
WHERE
	Status = 'off'

--b) Agora imagine que essa coluna de Status n�o existe na sua tabela. Qual seria a outra forma que voc� teria de descobrir quais s�o 
--as lojas que n�o est�o mais funcionando?

SELECT 
	*
FROM
	DimStore
WHERE
	CloseDate IS NOT NULL
-- As linhas da coluna CloseDate preenchidas com NULL s�o de lojas que ainda est�o ativas.

--7. De acordo com a quantidade de funcion�rios, cada loja receber� uma determinada quantidade de m�quinas de caf�. 
--As lojas ser�o divididas em 3 categorias:
--CATEGORIA 1: De 1 a 20 funcion�rios -> 1 m�quina de caf�
--CATEGORIA 2: De 21 a 50 funcion�rios -> 2 m�quinas de caf�
--CATEGORIA 3: Acima de 51 funcion�rios -> 3 m�quinas de caf�
--Identifique, para cada caso, quais s�o as lojas de cada uma das 3 categorias acima (basta fazer uma verifica��o).

--CATEGORIA 1: De 1 a 20 funcion�rios -> 1 m�quina de caf�

SELECT
	*
FROM
	DimStore
WHERE
	EmployeeCount BETWEEN '1' AND '20'

--CATEGORIA 2: De 21 a 50 funcion�rios -> 2 m�quinas de caf�

SELECT
	*
FROM
	DimStore
WHERE
	EmployeeCount BETWEEN '21' AND '50'

--CATEGORIA 3: Acima de 51 funcion�rios -> 3 m�quinas de caf�

SELECT
	*
FROM
	DimStore
WHERE
	EmployeeCount >= 51

--8. A empresa decidiu que todas as televis�es de LCD receber�o um super desconto no pr�ximo m�s. O seu trabalho � fazer uma consulta 
--� tabela DimProduct e retornar os ID�s, Nomes e Pre�os de todos os produtos LCD existentes.

SELECT
	ProductKey AS 'ID',
	ProductName AS 'Nome',
	UnitPrice AS 'Pre�o Unit�rio'
FROM
	DimProduct
WHERE 
	ProductName LIKE '%LCD%' 


--9. Fa�a uma lista com todos os produtos das cores: Green, Orange, Black, Silver e Pink. Estes produtos devem ser exclusivamente das marcas: 
--Contoso, Litware e Fabrikam.

SELECT 
	*
FROM
	DimProduct
WHERE
	ColorName IN ('Green', 'Orange', 'Black', 'Silver', 'Pink')
	AND BrandName IN('Contoso', 'Litware', 'Fabrikam') 

--10. A empresa possui 16 produtos da marca Contoso, da cor Silver e com um Weight entre 10 e 30. Descubra quais s�o esses 
--produtos e ordene o resultado em ordem decrescente de acordo com o pre�o (UnitPrice).

SELECT 
	*
FROM
	DimProduct
WHERE
	BrandName = 'Contoso'
	AND ColorName = 'Silver'
	AND Weight BETWEEN 10 AND 30
ORDER BY
	UnitPrice DESC