DECLARE @NomeProduto VARCHAR(50);
DECLARE @QuantidadeEstoque INT;
DECLARE @PrecoProduto DECIMAL(10,2);
 
SET @NomeProduto = 'Notebook';
SET @QuantidadeEstoque = 15;
SET @PrecoProduto = 2999.99;
 
PRINT 'Nome do Produto: ' + @NomeProduto;
PRINT 'Quantidade em Estoque: ' + CAST(@QuantidadeEstoque AS VARCHAR(10));
PRINT 'Pre�o do Produto: ' + CAST(@PrecoProduto AS VARCHAR(20));
 

SELECT @NomeProduto AS NomeProduto, @QuantidadeEstoque AS QuantidadeEstoque, @PrecoProduto AS PrecoProduto;
 
 
DECLARE @SalarioBase DECIMAL(10,2);
DECLARE @Bonus DECIMAL(10,2);
DECLARE @SalarioTotal DECIMAL(10,2);
 
SET @SalarioBase = 5000.00;
SET @Bonus = 800.00;
SET @SalarioTotal = @SalarioBase + @Bonus;
 
SELECT @SalarioTotal AS SalarioTotal;
