create database Comercial_AMF;

CREATE TABLE Alunos (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    idade INT,
    cidade VARCHAR(255),
    aprovado BOOLEAN 
);


CREATE TABLE Cursos (
    id_curso SERIAL PRIMARY KEY,
    nome_curso VARCHAR(255)
);

CREATE TABLE Detalhes_Aluno (
    id_detalhe SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES Alunos(id_aluno),
    id_curso INT REFERENCES Cursos(id_curso),
    usa_transporte BOOLEAN,
    mora_faculdade BOOLEAN,
    tem_bolsa BOOLEAN 
);

INSERT INTO Alunos (nome, idade, cidade, aprovado) 
VALUES 
('Arthur Zanon de Andrade', 19, 'Faxinal', TRUE),
('Maria Souza', 22, 'Agudo', FALSE),
('Milton Roberto Bortollanza', 20, 'Uruguaiana', TRUE),
('Marcelo Telles', 20, 'Uruguaiana', TRUE),
('Lucas Martins', 21, 'Restinga', FALSE);


INSERT INTO Cursos (nome_curso)
VALUES 
('Sistemas de Informação'),
('Direito'),
('Administração'),
('Ontopsicologia'),
('Ciências Gastronômicas'),
('Pedagogia'),
('Ciências Contábeis');


INSERT INTO Detalhes_Aluno (id_aluno, id_curso, usa_transporte, mora_faculdade, tem_bolsa)
VALUES 
(1, 1, FALSE, FALSE, TRUE),  
(2, 2, FALSE, TRUE, FALSE), 
(3, 1, FALSE, TRUE, TRUE),   
(4, 1, FALSE, TRUE, TRUE), 
(5, 3, TRUE, FALSE, FALSE);

SELECT 
    Alunos.nome AS aluno_nome,
    Alunos.idade,
    Cursos.nome_curso,
    Detalhes_Aluno.usa_transporte,
    Detalhes_Aluno.mora_faculdade,
    Detalhes_Aluno.tem_bolsa
FROM 
    Alunos
JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;

SELECT 
    Alunos.nome AS aluno_nome,
    Cursos.nome_curso
FROM 
    Alunos
INNER JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
INNER JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;

   SELECT 
    Alunos.nome AS aluno_nome,
    Cursos.nome_curso
FROM 
    Alunos
LEFT JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
LEFT JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;
   
SELECT 
    Alunos.nome AS aluno_nome,
    Cursos.nome_curso,
    Detalhes_Aluno.usa_transporte,
    Detalhes_Aluno.mora_faculdade,
    Detalhes_Aluno.tem_bolsa
FROM 
    Alunos
LEFT JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
LEFT JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;

SELECT 
    Cursos.nome_curso,
    Alunos.nome AS aluno_nome
FROM 
    Cursos
RIGHT JOIN 
    Detalhes_Aluno ON Cursos.id_curso = Detalhes_Aluno.id_curso
RIGHT JOIN 
    Alunos ON Detalhes_Aluno.id_aluno = Alunos.id_aluno;

SELECT 
    Alunos.nome AS aluno_nome,
    Cursos.nome_curso
FROM 
    Alunos
FULL OUTER JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
FULL OUTER JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;
   
SELECT 
    Alunos.nome AS aluno_nome,
    Cursos.nome_curso,
    Detalhes_Aluno.usa_transporte,
    Detalhes_Aluno.mora_faculdade,
    Detalhes_Aluno.tem_bolsa
FROM 
    Alunos
FULL OUTER JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
FULL OUTER JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;

SELECT 
    Alunos.nome AS aluno_nome,
    Alunos.idade,
    Cursos.nome_curso,
    Detalhes_Aluno.usa_transporte,
    Detalhes_Aluno.mora_faculdade,
    Detalhes_Aluno.tem_bolsa
FROM 
    Alunos
JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;

   SELECT 
    Alunos.nome AS aluno_nome,
    Cursos.nome_curso
FROM 
    Alunos
INNER JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
INNER JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;

SELECT 
    Alunos.nome AS aluno_nome,
    Cursos.nome_curso
FROM 
    Alunos
LEFT JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
LEFT JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;

