CREATE USER 'matheus'@'localhost' IDENTIFIED BY '12345';

GRANT ALL PRIVILEGES on * . * to 'matheus'@'localhost';

FLUSH PRIVILEGES;

/* Criação do banco de dados uvv */
CREATE DATABASE uvv;

/* Seleção do banco de dados */
USE uvv;

/* Criação da tabela funcionario */
CREATE TABLE funcionario (
 cpf CHAR(11) NOT NULL,
 primeiro_nome VARCHAR(15) NOT NULL,
 nome_meio CHAR(1),
 ultimo_nome VARCHAR(15) NOT NULL,
 data_nascimento DATE,
 endereco VARCHAR(30),
 sexo CHAR(1),
 salario DECIMAL(10,2),
 cpf_supervisor CHAR(11) NOT NULL,
 numero_departamento INT NOT NULL,
 PRIMARY KEY (cpf)
);

ALTER TABLE funcionario COMMENT 'Tabela com informações gerais de cada funcionario';

ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'Coluna com o cpf do funcionário';

ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Coluna com o primeiro nome do funcionário';

ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Coluna com o nome do meio do funcionário';

ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Coluna com o último nome do funcionario ';

ALTER TABLE funcionario MODIFY COLUMN data_nascimento DATE COMMENT 'Coluna com a data de nascimento do funcionário ';

ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(30) COMMENT 'Coluna com o endereço do funcionário';

ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Coluna com o sexo do funcionário';

ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Coluna com o salário do funcionário';

ALTER TABLE funcionario MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'Coluna com o cpf do supervisor ';

ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'Coluna com o número do departamento';

/* Criação da tabela dependente */
CREATE TABLE dependente (
 cpf_funcionario CHAR(11) NOT NULL,
 nome_dependente VARCHAR(15) NOT NULL,
 sexo CHAR(1),
 data_nascimento DATE,
 parentesco VARCHAR(15),
 PRIMARY KEY (cpf_funcionario, nome_dependente)
);

ALTER TABLE dependente COMMENT 'Tabela com os dados do dependente';

ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'Coluna com o cpf do funcionário ';

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Coluna com o nome do dependente';

ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Coluna com o sexo do dependente';

ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Coluna com a data de nascimento do dependente';

ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Coluna com o parentesco do dependente';

/* Criação da tabela departamento */
CREATE TABLE departamento (
 numero_departamento INT NOT NULL,
 nome_departamento VARCHAR(15) NOT NULL,
 cpf_gerente CHAR(11) NOT NULL,
 data_inicio_gerente DATE,
 PRIMARY KEY (numero_departamento)
);

ALTER TABLE departamento COMMENT 'Tabela com os dados do departamento ';

ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Coluna com o número do departamento ';

ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Coluna com o nome do departamento ';

ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'Coluna com o cpf do gerente';

ALTER TABLE departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'Coluna com a data de ínicio do gerente';

/* Criação do unique index no nome_departamento */ 
CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento ASC );

/* Criação da tabela projeto */
CREATE TABLE projeto (
 numero_projeto INT NOT NULL,
 nome_projeto VARCHAR(15) NOT NULL,
 local_projeto VARCHAR(15),
 numero_departamento INT NOT NULL,
 PRIMARY KEY (numero_projeto)
);

ALTER TABLE projeto COMMENT 'Tabela com os dados do projeto ';

ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Coluna com o número do projeto  ';

ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(15) COMMENT 'Coluna com o nome do projeto ';

ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Coluna com o local do projeto';

ALTER TABLE projeto MODIFY COLUMN numero_departamento INTEGER COMMENT 'Coluna com o número do departamento';

/* Criação do unique index no nome_projeto */
CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto ASC );

/* Criação da tabela trabalha_em */
CREATE TABLE trabalha_em (
 cpf_funcionario CHAR(11) NOT NULL,
 numero_projeto INT NOT NULL,
 horas DECIMAL(3,1) NOT NULL,
 PRIMARY KEY (cpf_funcionario, numero_projeto)
);

ALTER TABLE trabalha_em COMMENT 'Tabela com os dados de trabalha em';

ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'Coluna com o cpf do funcionário ';

ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'Coluna com o número do projeto';

ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Coluna com o número de horas';

/* Criação da tabela localizacoes_departamento */
CREATE TABLE localizacoes_departamento (
 numero_departamento INT NOT NULL,
 local VARCHAR(15) NOT NULL,
 PRIMARY KEY (numero_departamento, local)
);

ALTER TABLE localizacoes_departamento COMMENT 'Tabela com as localizações do departamento ';

ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Coluna com o número do departamento';

ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Coluna com o local do departamento  ';

/* A foreign key cpf_supervisor está referenciando a primary key cpf dentro da tabela funcionario */
ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* A foreign key cpf_gerente da tabela departamento está referenciando a primary key cpf da tabela funcionario */
ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* A foreign key cpf_funcionario da tabela trabalha_em está referenciando a primary key cpf da tabela funcionario */
ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* A foreign key cpf_funcionario da tabela dependente está referenciando a primary key cpf da tabela funcionario */
ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* A foreign key numero_departamento da tabela localizacoes_departamento está referenciando a primary key numero_departamento da tabela departamento */
ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* A foreign key numero_departamento da tabela projeto está referenciando a primary key numero_departamento da tabela departamento */
ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* A foreign key numero_projeto da tabela trabalha_em está referenciando a primary key numero_projeto da tabela projeto */
ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Implementação da restrição check no atributo sexo restringindo as letras que podem ser colocadas, no caso só F e M */ 
ALTER TABLE funcionario 
ADD CONSTRAINT ck_sexo
CHECK (sexo in ('F', 'M'));

