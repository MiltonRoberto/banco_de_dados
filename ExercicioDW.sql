-- 1) Ciência da Computação, Data Warehouse, CESGRANRIO, 2018, Petrobras, Analista de
-- Sistemas Júnior
-- Ao construir um modelo de dados para um data warehouse de sua empresa, um
-- desenvolvedor viu-se às voltas com três tabelas relacionais: venda, cliente e vendedor.
-- Ao fazer uma transformação para o modelo estrela, ele deve organizar:
-- A) venda, como tabela fato; cliente e vendedor, como tabelas dimensão 
-- B) cliente e vendedor, como tabelas fato; venda, como tabela dimensão
-- C) cliente, como tabela fato; venda e vendedor, como tabelas dimensão
-- D) vendedor e venda, como tabelas fato; cliente, como tabela dimensão
-- E) vendedor, como tabela fato; cliente e venda, como tabelas dimensão
RESPOSTA - A

-- 2) Ciência da Computação, Data Warehouse, CESPE / CEBRASPE, 2019, Secretaria da
-- Fazenda do Estado - RS (SEFAZ/RS), Auditor Fiscal da Receita Estadual (Classe A)
-- O data warehouse diferencia-se dos bancos de dados transacionais porque
-- A) trabalha com dados atuais, mas não com dados históricos.
-- B) faz uso intenso de operações diárias e de processamento de transações continuamente.
-- C) possui milhares de usuários de diferentes níveis hierárquicos dentro da organização.
-- D) tem dimensionalidade genérica e níveis de agregação ilimitados.
-- E) utiliza ferramentas de prospecção e consulta de dados baseadas em OLTP (on-line
-- transaction processing).
RESPOSTA - D
    
-- 3) Ciência da Computação, Data Warehouse, FCC, 2018, Defensoria Pública do Estado de
-- Amazonas - AM (DPE/AM), Analista em Gestão Especializado em TI
-- Uma das características fundamentais de um ambiente de data warehouse está em
-- A) servir como substituto aos bancos de dados operacionais de uma empresa, na
-- eventualidade da ocorrência de problemas com tais bancos de dados.
-- B) ser de utilização exclusiva da área de aplicações financeiras das empresas.
-- C) proporcionar um ambiente que permita realizar análise dos negócios de uma empresa com base nos dados por ela armazenados.
-- D) ser de uso prioritário de funcionários responsáveis pela área de telemarketing das
-- empresas.
-- E) armazenar apenas os dados mais atuais (máximo de 3 meses de criação),
-- independentemente da área de atuação de cada empresa.
RESPOSTA - C

-- 4) Ciência da Computação, Data Warehouse, FCC, 2018, Defensoria Pública do Estado de
-- Amazonas - AM (DPE/AM), Analista em Gestão Especializado em TI
-- Sobre o processo de ETL, aplicado a data warehouse, é correto afirmar que
-- A) a fase de extração de dados consiste em obter os dados do servidor do data warehouse.
-- B) a fase de transformação consiste em realizar modificações nos dados carregados,
-- adequando seus valores ao modelo definido para o data warehouse.
-- C) as fases de extração e carga de dados são realizadas de forma simultânea.
-- D) a fase de carga de dados visa eliminar valores nulos contidos nos bancos de dados
-- transacionais da empresa.
-- E) a fase de carga de dados consiste em inserir os dados transformados nos bancos de
-- dados transacionais da empresa.
RESPOSTA - B

-- 5) Ciência da Computação, Data Warehouse, CESGRANRIO, 2018, Banco da Amazônia S/A
-- - AM (BASA/AM), Técnico Científico
-- Um Data Warehouse é recomendado para armazenar dados
-- A) sumarizados de um departamento.
-- B) sumarizados de toda a empresa para apoio à decisão e utilização de ferramentas OLAP.
-- C) detalhados de toda a empresa para apoio à decisão e utilização de ferramentas OLAP.
-- D) detalhados gerados por sistemas de informação transacionais.
-- E) históricos detalhados de todas as transações realizadas em um determinado período de
-- tempo.
RESPOSTA - B


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