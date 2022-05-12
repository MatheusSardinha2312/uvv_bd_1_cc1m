use uvv;

-- Questão 1

SELECT avg(fu.salario) AS media_salario, dept.nome_departamento 
FROM funcionario fu
INNER JOIN departamento dept
ON dept.numero_departamento = fu.numero_departamento 
GROUP BY dept.nome_departamento;

-- Questão 2

SELECT avg(fu.salario) AS media_salario, fu.sexo
FROM funcionario fu
GROUP BY fu.sexo;

-- Questão 3

SELECT nome_departamento AS departamento, concat(fu.primeiro_nome, ' ', fu.nome_meio, ' ', fu.ultimo_nome) AS nome_completo,
floor(datediff(curdate(),data_nascimento)/365.25) AS idade, 
salario AS salario
FROM funcionario fu INNER JOIN departamento dept
WHERE fu.numero_departamento = dept.numero_departamento ORDER BY nome_departamento;

-- Questão 4

SELECT concat(fu.primeiro_nome, ' ', fu.nome_meio, ' ', fu.ultimo_nome) AS nome_completo, floor(datediff(curdate(), data_nascimento)/365.25) AS idade, 
salario AS salario, cast((salario*1.2) AS decimal(10,2)) AS salario_reajuste FROM funcionario fu
WHERE salario < '35000'

UNION

SELECT concat(fu.primeiro_nome, ' ', fu.nome_meio, ' ', fu.ultimo_nome) AS nome_completo, floor(datediff(curdate(), data_nascimento)/365.25) AS idade, 
salario AS salario, cast((salario*1.15) AS decimal(10,2)) AS salario_reajuste FROM funcionario fu
WHERE salario >= '35000';

-- Questão 5

SELECT nome_departamento, ge.primeiro_nome, fu.primeiro_nome, salario
FROM departamento dept INNER JOIN funcionario fu, 
(SELECT primeiro_nome, cpf FROM funcionario fu INNER JOIN departamento dept WHERE fu.cpf = dept.cpf_gerente) AS ge
WHERE dept.numero_departamento = fu.numero_departamento and ge.cpf = dept.cpf_gerente ORDER BY dept.nome_departamento asc, fu.salario desc;

-- Questão 6

SELECT concat(fu.primeiro_nome, ' ', fu.nome_meio, ' ', fu.ultimo_nome) AS nome_completo, dept.nome_departamento,
depn.nome_dependente, floor(datediff(curdate(), depn.data_nascimento)/365.25) AS idade_dependente,
case when depn.sexo = 'M' then 'Masculino' when depn.sexo = 'm' then 'masculino'
when depn.sexo = 'F' then 'Feminino' when depn.sexo = 'f' then 'feminino' end AS sexo_dependente
FROM funcionario fu
INNER JOIN departamento dept ON fu.numero_departamento = dept.numero_departamento INNER JOIN dependente depn ON depn.cpf_funcionario = fu.cpf;

-- Questão 7

SELECT DISTINCT concat(fu.primeiro_nome, ' ', fu.nome_meio, ' ', fu.ultimo_nome) AS nome_completo, dept.nome_departamento,
cast((fu.salario) AS decimal(10,2)) AS salario FROM funcionario fu
INNER JOIN departamento dept INNER JOIN dependente depn
WHERE dept.numero_departamento = fu.numero_departamento and
fu.cpf not IN (SELECT depn.cpf_funcionario FROM dependente);

-- Questão 8

SELECT dept.nome_departamento, pro.nome_projeto,
concat(fu.primeiro_nome, ' ', fu.nome_meio, ' ', fu.ultimo_nome) AS nome_completo, tbl.horas
FROM funcionario fu INNER JOIN departamento dept INNER JOIN projeto pro INNER JOIN trabalha_em tbl
WHERE dept.numero_departamento = fu.numero_departamento and
pro.numero_projeto = tbl.numero_projeto and fu.cpf = tbl.cpf_funcionario ORDER BY pro.numero_projeto;

-- Questão 9

SELECT dept.nome_departamento, pro.nome_projeto, sum(tbl.horas) AS total_horas
FROM departamento dept INNER JOIN projeto pro INNER JOIN trabalha_em tbl
WHERE dept.numero_departamento = pro.numero_departamento and pro.numero_projeto = tbl.numero_projeto GROUP BY pro.nome_projeto;

-- Questão 10

SELECT avg(fu.salario) AS media_salario, dept.nome_departamento 
FROM funcionario fu
INNER JOIN departamento dept
ON dept.numero_departamento = fu.numero_departamento 
GROUP BY dept.nome_departamento;

-- Questão 11

SELECT concat(fu.primeiro_nome, ' ', fu.nome_meio, ' ', fu.ultimo_nome) AS nome_completo, pro.nome_projeto,
cast((fu.salario) AS decimal(10,2)) AS recebimento
FROM funcionario fu INNER JOIN projeto pro INNER JOIN trabalha_em tbl
WHERE fu.cpf = tbl.cpf_funcionario and pro.numero_projeto = tbl.numero_projeto GROUP BY fu.primeiro_nome;

-- Questão 12

SELECT dept.nome_departamento, pro.nome_projeto,
concat(fu.primeiro_nome, ' ', fu.nome_meio, ' ', fu.ultimo_nome) AS nome_completo, tbl.horas
FROM funcionario fu INNER JOIN departamento dept INNER JOIN projeto pro INNER JOIN trabalha_em tbl
WHERE fu.cpf = tbl.cpf_funcionario and pro.numero_projeto = tbl.numero_projeto and (tbl.horas = 0) GROUP BY fu.primeiro_nome;

-- Questão 13

SELECT concat(fu.primeiro_nome, ' ', fu.nome_meio, ' ', fu.ultimo_nome) AS nome_completo,
case when sexo = 'M' then 'Masculino' when sexo = 'm' then 'masculino'
when sexo = 'F' then 'Feminino' when sexo = 'f' then 'feminino' end AS sexo,
floor(datediff(curdate(), fu.data_nascimento)/365.25) AS idade
FROM funcionario fu

UNION

SELECT depn.nome_dependente ,
case when sexo = 'M' then 'Masculino' when sexo = 'm' then 'masculino'
when sexo = 'F' then 'Feminino' when sexo = 'f' then 'feminino' end AS sexo,
floor(datediff(curdate(), depn.data_nascimento)/365.25) AS idade
FROM dependente depn ORDER BY idade;

-- Questão 14

SELECT dept.nome_departamento, count(fu.numero_departamento) AS numero_funcionarios
FROM funcionario fu INNER JOIN departamento dept
WHERE fu.numero_departamento = dept.numero_departamento GROUP BY dept.nome_departamento;
