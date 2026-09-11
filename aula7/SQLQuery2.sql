CREATE FUNCTION fn_calcula_Idade(@data_nasc DATE)
RETURNS INT
AS
BEGIN
    DECLARE @idade INT;
    SET @idade = DATEDIFF(YEAR, @data_nasc, GETDATE());
    
    
    IF (MONTH(@data_nasc) > MONTH(GETDATE()))
       OR ((MONTH(@data_nasc) = MONTH(GETDATE())) AND (DAY(@data_nasc) > DAY(GETDATE())))
    BEGIN
        SET @idade = @idade - 1;
    END;
    
    RETURN @idade;
END;
GO

SELECT D.Nome_dependente, D.Datanasc, dbo.fn_calcula_Idade(D.Datanasc) AS 'Idade'
FROM DEPENDENTE AS D;
GO

-- Retornar todos os funcionarios de um determinado departamento
CREATE FUNCTION fn_func_dpt(@nome_dpt VARCHAR(50))
RETURNS TABLE
AS 
RETURN
(
    SELECT F.Pnome, F.Unome
    FROM FUNCIONARIO AS F
    JOIN DEPARTAMENTO AS D
    ON F.Dnr = D.Dnumero
    WHERE D.Dnome = @nome_dpt
);
GO

SELECT * FROM dbo.fn_func_dpt('Pesquisa');
GO

-- FUNÇÂO QUE RETORNA NOME COMPLETO DOS FUNCIONARIOS E O VALOR DO SALARIO ANUAL
-- COM FÉRIAS E DÉCIMO TERCEIRO
CREATE FUNCTION fn_salarionaAnual()
RETURNS @SalAno  TABLE
(
   Nome_comp VARCHAR(100),
   saLario DECIMAL(10,2),
   salario_anual DECIMAL(10,2)
)
AS
BEGIN
    INSERT INTO @SalAno
    SELECT
         CONCAT(F.Pnome, ' ', F.Minicial, ' ', F.Unome),
         F.Salario,
         F.Salario * 13 + (F.Salario*0.3)
    FROM FUNCIONARIO AS F
    RETURN;
END;
GO

SELECT  * FROM DBO.fn_salarionaAnual();
GO

