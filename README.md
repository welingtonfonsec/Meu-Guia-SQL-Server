## Índice

[1. Introdução ao SQL](#introdução-ao-SQL)

[2. Ordenando e Filtrando Dados](#ordenando-e-filtrando-dados)

[3. Funções de Agregação ](#funções-de-agregação)

[4. Criando Agrupamentos no SQL](#criando-agrupamentos-no-sql)

[5. JOINs no SQL](#joins-no-sql)

[6. Group By + Joins + Aplicações](#group-by-+-joins+aplicações)

[7. Variáveis](#variaveis)

[8. Manipulando Strings e Datas no SQL](#manipulando-strings-e-datas-no-sql)

[9. Funções Condicionais](#funções-condicionais)

[10. SQL Views](#sql-views)

[11. CRUD](#CRUD)

[12. Subqueries e CTE's](#Subqueries-cte's)

[13. Loops no SQL](#loops-no-sql)

[14. Window Functions](#windows-function)

[15. Regex - Regular Expressions](#regex-regular-expressions)


## Ordenando e Filtrando Dados

#### ORDER BY

A cláusula ORDER BY é usada para ordenar o resultado de uma consulta em ordem ascendente (ASC) ou descendente (DESC) com base em uma ou mais colunas.

Exemplo:

```
SELECT NomeProduto, PrecoUnitario
FROM Produtos
ORDER BY PrecoUnitario DESC;
Neste exemplo, a consulta retorna o nome do produto e o preço unitário, ordenados em ordem decrescente pelo preço unitário.
```

#### WHERE

A cláusula WHERE é utilizada para filtrar registros com base em uma condição específica.

Exemplo:
```
Copy code
SELECT NomeCliente, ValorCompra
FROM Compras
WHERE ValorCompra > 1000;
Neste exemplo, a consulta retorna o nome do cliente e o valor da compra apenas para compras com valor superior a 1000.
```

#### OR

O operador OR é usado para combinar duas ou mais condições na cláusula WHERE.

Exemplo:

```
SELECT NomeProduto, QuantidadeEstoque
FROM Estoque
WHERE Categoria = 'Eletrônicos' OR QuantidadeEstoque > 50;
Neste exemplo, a consulta retorna produtos na categoria 'Eletrônicos' ou com mais de 50 unidades em estoque.
```

#### AND

O operador AND é utilizado para combinar duas ou mais condições na cláusula WHERE.

```
SELECT NomeCliente, ValorCompra
FROM Compras
WHERE ValorCompra > 500 AND ValorCompra < 1000;
Neste exemplo, a consulta retorna o nome do cliente e o valor da compra para compras com valores entre 500 e 1000.
```

#### NOT

O operador NOT é usado para negar uma condição na cláusula WHERE.

Exemplo:

```
SELECT NomeProduto, QuantidadeEstoque
FROM Estoque
WHERE NOT Categoria = 'Perfumaria';
Neste exemplo, a consulta retorna produtos que não pertencem à categoria 'Perfumaria'.
```

#### IN

O operador IN é usado para filtrar registros com base em uma lista de valores.

Exemplo:

```
SELECT NomeProduto, Categoria
FROM Produtos
WHERE Categoria IN ('Eletrônicos', 'Móveis', 'Decoração');
Neste exemplo, a consulta retorna produtos nas categorias 'Eletrônicos', 'Móveis' ou 'Decoração'.
```

#### LIKE

O operador LIKE é utilizado para realizar buscas de padrões em uma coluna.

Exemplo:

```
SELECT NomeCliente
FROM Clientes
WHERE NomeCliente LIKE 'A%';
Neste exemplo, a consulta retorna clientes cujos nomes começam com a letra 'A'.
```

#### IS NULL / IS NOT NULL:

As condições IS NULL e IS NOT NULL são utilizadas para verificar se um valor em uma coluna é nulo ou não nulo, respectivamente.

Exemplo:

```
SELECT NomeFuncionario
FROM Funcionarios
WHERE DataDemissao IS NULL;
Neste exemplo, a consulta retorna funcionários que ainda não foram demitidos (data de demissão é nula).
```

#### BETWEEN:

O operador BETWEEN é usado para filtrar registros com base em um intervalo de valores.

Exemplo:

```
SELECT NomeProduto, PrecoUnitario
FROM Produtos
WHERE PrecoUnitario BETWEEN 50 AND 100;
Neste exemplo, a consulta retorna produtos com preço unitário entre 50 e 100.
```

### Exemplos Práticos 

1 - Você é o gerente da área de compras e precisa criar um relatório com as TOP 100 vendas, de acordo com a quantidade vendida. Você precisa fazer isso em 10min pois o diretor de compras solicitou essa informação para apresentar em uma reunião. Utilize seu conhecimento em SQL para buscar essas TOP 100 vendas, de acordo com o total vendido (SalesAmount).
```
SELECT 
	TOP (100) *
FROM 
	FactSales
ORDER BY 
	SalesAmount DESC
```

2 - Os TOP 10 produtos com maior UnitPrice possuem exatamente o mesmo preço. Porém, a empresa quer diferenciar esses preços de acordo com o peso (Weight) de cada um.
O que você precisará fazer é ordenar esses top 10 produtos, de acordo com a coluna de UnitPrice e, além disso, estabelecer um critério de desempate, para que seja mostrado na ordem, do maior para o menor. Caso ainda assim haja um empate entre 2 ou mais produtos, pense em uma forma de criar um segundo critério de desempate (além do peso).
```
SELECT TOP 10
	ProductName AS 'Nome do Produto',
	UnitPrice AS 'Preço Unitario',
	Weight AS 'Peso',
	Size As 'Tamanho' 
FROM 
	DimProduct
ORDER BY UnitPrice DESC, Weight DESC, Size DESC
-- EXISTIRAM PRODUTOS COM O MESMO PESO, USEI A COLUNA Size (tamanho) como mais critério de desempate
```

3 - Você é responsável pelo setor de logística da empresa Contoso e precisa dimensionar o transporte de todos os produtos em categorias, de acordo com o peso. Os produtos da categoria A, com peso acima de 100kg, deverão ser transportados na primeira leva. Faça uma consulta no banco de dados para descobrir quais são estes produtos que estão na categoria A.

  * a) Você deverá retornar apenas 2 colunas nessa consulta: Nome do Produto e Peso.
  * b) Renomeie essas colunas com nomes mais intuitivos.
  * c) Ordene esses produtos do mais pesado para o mais leve.
```
SELECT
	ProductName As 'Nome do Produto',
	Weight As 'Peso'
FROM
	DimProduct
WHERE 
	Weight > 100 
ORDER BY
	Weight DESC
```

4 - Você foi alocado para criar um relatório das lojas registradas atualmente na Contoso.

  * a) Descubra quantas lojas a empresa tem no total. Na consulta que você deverá fazer à tabela DimStore, retorne as seguintes informações: StoreName, OpenDate, EmployeeCount
  * b) Renomeeie as colunas anteriores para deixar a sua consulta mais intuitiva.
  * c) Dessas lojas, descubra quantas (e quais) lojas ainda estão ativas.
```
SELECT 
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura',
	EmployeeCount AS 'Qtd Funcionarios'
FROM
	DimStore
WHERE
	StoreType = 'Store' AND Status = 'On'
```

5 - O gerente da área de controle de qualidade notificou à Contoso que todos os produtos Home Theater da marca Litware, disponibilizados para venda no dia 15 de março de 2009, foram identificados com defeitos de fábrica. O que você deverá fazer é identificar os ID’s desses produtos e repassar ao gerente para que ele possa notificar as lojas e consequentemente solicitar a suspensão das vendas desses produtos.
```
SELECT
	*
FROM 
	DimProduct 
WHERE 
	ProductName LIKE '%Home Theater%' 
	AND BrandName = 'Litware' 
	AND AvailableForSaleDate = '20090315';

-- Normalmente seria usada a data nesse formato 2009-03-15 se o formato da coluna for apenas yyyy-mm-dd, 
--porém a coluna consultada é do tipo data-hora: yyyy-mm-dd hh:mm:ss.ccc.
-- Nesse caso, o SQL não irá funcionar da forma com '-'. 
--Se for retirado os '-' e a data for consultada assim yyyymmdd, funcionará. 
```
6 - Imagine que você precise extrair um relatório da tabela DimStore, com informações de lojas. Mas você precisa apenas das lojas que não estão mais funcionando atualmente.

* a) Utilize a coluna de Status para filtrar a tabela e trazer apenas as lojas que não estão mais funcionando.
```
SELECT 
	*
FROM
	DimStore
WHERE
	Status = 'off'
```

* b) Agora imagine que essa coluna de Status não existe na sua tabela. Qual seria a outra forma que você teria de descobrir quais são as lojas que não estão mais funcionando?
```
SELECT 
	*
FROM
	DimStore
WHERE
	CloseDate IS NOT NULL
-- As linhas da coluna CloseDate preenchidas com NULL são de lojas que ainda estão ativas.
```

7 - De acordo com a quantidade de funcionários, cada loja receberá uma determinada quantidade de máquinas de café. As lojas serão divididas em 3 categorias:
  * CATEGORIA 1: De 1 a 20 funcionários -> 1 máquina de café
  * CATEGORIA 2: De 21 a 50 funcionários -> 2 máquinas de café
  * CATEGORIA 3: Acima de 51 funcionários -> 3 máquinas de café


Identifique, para cada caso, quais são as lojas de cada uma das 3 categorias acima (basta fazer uma verificação).

CATEGORIA 1: De 1 a 20 funcionários -> 1 máquina de café
```
SELECT
	*
FROM
	DimStore
WHERE
	EmployeeCount BETWEEN '1' AND '20'
```

CATEGORIA 2: De 21 a 50 funcionários -> 2 máquinas de café
```
SELECT
	*
FROM
	DimStore
WHERE
	EmployeeCount BETWEEN '21' AND '50'
```

CATEGORIA 3: Acima de 51 funcionários -> 3 máquinas de café
```
SELECT
	*
FROM
	DimStore
WHERE
	EmployeeCount >= 51
```

8 - A empresa decidiu que todas as televisões de LCD receberão um super desconto no próximo mês. O seu trabalho é fazer uma consulta à tabela DimProduct e retornar os ID’s, Nomes e Preços de todos os produtos LCD existentes.
```
SELECT
	ProductKey AS 'ID',
	ProductName AS 'Nome',
	UnitPrice AS 'Preço Unitário'
FROM
	DimProduct
WHERE 
	ProductName LIKE '%LCD%' 
```

9 - Faça uma lista com todos os produtos das cores: Green, Orange, Black, Silver e Pink. Estes produtos devem ser exclusivamente das marcas: Contoso, Litware e Fabrikam.
```
SELECT 
	*
FROM
	DimProduct
WHERE
	ColorName IN ('Green', 'Orange', 'Black', 'Silver', 'Pink')
	AND BrandName IN('Contoso', 'Litware', 'Fabrikam') 
```

10 - A empresa possui 16 produtos da marca Contoso, da cor Silver e com um Weight entre 10 e 30. Descubra quais são esses produtos e ordene o resultado em ordem decrescente de acordo com o preço (UnitPrice).
```
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
 ```

## Funções de Agregação

#### SUM

A função SUM é utilizada para calcular a soma dos valores de uma coluna.

Exemplo:
```
SELECT SUM(QuantidadeVendida)
FROM Vendas;
Neste exemplo, a consulta retorna a soma total da quantidade vendida.
```
#### COUNT

A função COUNT é utilizada para contar o número de linhas em uma consulta.

Exemplo:
```
SELECT COUNT(*)
FROM Clientes;
Neste exemplo, a consulta retorna o número total de clientes.
```
#### COUNT DISTINCT

A função COUNT DISTINCT é utilizada para contar o número de valores distintos em uma coluna.

Exemplo:
```
SELECT COUNT(DISTINCT Categoria)
FROM Produtos;
Neste exemplo, a consulta retorna o número de categorias distintas de produtos.
```
#### MIN

A função MIN é utilizada para encontrar o valor mínimo em uma coluna.

Exemplo:
```
SELECT MIN(PrecoUnitario)
FROM Produtos;
Neste exemplo, a consulta retorna o preço unitário mínimo entre todos os produtos.
```
#### MAX

A função MAX é utilizada para encontrar o valor máximo em uma coluna.

Exemplo:
```
SELECT MAX(Salario)
FROM Funcionarios;
Neste exemplo, a consulta retorna o salário máximo entre todos os funcionários.
```
#### AVG

A função AVG é utilizada para calcular a média dos valores em uma coluna.

Exemplo:
```
SELECT AVG(Idade)
FROM Clientes;
Neste exemplo, a consulta retorna a idade média dos clientes.
```

### Exemplos Práticos 

1 - O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais importante da empresa: Store. Utilize uma função SQL para fazer essas consultas no seu banco de dados. Obs: Faça essa análise considerando a tabela FactSales.
```
SELECT TOP 10
	*
FROM
	FactSales
```
```
SELECT 
	*
FROM
	DimChannel
```
```
SELECT
	SUM(SalesQuantity) AS 'Quantidade Vendida',
	SUM(ReturnQuantity) AS 'Quantidade Devolvida'
FROM
	FactSales
Where
	channelKey = '1'

-- Para saber o canal de venda mais importante da empresa: Store. Temos que descobrir o número da sua chave na tabela DimChannel.
-- É o número 1
```	


2 - Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes da empresa, mas apenas de ocupação Professional. Utilize um comando SQL para atingir esse resultado.
```
SELECT
	AVG (YearlyIncome) AS 'Média Salarial de Clientes de Ocupação Professional '
FROM
	DimCustomer
WHERE
	Occupation = 'Professional'
```
3 - Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na empresa. O seu gerente te pediu os seguintes números e informações:

  * a) Quantos funcionários tem a loja com mais funcionários?
  * b) Qual é o nome dessa loja?
  * c) Quantos funcionários tem a loja com menos funcionários?
  * d) Qual é o nome dessa loja?


a) Quantos funcionários tem a loja com mais funcionários?
```
SELECT  
	MAX (EmployeeCount) AS 'Maior Qtd. de Funcionários'
FROM 
	DimStore
```
b) Qual é o nome dessa loja?
```
SELECT TOP 1
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. Funcionários'
FROM 
	DimStore
Order BY 
	EmployeeCount DESC
```
c) Quantos funcionários tem a loja com menos funcionários?
```
SELECT  
	MIN (EmployeeCount) AS 'Maior Qtd. de Funcionários'
FROM 
	DimStore
```
d) Qual é o nome dessa loja?
```
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
```

