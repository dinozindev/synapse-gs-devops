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
CREATE TABLE competencia (
    id_competencia        BIGSERIAL PRIMARY KEY,
    nome_competencia      VARCHAR(100) NOT NULL,  -- Ex: TypeScript, Comunicação
    categoria_competencia VARCHAR(50)  NOT NULL,  -- Ex: Soft Skills, Back-end
    descricao_competencia VARCHAR(255) NOT NULL   -- Justificativa escrita pelo usuário
);


/* ============================================================
   TABELA: USUARIO
   ============================================================ */
CREATE TABLE usuario (
    id_usuario        BIGSERIAL PRIMARY KEY,
    nome_usuario      VARCHAR(100) NOT NULL,       -- Nome de login
    senha_usuario     VARCHAR(255) NOT NULL,       -- Senha criptografada
    area_atual        VARCHAR(100) NOT NULL,       -- Área atual do usuário
    area_interesse    VARCHAR(100) NOT NULL,       -- Área desejada
    objetivo_carreira VARCHAR(255) NOT NULL,       -- Objetivo profissional
    nivel_experiencia VARCHAR(50)  NOT NULL,       -- Nível de experiência
    CONSTRAINT chk_nivel_experiencia CHECK (
        nivel_experiencia IN ('Nenhuma','Estagiário','Júnior','Pleno','Sênior')
    ),
    CONSTRAINT usuario_nome_unique UNIQUE (nome_usuario)
);


/* ============================================================
   TABELA: RECOMENDACAO (SUPERCLASSE)
   ============================================================ */
CREATE TABLE recomendacao (
    id_recomendacao        BIGSERIAL PRIMARY KEY,
    data_recomendacao      DATE         NOT NULL,
    descricao_recomendacao VARCHAR(1000) NOT NULL,  -- Retorno da IA
    prompt_usado           VARCHAR(1000) NOT NULL,  -- Prompt usado
    titulo_recomendacao    VARCHAR(100)  NOT NULL,  -- Título da recomendação
    usuario_id_usuario     BIGINT,                  -- FK para usuário
    CONSTRAINT recomendacao_usuario_fk FOREIGN KEY (usuario_id_usuario)
        REFERENCES usuario (id_usuario)
);


/* ============================================================
   TABELA: RECOMENDACAO_PROFISSIONAL (SUBCLASSE)
   ============================================================ */
CREATE TABLE recomendacao_profissional (
    id_recomendacao        BIGINT PRIMARY KEY,      -- FK para recomendacao
    categoria_recomendacao VARCHAR(50)  NOT NULL,  -- Vaga ou Curso
    area_recomendacao      VARCHAR(100) NOT NULL,  -- Área recomendada
    fonte_recomendacao     VARCHAR(100) NOT NULL,  -- Fonte da IA
    CONSTRAINT chk_categoria_recomendacao CHECK (
        categoria_recomendacao IN ('Vaga','Curso')
    ),
    CONSTRAINT chk_area_recomendacao CHECK (
        area_recomendacao IN (
            'Front-end','Back-end','DevOps','UX/UI',
            'Data Science','Banco de Dados','Governança de TI','IA'
        )
    ),
    CONSTRAINT recomendacao_profissional_fk FOREIGN KEY (id_recomendacao)
        REFERENCES recomendacao (id_recomendacao)
);


/* ============================================================
   TABELA: RECOMENDACAO_SAUDE (SUBCLASSE)
   ============================================================ */
CREATE TABLE recomendacao_saude (
    id_recomendacao BIGINT PRIMARY KEY,             -- FK para recomendacao
    tipo_saude      VARCHAR(50)  NOT NULL,         -- Tipo do problema
    nivel_alerta    VARCHAR(50)  NOT NULL,         -- Baixo, Moderado, Alto
    mensagem_saude  VARCHAR(1000) NOT NULL,        -- Recomendações da IA
    CONSTRAINT chk_tipo_saude CHECK (
        tipo_saude IN ('Sono','Produtividade','Saúde Mental')
    ),
    CONSTRAINT chk_nivel_alerta CHECK (
        nivel_alerta IN ('Baixo','Moderado','Alto')
    ),
    CONSTRAINT recomendacao_saude_fk FOREIGN KEY (id_recomendacao)
        REFERENCES recomendacao (id_recomendacao)
);


