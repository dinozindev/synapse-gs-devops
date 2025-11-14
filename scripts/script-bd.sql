/*
============================================================
SCRIPT DE CRIAÇÃO DE BANCO - Synapse
Banco: PostgreSQL
Autor: Equipe Synapse
============================================================
*/

/* ============================================================
   TABELA: COMPETENCIA
   ============================================================ */
CREATE TABLE "COMPETENCIA" (
    "ID_COMPETENCIA"        BIGSERIAL PRIMARY KEY,
    "NOME_COMPETENCIA"      VARCHAR(100) NOT NULL,
    "CATEGORIA_COMPETENCIA" VARCHAR(50)  NOT NULL,
    "DESCRICAO_COMPETENCIA" VARCHAR(255) NOT NULL
);

/* ============================================================
   TABELA: USUARIO
   ============================================================ */
CREATE TABLE "USUARIO" (
    "ID_USUARIO"        BIGSERIAL PRIMARY KEY,
    "NOME_USUARIO"      VARCHAR(100) NOT NULL,
    "SENHA_USUARIO"     VARCHAR(255) NOT NULL,
    "AREA_ATUAL"        VARCHAR(100) NOT NULL,
    "AREA_INTERESSE"    VARCHAR(100) NOT NULL,
    "OBJETIVO_CARREIRA" VARCHAR(255) NOT NULL,
    "NIVEL_EXPERIENCIA" VARCHAR(50)  NOT NULL,
    CONSTRAINT "CHK_NIVEL_EXPERIENCIA" CHECK (
        "NIVEL_EXPERIENCIA" IN ('Nenhuma','Estagiário','Júnior','Pleno','Sênior')
    ),
    CONSTRAINT "USUARIO_NOME_UNIQUE" UNIQUE ("NOME_USUARIO")
);

/* ============================================================
   TABELA: RECOMENDACAO (SUPERCLASSE)
   ============================================================ */
CREATE TABLE "RECOMENDACAO" (
    "ID_RECOMENDACAO"        BIGSERIAL PRIMARY KEY,
    "DATA_RECOMENDACAO"      DATE         NOT NULL,
    "DESCRICAO_RECOMENDACAO" VARCHAR(1000) NOT NULL,
    "PROMPT_USADO"           VARCHAR(1000) NOT NULL,
    "TITULO_RECOMENDACAO"    VARCHAR(100)  NOT NULL,
    "USUARIO_ID_USUARIO"     BIGINT,
    CONSTRAINT "RECOMENDACAO_USUARIO_FK" FOREIGN KEY ("USUARIO_ID_USUARIO")
        REFERENCES "USUARIO" ("ID_USUARIO")
);

/* ============================================================
   TABELA: RECOMENDACAO_PROFISSIONAL (SUBCLASSE)
   ============================================================ */
CREATE TABLE "RECOMENDACAO_PROFISSIONAL" (
    "ID_RECOMENDACAO"        BIGINT PRIMARY KEY,
    "CATEGORIA_RECOMENDACAO" VARCHAR(50)  NOT NULL,
    "AREA_RECOMENDACAO"      VARCHAR(100) NOT NULL,
    "FONTE_RECOMENDACAO"     VARCHAR(100) NOT NULL,
    CONSTRAINT "CHK_CATEGORIA_RECOMENDACAO" CHECK (
        "CATEGORIA_RECOMENDACAO" IN ('Vaga','Curso')
    ),
    CONSTRAINT "CHK_AREA_RECOMENDACAO" CHECK (
        "AREA_RECOMENDACAO" IN (
            'Front-end','Back-end','DevOps','UX/UI',
            'Data Science','Banco de Dados','Governança de TI','IA'
        )
    ),
    CONSTRAINT "RECOMENDACAO_PROFISSIONAL_FK" FOREIGN KEY ("ID_RECOMENDACAO")
        REFERENCES "RECOMENDACAO" ("ID_RECOMENDACAO")
);

