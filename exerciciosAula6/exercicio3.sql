DECLARE @Idade INT = 20;
 
IF @Idade >= 18
    PRINT 'Maior de Idade';
ELSE
    PRINT 'Menor de Idade';
 
 
DECLARE @NotaFinal INT = 82;
 
IF @NotaFinal >= 90
    PRINT 'Aprovado com Excel�ncia';
ELSE IF @NotaFinal >= 70 
    PRINT 'Aprovado';
ELSE IF @NotaFinal >= 50
    PRINT 'Em Recupera��o';
ELSE
    PRINT 'Reprovado';
 

DECLARE @Ano INT = 2024;
 
IF (@Ano % 4 = 0 AND @Ano % 100 <> 0) OR (@Ano % 400 = 0)
    PRINT 'Ano Bissexto';
ELSE
    PRINT 'Ano Comum';
