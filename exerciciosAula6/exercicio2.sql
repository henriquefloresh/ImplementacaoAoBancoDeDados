SELECT CAST(GETDATE() AS VARCHAR(10)) AS DataAtualFormatada;
 
SELECT CONVERT(INT, 12345.67) AS NumeroConvertido;

DECLARE @NumeroDecimal DECIMAL(10,2) = 987.65;
DECLARE @NumeroInteiro INT = 42;
 
SELECT CAST(@NumeroDecimal AS INT) AS DecimalParaInteiro_CAST;
SELECT CONVERT(INT, @NumeroDecimal) AS DecimalParaInteiro_CONVERT;
 

SELECT CAST(@NumeroInteiro AS DECIMAL(10,2)) AS InteiroParaDecimal_CAST;
SELECT CONVERT(DECIMAL(10,2), @NumeroInteiro) AS InteiroParaDecimal_CONVERT;

DECLARE @DataNascimento VARCHAR(10) = '15/08/1990';
DECLARE @DataConvertida DATE;
 
SET @DataConvertida = CONVERT(DATE, @DataNascimento, 103); 
SELECT @DataConvertida AS DataNascimentoConvertida;
