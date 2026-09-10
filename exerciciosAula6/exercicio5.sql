IF OBJECT_ID('dbo.CalcularDesconto', 'P') IS NOT NULL
    DROP PROCEDURE dbo.CalcularDesconto;
GO
 
CREATE PROCEDURE CalcularDesconto
    @PrecoOriginal DECIMAL(10,2),
    @QuantidadeComprada INT
AS
BEGIN
    DECLARE @Desconto DECIMAL(10,2) = 0;
    DECLARE @PrecoFinal DECIMAL(10,2);
    DECLARE @ContadorUnidade INT;
 
    
    IF @QuantidadeComprada > 10
    BEGIN
        SET @Desconto = 0.10;
    END
    ELSE
    BEGIN
        SET @Desconto = 0.00;
    END
 
    IF @QuantidadeComprada < 5
    BEGIN
        SET @ContadorUnidade = 2; 
 
        WHILE @ContadorUnidade <= @QuantidadeComprada
        BEGIN
            SET @Desconto = @Desconto + 0.01;
            SET @ContadorUnidade = @ContadorUnidade + 1;
        END
    END
 

    SET @PrecoFinal = @PrecoOriginal * (1 - @Desconto);
 
    SELECT
        @PrecoOriginal AS PrecoOriginal,
        @QuantidadeComprada AS QuantidadeComprada,
        @Desconto AS PercentualDesconto,
        @PrecoFinal AS PrecoFinal;
END
GO

EXEC CalcularDesconto @PrecoOriginal = 100.00, @QuantidadeComprada = 15;
EXEC CalcularDesconto @PrecoOriginal = 100.00, @QuantidadeComprada = 3;  
EXEC CalcularDesconto @PrecoOriginal = 100.00, @QuantidadeComprada = 7;  
 
