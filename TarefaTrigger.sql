-- Criação da função para atualizar o estoque
CREATE OR REPLACE FUNCTION atualizar_estoque()
RETURNS trigger
AS $$
BEGIN
    UPDATE Produto
    SET qtd_disponivel = qtd_disponivel - NEW.qtd_vendida
    WHERE cod_prod = NEW.id_produto;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tabela Produto
CREATE TABLE Produto (
    cod_prod SERIAL PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    qtd_disponivel INT NOT NULL
);

-- Tabela ItensVenda
CREATE TABLE ItensVenda (
    cod_venda SERIAL PRIMARY KEY,
    id_produto INT NOT NULL REFERENCES Produto(cod_prod),
    qtd_vendida INT NOT NULL
);

-- Criação da trigger
CREATE TRIGGER trigger_atualizar_estoque
AFTER INSERT ON ItensVenda
FOR EACH ROW
EXECUTE FUNCTION atualizar_estoque();

CREATE TABLE tb_bkp_usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    senha VARCHAR(100)
);

CREATE OR REPLACE FUNCTION backup_usuario_excluido()
RETURNS trigger
AS $$
BEGIN
    INSERT INTO tb_bkp_usuarios (id, nome, senha)
    VALUES (OLD.id, OLD.nome, OLD.senha);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;




CREATE TABLE tb_usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    senha VARCHAR(100)
);

CREATE OR REPLACE FUNCTION backup_usuario_excluido()
RETURNS trigger
AS $$
BEGIN
    INSERT INTO tb_bkp_usuarios (id, nome, senha)
    VALUES (OLD.id, OLD.nome, OLD.senha);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_backup_usuarios
AFTER DELETE ON tb_usuarios
FOR EACH ROW
EXECUTE FUNCTION backup_usuario_excluido();

INSERT INTO Produto (descricao, qtd_disponivel) VALUES ('Caderno', 100);
INSERT INTO ItensVenda (id_produto, qtd_vendida) VALUES (1, 10);
SELECT * FROM Produto;

INSERT INTO tb_usuarios (nome, senha) VALUES ('João', '1234');
DELETE FROM tb_usuarios WHERE nome = 'João';
SELECT * FROM tb_bkp_usuarios;
