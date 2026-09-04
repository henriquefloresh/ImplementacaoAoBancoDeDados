-- Exibir uma mensagem na tela do salário do funcionário criando duas variaveis 

DECLARE @nomeFuncionario VARCHAR(100),
		@salarioFuncionario DECIMAL(10,2); 
SET @nomeFuncionario = 'Jennifer';

SELECT @salarioFuncionario = F.Salario
FROM FUNCIONARIO AS F
WHERE F.Pnome = @nomeFuncionario;

PRINT	'O funcionario '
		+@nomeFuncionario	
		+ ' tem um salário de: R$ ' 
		+ CAST(@salarioFuncionario AS VARCHAR(10)); -- Converte para varchar 


-- CONVERT 
-- Normalmente utilizado para conversões de datas, "converter data padrão amarecicano para padrão brasileiro"
SET @nomeFuncionario = 'Jennifer';

SELECT @salarioFuncionario = F.Salario
FROM FUNCIONARIO AS F
WHERE F.Pnome = @nomeFuncionario;

PRINT	'O funcionario '
		+@nomeFuncionario	
		+ ' tem um salário de: R$ ' 
		+ CONVERT(VARCHAR(10), @salarioFuncionario*1.1);

-- Condicional IF/ELSE 
DECLARE @mediaSalarial DECIMAL(10,2),
		@nome VARCHAR(100),
		@salario DECIMAL(10,2);
SET @nome = 'Jennifer'; 

SELECT @mediaSalarial = AVG(F.Salario) FROM FUNCIONARIO AS F 
SELECT @salario = F.Salario FROM FUNCIONARIO AS F WHERE @nome = F.Pnome

IF(@salario < @mediaSalarial)
	PRINT	'O funcionario(a) '
			+@nome
			+' ganha abaixo da média'; 
ELSE 
	PRINT	'O funcionario(a) '
			+@nome
			+' ganha acima da média'; 


-- Verificar se um funcionario esta próxio de se aposentar (60 anos)
-- > 56 e > 60 esta próximo 
-- > 60 ja passou do tempo 
DECLARE @idade INT;
SET @nome = 'Jennifer';

SELECT @idade = DATEDIFF(YEAR, F.Datanasc, GETDATE())
    - CASE
        WHEN DATEADD(YEAR, DATEDIFF(YEAR, F.Datanasc, GETDATE()), F.Datanasc) > GETDATE()
        THEN 1
        ELSE 0
      END
FROM FUNCIONARIO AS F
IF(@idade > 56 AND @idade < 60)
	BEGIN 
		PRINT @idade; 
		PRINT 'Esta próximo de se aposentar';
	END 
ELSE IF(@idade = 60)
	BEGIN 
		PRINT @idade;
		PRINT 'Está na idade para se aposentar';
	END 
ELSE IF(@idade > 60)
	BEGIN 
		PRINT @idade;
		PRINT 'Já passou do tempo para se aposentar';
	END
ELSE 
	BEGIN 
		PRINT @idade;
		PRINT 'Está longe de se aposentar';
	END 
GO


-- Tendo o nome da pessoa calcular a idade correta
DECLARE @data_nasc DATE, @nome VARCHAR(100), @idade INT;
SET @nome = 'JOÃO';
SELECT @data_nasc = Datanasc FROM FUNCIONARIO WHERE Pnome = @nome
IF(MONTH(GETDATE()) < MONTH(@data_nasc))
	SET @idade = DATEDIFF(YEAR,@data_nasc,GETDATE()) -1
ELSE IF (MONTH(GETDATE()) = MONTH(@data_nasc) ) 
			AND DAY(@data_nasc) > DAY(GETDATE())
	 SET @idade = DATEDIFF(YEAR,@data_nasc,GETDATE())-1
ELSE
	SET @idade = DATEDIFF(YEAR,@data_nasc,GETDATE())
PRINT @data_nasc
PRINT @idade

SELECT * FROM FUNCIONARIO
GO

SELECT
	F.Pnome,
	F.Unome,
	F.Salario,
	IIF(F.Salario < 20000,'Baixo','Alto') AS 'Categoria'
FROM FUNCIONARIO AS F;
-- CASE
SELECT
	F.Pnome,
	F.Unome,
	F.Salario,
	CASE 
		WHEN F.Salario <= 10000 AND F.Salario > 0 THEN 'Baixo'
		WHEN F.Salario > 10000 AND F.Salario <= 30000 THEN 'Medio'
		WHEN F.Salario > 30000 THEN 'Alto'
		ELSE 'ERRO'
	END AS 'Categoria'
FROM FUNCIONARIO AS F;

-- WHILE
DECLARE @contador INT = 0;

WHILE @contador < 10
BEGIN 
	SET @contador = @contador+1
	IF @contador %2 = 0
		CONTINUE
	PRINT 'Contador: ' + CAST(@contador AS VARCHAR(3));
END

-- CURSORES
DECLARE @nome VARCHAR(50);

DECLARE cursorFuncionario CURSOR FOR
SELECT Pnome FROM FUNCIONARIO;

OPEN cursorFuncionario;

FETCH NEXT FROM cursorFuncionario INTO @nome;

WHILE @@FETCH_STATUS = 0
BEGIN 
	PRINT @nome;
	FETCH NEXT FROM cursorFuncionario INTO @nome
END

CLOSE cursorFuncionario;
DEALLOCATE cursorFuncionario;