4 - A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade total de funcionários do sexo Masculino e do sexo Feminino.
  * a) Descubra essas duas informações utilizando o SQL.
  * b) b) O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as seguintes informações de cada um deles: Nome, E-mail, Data de Contratação.

a) Quantidade total de funcionários do sexo Masculino e Feminino   
```
-- Quantidade total de funcionários do sexo Feminino
SELECT
	COUNT (FirstName) AS 'Numero de Funcionários'
FROM 
	DimEmployee 
WHERE 
	Gender = 'M'

-- Quantidade total de funcionários do sexo Feminino

SELECT
	COUNT (FirstName) AS 'Numero de Funcionárias'
FROM 
	DimEmployee 
WHERE 
	Gender LIKE 'F'
```

b) O funcionário mais antigo
```
SELECT
	*
FROM 
	DimEmployee 
```
```
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
```

A funcionária mais antiga:
```
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
```

5 - Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes informações:

Para simplificar, você pode fazer isso em uma mesma consulta.
  * a) Quantidade distinta de cores de produtos.
  * b) Quantidade distinta de marcas
  * c) Quantidade distinta de classes de produto

```
SELECT
	COUNT (DISTINCT ColorName) AS 'Ouantidade de Cores Diferentes',
	COUNT (DISTINCT BrandName) AS 'Ouantidade de Marcas Diferentes',
	COUNT (DISTINCT ClassName) AS 'Ouantidade de Classes Diferentes'
FROM
	DimProduct
```

