DECLARE @Contador INT = 1;
 
WHILE @Contador <= 10
BEGIN
    PRINT CAST(@Contador AS VARCHAR(10));
    SET @Contador = @Contador + 1;
END
 

DECLARE @Valor INT = 100;
 
WHILE @Valor >= 50
BEGIN
    PRINT 'Valor atual: ' + CAST(@Valor AS VARCHAR(10));
    SET @Valor = @Valor - 5;
END
 

IF OBJECT_ID('dbo.Produtos', 'U') IS NULL
BEGIN
    CREATE TABLE Produtos (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Nome VARCHAR(100),
        Preco DECIMAL(10,2)
    );
 
    INSERT INTO Produtos (Nome, Preco) VALUES
    ('Mouse', 45.90),
    ('Teclado', 120.00),
    ('Monitor', 899.99),
    ('Cabo USB', 25.00),
    ('Notebook', 2999.99);
END
 
DECLARE @Indice INT = 1;
DECLARE @TotalProdutos INT;
DECLARE @PrecoLimite DECIMAL(10,2) = 100;
DECLARE @NomeAtual VARCHAR(100);
DECLARE @PrecoAtual DECIMAL(10,2);
 
SELECT @TotalProdutos = COUNT(*) FROM Produtos;
 
WHILE @Indice <= @TotalProdutos
BEGIN
    SELECT @NomeAtual = Nome, @PrecoAtual = Preco
    FROM (
        SELECT Nome, Preco, ROW_NUMBER() OVER (ORDER BY Id) AS RowNum
        FROM Produtos
    ) AS ProdutosNumerados
    WHERE RowNum = @Indice;
 
    IF @PrecoAtual > @PrecoLimite
        PRINT @NomeAtual + ' - R$ ' + CAST(@PrecoAtual AS VARCHAR(20));
 
    SET @Indice = @Indice + 1;
END
 
 
DECLARE @Numero INT = 2;
 
WHILE @Numero <= 1000
BEGIN
    PRINT CAST(@Numero AS VARCHAR(10));
    SET @Numero = @Numero * 2;
END
PRINT 'Valor final (ja ultrapassou 1000): ' + CAST(@Numero AS VARCHAR(10));
