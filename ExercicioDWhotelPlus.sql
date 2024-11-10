CREATE TABLE Dim_Cliente (
    Cliente_Surrogate INT AUTO_INCREMENT PRIMARY KEY,   -- Chave surrogate
    ID_Cliente INT NOT NULL,                             -- Chave natural
    Nome VARCHAR(255),
    Data_Nascimento DATE,
    Categoria_Fidelidade VARCHAR(50),
    Endereco VARCHAR(255),
    Data_Inicio DATE,                                    -- Data de início da versão
    Data_Fim DATE,                                       -- Data de fim da versão
    Status VARCHAR(10) DEFAULT 'Ativo',                  -- Status da versão (Ativo/Inativo)
    CONSTRAINT fk_cliente_id FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE Dim_Quarto (
    Quarto_Surrogate INT AUTO_INCREMENT PRIMARY KEY,  -- Chave surrogate
    ID_Quarto INT NOT NULL,                            -- Chave natural
    Tipo_Quarto VARCHAR(50),
    Status_Manutencao VARCHAR(50),
    Data_Ultima_Reforma DATE,
    Data_Inicio DATE,                                  -- Data de início da versão
    Data_Fim DATE,                                     -- Data de fim da versão
    Status VARCHAR(10) DEFAULT 'Ativo',                -- Status da versão (Ativo/Inativo)
    CONSTRAINT fk_quarto_id FOREIGN KEY (ID_Quarto) REFERENCES Quarto(ID_Quarto)
);

CREATE TABLE Dim_Hotel (
    Hotel_Surrogate INT AUTO_INCREMENT PRIMARY KEY,    -- Chave surrogate
    ID_Hotel INT NOT NULL,                              -- Chave natural
    Nome_Hotel VARCHAR(255),
    Cidade VARCHAR(100),
    Pais VARCHAR(100),
    Data_Inauguracao DATE,
    CONSTRAINT fk_hotel_id FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel)
);

CREATE TABLE Dim_Data (
    Data DATE PRIMARY KEY,  -- Chave primária para representar a data
    Ano INT,
    Mes INT,
    Dia INT,
    Dia_Semana VARCHAR(20),
    Trimestre INT,
    Semestre INT
);

CREATE TABLE Fato_Reserva (
    ID_Reserva INT AUTO_INCREMENT PRIMARY KEY,
    Cliente_Surrogate INT,
    Quarto_Surrogate INT,
    Hotel_Surrogate INT,
    Data_Checkin DATE,
    Data_Checkout DATE,
    Valor_Total DECIMAL(10, 2),
    CONSTRAINT fk_cliente FOREIGN KEY (Cliente_Surrogate) REFERENCES Dim_Cliente(Cliente_Surrogate),
    CONSTRAINT fk_quarto FOREIGN KEY (Quarto_Surrogate) REFERENCES Dim_Quarto(Quarto_Surrogate),
    CONSTRAINT fk_hotel FOREIGN KEY (Hotel_Surrogate) REFERENCES Dim_Hotel(Hotel_Surrogate),
    CONSTRAINT fk_data_checkin FOREIGN KEY (Data_Checkin) REFERENCES Dim_Data(Data),
    CONSTRAINT fk_data_checkout FOREIGN KEY (Data_Checkout) REFERENCES Dim_Data(Data)
);

CREATE TABLE Fato_Receitas (
    ID_Hotel INT,
    Data DATE,
    Receita_Total_Diaria DECIMAL(15, 2),
    Despesas_Operacionais_Diarias DECIMAL(15, 2),
    CONSTRAINT fk_receitas_hotel FOREIGN KEY (ID_Hotel) REFERENCES Dim_Hotel(Hotel_Surrogate),
    CONSTRAINT fk_receitas_data FOREIGN KEY (Data) REFERENCES Dim_Data(Data)
);

-- Implementação do SCD Tipo 2 para CLIENTE e QUARTO:
-- Dimensão CLIENTE (SCD Tipo 2):

-- Objetivo: Rastrear mudanças nos dados pessoais do cliente (como mudança de endereço, categoria de fidelidade, etc.).
-- Estrutura da Tabela CLIENTE com SCD Tipo 2:
  -- Cliente_Surrogate: Chave surrogate para o cliente.
  -- ID_Cliente: Chave natural.
  -- Nome, Data_Nascimento, Categoria_Fidelidade, Endereco: Atributos do cliente.
  -- Data_Inicio: Data de início da versão do cliente.
  -- Data_Fim: Data de término da versão (usada quando uma nova versão do cliente é criada).
  -- Status: Status da versão (Ativo/Inativo). A versão ativa será marcada como "Ativo".
-- Como funciona: Sempre que um cliente sofrer uma alteração (por exemplo, uma mudança na categoria de fidelidade ou no endereço), uma nova linha será inserida na tabela CLIENTE com um novo Cliente_Surrogate, e o Status da versão anterior será marcado como "Inativo". A Data_Fim da versão anterior será preenchida com a data da mudança.

-- Dimensão QUARTO (SCD Tipo 2):
-- Objetivo: Rastrear alterações no status do quarto ou no tipo de quarto (por exemplo, reforma, mudança de categoria de quarto).
-- Estrutura da Tabela QUARTO com SCD Tipo 2:
  -- Quarto_Surrogate: Chave surrogate para o quarto.
  -- ID_Quarto: Chave natural.
  -- Tipo_Quarto, Status_Manutencao, Data_Ultima_Reforma: Atributos relacionados ao quarto.
  -- Data_Inicio: Data de início da versão do quarto.
  -- Data_Fim: Data de término da versão.
  -- Status: Status da versão (Ativo/Inativo).
-- Como funciona: Sempre que um quarto for reformado ou tiver alteração em seu status, uma nova linha será criada com o novo Quarto_Surrogate. A versão anterior será desativada, com a Data_Fim sendo preenchida com a data da reforma ou alteração.


--Modelo Star Schema
  -- Fato RESERVA:
  -- Relacionada a CLIENTE, QUARTO, HOTEL, DATA.
  -- Métricas: Total de receitas, número de reservas, tempo de permanência, entre outras.
-- Dimensões:
  -- CLIENTE: Informações sobre o hóspede, com SCD Tipo 2.
  -- QUARTO: Detalhes sobre os quartos, com SCD Tipo 2.
  -- HOTEL: Dados sobre o hotel, cidade e país.
  -- DATA: Para representar períodos e facilitar a análise temporal.


