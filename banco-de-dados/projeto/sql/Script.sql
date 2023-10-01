-- Tabela para armazenar informações sobre os Alunos
CREATE TABLE Alunos (
    matricula SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    mensalidade DECIMAL(10,2)
);

-- Tabela para armazenar informações sobre as Disciplinas
CREATE TABLE Disciplinas (
    codcred VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(255)
);

-- Tabela para armazenar informações sobre as Turmas
CREATE TABLE Turmas (
    id SERIAL PRIMARY KEY,
    codcred VARCHAR(10) REFERENCES Disciplinas(codcred),
    numero VARCHAR(10),
    horario TIME,
    semestre VARCHAR(10)
);

-- Tabela para armazenar informações sobre as Unidades Acadêmicas
CREATE TABLE UnidadesAcademicas (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(255)
);

-- Tabela para armazenar informações sobre os Contratados (Professores e Funcionários)
CREATE TABLE Contratados (
    matricula SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    salario DECIMAL(10,2),
    data_inicio DATE,
    unidade_codigo INTEGER REFERENCES UnidadesAcademicas(codigo)
);

-- Tabela para armazenar informações sobre os Dependentes dos Contratados
CREATE TABLE Dependentes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    contratado_matricula INTEGER REFERENCES Contratados(matricula)
);

-- Tabela para armazenar informações adicionais sobre os Professores
CREATE TABLE Professores (
    matricula INTEGER PRIMARY KEY REFERENCES Contratados(matricula),
    formacao VARCHAR(255)
);

-- Tabela para armazenar informações adicionais sobre os Funcionários
CREATE TABLE Funcionarios (
    matricula INTEGER PRIMARY KEY REFERENCES Contratados(matricula),
    funcao VARCHAR(255)
);

-- Tabela para relacionar Alunos, Turmas e os semestres em que estão matriculados
CREATE TABLE Matriculas (
    aluno_matricula INTEGER REFERENCES Alunos(matricula),
    turma_id INTEGER REFERENCES Turmas(id),
    semestre VARCHAR(10),
    PRIMARY KEY (aluno_matricula, turma_id, semestre)
);

-- Tabela para relacionar Professores e Turmas que lecionam
CREATE TABLE Leciona (
    professor_matricula INTEGER REFERENCES Professores(matricula),
    turma_id INTEGER REFERENCES Turmas(id),
    PRIMARY KEY (professor_matricula, turma_id)
);

-- Inserindo alguns dados para teste
INSERT INTO UnidadesAcademicas (nome) VALUES ('Engenharia');
INSERT INTO Disciplinas (codcred, nome) VALUES ('ENG101', 'Engenharia Básica');
INSERT INTO Turmas (codcred, numero, horario, semestre) VALUES ('ENG101', 'A', '08:00', '2023-1');
INSERT INTO Alunos (nome, email, mensalidade) VALUES ('João Silva', 'joao@exemplo.com', 1500.00);
INSERT INTO Contratados (nome, email, salario, data_inicio, unidade_codigo) VALUES ('Prof. Ana', 'ana@exemplo.com', 5000.00, '2023-01-01', 1);
INSERT INTO Professores (matricula, formacao) VALUES (1, 'Doutorado');
INSERT INTO Matriculas (aluno_matricula, turma_id, semestre) VALUES (1, 1, '2023-1');
INSERT INTO Leciona (professor_matricula, turma_id) VALUES (1, 1);

-- Verificar se um aluno está matriculado em uma turma no mesmo semestre:
SELECT a.nome AS aluno, t.numero AS turma, t.semestre
FROM Alunos a
JOIN Matriculas m ON a.matricula = m.aluno_matricula
JOIN Turmas t ON m.turma_id = t.id
WHERE a.nome = 'João Silva' AND t.semestre = '2023-1';

-- Verificar quais turmas um professor está lecionando:
SELECT c.nome AS professor, t.numero AS turma, d.nome AS disciplina, t.semestre
FROM Professores p
JOIN Contratados c ON p.matricula = c.matricula
JOIN Leciona l ON p.matricula = l.professor_matricula
JOIN Turmas t ON l.turma_id = t.id
JOIN Disciplinas d ON t.codcred = d.codcred
WHERE c.nome = 'Prof. Ana';

-- Verificar quais alunos estão matriculados em uma turma:
SELECT a.nome AS aluno
FROM Alunos a
JOIN Matriculas m ON a.matricula = m.aluno_matricula
JOIN Turmas t ON m.turma_id = t.id
WHERE t.numero = 'A' AND t.semestre = '2023-1';

-- Adicionando mais dados
INSERT INTO Alunos (nome, email, mensalidade) VALUES 
('Maria Oliveira', 'maria@exemplo.com', 1400.00),
('Carlos Souza', 'carlos@exemplo.com', 1600.00);

INSERT INTO Disciplinas (codcred, nome) VALUES 
('MAT101', 'Matemática Básica'),
('FIS101', 'Física Básica');

INSERT INTO Turmas (codcred, numero, horario, semestre) VALUES 
('MAT101', 'B', '10:00', '2023-1'),
('FIS101', 'A', '14:00', '2023-1');

-- Novo professor
INSERT INTO Contratados (nome, email, salario, data_inicio, unidade_codigo) VALUES 
('Prof. Carlos', 'carlos.prof@exemplo.com', 6000.00, '2023-01-15', 1);

INSERT INTO Professores (matricula, formacao) VALUES 
(2, 'Mestrado');

-- Relacionando alunos a turmas
INSERT INTO Matriculas (aluno_matricula, turma_id, semestre) VALUES 
(2, 1, '2023-1'),
(2, 2, '2023-1'),
(3, 3, '2023-1');

-- Relacionando professores a turmas
INSERT INTO Leciona (professor_matricula, turma_id) VALUES 
(2, 2),
(2, 3);

-- Professores lecionando várias turmas:
-- a função STRING_AGG(d.nome, ', ') concatena os nomes das disciplinas em que um professor está lecionando
SELECT c.nome AS professor, STRING_AGG(d.nome, ', ') AS disciplinas
FROM Professores p
JOIN Contratados c ON p.matricula = c.matricula
JOIN Leciona l ON p.matricula = l.professor_matricula
JOIN Turmas t ON l.turma_id = t.id
JOIN Disciplinas d ON t.codcred = d.codcred
GROUP BY c.nome;

-- Relacionamento M:N entre Alunos e Turmas e entre Professores e Turmas.
SELECT a.nome AS aluno, STRING_AGG(d.nome, ', ') AS disciplinas
FROM Alunos a
JOIN Matriculas m ON a.matricula = m.aluno_matricula
JOIN Turmas t ON m.turma_id = t.id
JOIN Disciplinas d ON t.codcred = d.codcred
GROUP BY a.nome;