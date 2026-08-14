--DISTINCT
SELECT DISTINCT F.Salario
FROM FUNCIONARIO AS F;

SELECT DISTINCT F.Sexo
FROM FUNCIONARIO AS F;

--WHERE
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'João';

--AND
SELECT *
FROM FUNCIONARIO AS F
WHERE 
	 F.Sexo = 'M' AND F.Salario >= 30000;

--OR
SELECT *
FROM FUNCIONARIO AS F
WHERE
	 F.Endereco LIKE '%São Paulo%' 
	 OR F.Endereco LIKE '%Curitiba%';

--NOT
SELECT *
FROM FUNCIONARIO AS F
WHERE NOT F.Endereco LIKE '%São Paulo%';

--ORDER BY
SELECT F.Pnome AS 'Nome', 
	   F.Unome AS 'Sobrenome',  
	   F.Salario,
	   F.Salario*12 AS 'CustoAnual'
FROM FUNCIONARIO AS F
ORDER BY F.Salario DESC;

--NULL
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Cpf_supervisor IS NULL;

--NOT NULL
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Cpf_supervisor IS NOT NULL;

-- TOP - MySQL Limit
SELECT TOP 3 *
FROM FUNCIONARIO AS F
ORDER BY F.Salario DESC; --3 maiores salarios

--MIN() / MAX()
SELECT MIN(Salario)
FROM FUNCIONARIO;

SELECT * 
FROM FUNCIONARIO AS F
WHERE F.Salario = (SELECT MIN(Salario) FROM FUNCIONARIO); -- SELECT ALINHADO

--OUTRA FORMA
DECLARE @salario_min DECIMAL(10,2);
SET @salario_min = (SELECT MIN(Salario) FROM FUNCIONARIO);

SELECT * 
FROM FUNCIONARIO AS F
WHERE F.Salario = @salario_min;


--COUNT()
SELECT COUNT(F.Cpf)
FROM FUNCIONARIO AS F

SELECT COUNT(D.Nome_dependente)
FROM DEPENDENTE AS D;

SELECT 
	  (SELECT COUNT(F.Cpf) FROM FUNCIONARIO AS F) +
	  (SELECT COUNT(D.Nome_dependente) FROM DEPENDENTE AS D)
	  AS 'Quantidade de Pessoas'

--AVG()
SELECT AVG(F.Salario)
FROM FUNCIONARIO AS F --Media salarial

SELECT *
FROM FUNCIONARIO AS F
WHERE F.Salario < (SELECT AVG(F.Salario) FROM FUNCIONARIO AS F)
ORDER BY F.Salario ASC;--Pessoas que recebem menos que a media salarial

--SUM()
--Custo mensal com folha de pagamento
SELECT SUM(F.Salario)*12 --*12 é o custo ANUAL
FROM FUNCIONARIO AS F; --Somatorio da folha de pagamento

--LIKE
--Funcionarios que nasceram no ano de 72
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Datanasc LIKE '__72%';
