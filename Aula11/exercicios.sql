USE CAIXA;
GO

--1
SELECT * FROM CONTA;

BEGIN TRAN;

INSERT INTO CONTA VALUES (70, 'Ana', 100);

SAVE TRAN sp_ana_ok;

INSERT INTO CONTA VALUES (80, 'Bruno', 200);

SELECT * FROM CONTA WHERE id IN (70, 80);

ROLLBACK TRAN sp_ana_ok;

SELECT * FROM CONTA WHERE id IN (70, 80);

COMMIT TRAN;

-- Evidência após o COMMIT
SELECT * FROM CONTA WHERE id IN (70, 80);
SELECT @@TRANCOUNT AS transacoes_abertas;  

--2
SELECT * FROM CONTA WHERE id = 30;

BEGIN TRAN;

UPDATE CONTA
   SET Saldo = Saldo + 2000
 WHERE id = 30;

DECLARE @linhas INT = @@ROWCOUNT;

SELECT @linhas AS linhas_afetadas;
SELECT * FROM CONTA WHERE id = 30;   

IF @linhas = 1
BEGIN
    COMMIT TRAN;
    PRINT 'Decisão: COMMIT - 1 linha afetada, alteração confirmada.';
END
ELSE
BEGIN
    ROLLBACK TRAN;
    PRINT 'Decisão: ROLLBACK - número de linhas afetadas diferente de 1.';
END

SELECT * FROM CONTA WHERE id = 30;