## Criando Agrupamentos no SQL

#### GROUP BY

A cláusula GROUP BY é usada para agrupar linhas com base nos valores de uma ou mais colunas.

Exemplo:
```
SELECT Departamento, COUNT(*) as TotalFuncionarios
FROM Funcionarios
GROUP BY Departamento;
Neste exemplo, a consulta retorna o número total de funcionários agrupados por departamento.
```
#### COUNT

A função COUNT é utilizada para contar o número de linhas em cada grupo definido pelo GROUP BY.

Exemplo:
```
SELECT Departamento, COUNT(*) as TotalFuncionarios
FROM Funcionarios
GROUP BY Departamento;
Neste exemplo, a consulta retorna o número total de funcionários em cada departamento.
```
#### SUM

A função SUM é utilizada para calcular a soma dos valores de uma coluna em cada grupo definido pelo GROUP BY.

Exemplo:
```
SELECT Departamento, SUM(Salario) as TotalSalarios
FROM Funcionarios
GROUP BY Departamento;
Neste exemplo, a consulta retorna a soma total dos salários em cada departamento.
```
#### AVG

A função AVG é utilizada para calcular a média dos valores de uma coluna em cada grupo definido pelo GROUP BY.

Exemplo:
```
SELECT Departamento, AVG(Idade) as MediaIdade
FROM Funcionarios
GROUP BY Departamento;
Neste exemplo, a consulta retorna a média de idade em cada departamento.
```
#### MIN

