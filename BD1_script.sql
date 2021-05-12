DROP SCHEMA IF EXISTS mydb;
CREATE SCHEMA IF NOT EXISTS mydb;
DROP SCHEMA IF EXISTS pizzaria;
CREATE SCHEMA IF NOT EXISTS pizzaria;
USE mydb;

DROP TABLE IF EXISTS Endereço;

CREATE TABLE IF NOT EXISTS Endereço(
  Tempo TIME NOT NULL,
  Rua VARCHAR(45) NULL,
  Numero VARCHAR(45) NULL,
  Complemento VARCHAR(45) NULL,
  Bairro VARCHAR(45) NULL,
  Cidade VARCHAR(45) NULL,
  PRIMARY KEY (Tempo)
)

DROP TABLE IF EXISTS Clientes;

CREATE TABLE IF NOT EXISTS Clientes (
  Telefone_Cliente INT NOT NULL,
  Nome VARCHAR(45) NULL,
  Cidade VARCHAR(45) NULL,
  Endereço_Tempo INT NOT NULL,
  PRIMARY KEY (Telefone_Cliente),
  CONSTRAINT Clientes_Endereço
  FOREIGN KEY (Tempo) REFERENCES Endereço (Tempo)
)

DROP TABLE IF EXISTS Produtos;

CREATE TABLE IF NOT EXISTS Produtos (
  Codigo_Produto INT NOT NULL,
  Descricao VARCHAR(45) NULL,
  Valor INT NULL,
  PRIMARY KEY (Codigo_Produto)
)
DROP TABLE IF EXISTS Funcionario;

CREATE TABLE IF NOT EXISTS Funcionario (
  id_Funcionario INT NOT NULL,
  nome VARCHAR(30) NULL,
  telefone INT NULL,
  PRIMARY KEY (id_Funcionario)
)

DROP TABLE IF EXISTS Entregador;

CREATE TABLE IF NOT EXISTS Entregador (
  Nome INT NOT NULL,
  id_Funcionario INT NOT NULL,
  Clientes_Telefone INT NOT NULL,
  PRIMARY KEY (Nome, id_Funcionario),
  CONSTRAINT Entregador_Funcionario
    FOREIGN KEY (id_Funcionario) REFERENCES Funcionario (id_Funcionario),
  CONSTRAINT Entregador_Clientes
    FOREIGN KEY (Clientes_Telefone) REFERENCES (Clientes)
)
DROP TABLE IF EXISTS Fornecedor;

CREATE TABLE IF NOT EXISTS Fornecedor (
  id_Fornecedor INT NOT NULL,
  Nome VARCHAR(45) NULL,
  Telefone INT NULL,
  PRIMARY KEY (id_Fornecedor)
)
DROP TABLE IF EXISTS Estoque;

CREATE TABLE IF NOT EXISTS Estoque (
  Quantidade INT NULL,
  Alerta REAL NULL,
  Codigo_Produto INT NOT NULL,
  id_Fornecedor INT NOT NULL,
  CONSTRAINT Estoque_Produtos
    FOREIGN KEY (Codigo_Produto) REFERENCES Produtos (Codigo_Produto),
  CONSTRAINT Estoque_Fornecedor
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor (id_Fornecedor)
)
DROP TABLE IF EXISTS Pizza;

CREATE TABLE IF NOT EXISTS Pizza (
  Numero_Pizza INT NOT NULL,
  Nome VARCHAR(30) NULL,
  Ingredientes VARCHAR(30) NULL,
  PRIMARY KEY (Numero_Pizza)
)

DROP TABLE IF EXISTS Bebidas;

CREATE TABLE IF NOT EXISTS Bebidas (
  Codigo_Produto INT NOT NULL,
  Nome VARCHAR(45) NULL,
  Tamanho VARCHAR(45) NULL,
  PRIMARY KEY (Codigo_Produto),
  CONSTRAINT Bebidas_Produtos
    FOREIGN KEY (Codigo_Produto) REFERENCES Produtos (Codigo_Produto)
)

