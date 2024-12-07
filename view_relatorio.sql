-- Criação das tabelas
CREATE TABLE Alunos (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Disciplinas (
    id_disciplina SERIAL PRIMARY KEY,
    nome_disciplina VARCHAR(100)
);

CREATE TABLE Matriculas (
    id_matricula SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES Alunos(id_aluno),
    id_disciplina INT REFERENCES Disciplinas(id_disciplina),
    nota DECIMAL(5, 2),
    faltas INT
);

-- Inserção de dados fictícios
INSERT INTO Alunos (nome) VALUES 
('João'), ('Maria'), ('Pedro'), ('Ana'), ('Lucas');

INSERT INTO Disciplinas (nome_disciplina) VALUES 
('Matemática'), ('Física'), ('Química'), ('História'), ('Geografia');

INSERT INTO Matriculas (id_aluno, id_disciplina, nota, faltas) VALUES
(1, 1, 8.5, 2),
(2, 1, 7.0, 3),
(3, 1, 9.0, 1),
(4, 2, 6.5, 5),
(5, 2, 8.0, 4),
(1, 3, 7.5, 3),
(2, 3, 6.0, 2),
(3, 3, 8.5, 1),
(4, 4, 9.0, 0),
(5, 4, 8.5, 1);

-- Criação da View para número de alunos matriculados por disciplina
CREATE VIEW Relatorio_Matriculas AS
SELECT 
    d.id_disciplina,
    d.nome_disciplina,
    COUNT(m.id_matricula) AS numero_alunos
FROM 
    Disciplinas d
LEFT JOIN 
    Matriculas m ON d.id_disciplina = m.id_disciplina
GROUP BY 
    d.id_disciplina, d.nome_disciplina;

-- Criação da View para média geral das notas por disciplina
CREATE VIEW Relatorio_Notas AS
SELECT 
    d.id_disciplina,
    d.nome_disciplina,
    AVG(m.nota) AS media_notas
FROM 
    Disciplinas d
LEFT JOIN 
    Matriculas m ON d.id_disciplina = m.id_disciplina
GROUP BY 
    d.id_disciplina, d.nome_disciplina;

-- Criação da View para média de faltas por disciplina
CREATE VIEW Relatorio_Faltas AS
SELECT 
    d.id_disciplina,
    d.nome_disciplina,
    AVG(m.faltas) AS media_faltas
FROM 
    Disciplinas d
LEFT JOIN 
    Matriculas m ON d.id_disciplina = m.id_disciplina
GROUP BY 
    d.id_disciplina, d.nome_disciplina;

-- Criação da View final unificada
CREATE VIEW Relatorio_Final AS
SELECT 
    rm.id_disciplina,
    rm.nome_disciplina,
    rm.numero_alunos,
    rn.media_notas,
    rf.media_faltas
FROM 
    Relatorio_Matriculas rm
LEFT JOIN 
    Relatorio_Notas rn ON rm.id_disciplina = rn.id_disciplina
LEFT JOIN 
    Relatorio_Faltas rf ON rm.id_disciplina = rf.id_disciplina;

-- Consulta ao relatório final
SELECT * FROM Relatorio_Final;
