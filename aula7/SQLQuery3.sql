CREATE PROCEDURE sp_exibe_meu_nome
AS 
BEGIN
    PRINT 'HENRIQUE F. HIEMER';
END
GO

EXEC sp_exibe_meu_nome;
GO

-- Crie um procedure que liste o nome completo dos funcionários
-- e os nomes dos seus  respectivos departamentos
GO
CREATE PROCEDURE sp_dissidio(
    @porcentagem_anual DECIMAL(3,1), 
    @cpf CHAR(11)
)
AS
BEGIN
    UPDATE FUNCIONARIO
    SET Salario = Salario * (1 + (@porcentagem_anual / 100))
    WHERE Cpf = @cpf;
END;
GO

EXEC sp_dissidio @porcentagem_anual = 5.0, @cpf = '98765432300';

SELECT * FROM FUNCIONARIO;
GO


CREATE PROCEDURE sp_funcionarios
WITH ENCRYPTION
AS
SELECT * FROM FUNCIONARIO;
GO

EXEC sp_help sp_funcionarios;
GO

--Crie um procedure que insira um novo departamento com sua respectiva localidade
CREATE PROCEDURE sp_add_dpt_loc (@nome_dpt VARCHAR(50), @dpt_numero INT, @local VARCHAR(50))
AS
BEGIN
     IF EXISTS (SELECT 1 FROM DEPARTAMENTO WHERE Dnome = @nome_dpt)
     BEGIN
         PRINT 'Já existe um departamento' + @nome_dpt;
         RETURN;
     END
  ELSE
     BEGIN
        INSERT INTO DEPARTAMENTO (Dnome,Dnumero)
        VALUES (@nome_dpt, @dpt_numero);

        INSERT INTO LOCALIZACAO_DEP (Dnumero, Dlocal)
        VALUES (@dpt_numero,@local);
        PRINT @nome_dpt + 'inserido com sucesso';
        PRINT @local + 'inserido com sucesso';
     END 

END
GO

EXEC sp_add_dpt_loc 'COMPRAS', 130, 'SANTA MARIA';

SELECT *
FROM DEPARTAMENTO AS D
JOIN LOCALIZACAO_DEP AS L
ON D.Dnumero = L.Dnumero;

GO

-- Crie um procedure que faz uma listagem dos funcionarios por departamento
-- mas se o departamento não for especificado, o procedimento lista todos os funcionarios
CREATE PROCEDURE 
AS
BEGIN

END;