CREATE DATABASE CAIXA;

USE CAIXA;

CREATE TABLE CONTA(
  id INT PRIMARY KEY,
  Nome VARCHAR(50),
  Saldo MONEY
);

INSERT INTO CONTA
VALUES (10, 'Maria', 500),
       (20, 'João', 1500),
       (30, 'Paulo', 30000),
       (40, 'Maria', 50000);
GO

--Primeira transação
BEGIN TRAN; 
DECLARE @erro INT = 0;
INSERT INTO CONTA
VALUES (50, 'Pedro', 50);
SET @erro = @erro+ @@ERROR
INSERT INTO CONTA
VALUES (10, 'Judas', 666);
SET @erro = @erro+ @@ERROR
SELECT * FROM CONTA;
IF @erro <> 0
BEGIN 
   PRINT 'Transação revertida'
   ROLLBACK TRAN;
END
ELSE
BEGIN
    PRINT 'Transação realizada com sucesso!'
    COMMIT TRAN;
END
SELECT * FROM CONTA;



BEGIN TRAN;
UPDATE conta
SET Saldo = saldo+10000
WHERE Nome = 'Maria';
IF @@ROWCOUNT <> 1
BEGIN
    SELECT * FROM conta;
    ROLLBACK TRAN
END
ELSE 
    COMMIT TRAN;

go
-- Transferir de uma conta para outra

CREATE PROCEDURE usp_transferencia
    @id_origem INT,
    @id_destino INT,
    @valor MONEY
AS
BEGIN
   BEGIN TRAN;
   --Tirando dinheiro da conta de origem
   UPDATE CONTA 
   SET Saldo = Saldo - @valor
   WHERE id = @id_origem;
   -- Depositar na conta destino
   UPDATE CONTA 
   SET Saldo = Saldo + @valor
   WHERE id = @id_destino;
   -- Ver possível estado da tabela conta
   SELECT * FROM CONTA;
   -- Condição para rollback
   if (SELECT Saldo FROM conta WHERE id =@id_origem)<0
   BEGIN
       ROLLBACK TRAN
       PRINT 'Saldo insuficiente'
   END
   -- Condição para commit
   ELSE
   BEGIN
       COMMIT TRAN
       PRINT 'Transferência realizada!'
   END          
END
GO
SELECT * FROM CONTA;

EXEC usp_transferencia 40,10,500;

--Save point
begin tran;
insert into conta
values (50, 'Pedro', 50)

-- save point
save tran pedroOK
insert into conta
values (10, 'Juca', -200);
if @@ERROR <> 0 
begin
    rollback tran pedroOK;
    commit tran;
    print 'Voltamos para save point';
end
else
    commit tran;

select * from CONTA;

-- try catch
begin try
    print 'ola try catch'
    select 1/0; --erro
    print 'nao cheguei aqui'
end try
begin catch
    print 'deu erro'
    print 'numero: ' + cast(error_number() as varchar (10));
    print 'mensagem de erro: ' + error_message();
end catch

-- transaction + try catch
begin tran
    begin try
        insert into conta
        values (60, 'Matheus', 15)
        select * from conta;
        insert into conta
        values (10, 'Juca', -200);
        commit tran;
        select * from conta;
    end try
    begin catch
        rollback tran;
        print 'erro'
        print 'numero: ' + cast(error_number() as varchar (10));
        print 'mensagem de erro: ' + error_message();
    end catch
select * from conta;
go

-- crie um proc q insira um novo usuario no banco(nao permita duplicidade de nomes).
CREATE PROCEDURE usp_inserirusuario
    @id INT,
    @nome VARCHAR(50),
    @valor MONEY
AS
BEGIN
    -- O BEGIN TRY DEVE FICAR AQUI
    BEGIN TRY
        BEGIN TRAN;
        
        INSERT INTO conta VALUES (@id, @nome, @valor);
        
        -- CORREÇÃO: Mudado de 'Maria' para @nome para checar o nome que você está inserindo
        IF (SELECT COUNT(*) FROM conta WHERE nome = @nome) > 1
        BEGIN
            ROLLBACK TRAN;
            PRINT 'Já existe alguém com o nome: ' + @nome;
        END
        ELSE 
        BEGIN
            COMMIT TRAN;
            PRINT 'Cadastro realizado!';
        END
        
        -- É melhor listar o resultado após o COMMIT/ROLLBACK
        SELECT * FROM conta;
        
    END TRY -- FECHAMENTO DO TRY
    BEGIN CATCH
        -- Verifica se há uma transação ativa antes de dar ROLLBACK para não gerar outro erro
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN;
            
        PRINT 'Erro!';
        PRINT 'Número: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
        PRINT 'Mensagem de erro: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- Agora o teste vai funcionar (se o ID 10 não estiver ocupado)
EXEC usp_inserirusuario 60, 'tiago', 600;
select * from conta;