SELECT 
    Alunos.nome AS aluno_nome,
    Cursos.nome_curso,
    Detalhes_Aluno.usa_transporte,
    Detalhes_Aluno.mora_faculdade,
    Detalhes_Aluno.tem_bolsa
FROM 
    Alunos
LEFT JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
LEFT JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;


SELECT 
    Cursos.nome_curso,
    Alunos.nome AS aluno_nome
FROM 
    Cursos
RIGHT JOIN 
    Detalhes_Aluno ON Cursos.id_curso = Detalhes_Aluno.id_curso
RIGHT JOIN 
    Alunos ON Detalhes_Aluno.id_aluno = Alunos.id_aluno;

SELECT 
    Alunos.nome AS aluno_nome,
    Cursos.nome_curso
FROM 
    Alunos
FULL OUTER JOIN 
    Detalhes_Aluno ON Alunos.id_aluno = Detalhes_Aluno.id_aluno
FULL OUTER JOIN 
    Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso;
   
 ALTER TABLE Alunos
ADD COLUMN nota NUMERIC;

UPDATE Alunos
SET nota = CASE
    WHEN nome = 'Arthur Zanon de Andrade' THEN 8.5
    WHEN nome = 'Maria Souza' THEN 7.0
    WHEN nome = 'Milton Roberto Bortollanza' THEN 9.0
    WHEN nome = 'Marcelo Telles' THEN 6.5
    WHEN nome = 'Lucas Martins' THEN 7.5
END;

SELECT MAX(nota) AS max_nota
FROM Alunos;

SELECT MIN(nota) AS min_nota
FROM Alunos;

SELECT AVG(nota) AS avg_nota
FROM Alunos;

SELECT SUM(nota) AS total_nota
FROM Alunos;

SELECT COUNT(*) AS total_alunos
FROM Alunos;

CREATE TABLE Notas (
    id SERIAL PRIMARY KEY,
    aluno_nome VARCHAR(255),
    nota NUMERIC
);

INSERT INTO Notas (aluno_nome, nota) 
VALUES 
('Arthur Zanon de Andrade', 8.5),
('Maria Souza', 7.0),
('Milton Roberto Bortollanza', 9.0),
('Marcelo Telles', 6.5),
('Lucas Martins', 7.5);

SELECT idade, COUNT(*) AS total_alunos
FROM Alunos
GROUP BY idade;

SELECT cidade, AVG(nota) AS media_nota
FROM Alunos
GROUP BY cidade;

SELECT Cursos.nome_curso, COUNT(Detalhes_Aluno.id_aluno) AS total_alunos
FROM Detalhes_Aluno
JOIN Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso;

SELECT Cursos.nome_curso, COUNT(*) AS total_usa_transporte
FROM Detalhes_Aluno
JOIN Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso
WHERE usa_transporte = TRUE
GROUP BY Cursos.nome_curso;

SELECT Cursos.nome_curso, aprovado, COUNT(*) AS total_alunos
FROM Detalhes_Aluno
JOIN Alunos ON Detalhes_Aluno.id_aluno = Alunos.id_aluno
JOIN Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso, aprovado;

SELECT idade, AVG(nota) AS media_nota
FROM Alunos
GROUP BY idade
HAVING AVG(nota) > 7.0;

SELECT Cursos.nome_curso, COUNT(Detalhes_Aluno.id_aluno) AS total_alunos
FROM Detalhes_Aluno
JOIN Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso
GROUP BY Cursos.nome_curso
HAVING COUNT(Detalhes_Aluno.id_aluno) > 1;

SELECT cidade, AVG(nota) AS media_nota
FROM Alunos
GROUP BY cidade
HAVING AVG(nota) < 7.5;

SELECT Cursos.nome_curso, COUNT(Detalhes_Aluno.id_aluno) AS total_aprovados
FROM Detalhes_Aluno
JOIN Alunos ON Detalhes_Aluno.id_aluno = Alunos.id_aluno
JOIN Cursos ON Detalhes_Aluno.id_curso = Cursos.id_curso
WHERE Alunos.aprovado = TRUE
GROUP BY Cursos.nome_curso
HAVING COUNT(Detalhes_Aluno.id_aluno) > 2;

SELECT cidade, COUNT(*) AS total_alunos
FROM Alunos
GROUP BY cidade
HAVING COUNT(*) > 1;













