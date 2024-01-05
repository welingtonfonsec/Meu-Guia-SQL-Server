## Índice

[1. Introdução ao SQL](#introdução-ao-SQL)

[2. Ordenando e Filtrando Dados](#ordeando-e-filtrando-dados)

[3. Funções de Agregação ](#funções-de-agregação)

[4. Criando Agrupamentos no SQL](#criando-argumentos-no-sql)

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

### Conceitos Básicos 

#### ORDER BY:

A cláusula ORDER BY é usada para ordenar o resultado de uma consulta em ordem ascendente (ASC) ou descendente (DESC) com base em uma ou mais colunas.
Exemplo:

```
SELECT column1, column2
FROM table
ORDER BY column1 ASC, column2 DESC;
```

#### WHERE:

A cláusula WHERE é usada para filtrar registros com base em uma condição especificada. Somente os registros que atendem à condição serão incluídos no resultado da consulta.
Exemplo:

```
SELECT column1, column2
FROM table
WHERE column1 > 10;
```

#### OR:

O operador OR é usado para combinar duas ou mais condições na cláusula WHERE, onde pelo menos uma das condições deve ser verdadeira para incluir o registro no resultado.
Exemplo:

```
SELECT column1, column2
FROM table
WHERE column1 > 10 OR column2 = 'ABC';
```
#### AND:

O operador AND é usado para combinar duas ou mais condições na cláusula WHERE, onde todas as condições devem ser verdadeiras para incluir o registro no resultado.
Exemplo:

```
SELECT column1, column2
FROM table
WHERE column1 > 10 AND column2 = 'ABC';
```
#### NOT:

O operador NOT é usado para negar uma condição na cláusula WHERE, ou seja, retorna registros que não atendem à condição especificada.
Exemplo:

```
SELECT column1, column2
FROM table
WHERE NOT column1 = 10;
```

#### IN:

O operador IN é usado para filtrar registros com base em uma lista de valores. Ele retorna registros onde uma coluna está presente em uma lista de valores.
Exemplo:

```
SELECT column1, column2
FROM table
WHERE column1 IN (1, 2, 3);
```

#### LIKE:

O operador LIKE é usado para realizar buscas de padrões em uma coluna. É frequentemente usado com caracteres curinga (% para qualquer sequência de caracteres, _ para um único caractere).
Exemplo:

```
SELECT column1, column2
FROM table
WHERE column2 LIKE 'A%';
```

#### IS NULL / IS NOT NULL:

As condições IS NULL e IS NOT NULL são usadas para verificar se um valor em uma coluna é nulo ou não nulo, respectivamente.
Exemplo:

```
SELECT column1, column2
FROM table
WHERE column1 IS NULL;
```

#### BETWEEN:

O operador BETWEEN é usado para filtrar registros com base em um intervalo de valores. Ele inclui os valores limite na condição.
Exemplo:

```
SELECT column1, column2
FROM table
WHERE column1 BETWEEN 10 AND 20;
```

### Exemplos Práticos 

1 - Você é o gerente da área de compras e precisa criar um relatório com as TOP 100 vendas, de acordo com a quantidade vendida. 
Utilize seu conhecimento em SQL para buscar essas TOP 100 vendas, de acordo com o total vendido (SalesAmount).
```
SELECT 	TOP (100)
	*
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
```


3 - Você é responsável pelo setor de logística da empresa Contoso e precisa dimensionar o transporte de todos os produtos em categorias, de acordo com o peso.
Os produtos da categoria A, com peso acima de 100kg, deverão ser transportados na primeira leva. Faça uma consulta no banco de dados para descobrir quais são estes produtos que estão na categoria A.

a) Você deverá retornar apenas 2 colunas nessa consulta: Nome do Produto e Peso.
b) Renomeie essas colunas com nomes mais intuitivos.
c) Ordene esses produtos do mais pesado para o mais leve.

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
```

6 - Imagine que você precise extrair um relatório da tabela DimStore, com informações de lojas. Mas você precisa apenas das lojas que não estão mais funcionando atualmente.
a) Utilize a coluna de Status para filtrar a tabela e trazer apenas as lojas que não estão mais funcionando.

```
SELECT 
	*
FROM
	DimStore
WHERE
	Status = 'off'
```

b) Agora imagine que essa coluna de Status não existe na sua tabela. Qual seria a outra forma que você teria de descobrir quais são as lojas que não estão mais funcionando?

```
SELECT 
	*
FROM
	DimStore
WHERE
	CloseDate IS NOT NULL
```

7 - De acordo com a quantidade de funcionários, cada loja receberá uma determinada quantidade de máquinas de café. 
As lojas serão divididas em 3 categorias:

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

9 - Faça uma lista com todos os produtos das cores: Green, Orange, Black, Silver e Pink. Estes produtos devem ser exclusivamente das marcas: 
Contoso, Litware e Fabrikam.

```
SELECT 
	*
FROM
	DimProduct
WHERE
	ColorName IN ('Green', 'Orange', 'Black', 'Silver', 'Pink')
	AND BrandName IN('Contoso', 'Litware', 'Fabrikam')
``` 

10 - A empresa possui 16 produtos da marca Contoso, da cor Silver e com um Weight entre 10 e 30. Descubra quais são esses 
produtos e ordene o resultado em ordem decrescente de acordo com o preço (UnitPrice).

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
