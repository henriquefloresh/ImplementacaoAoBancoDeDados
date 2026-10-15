USE CAIXA;
GO

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

Item  	                    Registro
Saldo antes	                30.000,00
Saldo dentro da transação  	32.000,00
Linhas afetadas	            1
Critério de decisão	        @@ROWCOUNT = 1 (apenas a conta do Paulo foi alterada)
Decisão	                    COMMIT
Estado final	              id 30, Paulo, Saldo = 32.000,00