/* ============================================================
   TABELA: RECOMENDACAO_SAUDE (SUBCLASSE)
   ============================================================ */
CREATE TABLE "RECOMENDACAO_SAUDE" (
    "ID_RECOMENDACAO" BIGINT PRIMARY KEY,
    "TIPO_SAUDE"      VARCHAR(50)  NOT NULL,
    "NIVEL_ALERTA"    VARCHAR(50)  NOT NULL,
    "MENSAGEM_SAUDE"  VARCHAR(1000) NOT NULL,
    CONSTRAINT "CHK_TIPO_SAUDE" CHECK (
        "TIPO_SAUDE" IN ('Sono','Produtividade','Saúde Mental')
    ),
    CONSTRAINT "CHK_NIVEL_ALERTA" CHECK (
        "NIVEL_ALERTA" IN ('Baixo','Moderado','Alto')
    ),
    CONSTRAINT "RECOMENDACAO_SAUDE_FK" FOREIGN KEY ("ID_RECOMENDACAO")
        REFERENCES "RECOMENDACAO" ("ID_RECOMENDACAO")
);

/* ============================================================
   TABELA: REGISTRO_BEM_ESTAR
   ============================================================ */
CREATE TABLE "REGISTRO_BEM_ESTAR" (
    "ID_REGISTRO"         BIGSERIAL PRIMARY KEY,
    "DATA_REGISTRO"       DATE         NOT NULL,
    "HUMOR_REGISTRO"      VARCHAR(20)  NOT NULL,
    "HORAS_SONO"          SMALLINT     NOT NULL,
    "HORAS_TRABALHO"      SMALLINT     NOT NULL,
    "NIVEL_ENERGIA"       SMALLINT     NOT NULL,
    "NIVEL_ESTRESSE"      SMALLINT     NOT NULL,
    "OBSERVACAO_REGISTRO" VARCHAR(255),
    "USUARIO_ID_USUARIO"  BIGINT,
    CONSTRAINT "CHK_HUMOR_REGISTRO" CHECK (
        "HUMOR_REGISTRO" IN ('Feliz','Triste','Estressado','Bravo','Calmo')
    ),
    CONSTRAINT "REGISTRO_BEM_ESTAR_USUARIO_FK" FOREIGN KEY ("USUARIO_ID_USUARIO")
        REFERENCES "USUARIO" ("ID_USUARIO")
);

/* ============================================================
   TABELA: USUARIO_COMPETENCIA (N:N)
   ============================================================ */
CREATE TABLE "USUARIO_COMPETENCIA" (
    "USUARIO_ID_USUARIO"         BIGINT NOT NULL,
    "COMPETENCIA_ID_COMPETENCIA" BIGINT NOT NULL,
    CONSTRAINT "USUARIO_COMPETENCIA_PK" PRIMARY KEY (
        "USUARIO_ID_USUARIO",
        "COMPETENCIA_ID_COMPETENCIA"
    ),
    CONSTRAINT "USUARIO_COMP_USUARIO_FK" FOREIGN KEY ("USUARIO_ID_USUARIO")
        REFERENCES "USUARIO" ("ID_USUARIO"),
    CONSTRAINT "USUARIO_COMP_COMPETENCIA_FK" FOREIGN KEY ("COMPETENCIA_ID_COMPETENCIA")
        REFERENCES "COMPETENCIA" ("ID_COMPETENCIA")
);

/* ============================================================
   INSERTS
   ============================================================ */
