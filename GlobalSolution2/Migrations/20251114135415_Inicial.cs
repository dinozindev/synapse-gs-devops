using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace GlobalSolution2.Migrations
{
    /// <inheritdoc />
    public partial class Inicial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "COMPETENCIA",
                columns: table => new
                {
                    ID_COMPETENCIA = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    NOME_COMPETENCIA = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    CATEGORIA_COMPETENCIA = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    DESCRICAO_COMPETENCIA = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("COMPETENCIA_PK", x => x.ID_COMPETENCIA);
                });

            migrationBuilder.Sql(@"
            INSERT INTO ""COMPETENCIA"" (""NOME_COMPETENCIA"", ""CATEGORIA_COMPETENCIA"", ""DESCRICAO_COMPETENCIA"") VALUES
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
            ");

            migrationBuilder.CreateTable(
                name: "USUARIO",
                columns: table => new
                {
                    ID_USUARIO = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    NOME_USUARIO = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    SENHA_USUARIO = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    AREA_ATUAL = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    AREA_INTERESSE = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    OBJETIVO_CARREIRA = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: false),
                    NIVEL_EXPERIENCIA = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("USUARIO_PK", x => x.ID_USUARIO);
                });

            migrationBuilder.Sql("ALTER TABLE \"USUARIO\" ADD CONSTRAINT CHK_NIVEL_EXPERIENCIA CHECK (\"NIVEL_EXPERIENCIA\" IN ('Nenhuma', 'Estagiário', 'Júnior', 'Sênior', 'Pleno'))");

            migrationBuilder.Sql(@"
            INSERT INTO ""USUARIO"" (""NOME_USUARIO"", ""SENHA_USUARIO"", ""AREA_ATUAL"", ""AREA_INTERESSE"", ""OBJETIVO_CARREIRA"", ""NIVEL_EXPERIENCIA"") VALUES
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
            ");

            migrationBuilder.CreateTable(
                name: "RECOMENDACAO",
                columns: table => new
                {
                    ID_RECOMENDACAO = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    DATA_RECOMENDACAO = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    DESCRICAO_RECOMENDACAO = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: false),
                    PROMPT_USADO = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: false),
                    TITULO_RECOMENDACAO = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    USUARIO_ID_USUARIO = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("RECOMENDACAO_PK", x => x.ID_RECOMENDACAO);
                    table.ForeignKey(
                        name: "RECOMENDACAO_USUARIO_FK",
                        column: x => x.USUARIO_ID_USUARIO,
                        principalTable: "USUARIO",
                        principalColumn: "ID_USUARIO",
                        onDelete: ReferentialAction.Cascade);
                });
            
            migrationBuilder.Sql(@"
            INSERT INTO ""RECOMENDACAO"" (""USUARIO_ID_USUARIO"", ""DATA_RECOMENDACAO"", ""TITULO_RECOMENDACAO"", ""DESCRICAO_RECOMENDACAO"", ""PROMPT_USADO"") VALUES
            -- Recomendações Profissionais (IDs 1-10)
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
            -- Recomendações de Saúde (IDs 11-20)
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
        ");

            migrationBuilder.CreateTable(
                name: "REGISTRO_BEM_ESTAR",
                columns: table => new
                {
                    ID_REGISTRO = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    DATA_REGISTRO = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    HUMOR_REGISTRO = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false),
                    HORAS_SONO = table.Column<int>(type: "integer", precision: 2, scale: 0, nullable: false),
                    HORAS_TRABALHO = table.Column<int>(type: "integer", precision: 2, scale: 0, nullable: false),
                    NIVEL_ENERGIA = table.Column<int>(type: "integer", precision: 2, scale: 0, nullable: false),
                    NIVEL_ESTRESSE = table.Column<int>(type: "integer", precision: 2, scale: 0, nullable: false),
                    OBSERVACAO_REGISTRO = table.Column<string>(type: "character varying(255)", maxLength: 255, nullable: true),
                    USUARIO_ID_USUARIO = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("REGISTRO_BEM_ESTAR_PK", x => x.ID_REGISTRO);
                    table.ForeignKey(
                        name: "REGISTRO_BEM_ESTAR_USUARIO_FK",
                        column: x => x.USUARIO_ID_USUARIO,
                        principalTable: "USUARIO",
                        principalColumn: "ID_USUARIO",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.Sql("ALTER TABLE \"REGISTRO_BEM_ESTAR\" ADD CONSTRAINT CHK_HUMOR_REGISTRO CHECK (\"HUMOR_REGISTRO\" IN ('Feliz', 'Triste', 'Estressado', 'Bravo', 'Calmo'))");

            migrationBuilder.Sql(@"
            INSERT INTO ""REGISTRO_BEM_ESTAR"" (""USUARIO_ID_USUARIO"", ""DATA_REGISTRO"", ""HUMOR_REGISTRO"", ""HORAS_SONO"", ""HORAS_TRABALHO"", ""NIVEL_ENERGIA"", ""NIVEL_ESTRESSE"", ""OBSERVACAO_REGISTRO"") VALUES
            -- Maria Silva (ID 1)
            (1, CURRENT_DATE - INTERVAL '7 days', 'Estressado', 6, 10, 5, 8, 'Muita demanda no trabalho'),
            (1, CURRENT_DATE - INTERVAL '6 days', 'Calmo', 7, 8, 7, 5, 'Dia mais tranquilo'),
            (1, CURRENT_DATE - INTERVAL '5 days', 'Feliz', 8, 7, 8, 4, 'Finalizei projeto importante'),
            -- João Santos (ID 2)
            (2, CURRENT_DATE - INTERVAL '10 days', 'Calmo', 7, 9, 7, 6, 'Estudando novos frameworks'),
            (2, CURRENT_DATE - INTERVAL '5 days', 'Feliz', 8, 8, 8, 4, 'Consegui certificação'),
            (2, CURRENT_DATE - INTERVAL '2 days', 'Estressado', 5, 11, 4, 9, 'Deadline apertado'),
            -- Ana Costa (ID 3)
            (3, CURRENT_DATE - INTERVAL '8 days', 'Feliz', 8, 6, 9, 3, 'Ótimo feedback do cliente'),
            (3, CURRENT_DATE - INTERVAL '4 days', 'Calmo', 7, 7, 7, 5, 'Dia produtivo'),
            (3, CURRENT_DATE - INTERVAL '1 day', 'Triste', 6, 8, 5, 7, 'Projeto rejeitado'),
            -- Pedro Oliveira (ID 4)
            (4, CURRENT_DATE - INTERVAL '9 days', 'Estressado', 5, 12, 3, 9, 'Bug crítico em produção'),
            (4, CURRENT_DATE - INTERVAL '6 days', 'Calmo', 7, 8, 6, 6, 'Bug resolvido'),
            (4, CURRENT_DATE - INTERVAL '3 days', 'Feliz', 8, 7, 8, 4, 'Elogio do tech lead'),
            -- Julia Ferreira (ID 5)
            (5, CURRENT_DATE - INTERVAL '7 days', 'Feliz', 8, 6, 8, 3, 'Aprendendo muito'),
            (5, CURRENT_DATE - INTERVAL '4 days', 'Estressado', 6, 9, 5, 7, 'Muitas tarefas novas'),
            (5, CURRENT_DATE - INTERVAL '1 day', 'Calmo', 7, 7, 7, 5, 'Adaptando ao ritmo'),
            -- Carlos Mendes (ID 6)
            (6, CURRENT_DATE - INTERVAL '10 days', 'Calmo', 7, 0, 8, 2, 'Estudando em casa'),
            (6, CURRENT_DATE - INTERVAL '5 days', 'Feliz', 8, 0, 9, 2, 'Progresso nos estudos'),
            -- Fernanda Lima (ID 7)
            (7, CURRENT_DATE - INTERVAL '8 days', 'Estressado', 6, 11, 5, 8, 'Muitas reuniões'),
            (7, CURRENT_DATE - INTERVAL '3 days', 'Calmo', 7, 9, 7, 6, 'Dia administrativo'),
            -- Ricardo Alves (ID 8)
            (8, CURRENT_DATE - INTERVAL '6 days', 'Feliz', 8, 8, 8, 4, 'Modelo ML funcionando'),
            (8, CURRENT_DATE - INTERVAL '2 days', 'Estressado', 5, 10, 4, 8, 'Ajustando hiperparâmetros'),
            -- Beatriz Rocha (ID 9)
            (9, CURRENT_DATE - INTERVAL '7 days', 'Calmo', 7, 8, 7, 5, 'Automatizando testes'),
            (9, CURRENT_DATE - INTERVAL '3 days', 'Feliz', 8, 7, 8, 4, 'Pipeline CI/CD OK'),
            -- Lucas Martins (ID 10)
            (10, CURRENT_DATE - INTERVAL '9 days', 'Calmo', 7, 8, 7, 6, 'Análise de dados'),
            (10, CURRENT_DATE - INTERVAL '4 days', 'Feliz', 8, 7, 9, 3, 'Dashboard aprovado');
        ");
            
            migrationBuilder.CreateTable(
                name: "USUARIO_COMPETENCIA",
                columns: table => new
                {
                    USUARIO_ID_USUARIO = table.Column<int>(type: "integer", nullable: false),
                    COMPETENCIA_ID_COMPETENCIA = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("USUARIO_COMPETENCIA_PK", x => new { x.USUARIO_ID_USUARIO, x.COMPETENCIA_ID_COMPETENCIA });
                    table.ForeignKey(
                        name: "USUARIO_COMP_COMPETENCIA_FK",
                        column: x => x.COMPETENCIA_ID_COMPETENCIA,
                        principalTable: "COMPETENCIA",
                        principalColumn: "ID_COMPETENCIA",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "USUARIO_COMP_USUARIO_FK",
                        column: x => x.USUARIO_ID_USUARIO,
                        principalTable: "USUARIO",
                        principalColumn: "ID_USUARIO",
                        onDelete: ReferentialAction.Cascade);
                });
            
             migrationBuilder.Sql(@"
            INSERT INTO ""USUARIO_COMPETENCIA"" (""USUARIO_ID_USUARIO"", ""COMPETENCIA_ID_COMPETENCIA"") VALUES
            -- Maria Silva (ID 1)
            (1, 5),   -- Docker
            (1, 10),  -- Git
            (1, 15),  -- Comunicação
            -- João Santos (ID 2)
            (2, 1),   -- Python
            (2, 4),   -- SQL
            (2, 19),  -- Pandas
            (2, 17),  -- Resolução de Problemas
            -- Ana Costa (ID 3)
            (3, 9),   -- Figma
            (3, 15),  -- Comunicação
            (3, 16),  -- Trabalho em Equipe
            -- Pedro Oliveira (ID 4)
            (4, 2),   -- JavaScript
            (4, 12),  -- Node.js
            (4, 4),   -- SQL
            (4, 10),  -- Git
            -- Julia Ferreira (ID 5)
            (5, 2),   -- JavaScript
            (5, 3),   -- React
            (5, 14),  -- TypeScript
            -- Carlos Mendes (ID 6)
            (6, 4),   -- SQL
            (6, 17),  -- Resolução de Problemas
            -- Fernanda Lima (ID 7)
            (7, 15),  -- Comunicação
            (7, 16),  -- Trabalho em Equipe
            (7, 17),  -- Resolução de Problemas
            -- Ricardo Alves (ID 8)
            (8, 1),   -- Python
            (8, 7),   -- Machine Learning
            (8, 8),   -- TensorFlow
            (8, 2),   -- JavaScript
            -- Beatriz Rocha (ID 9)
            (9, 10),  -- Git
            (9, 18),  -- Jenkins
            (9, 16),  -- Trabalho em Equipe
            -- Lucas Martins (ID 10)
            (10, 4),  -- SQL
            (10, 20), -- Power BI
            (10, 17), -- Resolução de Problemas
            -- Camila Souza (ID 11)
            (11, 2),  -- JavaScript
            (11, 10), -- Git
            (11, 15), -- Comunicação
            -- Rafael Dias (ID 12)
            (12, 2),  -- JavaScript
            (12, 3),  -- React
            (12, 10); -- Git
        ");

            migrationBuilder.CreateTable(
                name: "RECOMENDACAO_PROFISSIONAL",
                columns: table => new
                {
                    ID_RECOMENDACAO = table.Column<int>(type: "integer", nullable: false),
                    CATEGORIA_RECOMENDACAO = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    AREA_RECOMENDACAO = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    FONTE_RECOMENDACAO = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("RECOMENDACAO_PROFISSIONAL_PK", x => x.ID_RECOMENDACAO);
                    table.ForeignKey(
                        name: "RECOMENDACAO_PROFISSIONAL_FK",
                        column: x => x.ID_RECOMENDACAO,
                        principalTable: "RECOMENDACAO",
                        principalColumn: "ID_RECOMENDACAO",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.Sql("ALTER TABLE \"RECOMENDACAO_PROFISSIONAL\" ADD CONSTRAINT CHK_CATEGORIA_RECOMENDACAO CHECK (\"CATEGORIA_RECOMENDACAO\" IN ('Vaga', 'Curso'))");

            migrationBuilder.Sql("ALTER TABLE \"RECOMENDACAO_PROFISSIONAL\" ADD CONSTRAINT CHK_AREA_RECOMENDACAO CHECK (\"AREA_RECOMENDACAO\" IN ('Front-end', 'Back-end', 'DevOps', 'UX/UI', 'Data Science', 'Banco de Dados', 'Governança de TI', 'IA'))");

            migrationBuilder.Sql(@"
            INSERT INTO ""RECOMENDACAO_PROFISSIONAL"" (""ID_RECOMENDACAO"", ""CATEGORIA_RECOMENDACAO"", ""AREA_RECOMENDACAO"", ""FONTE_RECOMENDACAO"") VALUES
            (1, 'Vaga', 'Front-end', 'LinkedIn'),
            (2, 'Curso', 'Back-end', 'Alura'),
            (3, 'Vaga', 'DevOps', 'Gupy'),
            (4, 'Curso', 'UX/UI', 'Coursera'),
            (5, 'Vaga', 'Data Science', 'Glassdoor'),
            (6, 'Curso', 'Banco de Dados', 'Udemy'),
            (7, 'Vaga', 'Governança de TI', 'Indeed'),
            (8, 'Curso', 'IA', 'DIO'),
            (9, 'Vaga', 'Back-end', 'InfoJobs'),
            (10, 'Curso', 'DevOps', 'Microsoft Learn');
        ");

            migrationBuilder.CreateTable(
                name: "RECOMENDACAO_SAUDE",
                columns: table => new
                {
                    ID_RECOMENDACAO = table.Column<int>(type: "integer", nullable: false),
                    TIPO_SAUDE = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    NIVEL_ALERTA = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    MENSAGEM_SAUDE = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("RECOMENDACAO_SAUDE_PK", x => x.ID_RECOMENDACAO);
                    table.ForeignKey(
                        name: "RECOMENDACAO_SAUDE_FK",
                        column: x => x.ID_RECOMENDACAO,
                        principalTable: "RECOMENDACAO",
                        principalColumn: "ID_RECOMENDACAO",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.Sql("ALTER TABLE \"RECOMENDACAO_SAUDE\" ADD CONSTRAINT CHK_TIPO_SAUDE CHECK (\"TIPO_SAUDE\" IN ('Sono', 'Produtividade', 'Saúde Mental'))");

            migrationBuilder.Sql("ALTER TABLE \"RECOMENDACAO_SAUDE\" ADD CONSTRAINT CHK_NIVEL_ALERTA CHECK (\"NIVEL_ALERTA\" IN ('Baixo', 'Moderado', 'Alto'))");

            migrationBuilder.Sql(@"
            INSERT INTO ""RECOMENDACAO_SAUDE"" (""ID_RECOMENDACAO"", ""TIPO_SAUDE"", ""NIVEL_ALERTA"", ""MENSAGEM_SAUDE"") VALUES
            (11, 'Sono', 'Moderado', 'Estabeleça rotina de sono consistente'),
            (12, 'Produtividade', 'Baixo', 'Utilize a técnica Pomodoro para melhor desempenho'),
            (13, 'Saúde Mental', 'Moderado', 'Pratique meditação ou respiração profunda'),
            (14, 'Sono', 'Baixo', 'Evite dispositivos eletrônicos à noite'),
            (15, 'Produtividade', 'Alto', 'Diminua o ritmo quando notar fadiga mental'),
            (16, 'Saúde Mental', 'Alto', 'Busque ajuda psicológica se sentir ansiedade constante'),
            (17, 'Produtividade', 'Moderado', 'Evite interrupções frequentes durante tarefas críticas'),
            (18, 'Sono', 'Baixo', 'Evite cafeína após 18h e reduza estímulos antes de dormir'),
            (19, 'Saúde Mental', 'Moderado', 'Desconecte-se de responsabilidades após o expediente'),
            (20, 'Produtividade', 'Baixo', 'Reserve tempo para atividades pessoais e familiares');
        ");

            migrationBuilder.CreateIndex(
                name: "IX_RECOMENDACAO_USUARIO_ID_USUARIO",
                table: "RECOMENDACAO",
                column: "USUARIO_ID_USUARIO");

            migrationBuilder.CreateIndex(
                name: "IX_REGISTRO_BEM_ESTAR_USUARIO_ID_USUARIO",
                table: "REGISTRO_BEM_ESTAR",
                column: "USUARIO_ID_USUARIO");

            migrationBuilder.CreateIndex(
                name: "NOME_UNIQUE",
                table: "USUARIO",
                column: "NOME_USUARIO",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_USUARIO_COMPETENCIA_COMPETENCIA_ID_COMPETENCIA",
                table: "USUARIO_COMPETENCIA",
                column: "COMPETENCIA_ID_COMPETENCIA");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "RECOMENDACAO_PROFISSIONAL");

            migrationBuilder.DropTable(
                name: "RECOMENDACAO_SAUDE");

            migrationBuilder.DropTable(
                name: "REGISTRO_BEM_ESTAR");

            migrationBuilder.DropTable(
                name: "USUARIO_COMPETENCIA");

            migrationBuilder.DropTable(
                name: "RECOMENDACAO");

            migrationBuilder.DropTable(
                name: "COMPETENCIA");

            migrationBuilder.DropTable(
                name: "USUARIO");
        }
    }
}