A função MIN é utilizada para encontrar o valor mínimo em uma coluna em cada grupo definido pelo GROUP BY.

Exemplo:
```
SELECT Departamento, MIN(Salario) as MenorSalario
FROM Funcionarios
GROUP BY Departamento;
Neste exemplo, a consulta retorna o menor salário em cada departamento.
```
#### MAX

A função MAX é utilizada para encontrar o valor máximo em uma coluna em cada grupo definido pelo GROUP BY.

Exemplo:
```
SELECT Departamento, MAX(Salario) as MaiorSalario
FROM Funcionarios
GROUP BY Departamento;
Neste exemplo, a consulta retorna o maior salário em cada departamento.
```
#### HAVING

A cláusula HAVING é usada em conjunto com o GROUP BY para filtrar resultados após a aplicação da agregação.

Exemplo:
```
SELECT Departamento, AVG(Salario) as MediaSalario
FROM Funcionarios
GROUP BY Departamento
HAVING AVG(Salario) > 50000;
Neste exemplo, a consulta retorna departamentos com uma média de salário superior a 50.000.
```
#### ORDER BY

A cláusula ORDER BY pode ser usada para ordenar os resultados da consulta, inclusive em consultas que utilizam GROUP BY.

Exemplo:
```
SELECT Departamento, COUNT(*) as TotalFuncionarios
FROM Funcionarios
GROUP BY Departamento
ORDER BY TotalFuncionarios DESC;
Neste exemplo, a consulta retorna o número total de funcionários agrupados por departamento, ordenados pelo total de funcionários em ordem decrescente.
```