INSERT INTO "COMPETENCIA" ("NOME_COMPETENCIA", "CATEGORIA_COMPETENCIA", "DESCRICAO_COMPETENCIA") VALUES
('Python', 'Back-end', 'Linguagem versátil para desenvolvimento e ciência de dados'),
('JavaScript', 'Front-end', 'Linguagem essencial para desenvolvimento web'),
('React', 'Front-end', 'Biblioteca moderna para interfaces de usuário'),
('SQL', 'Banco de Dados', 'Linguagem para manipulação de bancos relacionais'),
('Docker', 'DevOps', 'Containerização de aplicações'),
('Kubernetes', 'DevOps', 'Orquestração de containers'),
('Machine Learning', 'IA', 'Desenvolvimento de modelos preditivos'),
('TensorFlow', 'IA', 'Framework para deep learning'),
('Figma', 'UX/UI', 'Ferramenta de design de interfaces'),
('Git', 'DevOps', 'Controle de versão de código'),
('AWS', 'DevOps', 'Serviços de cloud computing da Amazon'),
('Node.js', 'Back-end', 'Runtime JavaScript para servidor'),
('MongoDB', 'Banco de Dados', 'Banco de dados NoSQL orientado a documentos'),
('TypeScript', 'Front-end', 'JavaScript com tipagem estática'),
('Comunicação', 'Soft Skills', 'Habilidade de comunicar ideias claramente'),
('Trabalho em Equipe', 'Soft Skills', 'Colaboração efetiva com colegas'),
('Resolução de Problemas', 'Soft Skills', 'Análise e solução de desafios complexos'),
('Jenkins', 'DevOps', 'Automação de CI/CD'),
('Pandas', 'Data Science', 'Manipulação e análise de dados em Python'),
('Power BI', 'Data Science', 'Visualização de dados e business intelligence');

INSERT INTO "USUARIO" ("NOME_USUARIO", "SENHA_USUARIO", "AREA_ATUAL", "AREA_INTERESSE","OBJETIVO_CARREIRA", "NIVEL_EXPERIENCIA") VALUES
('maria.silva', 'senha123', 'Suporte Técnico', 'DevOps', 'Migrar para área de infraestrutura e automação', 'Júnior'),
('joao.santos', 'pass456', 'Analista de Sistemas', 'Data Science', 'Tornar-me cientista de dados especializado em IA', 'Pleno'),
('ana.costa', 'secure789', 'Designer Gráfico', 'UX/UI', 'Transição para design de experiência do usuário', 'Júnior'),
('pedro.oliveira', 'mypass321', 'Desenvolvedor Junior', 'Back-end', 'Crescer como desenvolvedor backend sênior', 'Júnior'),
('julia.ferreira', 'pass2024', 'Estagiária TI', 'Front-end', 'Desenvolver carreira em desenvolvimento web moderno', 'Estagiário'),
('carlos.mendes', 'dev4567', 'Nenhuma', 'Banco de Dados', 'Iniciar carreira como DBA ou engenheiro de dados', 'Nenhuma'),
('fernanda.lima', 'secure890', 'Gerente de Projetos', 'Governança de TI', 'Especializar-me em governança e compliance de TI', 'Sênior'),
('ricardo.alves', 'pass9999', 'Desenvolvedor Full Stack', 'IA', 'Migrar para desenvolvimento de soluções de inteligência artificial', 'Pleno'),
('beatriz.rocha', 'bea2024', 'QA Tester', 'DevOps', 'Automatizar testes e trabalhar com CI/CD', 'Júnior'),
('lucas.martins', 'lucas123', 'Analista de Negócios', 'Data Science', 'Combinar análise de negócios com ciência de dados', 'Pleno'),
('camila.souza', 'cami456', 'Desenvolvedora Mobile', 'Back-end', 'Expandir conhecimento para desenvolvimento backend', 'Júnior'),
('rafael.dias', 'rafa789', 'Freelancer Web', 'Front-end', 'Profissionalizar carreira como desenvolvedor frontend', 'Júnior');

