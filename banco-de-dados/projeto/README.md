# Hierarquia de Pessoas da Universidade

Considere as Pessoas que têm relacionamento com a universidade.

Alunos possuem um número de matrícula, nome e e-mail, além de um valor de mensalidade. Eles se
matriculam em Turmas em um determinado semestre, sendo que não é possível um mesmo aluno matricular-se na mesma turma no mesmo semestre.

Os Professores possuem número de matrícula, nome, e-mail, salário e uma formação, ensinando para
várias Turmas. Cada Turma é identificada por um número e pelo codcred da disciplina, possuindo, ainda, o nome da disciplina e o horário.

Já os Funcionários têm número de matrícula, nome, e-mail, salário e uma função.

Todos os Contratados da universidade, incluindo Professores e Funcionários, atuam em uma Unidade
Acadêmica, que possui um código e um nome, sendo registrada a data de início na Unidade.

Além disso, os Contratados podem declarar seus dependentes, sendo que cada dependente pode estar
associado no máximo a um Contratado.

## Alunos
- Vinicius Teixeira Saraiva
- Isadora Francine Dias
- Maria Eduarda De Oliveira Almeida
- Jeyquisson Thauan da Fonseca Lima
- Yasmin Caroline do Carmo Felício

### Modelo de Dados

*1. Aluno*
- *Atributos:* NumMatricula (PK), Nome, Email, Mensalidade.

*2. Disciplina*
- *Atributos:* CodCred (PK), Nome.

*3. Turma*
- *Atributos:* Id (PK), CodCred (FK), Numero, Horario, Semestre.
- *Chaves estrangeiras:* CodCred referencia Disciplina.

*4. UnidadeAcademica*
- *Atributos:* CodigoUnidade (PK), Nome.

*5. Contratados*
- *Atributos:* NumMatricula (PK), Nome, Email, Salario, DataInicio, UnidadeCodigo (FK).
- *Chaves estrangeiras:* UnidadeCodigo referencia UnidadeAcademica.

*6. Dependente*
- *Atributos:* Id (PK), Nome, MatriculaContratados (FK).
- *Chaves estrangeiras:* MatriculaContratados referencia Contratados.

*7. Professores*
- *Atributos:* NumMatricula (PK, FK), Formacao.
- *Chaves estrangeiras:* NumMatricula referencia Contratados.

*8. Funcionarios*
- *Atributos:* NumMatricula (PK, FK), Funcao.
- *Chaves estrangeiras:* NumMatricula referencia Contratados.

*9. Matriculas*
- *Atributos:* AlunoMatricula (PK, FK), TurmaId (PK, FK), Semestre.
- *Chaves estrangeiras:*
  - AlunoMatricula referencia Aluno.
  - TurmaId referencia Turma.

*10. Leciona*
- *Atributos:* ProfessorMatricula (PK, FK), TurmaId (PK, FK).
- *Chaves estrangeiras:*
  - ProfessorMatricula referencia Professores.
  - TurmaId referencia Turma.

### Relacionamentos Mapeados

- *`Alunos` e `Matriculas`: Um aluno pode estar matriculado em diversas turmas, e uma turma pode ter vários alunos. (*M:N).
  
- *`Turmas` e `Disciplinas`: Uma turma é associada a uma única disciplina, mas uma disciplina pode ser oferecida em várias turmas. (*1:N).

- *`Turmas` e `Matriculas`: Uma turma pode ter várias matrículas, mas uma matrícula é associada a uma única turma. (*1:N).

- *`Contratados` e `UnidadesAcademicas`: Um contratado está associado a uma única unidade acadêmica, mas uma unidade pode ter vários contratados. (*N:1).

- *`Dependentes` e `Contratados`: Um dependente está associado a um único contratado, mas um contratado pode ter vários dependentes. (*N:1).

- *`Professores` e `Contratados`: Relação *1:1, onde a tabela `Professores` estende informações sobre os contratados que são professores.

- *`Funcionarios` e `Contratados`: Relação *1:1, onde a tabela `Funcionarios` estende informações sobre os contratados que são funcionários.

- *`Professores` e `Leciona`: Um professor pode lecionar várias turmas, enquanto uma turma pode ser lecionada por vários professores (*M:N, embora a prática comum seja 1:N).

### Diagrama DER
![image](https://github.com/vinizer4/ada-fullstack-course/assets/85684965/28a8c8e0-4339-42ec-bf91-738aee76863c)


### Observações:

- *Contratados:* Podem ser tanto Professores quanto Funcionários e contém informações básicas relevantes para ambos.
- *Professores e Funcionarios:* Herdam a chave primária de Contratados, estabelecendo uma relação de herança e garantindo integridade de dados. Formação e Função, respectivamente, são atributos específicos para cada tipo de Contratado.
- *Dependente:* Possui uma relação com Contratados, indicando de quem é dependente.
- *Matriculas:* Associa Alunos com Turmas, indicando em qual semestre o Aluno está matriculado em uma determinada Turma.
- *Leciona:* Estabelece a relação entre Professores e Turmas que lecionam.

### Descrição dos Testes de Consulta

- *Verificar Matrículas*: As consultas verificam se determinado aluno está matriculado em uma turma específica em um semestre.

- *Turmas de um Professor*: Verifica em quais turmas um professor está lecionando, mostrando as disciplinas e semestres correspondentes.

- *Alunos em uma Turma*: Lista todos os alunos matriculados em uma turma específica.

- *Disciplinas de Professores e Alunos*: As consultas agregadas (usando `STRING_AGG`) mostram todas as disciplinas que um professor está lecionando e que um aluno está matriculado, respectivamente.

### Operações Básicas Exploradas:

- *Verificar Matrículas:* Exibir alunos, turmas, e semestres aos quais estão associados.
- *Professor e Turmas:* Recuperar turmas e disciplinas que um professor está lecionando.
- *Alunos em Turma:* Recuperar todos os alunos matriculados em uma turma específica.
- *Professores e Disciplinas:* Agrupar e exibir disciplinas que os professores estão lecionando.
- *Alunos e Disciplinas:* Agrupar e exibir disciplinas em que os alunos estão matriculados.

Essa documentação básica tem o objetivo de oferecer um entendimento claro das tabelas e relações criadas para auxiliar na manipulação e consulta dos dados no contexto de um sistema acadêmico.
