--1. Declare 4 vari�veis inteiras. Atribua os seguintes valores a elas:
--valor1 = 10
--valor2 = 5
--valor3 = 34
--valor4 = 7

-- a) Crie uma nova vari�vel para armazenar o resultado da soma entre valor1 e valor2. Chame essa vari�vel de soma.

DECLARE @valor1 INT
DECLARE @valor2 INT
DECLARE @variavelSoma INT

SET @valor1 = 10
SET @valor2 = 5
SET @variavelSoma = @valor1 + @valor2

SELECT @variavelSoma AS 'Soma'

--b) Crie uma nova vari�vel para armazenar o resultado da subtra��o entre valor3 e valor 4. Chame essa vari�vel de subtracao.

DECLARE @valor3 INT
DECLARE @valor4 INT
DECLARE @variavelSubtra��o INT

SET @valor3 = 34
SET @valor4 = 7
SET @variavelSubtra��o = @valor3 - @valor4

SELECT @variavelSubtra��o AS 'Subtra��o'

--c) Crie uma nova vari�vel para armazenar o resultado da multiplica��o entre o valor 1 e o valor4. Chame essa vari�vel de multiplicacao.

DECLARE @valor1 INT
DECLARE @valor4 INT
DECLARE @variavelMultiplica��o INT

SET @valor1 = 10
SET @valor4 = 7
SET @variavelMultiplica��o = @valor1 * @valor4

SELECT @variavelMultiplica��o AS 'Multiplica��o'

--d) Crie uma nova vari�vel para armazenar o resultado da divis�o do valor3 pelo valor4. Chame essa vari�vel de divisao. Obs: O resultado dever� estar em decimal, e n�o em inteiro.

DECLARE @valor3 FLOAT
DECLARE @valor4 FLOAT
DECLARE @variavelDivis�o FLOAT

SET @valor3 = 34
SET @valor4 = 7
SET @variavelDivis�o = @valor3 / @valor4

SELECT @variavelDivis�o AS 'Divis�o'

--e) Arredonde o resultado da letra d) para 2 casas decimais.

DECLARE @valor3 FLOAT
DECLARE @valor4 FLOAT
DECLARE @variavelDivis�o FLOAT

SET @valor3 = 34
SET @valor4 = 7
SET @variavelDivis�o = @valor3 / @valor4

SELECT ROUND (@variavelDivis�o, 2) AS 'Divis�o'


--2. Para cada declara��o das vari�veis abaixo, aten��o em rela��o ao tipo de dado que dever� ser especificado.
--a) Declare uma vari�vel chamada �produto� e atribua o valor de �Celular�.
--b) Declare uma vari�vel chamada �quantidade� e atribua o valor de 12.
--c) Declare uma vari�vel chamada �preco� e atribua o valor 9.99.
--d) Declare uma vari�vel chamada �faturamento� e atribua o resultado da multiplica��o entre �quantidade� e �preco�.
--e) Visualize o resultado dessas 4 vari�veis em uma �nica consulta, por meio do SELECT.

DECLARE @varProduto VARCHAR(30)
DECLARE @varQuantidade FLOAT -- S�o tipo FLOAT para que representem n�meros decimais. Se fosse INT, o valor estaria errado
DECLARE @varPreco FLOAT
DECLARE @varFaturamento FLOAT

SET @varProduto = 'Celular'
SET @varQuantidade = 12
SET @varPreco = 9.99
SET @varFaturamento = @varQuantidade * @varPreco

SELECT 
	@varProduto AS 'Produto',
	@varQuantidade AS 'Quantidade',
	@varPreco AS 'Pre�o',
	@varFaturamento AS 'Faturamento'

-- 3. Voc� � respons�vel por gerenciar um banco de dados onde s�o recebidos dados externos de usu�rios. Em resumo, esses dados s�o:
-- - Nome do usu�rio
-- - Data de nascimento
-- - Quantidade de pets que aquele usu�rio possui
-- Voc� precisar� criar um c�digo em SQL capaz de juntar as informa��es fornecidas por este usu�rio. 
-- Para simular estes dados, crie 3 vari�veis, chamadas: nome, data_nascimento e num_pets. 
-- Voc� dever� armazenar os valores �Andr�, �10/02/1998� e 2, respectivamente.

--Dica: voc� precisar� utilizar as fun��es CAST e FORMAT para chegar no resultado.

DECLARE @varNomedoUsuario VARCHAR(30)
DECLARE @varDataDeNascimento DATETIME
DECLARE @varQuantidadeDePets INT

SET @varNomedoUsuario = 'Andr�'
SET @varDataDeNascimento = '10/02/1998'
SET @varQuantidadeDePets = 2

-- PRINT 'O total de lojas abertas ' + CAST(@varLojasOn AS VARCHAR(30)) -- O CAST FOI USADO PARA CONVERTER O A VARIAVEL EM TEXTO

PRINT 'Meu nome � ' + @varNomedoUsuario + ', ' + 'Nasci em ' + FORMAT(@varDataDeNascimento, 'dd/MM/yyyy') + ' e tenho ' + CAST(@varQuantidadeDePets AS VARCHAR(30)) + ' pets.'


-- 4. Voc� acabou de ser promovido e o seu papel ser� realizar um controle de qualidade sobre as lojas da empresa.
--A primeira informa��o que � passada a voc� � que o ano de 2008 foi bem complicado para a empresa, pois foi quando 
--duas das principais lojas fecharam. O seu primeiro desafio � descobrir o nome dessas lojas que fecharam no ano de 2008, 
--para que voc� possa entender o motivo e mapear planos de a��o para evitar que outras lojas importantes tomem o mesmo caminho.
--O seu resultado dever� estar estruturado em uma frase, com a seguinte estrutura:
--�As lojas fechadas no ano de 2008 foram: � + nome_das_lojas

DECLARE @varNomeDasLojasOff VARCHAR(100)
SET @varNomeDasLojasOff = ''

SELECT @varNomeDasLojasOff = @varNomeDasLojasOff + StoreName + ', '
FROM DimStore
WHERE FORMAT(CloseDate, 'yyyy') = 2008

PRINT 'As lojas fechadas no ano de 2008 foram: ' + @varNomeDasLojasOff

-- 5. Voc� precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria espec�fica: �Lamps�.
-- Utilize o conceito de vari�veis para chegar neste resultado.

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