INSERT INTO "RECOMENDACAO" ("DATA_RECOMENDACAO","DESCRICAO_RECOMENDACAO","PROMPT_USADO","TITULO_RECOMENDACAO","USUARIO_ID_USUARIO") VALUES
(1, CURRENT_DATE, 'Vaga Front-end Júnior', 'Oportunidade para desenvolvedor front-end iniciante', 'IA recomenda vagas baseadas em perfil'),
(1, CURRENT_DATE, 'Curso de Back-end com Spring Boot', 'Aprofunde seus conhecimentos em APIs Java', 'IA recomenda curso baseado em interesse'),
(2, CURRENT_DATE, 'Vaga DevOps Pleno', 'Ambiente cloud com CI/CD', 'IA recomenda vaga compatível com suas skills'),
(2, CURRENT_DATE, 'Curso UX/UI Avançado', 'Aprenda design centrado no usuário', 'IA recomenda aprimorar habilidades de UX'),
(3, CURRENT_DATE, 'Vaga Cientista de Dados', 'Trabalhe com análise preditiva e machine learning', 'IA recomenda com base no histórico de aprendizado'),
(3, CURRENT_DATE, 'Curso Banco de Dados Oracle', 'Curso completo sobre modelagem e SQL avançado', 'IA recomenda aprimorar conhecimento em banco de dados'),
(4, CURRENT_DATE, 'Vaga de Governança de TI', 'Atue com políticas de segurança e compliance', 'IA sugere com base no perfil profissional'),
(4, CURRENT_DATE, 'Curso de Inteligência Artificial Aplicada', 'Aprenda IA com Python e frameworks modernos', 'IA recomenda com base no interesse em tecnologia emergente'),
(5, CURRENT_DATE, 'Vaga Full Stack Developer', 'Desenvolvimento com React e Node.js', 'IA recomenda vaga conforme habilidades recentes'),
(5, CURRENT_DATE, 'Curso DevOps com Azure', 'Aprenda CI/CD e monitoramento em nuvem', 'IA recomenda com base em seu histórico profissional'),
(1, CURRENT_DATE, 'Melhorar qualidade do sono', 'Evite cafeína e telas antes de dormir', 'IA recomenda hábitos saudáveis de sono'),
(1, CURRENT_DATE, 'Aumentar produtividade', 'Organize tarefas com pausas regulares', 'IA sugere técnicas de foco'),
(2, CURRENT_DATE, 'Reduzir estresse mental', 'Reserve tempo diário para relaxamento', 'IA recomenda práticas de mindfulness'),
(2, CURRENT_DATE, 'Melhorar rotina de sono', 'Durma de 7 a 8 horas por noite', 'IA sugere equilíbrio entre descanso e trabalho'),
(3, CURRENT_DATE, 'Gerenciar sobrecarga de trabalho', 'Evite multitarefas e priorize descanso', 'IA sugere equilíbrio profissional'),
(3, CURRENT_DATE, 'Cuidar da saúde emocional', 'Procure apoio de profissionais quando necessário', 'IA recomenda atenção emocional'),
(4, CURRENT_DATE, 'Melhorar foco no trabalho', 'Crie um ambiente silencioso e organizado', 'IA sugere técnicas de concentração'),
(4, CURRENT_DATE, 'Evitar insônia', 'Estabeleça horários fixos para dormir', 'IA recomenda rotina de sono estável'),
(5, CURRENT_DATE, 'Prevenir esgotamento mental', 'Pratique pausas e lazer fora do trabalho', 'IA recomenda autocuidado'),
(5, CURRENT_DATE, 'Manter equilíbrio entre vida pessoal e trabalho', 'Defina limites claros de horários', 'IA sugere estratégias de produtividade saudável');

