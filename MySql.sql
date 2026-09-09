-- 1. CRIANDO O BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS db_atividade;
USE db_atividade;

-- 2. CRIANDO AS TABELAS
CREATE TABLE cidades (
    id_cidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL
);

CREATE TABLE departamentos (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    id_cidade INT,
    FOREIGN KEY (id_cidade) REFERENCES cidades(id_cidade)
);

CREATE TABLE fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fantasia VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    id_cidade INT,
    FOREIGN KEY (id_cidade) REFERENCES cidades(id_cidade)
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    cargo VARCHAR(100),
    salario DECIMAL(10, 2),
    id_departamento INT,
    id_cidade INT,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento),
    FOREIGN KEY (id_cidade) REFERENCES cidades(id_cidade)
);

-- ========================================================
-- OPERAÇÕES DML (POPULAR, UPDATE, DELETE, SELECT)
-- ========================================================

-- TABELA: cidades
INSERT INTO cidades (nome, estado) VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Belo Horizonte', 'MG'),
('Curitiba', 'PR'),
('Porto Alegre', 'RS');

UPDATE cidades SET nome = 'São Paulo Capital' WHERE id_cidade = 1;
UPDATE cidades SET estado = 'RJ' WHERE id_cidade = 2;
DELETE FROM cidades WHERE id_cidade = 5;
SELECT * FROM cidades;

-- TABELA: departamentos
INSERT INTO departamentos (nome) VALUES
('Tecnologia da Informação'),
('Recursos Humanos'),
('Financeiro'),
('Marketing'),
('Vendas');

UPDATE departamentos SET nome = 'T.I. e Inovação' WHERE id_departamento = 1;
UPDATE departamentos SET nome = 'Gestão de Pessoas' WHERE id_departamento = 2;
DELETE FROM departamentos WHERE id_departamento = 5;
SELECT * FROM departamentos;

-- TABELA: clientes
INSERT INTO clientes (nome, email, telefone, id_cidade) VALUES
('Carlos Silva', 'carlos@email.com', '11999990001', 1),
('Ana Souza', 'ana@email.com', '21999990002', 2),
('Lucas Lima', 'lucas@email.com', '31999990003', 3),
('Mariana Costa', 'mariana@email.com', '41999990004', 4),
('Fernando Alves', 'fernando@email.com', '11999990005', 1);

UPDATE clientes SET telefone = '11988880001' WHERE id_cliente = 1;
UPDATE clientes SET email = 'ana.souza@novoemail.com' WHERE id_cliente = 2;
DELETE FROM clientes WHERE id_cliente = 5;
SELECT * FROM clientes;

-- TABELA: fornecedores
INSERT INTO fornecedores (nome_fantasia, cnpj, telefone, id_cidade) VALUES
('Tech Distribuidora', '11.111.111/0001-11', '1133330001', 1),
('Papelaria Central', '22.222.222/0001-22', '2133330002', 2),
('Atacado de Bebidas', '33.333.333/0001-33', '3133330003', 3),
('Logística Express', '44.444.444/0001-44', '4133330004', 4),
('Serviços Gerais', '55.555.555/0001-55', '1133330005', 1);

UPDATE fornecedores SET nome_fantasia = 'Tech Brasil' WHERE id_fornecedor = 1;
UPDATE fornecedores SET telefone = '2134445555' WHERE id_fornecedor = 2;
DELETE FROM fornecedores WHERE id_fornecedor = 5;
SELECT * FROM fornecedores;

-- TABELA: funcionarios
INSERT INTO funcionarios (nome, cpf, cargo, salario, id_departamento, id_cidade) VALUES
('Roberto Oliveira', '111.111.111-11', 'Desenvolvedor', 5000.00, 1, 1),
('Juliana Paes', '222.222.222-22', 'Analista de RH', 3500.00, 2, 2),
('Patricia Ramos', '333.333.333-33', 'Contadora', 4800.00, 3, 3),
('Gabriel Santos', '444.444.444-44', 'Designer', 3200.00, 4, 4),
('Beatriz Rocha', '555.555.555-55', 'Estagiária', 1500.00, 1, 1);

UPDATE funcionarios SET salario = 5500.00 WHERE id_funcionario = 1;
UPDATE funcionarios SET cargo = 'Analista Senior' WHERE id_funcionario = 2;
DELETE FROM funcionarios WHERE id_funcionario = 5;
SELECT * FROM funcionarios;