/* Implementação da restrição check no atributo sexo restringindo as letras que podem ser colocadas, no caso só F e M na tabela dependente */ 
ALTER TABLE dependente
ADD CONSTRAINT ck_sexod
CHECK (sexo in ('F', 'M'));

/* Implementação da restrição check no atributo salario restringindo o valor mínimo a ser utilizado que no caso só pode ser maior ou igual a 0 na tabela funcionario */
ALTER TABLE funcionario 
ADD CONSTRAINT ck_salario
CHECK (salario >= 0);

/* Implementação da restrição check no atributo horas restringindo o valor mínimo a ser utilizado que no caso só pode ser maior ou igual a 0 na tabela trabalha_em */
ALTER TABLE trabalha_em  
ADD CONSTRAINT ck_horas
CHECK (horas >= 0);

/* Modificação do varchar(30) para o varchar(35) do atributo endereco da tabela funcionario */ 
ALTER TABLE funcionario
MODIFY endereco varchar(35);

/* Modificação do char(11) not null para o char(11) null do atributo cpf_supervisor da tabela funcionario */
ALTER TABLE funcionario
MODIFY cpf_supervisor char(11) null;

/* Adição de valores dentro da tabela funcionario */
INSERT INTO funcionario (
primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento
)
values 
('Jorge', 'E', 'Brito','88866555576', '1937-11-10', 'Rua do Horto,35,São Paulo,SP', 'M', '55.000', NULL, '1'),
('Fernando', 'T', 'Wong', '33344555587', '1955-08-12', 'Rua da Lapa,34,São Paulo,SP', 'M', '40.000', '88866555576', '5'),
('João', 'B', 'Silva', '12345678966', '1968-12-08', 'Rua das Flores,751,São Paulo', 'M', '30.000', '33344555587', '5'),
('Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av.Arthur de Lima,54,Santo André,SP', 'F', '43.000', '88866555576', '4'),
('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima,35,Curitiba,PR', 'F', '25.000', '98765432168', '4'),
('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças,65,Piracicaba,SP', 'M', '38.000', '33344555587', '5'),
('Joice','A','Leite','45345345376','1972-07-31', 'Av.Lucas Obes,74,São Paulo, SP', 'F', '25.000','33344555587', '5'),
('André', 'V', 'Pereira', '98798798733', '1969-03-29', 'Rua Timbiera, 35, São Paulo,SP', 'M', '25.000', '98765432168', '4');

/* Adição de valores dentro da tabela departamento */
INSERT INTO departamento (
nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente
)
VALUES
('Pesquisa', '5', '33344555587', '1988-05-22'),
('Administração', '4', '98765432168', '1995-01-01'),
('Matriz', '1', '88866555576', '1981-06-19');

/* Adição de valores dentro da tabela localizacoes_departamento */
INSERT INTO localizacoes_departamento (
numero_departamento, local
)
VALUES 
('1', 'São Paulo'),
('4', 'Mauá'),
('5', 'Santo André'),
('5', 'Itu'),
('5', 'São Paulo');

/* Adição de valores dentro da tabela projeto */
INSERT INTO projeto (
nome_projeto, numero_projeto, local_projeto, numero_departamento
)
VALUES 
('ProdutoX', '1', 'Santo André', '5'),
('ProdutoY', '2', 'Itu', '5'),
('ProdutoZ', '3', 'São Paulo', '5'),
('Informatização', '10', 'Mauá', '4'),
('Reorganização', '20', 'São Paulo', '1'),
('Novosbenefícios', '30', 'Mauá', '4');

/* Adição de valores dentro da tabela dependente */
INSERT INTO dependente (
cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco
)
VALUES 
('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
('33344555587', 'Thiago', 'M', '1983-10-25', 'Filho'),
('33344555587', 'Janaína', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

/* Modificação do decimal(3,1) not null para o decimal(3,1) null do atributo horas da tabela trabalha_em */
ALTER TABLE trabalha_em 
MODIFY horas DECIMAL(3,1) NULL;

/* Adição de valores dentro da tabela trabalha_em */
INSERT INTO trabalha_em ( 
cpf_funcionario, numero_projeto, horas
)
VALUES 
('12345678966', 1, '32.5'),
('12345678966', 2, '7.5'),
('66688444476', 3, '40.0'),
('45345345376', 1, '20.0'),
('45345345376', 2, '20.0'),
('33344555587', 2, '10.0'),
('33344555587', 3, '10.0'),
('33344555587', 10, '10.0'),
('33344555587', 20, '10.0'),
('99988777767', 30, '30.0'),
('99988777767', 10, '10.0'),
('98798798733', 10, '35.0'),
('98798798733', 30, '5.0'),
('98765432168', 30, '20.0'),
('98765432168', 20, '15.0'),
('88866555576', 20, NULL);