INSERT INTO "REGISTRO_BEM_ESTAR" ("DATA_REGISTRO","HUMOR_REGISTRO","HORAS_SONO","HORAS_TRABALHO", "NIVEL_ENERGIA","NIVEL_ESTRESSE","OBSERVACAO_REGISTRO","USUARIO_ID_USUARIO") VALUES
(1, CURRENT_DATE - INTERVAL '7 days', 'Estressado', 6, 10, 5, 8, 'Muita demanda no trabalho'),
(1, CURRENT_DATE - INTERVAL '6 days', 'Calmo', 7, 8, 7, 5, 'Dia mais tranquilo'),
(1, CURRENT_DATE - INTERVAL '5 days', 'Feliz', 8, 7, 8, 4, 'Finalizei projeto importante'),
(2, CURRENT_DATE - INTERVAL '10 days', 'Calmo', 7, 9, 7, 6, 'Estudando novos frameworks'),
(2, CURRENT_DATE - INTERVAL '5 days', 'Feliz', 8, 8, 8, 4, 'Consegui certificação'),
(2, CURRENT_DATE - INTERVAL '2 days', 'Estressado', 5, 11, 4, 9, 'Deadline apertado'),
(3, CURRENT_DATE - INTERVAL '8 days', 'Feliz', 8, 6, 9, 3, 'Ótimo feedback do cliente'),
(3, CURRENT_DATE - INTERVAL '4 days', 'Calmo', 7, 7, 7, 5, 'Dia produtivo'),
(3, CURRENT_DATE - INTERVAL '1 day', 'Triste', 6, 8, 5, 7, 'Projeto rejeitado');

INSERT INTO "USUARIO_COMPETENCIA" ("USUARIO_ID_USUARIO","COMPETENCIA_ID_COMPETENCIA") VALUES
(1,5),(1,10),(1,15),
(2,1),(2,4),(2,19),(2,17),
(3,9),(3,15),(3,16),
(4,2),(4,12),(4,4),(4,10),
(5,2),(5,3),(5,14),
(6,4),(6,17),
(7,15),(7,16),(7,17),
(8,1),(8,7),(8,8),(8,2),
(9,10),(9,18),(9,16),
(10,4),(10,20),(10,17),
(11,2),(11,10),(11,15),
(12,2),(12,3),(12,10);

INSERT INTO "RECOMENDACAO_PROFISSIONAL" ("ID_RECOMENDACAO","CATEGORIA_RECOMENDACAO","AREA_RECOMENDACAO","FONTE_RECOMENDACAO") VALUES
(1,'Vaga','Front-end','LinkedIn'),
(2,'Curso','Back-end','Alura'),
(3,'Vaga','DevOps','Gupy'),
(4,'Curso','UX/UI','Coursera'),
(5,'Vaga','Data Science','Glassdoor'),
(6,'Curso','Banco de Dados','Udemy'),
(7,'Vaga','Governança de TI','Indeed'),
(8,'Curso','IA','DIO'),
(9,'Vaga','Back-end','InfoJobs'),
(10,'Curso','DevOps','Microsoft Learn');

INSERT INTO "RECOMENDACAO_SAUDE" ("ID_RECOMENDACAO","TIPO_SAUDE","NIVEL_ALERTA","MENSAGEM_SAUDE") VALUES
(11,'Sono','Moderado','Estabeleça rotina de sono consistente'),
(12,'Produtividade','Baixo','Utilize a técnica Pomodoro para melhor desempenho'),
(13,'Saúde Mental','Moderado','Pratique meditação ou respiração profunda'),
(14,'Sono','Baixo','Evite dispositivos eletrônicos à noite'),
(15,'Produtividade','Alto','Diminua o ritmo quando notar fadiga mental'),
(16,'Saúde Mental','Alto','Busque ajuda psicológica se sentir ansiedade constante'),
(17,'Produtividade','Moderado','Evite interrupções frequentes durante tarefas críticas'),
(18,'Sono','Baixo','Evite cafeína após 18h e reduza estímulos antes de dormir'),
(19,'Saúde Mental','Moderado','Desconecte-se de responsabilidades após o expediente'),
(20,'Produtividade','Baixo','Reserve tempo para atividades pessoais e familiares');