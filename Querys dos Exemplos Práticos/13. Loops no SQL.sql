-- 1. Utilize o loop WHILE para criar um contador que comece em um valor inicial @ValorInicial e termine em um valor final
-- @ValorFinal. Você deverá printar na tela a seguinte frase: 

-- 'O valor do contador é:' +

DECLARE @ValorInicial INT
DECLARE @ValorFinal INT

SET @ValorInicial = 1
SET @ValorFinal = 100

WHILE @ValorInicial <= @ValorFinal
BEGIN 
	PRINT CONCAT('O valor do contador é:' , @ValorInicial) 
	SET @ValorInicial = @ValorInicial + 1 
END


-- 2. Você deverá criar uma estrutura de repetição que printe na tela a quantidade de contratações para cada ano desde 1996 até 2003.
-- A informação de data de contratação encontra-se na coluna HireDate da tabela DimEmployer. Utilize o formato.

-- X contratções em 1996
-- Y contratções em 1997
-- Z contratções em 1998
-- ...
-- ...
-- N Contratações em 2003

-- OBS: A coluna HireDate contém a data completa (dd/mm/aaaa). Lembrando que você deverá printar a quantidade de contratações por ano

DECLARE @AnoInicial INT = 1996
DECLARE @AnoFinal INT = 2003

WHILE @AnoInicial <= @AnoFinal
BEGIN 

	DECLARE @QtdFuncionarios INT = (SELECT COUNT(*) FROM DimEmployee
									WHERE YEAR(HireDate) = @AnoInicial)
	PRINT CONCAT(@QtdFuncionarios, 'contratações em ', @AnoInicial)
	SET @AnoInicial = @AnoInicial + 1
END


-- 3. Utilize um loop While para criar uma tabela chamada Calendário, contendo uma coluna que comece com a data 01/01/2021 e vá ate 31/12/2021

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
