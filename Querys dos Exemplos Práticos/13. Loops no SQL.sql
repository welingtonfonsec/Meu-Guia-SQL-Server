-- 1. Utilize o loop WHILE para criar um contador que comece em um valor inicial @ValorInicial e termine em um valor final
-- @ValorFinal. Voc� dever� printar na tela a seguinte frase: 

-- 'O valor do contador �:' +

DECLARE @ValorInicial INT
DECLARE @ValorFinal INT

SET @ValorInicial = 1
SET @ValorFinal = 100

WHILE @ValorInicial <= @ValorFinal
BEGIN 
	PRINT CONCAT('O valor do contador �:' , @ValorInicial) 
	SET @ValorInicial = @ValorInicial + 1 
END


-- 2. Voc� dever� criar uma estrutura de repeti��o que printe na tela a quantidade de contrata��es para cada ano desde 1996 at� 2003.
-- A informa��o de data de contrata��o encontra-se na coluna HireDate da tabela DimEmployer. Utilize o formato.

-- X contrat��es em 1996
-- Y contrat��es em 1997
-- Z contrat��es em 1998
-- ...
-- ...
-- N Contrata��es em 2003

-- OBS: A coluna HireDate cont�m a data completa (dd/mm/aaaa). Lembrando que voc� dever� printar a quantidade de contrata��es por ano

DECLARE @AnoInicial INT = 1996
DECLARE @AnoFinal INT = 2003

WHILE @AnoInicial <= @AnoFinal
BEGIN 

	DECLARE @QtdFuncionarios INT = (SELECT COUNT(*) FROM DimEmployee
									WHERE YEAR(HireDate) = @AnoInicial)
	PRINT CONCAT(@QtdFuncionarios, 'contrata��es em ', @AnoInicial)
	SET @AnoInicial = @AnoInicial + 1
END


-- 3. Utilize um loop While para criar uma tabela chamada Calend�rio, contendo uma coluna que comece com a data 01/01/2021 e v� ate 31/12/2021

CREATE TABLE Calendario (
    Date DATE
)

DECLARE @DataInicio DATE = '2021-01-01'
DECLARE @DataFim DATE = '2021-12-31'

WHILE @DataInicio <= @DataFim
BEGIN
    INSERT INTO Calendario (Date) VALUES(@DataInicio)
    SET @DataInicio = DATEADD(DAY, 1, @DataInicio)
END

SELECT * FROM Calendario;
