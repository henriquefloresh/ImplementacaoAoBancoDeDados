create or alter trigger trg_after_insert_dpt
on DEPARTAMENTO
after insert
as
begin
	declare @nome varchar(40)
	select @nome = I.Dnome
	from inserted as I;

	print 'novo departamento: ' + @nome

end;
go

insert into DEPARTAMENTO(Dnumero,Dnome)
values(88, 'Expedição');

select * from DEPARTAMENTO
go

create trigger trg_insteadof_delete_dpt
on DEPARTAMENTO
instead of delete
as 
begin
	print 'nao deletei o registro'
end
delete 
from DEPARTAMENTO
where Dnumero = 88

select * from DEPARTAMENTO

alter table DEPARTAMENTO
disable trigger trg_insteadof_delete_dpt

exec sp_helptrigger DEPARTAMENTO;
go
-- trigger para nao permitir nomes duplicados em departamento
create or alter trigger trg_insteadof_insert_dpt
on DEPARTAMENTO
instead of insert
as
begin
	declare @nome varchar(40), @numero INT
	-- atribuir a variavel @nome o valor que esta no insert
	select @nome = I.Dnome, @numero = Dnumero from inserted as I
	if exists (select 1 from DEPARTAMENTO where Dnome = @nome)
		raiserror('Já existe um departamento com esse nome', 16, 1)
	else
		insert into DEPARTAMENTO(Dnumero,Dnome,Cpf_gerente,Data_inicio_gerente)
		select i.Dnumero, i.Dnome, i.Cpf_gerente, i.Data_inicio_gerente
		from inserted as i
end
go
select * from DEPARTAMENTO
insert into DEPARTAMENTO(Dnumero,Dnome)
values(100, 'Vendas');
go

-- Função UPDATE()
-- Verificar se um nome foi alterado.
CREATE TRIGGER trg_for_update_nome
on DEPARTAMENTO
FOR UPDATE -- for = after
as
begin
	declare @nome_antigo varchar(40),
			@nome_novo varchar(40);
	select @nome_antigo = d.Dnome from deleted as d
	select @nome_novo = i.Dnome  from inserted as i
	if UPDATE(Dnome)
	begin
		print 'o nome era: ' + @nome_antigo
		print 'o novo nome é: ' + @nome_novo
	end
	else
	print 'O nome não foi alterado'
end

update DEPARTAMENTO
set Dnome = 'Tecnologia'
where Dnome = 'TI'

update DEPARTAMENTO
set Dnumero = 9
where Dnome = 'Estoque'

select * from DEPARTAMENTO
go

create table log_funcionario(
	log_id INT identity(100,1) primary key,
	cpf char(11),
	operacao varchar(10),
	data_hora datetime default getdate()
)
go
-- trigger de log de insert
create trigger trg_for_insert_funcionario
on FUNCIONARIO
for INSERT
as
begin
	insert into log_funcionario (cpf, operacao)
	select i.Cpf, 'INSERT'
	from inserted as i
end
go
-- trigger de log de update
create trigger trg_for_update_funcionario
on FUNCIONARIO
for update
as
begin
	insert into log_funcionario (cpf, operacao)
	select i.Cpf, 'UPDATE'
	from inserted as i
end
go

-- trigger de log de delete
create trigger trg_for_delete_funcionario
on FUNCIONARIO
for DELETE
as
begin
	insert into log_funcionario (cpf, operacao)
	select d.Cpf, 'DELETE'
	from deleted as d
end

insert into FUNCIONARIO(Pnome, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Bonus, Data_Admissao, Dnr)
values('Henrique', 'Hiemer', '03732645002', '2006-03-12', 'Rua 10', 'M', 2000, 0,'2026-10-23', 10)

select * from FUNCIONARIO order by Pnome
select * from log_funcionario

update FUNCIONARIO
set Salario = 700
where Cpf = '03732645002'

delete from FUNCIONARIO
where Cpf = '03732645002'
go

-- trigger de log de insert,delete,update
create trigger trg_for_idu_funcionario
on FUNCIONARIO
for INSERT,DELETE,UPDATE
as
begin
	IF EXISTS (SELECT * FROM inserted)
	BEGIN
		IF EXISTS (SELECT * FROM deleted)
			insert into log_funcionario (cpf, operacao)
			select i.Cpf, 'UPDATE'
			from inserted as i
		ELSE
			insert into log_funcionario (cpf, operacao)
			select i.Cpf, 'INSERT'
			from inserted as i
	END
	ELSE
		insert into log_funcionario (cpf, operacao)
		select d.Cpf, 'DELETE'
		from deleted as d
end
go

-- view
create view vw_rh_funcionario_dpt
as
select concat(Pnome, ' ', Minicial, '. ', Unome) as 'NOME',
		DATEDIFF(YEAR, Datanasc, GETDATE()) as 'IDADE',
		Endereco as 'Endereço',
		Data_Admissao as 'Admissão',
		d.Dnome as 'Departamento'
from FUNCIONARIO as f
join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
go
select * from vw_rh_funcionario_dpt
where Departamento = 'Matriz'