DROP TABLE IF EXISTS Pedido;

CREATE TABLE IF NOT EXISTS Pedido (
  Num_Pedido INT NOT NULL,
  Endereço VARCHAR(45) NULL,
  Data DATE NULL,
  Abrir_Caixa TINYINT(1) NULL,
  Fechar_Caixa TINYINT(1) NULL,
  Telefone_Cliente INT NOT NULL,
  PRIMARY KEY (Num_Pedido),
  CONSTRAINT Pedido_Clientes
    FOREIGN KEY (Telefone_Cliente) REFERENCES Clientes (Telefone_Cliente)
)
DROP TABLE IF EXISTS Atendente;

CREATE TABLE IF NOT EXISTS Atendente (
  Nome INT NOT NULL,
  id_Funcionario INT NOT NULL,
  Num_Pedido INT NOT NULL,
  PRIMARY KEY (Nome, Funcionario_idFuncionario),
  CONSTRAINT Atendente_Funcionario
    FOREIGN KEY (Funcionario_idFunc) REFERENCES Funcionario (idFuncionario)
  CONSTRAINT Atendente_Pedido
    FOREIGN KEY (Num_Pedido) REFERENCES Pedido (Num_Pedido)
)

DROP TABLE IF EXISTS Cliente_Fidelidade;

CREATE TABLE IF NOT EXISTS Cliente_Fidelidade (
  Qtdpedido INT NOT NULL,
  Telefone_Cliente INT NULL,
  PRIMARY KEY (Telefone_Cliente),
  CONSTRAINT Fidelidade_Clientes
    FOREIGN KEY (Telefone_Cliente) REFERENCES Clientes (Telefone_Cliente)
)

DROP TABLE IF EXISTS Tamanho;

CREATE TABLE IF NOT EXISTS Tamanho (
  Descricao CHAR(3) NOT NULL,
  PRIMARY KEY (Descricao)
)

DROP TABLE IF EXISTS Sobremesas;

CREATE TABLE IF NOT EXISTS Sobremesas (
  Codigo_Produto INT NOT NULL,
  Nome VARCHAR(45) NULL,
  Ingredientes VARCHAR(45) NULL,
  PRIMARY KEY (Codigo_Produto),
  CONSTRAINT Sobremesas_Produtos
    FOREIGN KEY (Codigo_Produto) REFERENCES Produtos (Codigo_Produto)
)

DROP TABLE IF EXISTS Pizza_tem_Tamanho;

CREATE TABLE IF NOT EXISTS Pizza_tem_Tamanho (
  Numero_Pizza INT NOT NULL,
  Descrição INT NOT NULL,
  Preço FLOAT NULL,
  PRIMARY KEY (Numero_Pizza, Descricao),
  CONSTRAINT Pizza_tem_Tamanho
    FOREIGN KEY (Numero_Pizza)
    REFERENCES Pizza (Numero_Pizza),
  CONSTRAINT Pizza_tem_Tamanho
    FOREIGN KEY (Descricao) REFERENCES Tamanho (Descricao)
)

DROP TABLE IF EXISTS Pedido_tem_Pizza_tem_Tamanho;

CREATE TABLE IF NOT EXISTS Pedido_tem_Pizza_tem_Tamanho (
  Num_Pedido INT NOT NULL,
  Numero_Pizza INT NOT NULL,
  Descricao INT NOT NULL,
  PRIMARY KEY (Num_Pedido, Numero_Pizza, Descrição),
  CONSTRAINT Pedido_has_Pizza_tem_Tamanho_Pedido
    FOREIGN KEY (Num_Pedido)
    REFERENCES Pedido (Num_Pedido),
  CONSTRAINT Pedido_has_Pizza_tem_Tamanho_Pizza_tem_Tamanho
    FOREIGN KEY (Numero_Pizza , Descricao) REFERENCES Pizza_tem_Tamanho (Numero_Pizza , Descricao)

/*Essa é a tabela de agregação, ficaria como nome Pedido tem um tamanho de pizza.
