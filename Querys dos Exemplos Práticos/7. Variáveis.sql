--1. Declare 4 variáveis inteiras. Atribua os seguintes valores a elas:
--valor1 = 10
--valor2 = 5
--valor3 = 34
--valor4 = 7

-- a) Crie uma nova variável para armazenar o resultado da soma entre valor1 e valor2. Chame essa variável de soma.

DECLARE @valor1 INT
DECLARE @valor2 INT
DECLARE @variavelSoma INT

SET @valor1 = 10
SET @valor2 = 5
SET @variavelSoma = @valor1 + @valor2

SELECT @variavelSoma AS 'Soma'

--b) Crie uma nova variável para armazenar o resultado da subtração entre valor3 e valor 4. Chame essa variável de subtracao.

DECLARE @valor3 INT
DECLARE @valor4 INT
DECLARE @variavelSubtração INT

SET @valor3 = 34
SET @valor4 = 7
SET @variavelSubtração = @valor3 - @valor4

SELECT @variavelSubtração AS 'Subtração'

--c) Crie uma nova variável para armazenar o resultado da multiplicação entre o valor 1 e o valor4. Chame essa variável de multiplicacao.

DECLARE @valor1 INT
DECLARE @valor4 INT
DECLARE @variavelMultiplicação INT

SET @valor1 = 10
SET @valor4 = 7
SET @variavelMultiplicação = @valor1 * @valor4

SELECT @variavelMultiplicação AS 'Multiplicação'

--d) Crie uma nova variável para armazenar o resultado da divisão do valor3 pelo valor4. Chame essa variável de divisao. Obs: O resultado deverá estar em decimal, e não em inteiro.

DECLARE @valor3 FLOAT
DECLARE @valor4 FLOAT
DECLARE @variavelDivisão FLOAT

SET @valor3 = 34
SET @valor4 = 7
SET @variavelDivisão = @valor3 / @valor4

SELECT @variavelDivisão AS 'Divisão'

--e) Arredonde o resultado da letra d) para 2 casas decimais.

DECLARE @valor3 FLOAT
DECLARE @valor4 FLOAT
DECLARE @variavelDivisão FLOAT

SET @valor3 = 34
SET @valor4 = 7
SET @variavelDivisão = @valor3 / @valor4

SELECT ROUND (@variavelDivisão, 2) AS 'Divisão'


--2. Para cada declaração das variáveis abaixo, atenção em relação ao tipo de dado que deverá ser especificado.
--a) Declare uma variável chamada ‘produto’ e atribua o valor de ‘Celular’.
--b) Declare uma variável chamada ‘quantidade’ e atribua o valor de 12.
--c) Declare uma variável chamada ‘preco’ e atribua o valor 9.99.
--d) Declare uma variável chamada ‘faturamento’ e atribua o resultado da multiplicação entre ‘quantidade’ e ‘preco’.
--e) Visualize o resultado dessas 4 variáveis em uma única consulta, por meio do SELECT.

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

-- 3. Você é responsável por gerenciar um banco de dados onde são recebidos dados externos de usuários. Em resumo, esses dados são:
-- - Nome do usuário
-- - Data de nascimento
-- - Quantidade de pets que aquele usuário possui
-- Você precisará criar um código em SQL capaz de juntar as informações fornecidas por este usuário. 
-- Para simular estes dados, crie 3 variáveis, chamadas: nome, data_nascimento e num_pets. 
-- Você deverá armazenar os valores ‘André’, ‘10/02/1998’ e 2, respectivamente.

--Dica: você precisará utilizar as funções CAST e FORMAT para chegar no resultado.

DECLARE @varNomedoUsuario VARCHAR(30)
DECLARE @varDataDeNascimento DATETIME
DECLARE @varQuantidadeDePets INT

SET @varNomedoUsuario = 'André'
SET @varDataDeNascimento = '10/02/1998'
SET @varQuantidadeDePets = 2

-- PRINT 'O total de lojas abertas ' + CAST(@varLojasOn AS VARCHAR(30)) -- O CAST FOI USADO PARA CONVERTER O A VARIAVEL EM TEXTO

PRINT 'Meu nome é ' + @varNomedoUsuario + ', ' + 'Nasci em ' + FORMAT(@varDataDeNascimento, 'dd/MM/yyyy') + ' e tenho ' + CAST(@varQuantidadeDePets AS VARCHAR(30)) + ' pets.'


-- 4. Você acabou de ser promovido e o seu papel será realizar um controle de qualidade sobre as lojas da empresa.
--A primeira informação que é passada a você é que o ano de 2008 foi bem complicado para a empresa, pois foi quando 
--duas das principais lojas fecharam. O seu primeiro desafio é descobrir o nome dessas lojas que fecharam no ano de 2008, 
--para que você possa entender o motivo e mapear planos de ação para evitar que outras lojas importantes tomem o mesmo caminho.
--O seu resultado deverá estar estruturado em uma frase, com a seguinte estrutura:
--‘As lojas fechadas no ano de 2008 foram: ’ + nome_das_lojas

DECLARE @varNomeDasLojasOff VARCHAR(100)
SET @varNomeDasLojasOff = ''

SELECT @varNomeDasLojasOff = @varNomeDasLojasOff + StoreName + ', '
FROM DimStore
WHERE FORMAT(CloseDate, 'yyyy') = 2008

PRINT 'As lojas fechadas no ano de 2008 foram: ' + @varNomeDasLojasOff

-- 5. Você precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria específica: ‘Lamps’.
-- Utilize o conceito de variáveis para chegar neste resultado.

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory


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

