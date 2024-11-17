CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255),
    Cidade VARCHAR(100),
    Estado VARCHAR(50),
    Telefone VARCHAR(15)
);

CREATE TABLE Motoristas (
    MotoristaID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    CNH VARCHAR(20) NOT NULL,
    CategoriaCNH VARCHAR(5),
    DataAdmissao DATE
);

CREATE TABLE Veiculos (
    VeiculoID INT PRIMARY KEY,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Ano INT,
    CapacidadeCarga INT
);

CREATE TABLE Viagens (
    ViagemID INT PRIMARY KEY,
    MotoristaID INT NOT NULL,
    VeiculoID INT NOT NULL,
    ClienteID INT NOT NULL,
    DataSaida DATE,
    DataChegada DATE,
    DistanciaKM INT,
    ValorFrete DECIMAL(10, 2),
    FOREIGN KEY (MotoristaID) REFERENCES Motoristas(MotoristaID),
    FOREIGN KEY (VeiculoID) REFERENCES Veiculos(VeiculoID),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

CREATE TABLE Cargas (
    CargaID INT PRIMARY KEY,
    ViagemID INT NOT NULL,
    Descricao VARCHAR(255),
    Peso DECIMAL(10, 2),
    Volume DECIMAL(10, 2),
    FOREIGN KEY (ViagemID) REFERENCES Viagens(ViagemID)
);

INSERT INTO Clientes (ClienteID, Nome, Endereco, Cidade, Estado, Telefone) VALUES
(1, 'Transporte ABC', 'Rua das Flores, 123', 'São Paulo', 'SP', '(11) 1234-5678'),
(2, 'Logística XYZ', 'Avenida Central, 456', 'Rio de Janeiro', 'RJ', '(21) 9876-5432'),
(3, 'Cargas Rápidas', 'Rua Nova, 789', 'Curitiba', 'PR', '(41) 9988-7766');

INSERT INTO Motoristas (MotoristaID, Nome, CPF, CNH, CategoriaCNH, DataAdmissao) VALUES
(1, 'João Silva', '123.456.789-00', '1234567890', 'E', '2022-01-15'),
(2, 'Maria Santos', '987.654.321-00', '0987654321', 'D', '2023-03-22'),
(3, 'Carlos Pereira', '456.789.123-00', '5678901234', 'C', '2021-10-10');

INSERT INTO Veiculos (VeiculoID, Placa, Modelo, Marca, Ano, CapacidadeCarga) VALUES
(1, 'ABC-1234', 'FH 540', 'Volvo', 2020, 30000),
(2, 'XYZ-5678', 'Actros 2651', 'Mercedes-Benz', 2019, 25000),
(3, 'JKL-9012', 'Constellation 25.420', 'Volkswagen', 2021, 28000);

INSERT INTO Viagens (ViagemID, MotoristaID, VeiculoID, ClienteID, DataSaida, DataChegada, DistanciaKM, ValorFrete) VALUES
(1, 1, 1, 1, '2024-11-01', '2024-11-03', 800, 3500.00),
(2, 2, 2, 2, '2024-11-05', '2024-11-08', 1200, 5000.00),
(3, 3, 3, 3, '2024-11-10', '2024-11-13', 1500, 7500.00);


INSERT INTO Cargas (CargaID, ViagemID, Descricao, Peso, Volume) VALUES
(1, 1, 'Carga de Equipamentos', 20000.50, 35.0),
(2, 2, 'Produtos Alimentícios', 15000.75, 28.5),
(3, 3, 'Materiais de Construção', 25000.00, 40.0);

