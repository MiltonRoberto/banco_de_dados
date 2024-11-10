-- Criação da tabela Dimensão Veículo
CREATE TABLE Dimensao_Veiculo (
    Veiculo_ID INT PRIMARY KEY,
    Codigo CHAR(30),
    Nome CHAR(30),
    Modelo CHAR(10),
    Ano_Fabricacao INT,
    Fabricante CHAR(30)
);

-- Criação da tabela Dimensão Loja
CREATE TABLE Dimensao_Loja (
    Loja_ID INT PRIMARY KEY,
    CGC_Loja CHAR(12),
    Endereco CHAR(100),
    Cidade CHAR(30),
    Estado CHAR(2),
    Pais CHAR(20)
);

-- Criação da tabela Dimensão Cliente
CREATE TABLE Dimensao_Cliente (
    Cliente_ID INT PRIMARY KEY,
    CPF CHAR(12),
    Nome CHAR(30),
    Endereco CHAR(100),
    Cidade CHAR(30),
    Estado CHAR(2),
    Pais CHAR(20),
    Renda DECIMAL(15, 2)
);

-- Criação da tabela Fato_Venda
CREATE TABLE Fato_Venda (
    Fato_Venda_ID INT PRIMARY KEY,
    Data_ID DATE,  -- Pode ser uma referência a uma tabela de tempo, caso exista
    Loja_ID INT,
    Veiculo_ID INT,
    Cliente_ID INT,
    Valor_Venda DECIMAL(15, 2),
    Quantidade_Vendida INT,
    Valor_Imposto DECIMAL(15, 2),
    FOREIGN KEY (Loja_ID) REFERENCES Dimensao_Loja(Loja_ID),
    FOREIGN KEY (Veiculo_ID) REFERENCES Dimensao_Veiculo(Veiculo_ID),
    FOREIGN KEY (Cliente_ID) REFERENCES Dimensao_Cliente(Cliente_ID)
);
--1.
SELECT 
    Loja_ID,
    SUM(Valor_Venda) AS Total_Vendas
FROM 
    Fato_Venda
WHERE 
    Loja_ID = <ID_DA_LOJA> -- Substitua <ID_DA_LOJA> pelo ID da loja desejada
    AND Data_ID BETWEEN '<DATA_INICIAL>' AND '<DATA_FINAL>' -- Substitua <DATA_INICIAL> e <DATA_FINAL> pelo período desejado
GROUP BY 
    Loja_ID;

--2.
SELECT 
    Loja_ID,
    SUM(Valor_Venda) AS Total_Vendas
FROM 
    Fato_Venda
WHERE 
    Data_ID BETWEEN '<DATA_INICIAL>' AND '<DATA_FINAL>' -- Substitua <DATA_INICIAL> e <DATA_FINAL> pelo período desejado
GROUP BY 
    Loja_ID
ORDER BY 
    Total_Vendas DESC
LIMIT <N>; -- Substitua <N> pelo número de lojas que deseja listar

--3.
SELECT 
    Loja_ID,
    SUM(Valor_Venda) AS Total_Vendas
FROM 
    Fato_Venda
WHERE 
    Data_ID BETWEEN '<DATA_INICIAL>' AND '<DATA_FINAL>'
GROUP BY 
    Loja_ID
ORDER BY 
    Total_Vendas ASC
LIMIT <N>;

--4.
SELECT 
    Cliente_ID,
    COUNT(Fato_Venda_ID) AS Frequencia_Compra,
    AVG(Dimensao_Cliente.Renda) AS Renda_Media,
    Dimensao_Cliente.Cidade,
    Dimensao_Cliente.Estado
FROM 
    Fato_Venda
JOIN 
    Dimensao_Cliente ON Fato_Venda.Cliente_ID = Dimensao_Cliente.Cliente_ID
WHERE 
    Data_ID BETWEEN '<DATA_INICIAL>' AND '<DATA_FINAL>'
GROUP BY 
    Cliente_ID, Dimensao_Cliente.Cidade, Dimensao_Cliente.Estado
HAVING 
    Frequencia_Compra >= <FREQUENCIA_MINIMA> -- Substitua <FREQUENCIA_MINIMA> pelo mínimo desejado
ORDER BY 
    Frequencia_Compra DESC;

--5.
SELECT 
    Veiculo_ID,
    Dimensao_Veiculo.Modelo,
    Dimensao_Loja.Cidade,
    Dimensao_Loja.Estado,
    SUM(Fato_Venda.Quantidade_Vendida) AS Total_Vendas
FROM 
    Fato_Venda
JOIN 
    Dimensao_Veiculo ON Fato_Venda.Veiculo_ID = Dimensao_Veiculo.Veiculo_ID
JOIN 
    Dimensao_Loja ON Fato_Venda.Loja_ID = Dimensao_Loja.Loja_ID
WHERE 
    Dimensao_Loja.Cidade = '<CIDADE>' -- Substitua <CIDADE> pela cidade desejada
    AND Dimensao_Loja.Estado = '<ESTADO>' -- Substitua <ESTADO> pelo estado desejado
    AND Data_ID BETWEEN '<DATA_INICIAL>' AND '<DATA_FINAL>'
GROUP BY 
    Veiculo_ID, Dimensao_Veiculo.Modelo, Dimensao_Loja.Cidade, Dimensao_Loja.Estado
ORDER BY 
    Total_Vendas DESC;
