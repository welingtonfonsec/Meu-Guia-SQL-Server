## Índice

[1. Introdução ao SQL](#introdução-ao-SQL)

[2. Ordenando e Filtrando Dados](#ordenando-e-filtrando-dados)

[3. Funções de Agregação ](#funções-de-agregação)

[4. Criando Agrupamentos no SQL](#criando-agrupamentos-no-sql)

[5. JOINs no SQL](#joins-no-sql)

[6. Group By com Joins](#group-by-com-joins)

[7. Variáveis](#variáveis)

[8. Manipulando Strings e Datas no SQL](#manipulando-strings-e-datas-no-sql)

[9. Funções Condicionais](#funções-condicionais)

[10. SQL Views](#sql-views)

[11. CRUD](#CRUD)

[12. Subqueries e CTE's](#Subqueries-cte's)

[13. Loops no SQL](#loops-no-sql)

[14. Window Functions](#windows-function)

[15. Regex - Regular Expressions](#regex-regular-expressions)


## Ordenando e Filtrando Dados

No SQL Server, as funções de ordenação e filtragem são essenciais para manipular dados de forma eficiente. Aqui estão algumas das principais funções relacionadas a ordenação e filtragem.

### Ordenação

#### ORDER BY

A cláusula ORDER BY é usada para ordenar o resultado de uma consulta em ordem ascendente (ASC) ou descendente (DESC) com base em uma ou mais colunas.

Exemplo:

```
SELECT NomeProduto, PrecoUnitario
FROM Produtos
ORDER BY PrecoUnitario DESC;
Neste exemplo, a consulta retorna o nome do produto e o preço unitário, ordenados em ordem decrescente pelo preço unitário.
```
### Filtragem

#### WHERE

A cláusula WHERE é utilizada para filtrar registros com base em uma condição específica.

Exemplo:
```
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

6 - Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que identifica o tipo de conta, há também uma outra 
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

## Group By com Joins

Ao combinar GROUP BY com JOINS, podemos realizar operações de agregação em conjuntos de dados resultantes da junção de várias tabelas.

Exemplo:
```
SELECT Departments.DepartmentName, COUNT(Employees.EmployeeID) as EmployeeCount
FROM Departments
LEFT JOIN Employees ON Departments.DepartmentID = Employees.DepartmentID
GROUP BY Departments.DepartmentName;
```
Neste exemplo, estamos contando o número de funcionários por departamento, mesmo aqueles departamentos que não têm funcionários devido ao uso de LEFT JOIN.

Ao utilizar Group By com Joins, podemos analisar e agregar dados de maneira mais granular, obtendo insights valiosos sobre conjuntos de dados complexos em um banco de dados relacional.

### Exemplos Práticos

1 - a) Faça um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal de vendas (ChannelName). Você deve ordenar a tabela final de acordo com SalesQuantity, em ordem decrescente.
```
Select top 10 * From FactSales
Select top 10 * From DimChannel
```
```
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
```

b) Faça um agrupamento mostrando a quantidade total vendida (Sales Quantity) e quantidade total devolvida (Return Quantity) de acordo com o nome das lojas (StoreName).
```
Select top 10 * From FactSales
Select top 10 * From DimStore
```
```
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
```
c) Faça um resumo do valor total vendido (Sales Amount) para cada mês (CalendarMonthLabel) e ano (CalendarYear).
```
Select top 10 * From FactSales
Select top 10 * From DimDate
```
```
SELECT
	DimDate.CalendarYear AS 'Ano',
	DimDate.CalendarMonthLabel AS 'Mês',
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
```
2 - Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor total vendido (SalesAmount) por produto.
```
Select top 10 * From FactSales
Select top 10 * From DimProduct
```
```
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
```

a) Descubra qual é a cor de produto que mais é vendida (de acordo com SalesQuantity).
```
Select top 10 * From FactSales
Select top 10 * From DimProduct
```
```
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
```
b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.
```
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
```

3 - Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto (ProductCategoryName). 
--Obs: Você precisará fazer mais de 1 INNER JOIN, dado que a relação entre FactSales e DimProductCategory não é direta.
```
Select top 10 * From FactSales
Select top 10 * From DimProduct
Select top 10 * From DimProductSubcategory
Select top 10 * From DimProductCategory
```
```
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
```

4 - a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o nome completo do cliente (Pessoa Física) que mais realizou compras online (de acordo com a coluna SalesQuantity).
```
Select top 10 * From FactOnlineSales
Select top 10 * From DimCustomer
```
```
SELECT  
	DimCustomer.CustomerKey AS 'ID Pessoa Física',
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
```

b) Feito isso, faça um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da letra a, considerando o nome do produto.
```
Select top 10 * From FactOnlineSales
Select top 10 * From DimCustomer
Select top 10 * From DimProduct
```
```
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
```

5 - Faça um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o sexo dos clientes.
```
Select top 10 * From FactOnlineSales
Select top 10 * From DimCustomer
```
```
SELECT
	DimCustomer.Gender AS 'Gênero',
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
```

6 - Faça uma tabela resumo mostrando a taxa de câmbio média de acordo com cada CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100.
```
Select top 10 * From FACTEXCHANGERATE
Select top 10 * From DimCurrency
```
```
SELECT
	DimCurrency.CurrencyDescription AS 'Moeda',
	AVG(FactExchangeRate.AverageRate) AS 'Taxa de Câmbio Média'
FROM
	FactExchangeRate
INNER JOIN DimCurrency
	ON FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY
	DimCurrency.CurrencyDescription
HAVING 
	AVG(FactExchangeRate.AverageRate) BETWEEN 10 AND 100
```

7 - Descubra o valor total na tabela FactStrategyPlan destinado aos cenários: Actual e Budget.
```
Select top 10 * From FactStrategyPlan
Select top 10 * From DimScenario
```
```
SELECT
	DimScenario.ScenarioName AS 'Cenário',
	SUM(FactStrategyPlan.Amount) AS 'Total'
FROM 
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
GROUP BY
	DimScenario.ScenarioName
HAVING
	DimScenario.ScenarioName = 'Actual' OR DimScenario.ScenarioName = 'Budget'
```

8 - Faça uma tabela resumo mostrando o resultado do planejamento estratégico por ano.
```
Select top 10 * From FactStrategyPlan
Select top 10 * From DimDate
```
```
SELECT
	DimDate.CalendarYear AS 'Ano',
	SUM(FactStrategyPlan.Amount) AS 'Total'
FROM
	FactStrategyPlan
INNER JOIN DimDate
	ON FactStrategyPlan.Datekey = DimDate.Datekey
GROUP BY
	DimDate.CalendarYear
```

9 - Faça um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em consideração em sua análise apenas a marca Contoso e a cor Silver.
```
Select top 10 * From DimProduct
Select top 10 * From DimProductSubcategory
Select top 10 * From DimProductCategory
```
```
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
```

10 - Faça um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName. A tabela final deverá ser ordenada de acordo com a coluna BrandName.
```
Select top 10 * From DimProduct
Select top 10 * From DimProductSubcategory
Select top 10 * From DimProductCategory
```
```
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
```

## Variáveis

No SQL Server, você pode usar variáveis para armazenar valores temporários durante a execução de scripts, procedimentos armazenados ou funções. Aqui estão alguns conceitos relacionados ao uso de variáveis no SQL Server:

#### Declaração de Variáveis:
Para declarar uma variável no SQL Server, você pode usar a palavra-chave DECLARE seguida pelo nome da variável e seu tipo de dados.

```
DECLARE @NomeVariavel VARCHAR(50);
```

Você também pode atribuir um valor à variável durante a declaração:
```
DECLARE @Numero INT = 10;
```
#### Utilização de Variáveis em Consultas:

Você pode utilizar variáveis em consultas para tornar o processo mais dinâmico. Aqui está um exemplo de consulta usando uma variável:
```
DECLARE @DepartamentoID INT;
SET @DepartamentoID = 1;

SELECT * FROM Funcionarios WHERE DepartmentID = @DepartamentoID;
```
#### Variáveis em Procedimentos Armazenados:
Procedimentos armazenados no SQL Server frequentemente fazem uso de variáveis para armazenar resultados intermediários ou parâmetros.

```
CREATE PROCEDURE ExemploProcedimento
AS
BEGIN
   DECLARE @Contador INT;
   SET @Contador = 0;

   -- Resto do procedimento aqui

END;
```
#### Variáveis em Funções:
Funções podem ter parâmetros, que são semelhantes ao conceito de variáveis.

```
CREATE FUNCTION CalcularSalarioAnual(@SalarioMensal DECIMAL)
RETURNS DECIMAL
AS
BEGIN
   DECLARE @SalarioAnual DECIMAL;
   SET @SalarioAnual = @SalarioMensal * 12;
   RETURN @SalarioAnual;
END;
```
#### Variáveis de Tabela Temporária:
Além de variáveis simples, o SQL Server também suporta variáveis de tabela temporária. Essas variáveis são úteis para armazenar conjuntos temporários de dados.

```
CREATE TABLE #TempClientes (
   ClienteID INT,
   NomeCliente VARCHAR(100)
);

INSERT INTO #TempClientes VALUES (1, 'Cliente A');

SELECT * FROM #TempClientes;
```
Lembre-se de que variáveis declaradas com @ são limitadas ao escopo onde foram declaradas, enquanto as variáveis de tabela temporária (#) podem ser usadas em diferentes sessões ou escopos de consulta.

Esses são alguns conceitos básicos relacionados ao uso de variáveis no SQL Server. A sintaxe exata e as opções podem variar dependendo da versão específica do SQL Server que você está usando.

### Exemplos Práticos 

1 - Declare 4 variáveis inteiras. Atribua os seguintes valores a elas:
* valor1 = 10
* valor2 = 5
* valor3 = 34
* valor4 = 7
  
a) Crie uma nova variável para armazenar o resultado da soma entre valor1 e valor2. Chame essa variável de soma.
```
DECLARE @valor1 INT
DECLARE @valor2 INT
DECLARE @variavelSoma INT

SET @valor1 = 10
SET @valor2 = 5
SET @variavelSoma = @valor1 + @valor2

SELECT @variavelSoma AS 'Soma'
```
b) Crie uma nova variável para armazenar o resultado da subtração entre valor3 e valor 4. Chame essa variável de subtracao.
```
DECLARE @valor3 INT
DECLARE @valor4 INT
DECLARE @variavelSubtração INT

SET @valor3 = 34
SET @valor4 = 7
SET @variavelSubtração = @valor3 - @valor4

SELECT @variavelSubtração AS 'Subtração'
```
c) Crie uma nova variável para armazenar o resultado da multiplicação entre o valor 1 e o valor4. Chame essa variável de multiplicacao.
```
DECLARE @valor1 INT
DECLARE @valor4 INT
DECLARE @variavelMultiplicação INT

SET @valor1 = 10
SET @valor4 = 7
SET @variavelMultiplicação = @valor1 * @valor4

SELECT @variavelMultiplicação AS 'Multiplicação'
```
d) Crie uma nova variável para armazenar o resultado da divisão do valor3 pelo valor4. Chame essa variável de divisao. Obs: O resultado deverá estar em decimal, e não em inteiro.
```
DECLARE @valor3 FLOAT
DECLARE @valor4 FLOAT
DECLARE @variavelDivisão FLOAT

SET @valor3 = 34
SET @valor4 = 7
SET @variavelDivisão = @valor3 / @valor4

SELECT @variavelDivisão AS 'Divisão'
```
e) Arredonde o resultado da letra d) para 2 casas decimais.
```
DECLARE @valor3 FLOAT
DECLARE @valor4 FLOAT
DECLARE @variavelDivisão FLOAT

SET @valor3 = 34
SET @valor4 = 7
SET @variavelDivisão = @valor3 / @valor4

SELECT ROUND (@variavelDivisão, 2) AS 'Divisão'
```
2 - Para cada declaração das variáveis abaixo, atenção em relação ao tipo de dado que deverá ser especificado.

* a) Declare uma variável chamada ‘produto’ e atribua o valor de ‘Celular’.
* b) Declare uma variável chamada ‘quantidade’ e atribua o valor de 12.
* c) Declare uma variável chamada ‘preco’ e atribua o valor 9.99.
* d) Declare uma variável chamada ‘faturamento’ e atribua o resultado da multiplicação entre ‘quantidade’ e ‘preco’.
* e) Visualize o resultado dessas 4 variáveis em uma única consulta, por meio do SELECT.
```
DECLARE @varProduto VARCHAR(30)
DECLARE @varQuantidade FLOAT -- São tipo FLOAT para que representem números decimais. Se fosse INT, o valor estaria errado
DECLARE @varPreco FLOAT
DECLARE @varFaturamento FLOAT

SET @varProduto = 'Celular'
SET @varQuantidade = 12
SET @varPreco = 9.99
SET @varFaturamento = @varQuantidade * @varPreco

SELECT 
	@varProduto AS 'Produto',
	@varQuantidade AS 'Quantidade',
	@varPreco AS 'Preço',
	@varFaturamento AS 'Faturamento'
```
3 - Você é responsável por gerenciar um banco de dados onde são recebidos dados externos de usuários. Em resumo, esses dados são:
* Nome do usuário;
* Data de nascimento;
* Quantidade de pets que aquele usuário possui

Você precisará criar um código em SQL capaz de juntar as informações fornecidas por este usuário. Para simular estes dados, crie 3 variáveis, chamadas: nome, data_nascimento e num_pets. Você deverá armazenar os valores ‘André’, ‘10/02/1998’ e 2, respectivamente.

* Dica: você precisará utilizar as funções CAST e FORMAT para chegar no resultado.
```
DECLARE @varNomedoUsuario VARCHAR(30)
DECLARE @varDataDeNascimento DATETIME
DECLARE @varQuantidadeDePets INT

SET @varNomedoUsuario = 'André'
SET @varDataDeNascimento = '10/02/1998'
SET @varQuantidadeDePets = 2

-- PRINT 'O total de lojas abertas ' + CAST(@varLojasOn AS VARCHAR(30)) -- O CAST FOI USADO PARA CONVERTER O A VARIAVEL EM TEXTO

PRINT 'Meu nome é ' + @varNomedoUsuario + ', ' + 'Nasci em ' + FORMAT(@varDataDeNascimento, 'dd/MM/yyyy') + ' e tenho ' + CAST(@varQuantidadeDePets AS VARCHAR(30)) + ' pets.'
```

4 - Você acabou de ser promovido e o seu papel será realizar um controle de qualidade sobre as lojas da empresa.
A primeira informação que é passada a você é que o ano de 2008 foi bem complicado para a empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio é descobrir o nome dessas lojas que fecharam no ano de 2008, para que você possa entender o motivo e mapear planos de ação para evitar que outras lojas importantes tomem o mesmo caminho.
O seu resultado deverá estar estruturado em uma frase, com a seguinte estrutura:
‘As lojas fechadas no ano de 2008 foram: ’ + nome_das_lojas
```
DECLARE @varNomeDasLojasOff VARCHAR(100)
SET @varNomeDasLojasOff = ''

SELECT @varNomeDasLojasOff = @varNomeDasLojasOff + StoreName + ', '
FROM DimStore
WHERE FORMAT(CloseDate, 'yyyy') = 2008

PRINT 'As lojas fechadas no ano de 2008 foram: ' + @varNomeDasLojasOff
```

5 - Você precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria específica: ‘Lamps’. Utilize o conceito de variáveis para chegar neste resultado.
```
SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory
```
```
DECLARE @varIdSubcategoria INT
DECLARE @varNomeSubcategoria VARCHAR(100)

SET @varNomeSubcategoria = 'Lamps'
SET @varIdSubcategoria = (SELECT ProductSubcategoryKey FROM DimProductSubcategory WHERE ProductSubcategoryName = @varNomeSubcategoria)

SELECT 
	*
FROM 
	DimProduct
WHERE
	ProductSubcategoryKey = @varIdSubcategoria
```

## Manipulando Strings e Datas no SQL

#### LEN e DATALENGTH

As funções LEN e DATALENGTH possuem resultados semelhantes ambos retornam a quantidade de caracteres de um determinado texto 

A grande diferença entre os dois é sutil, o LEN retorna a quantidade de caracteres de um texto, porém ignora quando aparecem espaços a mais. 

```
SELECT LEN('Hello World  ') AS Comprimento; -- Foi adicionado 2 espaços no fim da frase
-- Resultado: 11
```

Já o DATALENGTH retorna a quantidade de caracteres, incluindo espaços a mais dentro do texto

```
SELECT LEN('Hello World  ') AS Comprimento; -- Foi adicionado 2 espaços no fim da frase
-- Resultado: 13
```

#### CONCAT

No SQL Server, a função CONCAT é usada para concatenar (juntar) duas ou mais strings em uma única string. Essa função é útil quando você precisa unir partes de texto armazenadas em diferentes colunas ou valores.

Conceito Básico do CONCAT:
A sintaxe básica da função CONCAT é a seguinte:

```
CONCAT(string1, string2, ...);
```

Exemplo de Uso:
Considere a tabela Clientes com colunas FirstName e LastName. Você pode usar CONCAT para criar uma coluna de nome completo:

```
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Clientes;
```
Neste exemplo, a função CONCAT combina os valores das colunas FirstName e LastName, adicionando um espaço entre eles para formar um nome completo na nova coluna chamada FullName.

#### LEFT e RIGHT

As funções LEFT e RIGHT são usadas no SQL Server para extrair um número específico de caracteres à esquerda ou à direita de uma string, respectivamente.

##### LEFT - Extrair Caracteres à Esquerda:
A função LEFT retorna um número especificado de caracteres à esquerda de uma string.

Sintaxe:
```
LEFT(string_expression, length)
```
string_expression: A expressão de string da qual você deseja extrair caracteres.
length: O número de caracteres a serem extraídos.

Exemplo:

```
SELECT LEFT('Hello World', 5) AS Resultado;
-- Resultado: 'Hello'
```
Neste exemplo, a função LEFT extrai os primeiros 5 caracteres da string 'Hello World'.

##### RIGHT - Extrair Caracteres à Direita:
A função RIGHT retorna um número especificado de caracteres à direita de uma string.

Sintaxe:

```
RIGHT(string_expression, length)
```
string_expression: A expressão de string da qual você deseja extrair caracteres.
length: O número de caracteres a serem extraídos.

Exemplo:

```
SELECT RIGHT('Hello World', 5) AS Resultado;
-- Resultado: 'World'
```
Neste exemplo, a função RIGHT extrai os últimos 5 caracteres da string 'Hello World'.

Ambas as funções são úteis quando você precisa trabalhar com partes específicas de strings em suas consultas SQL. Certifique-se de ajustar o valor do parâmetro length conforme necessário para atender aos seus requisitos.

#### LEFT e RIGHT

A função REPLACE no SQL Server é usada para substituir todas as ocorrências de uma substring por outra substring em uma string. Isso é útil para realizar alterações específicas em dados de texto.

Sintaxe:
```
REPLACE(string_expression, string_pattern, string_replacement)
```
string_expression: A expressão de string onde a substituição será realizada.
string_pattern: A substring que será substituída.
string_replacement: A nova substring que será usada como substituto.

Exemplo:

```
SELECT REPLACE('Hello World', 'Hello', 'Hi') AS Resultado;
-- Resultado: 'Hi World'
```
Neste exemplo, a função REPLACE substitui a substring 'Hello' por 'Hi' na string 'Hello World'.

##### Uso em Atualizações:
Além de ser usado em consultas, o REPLACE é frequentemente empregado em instruções UPDATE para modificar dados em uma tabela.

```
UPDATE TabelaExemplo
SET ColunaTexto = REPLACE(ColunaTexto, 'Antigo', 'Novo')
WHERE AlgumaCondição;
```
Neste caso, a instrução UPDATE usa o REPLACE para substituir todas as ocorrências da substring 'Antigo' pela substring 'Novo' na coluna ColunaTexto da tabela TabelaExemplo, apenas para as linhas que atendem à condição especificada.

Essa função é valiosa para realizar modificações específicas em dados de texto, e sua versatilidade a torna útil em várias situações no SQL Server.

#### TRANSLATE e STUFF

No SQL Server, as funções TRANSLATE e STUFF são utilizadas para manipulação de strings.

##### TRANSLATE - Substituir Caracteres:

A função TRANSLATE permite substituir caracteres em uma string com base em um mapa de substituição. Esta função é útil para realizar substituições de caracteres de maneira mais complexa do que a função REPLACE.

Sintaxe:

```
TRANSLATE (string_expression, target_expression, replacement_expression)
```
string_expression: A expressão de string que será modificada.
target_expression: A string de caracteres que será substituída.
replacement_expression: A string de caracteres que será usada como substituição.

Exemplo:
```
SELECT TRANSLATE('Hello World', 'elo', '123') AS Resultado;
-- Resultado: 'H123 W1rld'
```
Neste exemplo, a função TRANSLATE substitui os caracteres 'e', 'l' e 'o' por '1', '2' e '3', respectivamente.

##### STUFF - Substituir Parte de uma String:

A função STUFF é usada para substituir uma parte específica de uma string por outra string. É especialmente útil quando você precisa substituir uma parte específica de uma string sem modificar o restante.

Sintaxe:

```
STUFF (string_expression, start, length, replace_with_expression)
```
string_expression: A expressão de string que será modificada.
start: A posição de início da substituição.
length: O número de caracteres a serem substituídos.
replace_with_expression: A string de substituição.

Exemplo:
```
SELECT STUFF('Hello World', 7, 5, 'Universe') AS Resultado;
-- Resultado: 'Hello Universe'
```
Neste exemplo, a função STUFF substitui 5 caracteres a partir da posição 7 da string 'Hello World' pela string 'Universe'.

Essas funções são úteis para manipulação avançada de strings em consultas SQL Server, proporcionando flexibilidade na substituição e modificação de partes específicas de uma string.

#### UPPER e LOWER

##### UPPER - Converter para Maiúsculas:

A função UPPER converte todos os caracteres de uma string para maiúsculas.

Sintaxe:
```
UPPER(string_expression)
```
Exemplo:
```
SELECT UPPER('Hello World') AS Resultado;
-- Resultado: 'HELLO WORLD'
```
Neste exemplo, a função UPPER converte a string 'Hello World' para 'HELLO WORLD'.

##### LOWER - Converter para Minúsculas:

A função LOWER converte todos os caracteres de uma string para minúsculas.

Sintaxe:
```
LOWER(string_expression)
```
Exemplo:
```
SELECT LOWER('Hello World') AS Resultado;
-- Resultado: 'hello world'
```
Neste exemplo, a função LOWER converte a string 'Hello World' para 'hello world'.

Essas funções são úteis quando você precisa realizar comparações de strings sem considerar a diferença entre maiúsculas e minúsculas ou quando deseja padronizar a apresentação do texto em suas consultas SQL Server.

#### FORMAT

A função FORMAT no SQL Server é usada para formatar valores de data/hora e números de acordo com um formato específico. Essa função é útil quando você deseja exibir datas, horas ou números em um formato específico em suas consultas SQL.

##### Sintaxe para Datas:
```
FORMAT (date_expression, format)
```
date_expression: A expressão de data/hora que você deseja formatar.
format: O formato desejado para a apresentação.
Exemplo para Datas:
```
SELECT FORMAT(GETDATE(), 'dd/MM/yyyy') AS DataFormatada;
-- Resultado: '03/01/2024'
```
Neste exemplo, a função FORMAT formata a data atual (GETDATE()) no formato 'dd/MM/yyyy'.

##### Sintaxe para Números:
```
FORMAT (numeric_expression, format)
```
numeric_expression: A expressão numérica que você deseja formatar.
format: O formato desejado para a apresentação.
Exemplo para Números:
```
SELECT FORMAT(12345.6789, 'C', 'en-US') AS NumeroFormatado;
-- Resultado: '$12,345.68'
```
Neste exemplo, a função FORMAT formata o número 12345.6789 como uma moeda no formato 'C' (moeda) usando a cultura 'en-US' (Inglês dos Estados Unidos).

##### Observações:
A função FORMAT é poderosa para apresentação de dados, mas pode ter impacto no desempenho, especialmente em grandes conjuntos de dados.
O segundo parâmetro do formato é opcional, mas especificá-lo oferece maior controle sobre a formatação.
A função FORMAT é compatível apenas com versões mais recentes do SQL Server (a partir do SQL Server 2012).
Utilize a função FORMAT com cuidado, pois o seu uso excessivo pode afetar o desempenho em consultas que envolvem grandes conjuntos de dados. Considere também outras opções de formatação disponíveis no SQL Server, dependendo das suas necessidades específicas.

As funções CHARINDEX e SUBSTRING no SQL Server são usadas para realizar operações em strings.

#### CHARINDEX - Encontrar a Posição de uma Substring em uma String:
A função CHARINDEX é utilizada para encontrar a posição da primeira ocorrência de uma substring em uma string. A posição é retornada como um número inteiro.

Sintaxe:
```
CHARINDEX(substring, string [, start_location])
```
substring: A substring que você está procurando na string.
string: A string onde você está procurando a substring.
start_location (opcional): A posição inicial na string onde a busca deve começar. Se não especificado, a busca começa do início da string.
Exemplo:
```
SELECT CHARINDEX('world', 'Hello world') AS Posicao;
-- Resultado: 7
```
Neste exemplo, a função CHARINDEX encontra a posição da substring 'world' na string 'Hello world', e o resultado é 7.

#### SUBSTRING - Extrair uma Substring de uma String:
A função SUBSTRING é usada para extrair uma parte de uma string, começando de uma posição específica e com um comprimento determinado.

Sintaxe:
```
SUBSTRING(string, start, length)
```
string: A string da qual você deseja extrair a substring.
start: A posição inicial na string de onde começar a extração.
length: O comprimento da substring a ser extraído.
Exemplo:
```
SELECT SUBSTRING('Hello world', 7, 5) AS SubstringExtraida;
-- Resultado: 'world'
```
Neste exemplo, a função SUBSTRING extrai uma substring de comprimento 5 começando da posição 7 na string 'Hello world'.

Essas funções são úteis para manipular e extrair informações de strings em consultas SQL Server.

No SQL Server, as funções TRIM, LTRIM e RTRIM são usadas para remover espaços em branco de uma string. Vamos entender cada uma delas:

#### TRIM - Remover Espaços em Branco de Ambos os Lados:
A função TRIM é utilizada para remover espaços em branco do início e do final de uma string. Ela é especialmente útil para limpar strings que podem ter espaços extras.

Sintaxe:
```
TRIM([ { LEADING | TRAILING | BOTH } ] ' ' FROM string)
```
LEADING: Remove espaços do início da string.
TRAILING: Remove espaços do final da string.
BOTH: Remove espaços do início e do final da string. Este é o comportamento padrão se nenhum modificador for especificado.
Exemplo:
```
SELECT TRIM('   Hello world   ') AS StringLimpa;
-- Resultado: 'Hello world'
```
#### LTRIM - Remover Espaços em Branco do Início:
A função LTRIM remove espaços em branco do início de uma string.

Sintaxe:
```
LTRIM(string)
```
Exemplo:
```
SELECT LTRIM('   Hello world   ') AS StringLimpa;
-- Resultado: 'Hello world   '
```

#### RTRIM - Remover Espaços em Branco do Final:
A função RTRIM remove espaços em branco do final de uma string.

Sintaxe:
```
RTRIM(string)
```
Exemplo:
```
SELECT RTRIM('   Hello world   ') AS StringLimpa;
-- Resultado: '   Hello world'
```
Essas funções são úteis para manipulação de strings, especialmente quando você precisa garantir que não há espaços extras no início ou no final de uma string. Escolha a função que atenda melhor às suas necessidades com relação à posição dos espaços que você deseja remover.

#### DAY, MONTH e YEAR
As funções DAY, MONTH e YEAR no SQL Server são usadas para extrair componentes individuais de uma data, como dia, mês e ano.

##### DAY - Extrair o Dia de uma Data:
A função DAY é usada para extrair o componente do dia de uma data.

Sintaxe:
```
DAY(date)
```
date: A data da qual você deseja extrair o dia.
Exemplo:
```
SELECT DAY('2024-01-03') AS Dia;
-- Resultado: 3
```

##### MONTH - Extrair o Mês de uma Data:
A função MONTH é usada para extrair o componente do mês de uma data.

Sintaxe:
```
MONTH(date)
```
date: A data da qual você deseja extrair o mês.
Exemplo:
```
SELECT MONTH('2024-01-03') AS Mes;
-- Resultado: 1
```
##### YEAR - Extrair o Ano de uma Data:
A função YEAR é usada para extrair o componente do ano de uma data.

Sintaxe:
```
YEAR(date)
```
date: A data da qual você deseja extrair o ano.
Exemplo:
```
SELECT YEAR('2024-01-03') AS Ano;
-- Resultado: 2024
```
Essas funções são úteis ao lidar com colunas de data em consultas SQL, permitindo que você obtenha informações específicas sobre as datas armazenadas no banco de dados.

#### DATEFROMPARTS
A função DATEFROMPARTS no SQL Server é usada para criar uma data a partir de componentes específicos, como ano, mês e dia. Essa função é útil quando você tem valores separados para ano, mês e dia e deseja combiná-los para formar uma data.

Sintaxe:
```
DATEFROMPARTS (year, month, day)
```
year: O componente do ano.
month: O componente do mês.
day: O componente do dia.
Exemplo:
```
SELECT DATEFROMPARTS(2024, 1, 3) AS DataCompleta;
-- Resultado: '2024-01-03'
```
Neste exemplo, a função DATEFROMPARTS combina os componentes de ano, mês e dia para criar a data '2024-01-03'.

Essa função é útil em situações em que você possui os componentes da data armazenados em colunas separadas em uma tabela e precisa formar a data completa para análises ou manipulações.

#### GETDATE e SYSDATETIME

GETDATE() e SYSDATETIME() são funções no SQL Server que retornam a data e hora atuais do sistema no momento em que são executadas. Ambas são amplamente utilizadas para obter informações de data e hora durante consultas ou manipulações de dados.

##### GETDATE():
GETDATE() retorna a data e hora atuais em um formato padrão.

Exemplo:
```
SELECT GETDATE() AS DataHoraAtual;
-- Resultado: '2024-01-03 15:30:00.000'
```

##### SYSDATETIME():
SYSDATETIME() retorna a data e hora atuais com mais precisão do que GETDATE(). Ela inclui informações de frações de segundo.

Exemplo:
```
SELECT SYSDATETIME() AS DataHoraAtualPrecisa;
-- Resultado: '2024-01-03 15:30:00.1234567'
```
Ambas as funções são úteis, mas a escolha entre elas dependerá da precisão necessária para as suas operações. Se precisar de alta precisão, SYSDATETIME() é preferível, mas se a precisão padrão for suficiente, GETDATE() é mais comumente utilizada.

Lembre-se de que a saída exata pode variar dependendo do momento da execução da consulta.

#### DATENAME e DATEPART

As funções DATENAME e DATEPART no SQL Server são usadas para extrair partes específicas de uma data, como o nome do mês, o dia do mês, o ano, etc.

##### DATENAME - Extrair o Nome de uma Parte da Data:
A função DATENAME é utilizada para retornar uma parte específica de uma data como uma string.

Sintaxe:
```
DATENAME(datepart, date)
```
datepart: A parte da data que você deseja extrair (por exemplo, 'year', 'quarter', 'month', 'day', etc.).
date: A data da qual você deseja extrair a parte.
Exemplo:
```
SELECT DATENAME(month, '2024-01-03') AS NomeMes;
-- Resultado: 'January'
```

##### DATEPART - Extrair o Valor Numérico de uma Parte da Data:
A função DATEPART é utilizada para retornar a parte específica de uma data como um número.

Sintaxe:
```
DATEPART(datepart, date)
```
datepart: A parte da data que você deseja extrair (por exemplo, 'year', 'quarter', 'month', 'day', etc.).
date: A data da qual você deseja extrair a parte.
Exemplo:
```
SELECT DATEPART(day, '2024-01-03') AS Dia;
-- Resultado: 3
```
Ambas as funções são úteis para obter informações específicas de uma data em consultas SQL. A escolha entre DATENAME e DATEPART dependerá se você deseja a informação como uma string ou como um valor numérico.

#### DATEADD e DATEDIFF

As funções DATEADD e DATEDIFF no SQL Server são usadas para manipular e calcular diferenças entre datas.

##### DATEADD - Adicionar um Intervalo a uma Data:
A função DATEADD é utilizada para adicionar um intervalo específico a uma data.

Sintaxe:
```
DATEADD(datepart, number, date)
```
datepart: A unidade do intervalo a ser adicionada (por exemplo, 'year', 'month', 'day', 'hour', etc.).
number: A quantidade do intervalo a ser adicionada.
date: A data à qual o intervalo será adicionado.
Exemplo:
```
SELECT DATEADD(month, 3, '2024-01-03') AS NovaData;
-- Resultado: '2024-04-03'
```
Neste exemplo, DATEADD adiciona 3 meses à data '2024-01-03', resultando em '2024-04-03'.

##### DATEDIFF - Calcular a Diferença Entre Duas Datas:
A função DATEDIFF é utilizada para calcular a diferença entre duas datas em uma unidade específica.

Sintaxe:
```
DATEDIFF(datepart, startdate, enddate)
```
datepart: A unidade na qual a diferença deve ser calculada (por exemplo, 'year', 'month', 'day', 'hour', etc.).
startdate: A data de início.
enddate: A data de término.
Exemplo:
```
SELECT DATEDIFF(day, '2024-01-01', '2024-01-10') AS DiferencaDias;
-- Resultado: 9
```
Neste exemplo, DATEDIFF calcula a diferença em dias entre '2024-01-01' e '2024-01-10', resultando em 9 dias.

Essas funções são úteis para realizar cálculos relacionados a datas e para ajustar datas em consultas SQL.

### Exemplos Práticos 

1 - Quando estamos manipulando tabelas, é importante pensar em como os dados serão apresentados em um relatório. Imagine os nomes dos produtos da tabela DimProduct. Os textos são bem grandes e pode ser que mostrar os nomes completos dos produtos não seja a opção mais interessante, pois provavelmente não vão caber em um gráfico e a visualização ficará ruim.

a) Seu gestor te pede para listar todos os produtos para que seja criado um gráfico para ser apresentado na reunião diária de equipe. Faça uma consulta à tabela DimProduct que retorne (1) o nome do produto e (2) a quantidade de caracteres que cada produto tem, e ordene essa tabela do produto com a maior quantidade de caracteres para a menor.

```
SELECT
	ProductName AS 'Nome do Produto',
	LEN (ProductName) AS 'Qtd. Caracteres'  -- Apenas conta caracteres
FROM DimProduct
ORDER BY 
	LEN (ProductName) DESC
```

ou 
```
SELECT
	ProductName AS 'Nome do Produto',
	DATALENGTH (ProductName) AS 'Qtd. Caracteres'  -- Caracteres e espaços
FROM DimProduct
ORDER BY 
	DATALENGTH (ProductName) DESC
```

b) Qual é a média de caracteres dos nomes dos produtos?
```
SELECT
	AVG (LEN (ProductName)) AS 'Qtd Média de Caracteres'  -- Apenas conta caracteres
FROM DimProduct
```
ou
```
SELECT
	AVG (DATALENGTH (ProductName)) AS 'Qtd Média de Caracteres'  -- Caracteres e espaços
FROM 
	DimProduct
```
c) Analise a estrutura dos nomes dos produtos e verifique se seria possível reduzir o tamanho do nome dos produtos. (Dica: existem informações redundantes nos nomes dos produtos? Seria possível substituí-las?)

É IDENTIFICADO QUE AS INFORMAÇÕES DE BrandName e ColorName são redundantes na coluna de nomes de produtos, pois ja existem colunas específicas para isso
```
SELECT
	ProductName,
	BrandName,
	ColorName,
	REPLACE(REPLACE(ProductName, BrandName, ''), ColorName, '')  AS 'Nome do Produto - Limpo'
FROM 
	DimProduct
```

d) Qual é a média de caracteres nesse novo cenário?
```
SELECT
	AVG(LEN(REPLACE(REPLACE(ProductName, BrandName, ''), ColorName, ''))) AS 'Nome do Produto - Limpo'
FROM 
	DimProduct
```


2 - A coluna StyleName da tabela DimProduct possui alguns códigos identificados por números distintos, que vão de 0 até 9, como pode ser visto no exemplo abaixo.
Porém, o setor de controle decidiu alterar a identificação do StyleName, e em vez de usar números, a ideia agora é passar a usar letras para substituir os números, conforme exemplo:
0 -> A, 1 -> B, 2 -> C, 3 -> D, 4 -> E, 5 -> F, 6 -> G, 7 -> H, 8 -> I, 9 - J

É de sua responsabilidade alterar os números por letras na coluna StyleName da tabela DimProduct. Utilize uma função que permita fazer essas substituições de forma prática e rápida.
```
SELECT StyleName FROM DimProduct
```
```
SELECT 
	ProductName AS 'Nome do Produto',
	StyleName AS 'ID',
	TRANSLATE(StyleName, '0123456789', 'ABCDEFGHIJ') AS	'Novo ID'
FROM DimProduct
```
3 - O setor de TI está criando um sistema para acompanhamento individual de cada funcionário da empresa Contoso. Cada funcionário receberá um login e senha. O login de cada funcionário será o ID do e-mail, como no exemplo abaixo:

Já a senha será o FirtName + o dia do ano em que o funcionário nasceu, em MAIÚSCULA. Por exemplo, o funcionário com E-mail: mark0@contoso.com e data de nascimento 15/01/1990 deverá ter a seguinte senha: Login: mark0 e Senha: MARK15
O responsável pelo TI pediu a sua ajuda para retornar uma tabela contendo as seguintes colunas da tabela DimEmployee: Nome completo (FirstName + LastName), E-mail, ID do e-mail e Senha.
```
SELECT * FROM DimEmployee
```
```
SELECT 
    CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
    EmailAddress AS 'E-mail',
    LEFT(EmailAddress, CHARINDEX('@', EmailAddress) - 1) AS 'Login', 
    UPPER(FirstName + DATENAME(DAYOFYEAR, BirthDate)) AS 'Senha'
FROM 
	DimEmployee
```

4 - A tabela DimCustomer possui o primeiro registro de vendas no ano de 2001. Como forma de reconhecer os clientes que compraram nesse ano, o setor de Marketing solicitou a você que retornasse uma tabela com todos os clientes que fizeram a sua primeira compra neste ano para que seja enviado uma encomenda com um presente para cada um.
Para fazer esse filtro, você pode utilizar a coluna DateFirstPurchase, que contém a informação da data da primeira compra de cada cliente na tabela DimCustomer.
Você deverá retornar as colunas de FirstName, EmailAddress, AddressLine1 e DateFirstPurchase da tabela DimCustomer, considerando apenas os clientes que fizeram a primeira compra no ano de 2001.
```
SELECT * FROM DimCustomer
```
```
SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	AddressLine1 AS	'Endereço',
	DateFirstPurchase AS 'Data Primeira Compra'
FROM 
	DimCustomer
Where
	DATENAME(YEAR, DateFirstPurchase) = 2001
```

5 - A tabela DimEmployee possui uma informação de data de contratação (HireDate). A área de RH, no entanto, precisa das informações dessas datas de forma separada em dia, mês e ano, pois será feita uma automatização para criação de um relatório de RH, e facilitaria muito se essas informações estivessem separadas em uma tabela.
Você deverá realizar uma consulta à tabela DimEmployee e retornar uma tabela contendo as seguintes informações: FirstName, EmailAddress, HireDate, além das colunas de Dia, Mês e Ano de contratação. Obs1: A coluna de Mês deve conter o nome do mês por extenso, e não o número do mês. Obs2: Lembre-se de nomear cada uma dessas colunas em sua consulta para garantir que o entendimento de cada informação ficará 100% claro.

```
SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	DAY(HireDate) AS 'Dia',
	FORMAT(CAST(HireDate AS DATETIME), 'MMMM') AS 'Mês',
	YEAR (HireDate) AS 'Ano'
FROM 
	DimEmployee
```

6 - Descubra qual é a loja que possui o maior tempo de atividade (em dias). Você deverá fazer essa consulta na tabela DimStore, e considerar a coluna OpenDate como referência para esse cálculo. Considerando apenas as lojas que ainda estão funcionando.
```
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
```

## Funções Condicionais

#### CASE WHEN.. ELSE

A expressão CASE WHEN...ELSE no SQL Server é usada para realizar avaliações condicionais e retornar diferentes valores com base em condições específicas. Ela é uma forma flexível de implementar lógica condicional em consultas SQL.

Sintaxe:
```
SELECT
  column1,
  column2,
  CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
  END AS new_column
FROM
  table;
```
condition1, condition2, etc.: Condições que são avaliadas em ordem. Se a primeira condição for verdadeira, o resultado associado a essa condição é retornado. Se não, a próxima condição é verificada e assim por diante.
result1, result2, etc.: Valores ou expressões que são retornados se a condição correspondente for verdadeira.
default_result: Valor retornado se nenhuma das condições for verdadeira.
Exemplo:
```
SELECT
  ProductName,
  UnitsInStock,
  CASE
    WHEN UnitsInStock > 50 THEN 'Estoque Suficiente'
    WHEN UnitsInStock > 0 THEN 'Estoque Baixo'
    ELSE 'Sem Estoque'
  END AS Status
FROM
  Products;
```
Neste exemplo, a expressão CASE WHEN...ELSE é usada para determinar o status do estoque com base na quantidade de unidades em estoque. Se UnitsInStock for maior que 50, o status será 'Estoque Suficiente'. Se for maior que 0, mas não mais que 50, o status será 'Estoque Baixo'. Se nenhuma dessas condições for atendida, o status será 'Sem Estoque'.

Essa construção é útil para realizar avaliações condicionais em consultas SQL e retornar resultados personalizados com base nas condições especificadas.

#### CASE + AND

A expressão CASE em conjunto com AND pode ser utilizada para criar condições mais complexas e retornar diferentes resultados com base em múltiplas condições.

Sintaxe:
```
SELECT
  column1,
  column2,
  CASE
    WHEN condition1 AND condition2 THEN result1
    WHEN condition3 AND condition4 THEN result2
    ELSE default_result
  END AS new_column
FROM
  table;
```
condition1, condition2, condition3, condition4, etc.: Condições que são avaliadas em conjunto usando AND.
result1, result2, etc.: Valores ou expressões que são retornados se as condições correspondentes forem verdadeiras.
default_result: Valor retornado se nenhuma das condições for verdadeira.
Exemplo:
```
SELECT
  ProductName,
  UnitsInStock,
  CASE
    WHEN UnitsInStock > 50 AND CategoryID = 1 THEN 'Estoque Suficiente na Categoria 1'
    WHEN UnitsInStock > 0 AND CategoryID = 2 THEN 'Estoque Baixo na Categoria 2'
    ELSE 'Outras Condições'
  END AS Status
FROM
  Products;
```
Neste exemplo, a expressão CASE em conjunto com AND é utilizada para determinar o status do estoque com base em duas condições: quantidade de unidades em estoque (UnitsInStock) e identificação da categoria do produto (CategoryID). Se ambas as condições de uma cláusula WHEN forem verdadeiras, o resultado associado a essa cláusula será retornado.

Essa construção é útil quando você precisa considerar várias condições simultaneamente em uma expressão CASE.

#### CASE + OR

A expressão CASE em conjunto com OR pode ser utilizada para criar condições mais complexas e retornar diferentes resultados com base em múltiplas condições alternativas.

Sintaxe:
```
SELECT
  column1,
  column2,
  CASE
    WHEN condition1 OR condition2 THEN result1
    WHEN condition3 OR condition4 THEN result2
    ELSE default_result
  END AS new_column
FROM
  table;
```
condition1, condition2, condition3, condition4, etc.: Condições que são avaliadas em conjunto usando OR.
result1, result2, etc.: Valores ou expressões que são retornados se as condições correspondentes forem verdadeiras.
default_result: Valor retornado se nenhuma das condições for verdadeira.
Exemplo:
```
SELECT
  ProductName,
  UnitsInStock,
  CASE
    WHEN UnitsInStock > 50 OR CategoryID = 1 THEN 'Estoque Suficiente ou na Categoria 1'
    WHEN UnitsInStock > 0 OR CategoryID = 2 THEN 'Estoque Baixo ou na Categoria 2'
    ELSE 'Outras Condições'
  END AS Status
FROM
  Products;
```
Neste exemplo, a expressão CASE em conjunto com OR é utilizada para determinar o status do estoque com base em duas condições alternativas: quantidade de unidades em estoque (UnitsInStock) ou identificação da categoria do produto (CategoryID). Se uma das condições de uma cláusula WHEN for verdadeira, o resultado associado a essa cláusula será retornado.

Essa construção é útil quando você precisa considerar diferentes condições alternativas em uma expressão CASE.

#### CASE Aninhado

A expressão CASE aninhada, ou um "CASE WHEN... THEN... ELSE... END" dentro de outro, permite criar lógica condicional mais complexa e estruturada. Cada nível de CASE é avaliado sequencialmente até que uma condição verdadeira seja encontrada.

Sintaxe:
```
SELECT
  column1,
  column2,
  CASE
    WHEN condition1 THEN
      CASE
        WHEN nested_condition1 THEN result1
        WHEN nested_condition2 THEN result2
        ELSE nested_default_result
      END
    WHEN condition2 THEN
      CASE
        WHEN nested_condition3 THEN result3
        WHEN nested_condition4 THEN result4
        ELSE nested_default_result
      END
    ELSE default_result
  END AS new_column
FROM
  table;
```
condition1, condition2, etc.: Condições no nível mais externo.
result1, result2, etc.: Valores ou expressões retornados se as condições no nível mais interno forem verdadeiras.
nested_condition1, nested_condition2, etc.: Condições no nível mais interno.
nested_default_result: Valor retornado se nenhuma das condições no nível mais interno for verdadeira.
default_result: Valor retornado se nenhuma das condições no nível mais externo for verdadeira.
Exemplo:
```
SELECT
  ProductName,
  UnitsInStock,
  CASE
    WHEN UnitsInStock > 50 THEN
      CASE
        WHEN CategoryID = 1 THEN 'Estoque Suficiente na Categoria 1'
        WHEN CategoryID = 2 THEN 'Estoque Suficiente na Categoria 2'
        ELSE 'Outras Condições'
      END
    WHEN UnitsInStock > 0 THEN
      CASE
        WHEN CategoryID = 1 THEN 'Estoque Baixo na Categoria 1'
        WHEN CategoryID = 2 THEN 'Estoque Baixo na Categoria 2'
        ELSE 'Outras Condições'
      END
    ELSE 'Sem Estoque'
  END AS Status
FROM
  Products;
```
Neste exemplo, a expressão CASE aninhada é usada para determinar o status do estoque com base na quantidade de unidades em estoque (UnitsInStock) e na identificação da categoria do produto (CategoryID). Se UnitsInStock for maior que 50, ela avalia a categoria. Se for maior que 0, mas não mais que 50, também avalia a categoria. Se nenhuma dessas condições for atendida, retorna 'Sem Estoque'.

Essa construção é útil quando você precisa de uma lógica condicional hierárquica e estruturada em suas consultas SQL.

#### CASE Aditivo

Uma outra aplicação do CASE é em uma situação especial, nessa aplicação, conseguimos adicionar uma condição a uma condição anterior
Por exemplo, queremos aplicar um desconto de 10% aos produtos da categoria "TV and Video". E além disso, caso também seja da subcategoria
"Television", queremos aplicar mais 5% fechando em 15% de desconto.

Criamos um primeiro CASE para verificar a categoria. Logo em seguida, somamos ao CASE que verifica se a subcategoria é televisão
```
SELECT 
	ProductKey,
	ProductName,
	ProductCategoryName,
	ProductSubCategoryName,
	UnitPrice,
	CASE 
		WHEN ProductCategoryName = 'TV and Video' THEN 0.1
		ELSE 0.0
	END
	+ CASE
		WHEN ProductSubCategoryName = 'Televisions' THEN 0.05
		ELSE 0.0
	END
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductCategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
```
Os produtos da categoria 'TV and Video' terão um desconto de 10%. Se além de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receberá mais 5%. Totalizando 15%. 

### IIF: alternativa ao CASE

Uma alternativa ao CASE seria a função IIF Ela é muito semelhante com a fórmula SE do Excel, pois pede exatamente 3 argumentos

  * Teste Lógico
  * Valor se verdadeiro
  * Valor se falso
    
No exercício abaixo, queremos classificar um projeto de acordo com o seu nível de risco. Utilizamos para isso uma variável
```
-- Qual é a categoria de risco do projeto abaixo, de acordo com sua nota:

-- Risco Alto: Classificação >= 5
-- Risco Baixo: Classificação < 5

DECLARE @varRisco INT
SET @varRisco = 6

SELECT 
	IIF( 
		@varRisco >= 5,
		'Risco Alto',
		'Risco Baixo')
```

### IIF Composto

É possível utilizar um IIF dentro de outro IIF, criando o que chamamos de IIF composto. Com essa aplicação, tratamos vários resultados possíveis, de acordo
com mais de um teste lógico.
No exemplo abaixo, queremos fazer uma consulta à tabela DimProduct e retornar o responsável pelos estoques dos produtos, de acordo com o StockTypeName.
Como temos 3 tipos de estoque e consequentemente 3 responsáveis diferentes, teremos que utilizar mais de 1 IIF para conseguir cobrir
todas as situações possíveis

```
-- Existem  tipos de estoque: High, Mid e Low. Faça um SELECT contendo as colunas de ProductKey, ProductName, StockTypeName e Nome do
-- Responsável pelo produto, de acordo com o tipo de estoque. A regra deverá ser a seguinte:
-- João é responsável pelo produto tipo High;
-- Maria é responsável pelo produto tipo Mid;
-- Adenor é responsável pelo produto tipo Low.

SELECT
	ProductKey,
	ProductName,
	StockTypeName,
	IIF(
		StockTypeName = 'High',
		'João',
		IIF(
			StockTypeName = 'Mid',
			'Maria',
			'Adenor')
			) AS 'Responsável'
FROM 
	DimProduct
```

### ISNULL: Tratando valores nulos

A função ISNULL nos permite retornar um resultado alternativo para o caso de um valor ser nulo ( Observe no exemplo abaixo a coluna CityName Diversas dessas cidades estão com o valor NULL. Podemos utilizar a função ISNULL para verificar essa coluna (no 1 º argumento) e caso o valor seja nulo, ele retornará um resultado alternativo
```
SELECT
	GeographyKey,
	ContinentName,
	CityName,
	ISNULL(CityName, 'Local Desconhecido')
FROM 
	DimGeography
```

### Exemplos Práticos 

1 - O setor de vendas decidiu aplicar um desconto aos produtos de acordo com a sua classe. O percentual aplicado deverá ser de:

  * Economy -> 5%
  * Regular -> 7%
  * Deluxe -> 9%

a) Faça uma consulta à tabela DimProduct que retorne as seguintes colunas: ProductKey, ProductName, e outras duas colunas que deverão retornar o % de Desconto e UnitPrice com desconto.
```
SELECT * FROM DimProduct

SELECT 
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	ClassName AS 'Classe',
	UnitPrice AS 'Preço Unitário',
	CASE	
		WHEN ClassName = 'Economy' THEN 0.05
		WHEN ClassName = 'Regular' THEN 0.07
		ELSE 0.09
	END AS 'Desconto',
	CASE	
		WHEN ClassName = 'Economy' THEN (1 - 0.05) * UnitPrice
		WHEN ClassName = 'Regular' THEN (1 - 0.07) * UnitPrice
        ELSE (1 - 0.09) * UnitPrice
	END AS 'Preço com Desconto'
FROM 
    DimProduct
```

b) Faça uma adaptação no código para que os % de desconto de 5%, 7% e 9% sejam facilmente modificados (dica: utilize variáveis).
```
DECLARE @varDescEco FLOAT, @varDescReg FLOAT, @varDescDel FLOAT
SET @varDescEco = 0.05
SET @varDescReg = 0.07
SET @varDescDel = 0.09
	
SELECT 
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	ClassName AS 'Classe',
	UnitPrice AS 'Preço Unitário',
	CASE	
		WHEN ClassName = 'Economy' THEN 0.05
		WHEN ClassName = 'Regular' THEN 0.07
		ELSE 0.09
	END AS 'Desconto',
	CASE	
		WHEN ClassName = 'Economy' THEN (1 - @varDescEco) * UnitPrice
		WHEN ClassName = 'Regular' THEN (1 - @varDescReg) * UnitPrice
        ELSE (1 - @varDescDel) * UnitPrice
	END AS 'Preço com Desconto'
FROM 
    DimProduct
```

2 - Você ficou responsável pelo controle de produtos da empresa e deverá fazer uma análise da quantidade de produtos por Marca.
A divisão das marcas em categorias deverá ser a seguinte:

  * CATEGORIA A: Mais de 500 produtos
  * CATEGORIA B: Entre 100 e 500 produtos
  * CATEGORIA C: Menos de 100 produtos

Faça uma consulta à tabela DimProduct e retorne uma tabela com um agrupamento de Total de Produtos por Marca, além da coluna de Categoria, conforme a regra acima.
```
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
```

3 - Será necessário criar uma categorização de cada loja da empresa considerando a quantidade de funcionários de cada uma. A lógica a ser seguida será a lógica abaixo:

  * EmployeeCount >= 50; 'Acima de 50 funcionários'
  * EmployeeCount >= 40; 'Entre 40 e 50 funcionários'
  * EmployeeCount >= 30; 'Entre 30 e 40 funcionários'
  * EmployeeCount >= 20; 'Entre 20 e 30 funcionários'
  * EmployeeCount >= 40; 'Entre 10 e 20 funcionários'
  * Caso contrário: 'Abaixo de 10 funcionários'

Faça uma consulta à tabela DimStore que retorne as seguintes informações: StoreName, EmployeeCount e a coluna de categoria, seguindo a regra acima.
```
SELECT
	StoreName AS 'Nome da Loja', 
	EmployeeCount AS 'Qtd de Funcionários',
	CASE 
		WHEN EmployeeCount >= 50 THEN 'Acima de 50 funcionários'
		WHEN EmployeeCount >= 40 THEN 'Entre 40 e 50 funcionários'
		WHEN EmployeeCount >= 30 THEN 'Entre de 30 e 40 funcionários'
		WHEN EmployeeCount >= 20 THEN 'Entre de 20 e 30 funcionários'
		ELSE 'Entre de 10 e 20 funcionários'
	END AS 'Categoria'
FROM
	DimStore
GROUP BY
	StoreName,
	EmployeeCount
```

4 - O setor de logística deverá realizar um transporte de carga dos produtos que estão no depósito de Seattle para o depósito de Sunnyside.
Não se tem muitas informações sobre os produtos que estão no depósito, apenas se sabe que existem 100 exemplares de cada Subcategoria. 
Ou seja, 100 laptops, 100 câmeras digitais, 100 ventiladores, e assim vai.
O gerente de logística definiu que os produtos serão transportados por duas rotas distintas. 
Além disso, a divisão dos produtos em cada uma das rotas será feita de acordo com as subcategorias (ou seja, todos os produtos de uma mesma subcategoria serão transportados pela mesma rota):
Rota 1: As subcategorias que tiverem uma soma total menor que 1000 kg deverão ser transportados pela Rota 1.
Rota 2: As subcategorias que tiverem uma soma total maior ou igual a 1000 kg deverão ser transportados pela Rota 2.

Você deverá realizar uma consulta à tabela DimProduct e fazer essa divisão das subcategorias por cada rota. Algumas dicas:

Dica 1: A sua consulta deverá ter um total de 3 colunas: Nome da Subcategoria, Peso Total e Rota.
Dica 2: Como não se sabe quais produtos existem no depósito, apenas que existem 100 exemplares de cada subcategoria, você deverá descobrir o peso médio de cada subcategoria e multiplicar essa média por 100, de forma que você descubra aproximadamente qual é o peso total dos produtos por subcategoria.
Dica 3: Sua resposta final deverá ter um JOIN e um GROUP BY.
```
SELECT 
	ProductSubCategoryName AS 'Nome da Subcategoria',
	ROUND(AVG(Weight), 2) AS 'Peso Médio', -- Coloquei essa coluna apenas com a intenção de organização
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
```

5 - O setor de marketing está com algumas ideias de ações para alavancar as vendas em 2021. Uma delas consiste em realizar sorteios entre os clientes da empresa.
Este sorteio será dividido em categorias:
  * ‘Sorteio Mãe do Ano’: Nessa categoria vão participar todas as mulheres com filhos.
  * ‘Sorteio Pai do Ano’: Nessa categoria vão participar todos os pais com filhos.
  * ‘Caminhão de Prêmios’: Nessa categoria vão participar todas os demais clientes (homens e mulheres sem filhos).
 
 Seu papel será realizar uma consulta à tabela DimCustomer e retornar 3 colunas:
  * FirstName AS ‘Nome’
  * Gender AS ‘Sexo’
  * TotalChildren AS ‘Qtd. Filhos’
  * EmailAdress AS ‘E-mail’

Ação de Marketing: nessa coluna você deverá dividir os clientes de acordo com as categorias ‘Sorteio Mãe do Ano’, ‘Sorteio Pai do Ano’ e ‘Caminhão de Prêmios’.

```
SELECT
	CONCAT(FirstName,' ',LastName) AS 'Nome Completo',
	Gender AS 'Sexo',
	TotalChildren AS 'Qtd. Filhos',
	EmailAddress AS 'E-mail',
	CASE
		WHEN TotalChildren >= 1 AND Gender = 'F' THEN 'Sorteio Mãe do Ano'
		WHEN TotalChildren >= 1 AND Gender = 'M' THEN 'Sorteio Pai do Ano'
		ELSE 'Caminhão de Prêmios'
	END AS 'Ação de Marketing'
FROM 
	DimCustomer
```

6 - Descubra qual é a loja que possui o maior tempo de atividade (em dias). Você deverá fazer essa consulta na tabela DimStore, e considerar a coluna OpenDate como referência para esse cálculo. Atenção: lembre-se que existem lojas que foram fechadas.

OBSERVAÇÃO: Essa resolução é um aprimoramento do exercício do assunto anterior. Note que ele não leva em consideração as empresas que têm data de fechamento. veja abaixo: primeiro a resolução antiga e depois o aprimoramento
```
-- Resolução antiga. 294 linhas (Não levou em consideração as empresas que fecharam as portas)

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
```

```
-- Resolução aprimorada. 306 linhas (leva em conta as empresas que fecharam as portas

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
```

## SQL Views

Até agora, exploramos consultas ao banco de dados usando comandos como SELECT, GROUP BY e JOINs para visualizar dados temporariamente. No entanto, as tabelas criadas durante essas consultas não são armazenadas permanentemente. Cada vez que executamos um SELECT e, em seguida, outro SELECT, o resultado anterior é perdido.

A solução para preservar esses resultados é usar Views. Views são estruturas que permitem salvar consultas SQL complexas em um formato persistente. Diferentemente das consultas regulares, as Views são armazenadas no banco de dados e podem ser acessadas e consultadas posteriormente. Isso evita a necessidade de recriar consultas várias vezes.

Em resumo, as Views proporcionam uma maneira de salvar consultas frequentemente usadas, oferecendo conveniência e eficiência ao evitar a perda de resultados após cada consulta.

### Tudo bem, mas o que de fato é uma VIEW?

Uma View, ou exibição, é uma tabela virtual gerada por meio de uma consulta a uma ou mais tabelas no banco de dados. Ela se assemelha a uma tabela real, contendo linhas e colunas, e pode incorporar comandos como JOIN, WHERE e outras funções para manipulação de dados.

O diferencial das Views é que elas sempre refletem os dados mais atualizados no banco. Se houver alterações nos dados subjacentes, as Views são automaticamente atualizadas, garantindo que os resultados estejam sempre em sincronia.

Além disso, as Views são persistentes mesmo após o desligamento do servidor ou o fechamento do SQL Server Management Studio (SSMS). Elas proporcionam uma maneira eficiente de armazenar os resultados de consultas SELECT, permitindo o acesso fácil e recorrente a esses dados sem a necessidade de recriar a consulta do zero.

Em resumo, as Views oferecem a conveniência de armazenar e acessar resultados de consultas, comportando-se como tabelas virtuais atualizadas automaticamente.

### Vantagens de usar VIEWS

* **Reaproveitamento**: Sempre que precisarmos, podemos consultar a View, pois ela é armazenada no sistema.
* **Segurança**: Ao criar uma View, estamos selecionando e exibindo apenas as informações relevantes da tabela original do banco de dados. Isso permite ocultar linhas ou colunas desnecessárias, focando apenas nos dados que são pertinentes para a análise ou consulta específica.
* **Otimização de tempo**: Ao criar Views, economizamos tempo ao evitar a necessidade de recriar várias consultas SELECT. Isso resulta em um aumento da produtividade, uma vez que as Views fornecem uma maneira eficiente de armazenar e reutilizar consultas complexas de forma conveniente.

### Criando a primeira VIEW

Para criar uma View utilizamos o comando CREATE VIEW. Abaixo temos a estrutura padrão:
```
-- Crie uma VIEW contendo as seguintes informações da tabela DimCustomer: FirstName, EmailAddres e BirthDate. Chame essa VIEW de  
-- vwClientes

GO -- Essa função serve para delimitar o início e o final da CREATE VIEW. Para que o SQL não confunda códigos acima e abaixo como pertencentes a msm Consulta
CREATE VIEW vwClientes AS
SELECT
	FirstName AS 'Nome', 
	EmailAddress AS 'E-mail',
	BirthDate AS 'Data de Nascimento'
FROM
	DimCustomer
GO

SELECT * FROM vwClientes
```

### Alterando uma View criada

Para alterar uma View criada, usamos o comando ALTER VIEW. Abaixo temos um exemplo. A VIEW vwClientes criada anteriormente,
foi alterada para considerar apenas os clientes do sexo feminino.

```
-- Altere a VIEW criada no exemplo anterior para incluir apenas os clientes do sexo feminino

GO
ALTER VIEW vwClientes AS
SELECT
	FirstName AS 'Nome', 
	EmailAddress AS 'E-mail',
	BirthDate AS 'Data de Nascimento',
	Gender AS 'Sexo'
FROM
	DimCustomer
WHERE
	Gender = 'F'
GO

SELECT * FROM vwClientes
```

### Excluindo uma View

Para excluir uma View criada, usamos o comando DROP VIEW
```
-- Exclua as VIEWs vwClientes e vwProdutos

DROP VIEW vwClientes, vwProdutos
```
