CREATE TABLE Fato_Vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    id_tempo INT,
    quantidade INT,
    valor_total DECIMAL(10,2)
);

CREATE TABLE Dim_Cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(200),
    cidade VARCHAR(100),
    estado VARCHAR(100)
);

CREATE TABLE Dim_Produto (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(100),
    preco DECIMAL(10,2)
);

CREATE TABLE Dim_Tempo (
    id_tempo SERIAL PRIMARY KEY,
    dia INT,
    mes INT,
    ano INT,
    trimestre INT,
    ano_mes VARCHAR(7)
);


INSERT INTO Dim_Cliente (nome, endereco, cidade, estado)
SELECT nome_cliente, endereco_cliente, cidade_cliente, estado_cliente
FROM Staging_Clientes;

INSERT INTO Dim_Produto (nome_produto, categoria, preco)
SELECT nome_produto, categoria_produto, preco_produto
FROM Staging_Produtos;

INSERT INTO Dim_Tempo (dia, mes, ano, trimestre, ano_mes)
SELECT dia, mes, ano, trimestre, ano_mes
FROM Staging_Tempo;

INSERT INTO Fato_Vendas (id_cliente, id_produto, id_tempo, quantidade, valor_total)
SELECT 
    (SELECT id_cliente FROM Dim_Cliente WHERE nome = nome_cliente),
    (SELECT id_produto FROM Dim_Produto WHERE nome_produto = nome_produto),
    (SELECT id_tempo FROM Dim_Tempo WHERE ano_mes = ano_mes),
    quantidade, valor_total
FROM Staging_Vendas;

CREATE INDEX idx_cliente ON Fato_Vendas(id_cliente);
CREATE INDEX idx_produto ON Fato_Vendas(id_produto);
CREATE INDEX idx_tempo ON Fato_Vendas(id_tempo);