/* ============================================================
   TABELA: REGISTRO_BEM_ESTAR
   ============================================================ */
CREATE TABLE registro_bem_estar (
    id_registro         BIGSERIAL PRIMARY KEY,
    data_registro       DATE         NOT NULL,
    humor_registro      VARCHAR(20)  NOT NULL,    -- Feliz, Triste, Estressado, etc.
    horas_sono          SMALLINT     NOT NULL,    -- Quantidade de horas dormidas
    horas_trabalho      SMALLINT     NOT NULL,    -- Quantidade de horas trabalhadas
    nivel_energia       SMALLINT     NOT NULL,    -- 1 a 10
    nivel_estresse      SMALLINT     NOT NULL,    -- 1 a 10
    observacao_registro VARCHAR(255),             -- Observações adicionais
    usuario_id_usuario  BIGINT,
    CONSTRAINT chk_humor_registro CHECK (
        humor_registro IN ('Feliz','Triste','Estressado','Bravo','Calmo')
    ),
    CONSTRAINT registro_bem_estar_usuario_fk FOREIGN KEY (usuario_id_usuario)
        REFERENCES usuario (id_usuario)
);


/* ============================================================
   TABELA: USUARIO_COMPETENCIA (N:N)
   ============================================================ */
CREATE TABLE usuario_competencia (
    usuario_id_usuario         BIGINT NOT NULL,
    competencia_id_competencia BIGINT NOT NULL,
    CONSTRAINT usuario_competencia_pk PRIMARY KEY (
        usuario_id_usuario,
        competencia_id_competencia
    ),
    CONSTRAINT usuario_comp_usuario_fk FOREIGN KEY (usuario_id_usuario)
        REFERENCES usuario (id_usuario),
    CONSTRAINT usuario_comp_competencia_fk FOREIGN KEY (competencia_id_competencia)
        REFERENCES competencia (id_competencia)
);

INSERT INTO competencia (nome_competencia, categoria_competencia, descricao_competencia) VALUES
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

INSERT INTO usuario (nome_usuario, senha_usuario, area_atual, area_interesse, objetivo_carreira, nivel_experiencia) VALUES
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

INSERT INTO recomendacao (usuario_id_usuario, data_recomendacao, titulo_recomendacao, descricao_recomendacao, prompt_usado) VALUES
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

INSERT INTO registro_bem_estar (usuario_id_usuario, data_registro, humor_registro, horas_sono, horas_trabalho, nivel_energia, nivel_estresse, observacao_registro) VALUES
(1, CURRENT_DATE - INTERVAL '7 days', 'Estressado', 6, 10, 5, 8, 'Muita demanda no trabalho'),
(1, CURRENT_DATE - INTERVAL '6 days', 'Calmo', 7, 8, 7, 5, 'Dia mais tranquilo'),
(1, CURRENT_DATE - INTERVAL '5 days', 'Feliz', 8, 7, 8, 4, 'Finalizei projeto importante'),
(2, CURRENT_DATE - INTERVAL '10 days', 'Calmo', 7, 9, 7, 6, 'Estudando novos frameworks'),
(2, CURRENT_DATE - INTERVAL '5 days', 'Feliz', 8, 8, 8, 4, 'Consegui certificação'),
(2, CURRENT_DATE - INTERVAL '2 days', 'Estressado', 5, 11, 4, 9, 'Deadline apertado'),
(3, CURRENT_DATE - INTERVAL '8 days', 'Feliz', 8, 6, 9, 3, 'Ótimo feedback do cliente'),
(3, CURRENT_DATE - INTERVAL '4 days', 'Calmo', 7, 7, 7, 5, 'Dia produtivo'),
(3, CURRENT_DATE - INTERVAL '1 day', 'Triste', 6, 8, 5, 7, 'Projeto rejeitado');

INSERT INTO usuario_competencia (usuario_id_usuario, competencia_id_competencia) VALUES
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

INSERT INTO recomendacao_profissional (id_recomendacao, categoria_recomendacao, area_recomendacao, fonte_recomendacao) VALUES
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

INSERT INTO recomendacao_saude (id_recomendacao, tipo_saude, nivel_alerta, mensagem_saude) VALUES
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