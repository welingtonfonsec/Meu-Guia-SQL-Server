## Índice

[1. Introdução ao SQL](#introdução-ao-SQL)

[2. Ordenando e Filtrando Dados](#ordeando-e-filtrando-dados)

[3. Funções de Agregação ](#aunções-de-agregação)

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


## Funções de Agregação

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
SELECT 
	TOP (100) *
FROM 
	FactSales
ORDER BY 
	SalesAmount DESC
```