### Exemplos Práticos 

1 - a) Faça um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas (channelkey).
```
SELECT 
	*
FROM
	DimChannel
```
```
SELECT
	channelKey AS 'ID do Canal de Vendas' ,
	SUM (SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactSales
GROUP BY 
	channelKey
ORDER BY
	SUM (SalesQuantity) DESC
```

b) Faça um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey).
```
SELECT 
	*
FROM
	DimStore
```
```
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
```

c) Faça um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas para o ano de 2007.
```
SELECT 
	*
FROM
	DimChannel
```
```
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
```


2 - Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor total vendido (SalesAmount) por produto (ProductKey).

a) A tabela final deverá estar ordenada de acordo com a quantidade vendida e, além disso, mostrar apenas os produtos que tiveram um resultado final de vendas maior do que $5.000.000.
```
SELECT 
	*
FROM
	DimProduct
```
```
SELECT TOP 10
	*
FROM
	FactSales
```
```
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
```

b) Faça uma adaptação no exercício anterior e mostre os Top 10 produtos com mais vendas. Desconsidere o filtro de $5.000.000 aplicado.
```
SELECT TOP (10)
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Valor Total Vendido'
FROM
	FactSales
GROUP BY
	ProductKey
ORDER BY 
	SUM (SalesAmount) DESC
```

3 - a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o ID (CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).
```
SELECT TOP (1)
	CustomerKey AS 'ID do Cliente',
	SUM (SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactOnlineSales
GROUP BY
	CustomerKey
ORDER BY
	SUM (SalesQuantity) DESC
```

b) Feito isso, faça um agrupamento de total vendido (SalesQuantity) por ID do produto e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a).
```
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
```
```
SELECT 
	* 
FROM 
	DimProduct
WHERE 
 ProductKey IN ('2515','2516','2506')
```

4 - a) Faça um agrupamento e descubra a quantidade total de produtos por marca.
```
SELECT 
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Quantidade de Produtos'
FROM 
	DimProduct
GROUP BY
	BrandName 
ORDER BY
	COUNT(BrandName) DESC
```

b) Determine a média do preço unitário (UnitPrice) para cada ClassName.
```
SELECT 
	ClassName AS 'Classe',
	AVG(UnitPrice) AS 'Preço Médio'
FROM 
	DimProduct
GROUP BY
	ClassName 
ORDER BY
	AVG(UnitPrice) DESC
```

c) Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui.
```
SELECT 
	ColorName AS 'Cor',
	SUM (Weight) AS 'Peso Total'
FROM 
	DimProduct
GROUP BY
	ColorName 
ORDER BY
	SUM (Weight) DESC
```

5 - Você deverá descobrir o peso total para cada tipo de produto (StockTypeName).
A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em ordem decrescente.
```
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
```

6 - Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as 16 opções de cores?
```
SELECT
	COUNT(DISTINCT ColorName) AS 'Quantidade de Cores Diferentes'
FROM
	DimProduct

-- Faz a contagem de cores de produtos disponíveis no banco de dados. 16
```
```
SELECT
	BrandName,
	COUNT(DISTINCT ColorName) AS 'Quantidade de Cores Diferentes'
FROM
	DimProduct
GROUP BY
	BrandName
ORDER BY
	COUNT(DISTINCT ColorName) DESC
-- A conclusão: Nenhuma marca possui todas as 16 cores disponíveis para cada um de seus produtos.
```

7 - Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média salarial de acordo com o Sexo. Corrija qualquer resultado “inesperado” com os seus conhecimentos em SQL.
```
SELECT
	Gender AS 'Sexo',
	COUNT (Gender) 'Qtd Total de Clientes',
	AVG(YearlyIncome) AS 'Média Salarial'
FROM
	DimCustomer
WHERE
	Gender IS NOT NULL
GROUP BY
	Gender
ORDER BY
	AVG(YearlyIncome) DESC
```

8 - Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de acordo com o seu nível escolar. Utilize a coluna Education da tabela DimCustomer para fazer esse agrupamento.

```
SELECT
	*
FROM
	DimCustomer
```
```
SELECT
	Education AS 'Nível Educacional',
	COUNT(Education)'Número de Clientes',
	AVG(YearlyIncome) 'Média Salarial'
FROM
	DimCustomer
WHERE
	Gender IS NOT NULL
GROUP BY
	Education
ORDER BY
	AVG(YearlyIncome) DESC
```

9 - Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o Departamento (DepartmentName). Importante: Você deverá considerar apenas os funcionários ativos.
```
SELECT
	DepartmentName AS 'Departamento',
	COUNT(*) AS 'Número de Funcionários Atuais'
FROM
	DimEmployee
WHERE
	EndDate IS NULL
GROUP BY
	DepartmentName
ORDER BY
	COUNT(*)  DESC

-- Outra opção seria usar a coluna Status, e fazer um WHERE Status = 'Current'
```

10 - Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Você deve considerar apenas as mulheres, dos departamentos de Production, Marketing, Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000.
```
SELECT
	*
FROM
	DimEmployee
```
```
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
```

## JOINs no SQL

Em SQL, JOINS são utilizados para combinar linhas de duas ou mais tabelas com base em uma condição relacionada. Existem vários tipos de JOINS, cada um atendendo a diferentes cenários de relacionamento entre tabelas.

#### INNER JOIN

Retorna apenas as linhas que têm correspondência em ambas as tabelas.
Exemplo:
```
SELECT Orders.OrderID, Customers.CustomerName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
```
#### LEFT JOIN (ou LEFT OUTER JOIN)

Retorna todas as linhas da tabela à esquerda e as correspondentes da tabela à direita. Se não houver correspondência, as colunas da tabela à direita conterão valores nulos.
Exemplo:
```
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
```
#### RIGHT JOIN (ou RIGHT OUTER JOIN)

Retorna todas as linhas da tabela à direita e as correspondentes da tabela à esquerda. Se não houver correspondência, as colunas da tabela à esquerda conterão valores nulos.
Exemplo:
```
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
```
#### FULL JOIN (ou FULL OUTER JOIN)

Retorna todas as linhas quando há uma correspondência em uma das tabelas. Se não houver correspondência, as colunas sem correspondência conterão valores nulos.
Exemplo:
```
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
```
#### CROSS JOIN

Retorna o produto cartesiano de ambas as tabelas, ou seja, combina cada linha da primeira tabela com todas as linhas da segunda tabela.
Exemplo:
```
SELECT Customers.CustomerName, Products.ProductName
FROM Customers
CROSS JOIN Products;
```
#### SELF JOIN

Quando uma tabela é combinada com ela mesma para criar relacionamentos entre diferentes linhas dentro da mesma tabela.
Exemplo:
```
SELECT e1.EmployeeName AS Employee, e2.EmployeeName AS Manager
FROM Employees e1
INNER JOIN Employees e2 ON e1.ManagerID = e2.EmployeeID;
```
#### LEFT ANTI JOIN

