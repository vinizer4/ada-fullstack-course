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

### Observações:

- *Contratados:* Podem ser tanto Professores quanto Funcionários e contém informações básicas relevantes para ambos.
- *Professores e Funcionarios:* Herdam a chave primária de Contratados, estabelecendo uma relação de herança e garantindo integridade de dados. Formação e Função, respectivamente, são atributos específicos para cada tipo de Contratado.
- *Dependente:* Possui uma relação com Contratados, indicando de quem é dependente.
- *Matriculas:* Associa Alunos com Turmas, indicando em qual semestre o Aluno está matriculado em uma determinada Turma.
- *Leciona:* Estabelece a relação entre Professores e Turmas que lecionam.

### Operações Básicas Exploradas:

- *Verificar Matrículas:* Exibir alunos, turmas, e semestres aos quais estão associados.
- *Professor e Turmas:* Recuperar turmas e disciplinas que um professor está lecionando.
- *Alunos em Turma:* Recuperar todos os alunos matriculados em uma turma específica.
- *Professores e Disciplinas:* Agrupar e exibir disciplinas que os professores estão lecionando.
- *Alunos e Disciplinas:* Agrupar e exibir disciplinas em que os alunos estão matriculados.

A estrutura acima ajuda a manter o modelo de dados coerente e estruturado, facilitando a implementação e manutenção do banco de dados.