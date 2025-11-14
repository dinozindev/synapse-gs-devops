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