O termo "LEFT ANTI JOIN" refere-se a uma operação que retorna todas as linhas da tabela à esquerda (tabela principal) que não têm correspondência com a tabela à direita (tabela secundária). Em outras palavras, ele retorna as linhas da tabela à esquerda que não atendem à condição de junção especificada. LEFT ANTI JOIN não é uma operação padrão em SQL.

Exemplo:
Suponha que temos duas tabelas, "Clientes" e "Pedidos", e queremos encontrar clientes que não fizeram nenhum pedido.

```
SELECT Clients.ClientID, Clients.ClientName
FROM Clients
LEFT JOIN Orders ON Clients.ClientID = Orders.ClientID
WHERE Orders.OrderID IS NULL;
```
Neste exemplo, estamos usando um "LEFT JOIN" para combinar todas as linhas da tabela "Clientes" com as linhas correspondentes da tabela "Pedidos". A condição Orders.OrderID IS NULL no WHERE filtra apenas as linhas onde não há correspondência na tabela "Pedidos", ou seja, clientes que não fizeram nenhum pedido.

Esse tipo de consulta é útil quando queremos identificar registros na tabela principal que não possuem correspondência na tabela secundária.

#### RIGHT ANTI JOIN

A expressão "RIGHT ANTI JOIN" não é uma operação padrão em SQL, e o conceito de "anti join" geralmente é aplicado a operações que envolvem um conjunto de dados complementares (complemento).

No entanto, como não existe uma sintaxe específica chamada "RIGHT ANTI JOIN", podemos simular um efeito semelhante usando outras operações de junção e condições apropriadas.

Suponha que temos as tabelas "Clientes" e "Pedidos", e queremos encontrar pedidos que não têm correspondência com clientes (um cenário incomum, mas possível):
```
SELECT Orders.OrderID, Orders.OrderDate
FROM Orders
LEFT JOIN Clients ON Orders.ClientID = Clients.ClientID
WHERE Clients.ClientID IS NULL;
```

Neste exemplo, estamos usando um "LEFT JOIN" para combinar todas as linhas da tabela "Pedidos" com as linhas correspondentes da tabela "Clientes". A condição Clients.ClientID IS NULL no WHERE filtra apenas as linhas onde não há correspondência na tabela "Clientes", ou seja, pedidos que não têm um cliente associado.

Esses exemplos ajudam a entender como os diferentes tipos de JOINS podem ser aplicados em situações diversas para recuperar dados relacionados de várias tabelas em um banco de dados.

### Exemplos Práticos 

1 - Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct
```
SELECT TOP 10 * FROM DimProduct
```
```
SELECT TOP 10 * FROM DimProductSubcategory
```
```
SELECT
	DimProduct.Productkey AS 'ID Produto', 
	DimProduct.ProductName AS 'Produto', 
	DimProduct.ProductSubcategorykey AS 'Subcategoria',
	DimProductSubcategory.ProductSubcategoryName
FROM 
	DimProduct
INNER JOIN DimProductSubcategory
ON 	DimProduct.ProductSubcategorykey = DimProductSubcategory.ProductSubcategorykey 
```

2 - Identifique uma coluna em comum entre as tabelas DimProductSubcategory e DimProductCategory. Utilize essa coluna para complementar informações na tabela DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN.
```
SELECT TOP 10 * FROM DimProductSubcategory
```
```
SELECT TOP 10 * FROM DimProductCategory
```
```
SELECT
	DimProductSubcategory.ProductSubcategoryKey AS 'ID Subproduto', 
	DimProductSubcategory.ProductSubcategoryName AS 'Subcategoria',
	DimProductCategory.ProductCategoryName AS 'Categoria'
FROM 
	DimProductSubcategory
LEFT JOIN DimProductCategory
ON 	DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey 
```
3 - Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados (de acordo com DimGeography). Seu SELECT final deve conter apenas as seguintes colunas: StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. Utilize o LEFT JOIN neste exercício.
```
SELECT TOP 10 * FROM DimStore
```
```
SELECT TOP 10 * FROM DimGeography
```
```
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
```

4 - Complementa a tabela DimProduct com a informação de ProductCategoryDescription. Utilize o LEFT JOIN e retorne em seu SELECT 
 apenas as 3 colunas que considerar mais relevantes.
 
```
SELECT TOP 10 * FROM DimProduct
```
```
SELECT TOP 10 * FROM DimProductCategory
```
```
SELECT TOP 10 * FROM DimProductSubcategory

-- MULTIPLOS JOINS - PQ A COLUNA ProductCategoryDescription NÃO ESTA RELACIONADA DIRETAMENTE COM DimProduct e DimProductCategory. 
-- Nesse sentido, é necessário usar a tabela intermediária DimProductSubcategory que possui a ProductCategoryDescription
```
```
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
```

5 - A tabela FactStrategyPlan resume o planejamento estratégico da empresa. Cada linha representa um montante destinado a uma determinada 
AccountKey.
a) Faça um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela.
```
SELECT TOP 100 * FROM FactStrategyPlan
```
b) Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada AccountKey da tabela FactStrategyPlan. O seu SELECT final deve 
conter as colunas:
• StrategyPlanKey
• DateKey
• AccountName
• Amount 

```
SELECT TOP 100 * FROM FactStrategyPlan
```
```
SELECT TOP 100 * FROM DimAccount
```
```
SELECT
	FactStrategyPlan.StrategyPlanKey,
	FactStrategyPlan.DateKey,
	FactStrategyPlan.Amount,
	DimAccount.AccountName
FROM
	FactStrategyPlan
INNER JOIN DimAccount
	ON FactStrategyPlan.AccountKey = DimAccount.AccountKey
```

6. Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que identifica o tipo de conta, há também uma outra 
coluna chamada ScenarioKey. Essa coluna possui a numeração que identifica o tipo de cenário: Real, Orçado e Previsão.
Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey da tabela FactStrategyPlan. 
O seu SELECT final deve conter as colunas:
• StrategyPlanKey
• DateKey
• ScenarioName
• Amount

```
SELECT TOP 100 * FROM FactStrategyPlan
```
```
SELECT TOP 100 * FROM DimScenario
```
```
SELECT
	FactStrategyPlan.StrategyPlanKey,
	FactStrategyPlan.DateKey,
	DimScenario.ScenarioName,
	FactStrategyPlan.Amount
FROM
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
```

7 - Algumas subcategorias não possuem nenhum exemplar de produto. Identifique que subcategorias são essas.
```
SELECT TOP 100 * FROM DimProduct
```
```
SELECT TOP 100 * FROM DimProductSubcategory
```
```
SELECT
	DimProductSubcategory.ProductSubcategoryName
FROM 
	DimProductSubcategory
LEFT JOIN DimProduct
ON DimProductSubcategory.ProductSubcategorykey = DimProduct.ProductSubcategorykey
WHERE DimProduct.Productkey IS NULL;
```

8 - Crie uma tabela que mostre a combinação entre Marca e Canal de Venda, para as marcas Contoso, Fabrikam e Litware. 
``` 
SELECT TOP 10 * FROM FactSales
```
```
SELECT TOP 10 * FROM DimProduct
```
```
SELECT TOP 10 * FROM DimChannel
```
```
SELECT
	DISTINCT DimProduct.BrandName,
	DimChannel.ChannelName
FROM
	DimProduct CROSS JOIN DimChannel
WHERE BrandName IN ('Contoso', 'Fabrikam', 'Litware')
```

9 - Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion. Identifique a coluna que as duas tabelas 
têm em comum e utilize-a para criar esse relacionamento.
Retorne uma tabela contendo as seguintes colunas:
• OnlineSalesKey
• DateKey
• PromotionName
• SalesAmount
A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com desconto (PromotionName <> ‘No Discount’).
Além disso, você deverá ordenar essa tabela de acordo com a coluna DateKey, em ordem crescente.

```
SELECT TOP 10 * FROM DimPromotion
```
```
SELECT TOP 10 * FROM FactOnlineSales
```
```
SELECT TOP 10 * FROM DimChannel
```

```
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
```

10 - A tabela abaixo é resultado de um Join entre a tabela FactSales e as tabelas: DimChannel, DimStore e DimProduct.
Recrie esta consulta e classifique em ordem decrescente de acordo com SalesAmount.

```
SELECT TOP 10 * FROM FactSales
```
```
SELECT TOP 10 * FROM DimProduct
```
```
SELECT TOP 10 * FROM DimChannel
```
```
SELECT TOP 10 * FROM DimStore
```
```
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
```
