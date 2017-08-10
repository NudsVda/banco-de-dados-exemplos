-- nota, consultas com wildcard (*) podemos fazer sem problemas diretamente no terminal SQL,
-- porém para colocar em uma VIEW ou ler esses resultados por uma linguagem de programação
-- temos que espeficar os campos para não ter repetidos

-- selecionando somente as pessoas
SELECT * FROM pessoa;

-- selecionando todos os dados da pessoa física
SELECT * FROM pessoa AS p
	INNER JOIN pessoa_fisica AS pf
		ON p.id = pf.pessoa_id;
        
-- selecionando todos os dados da pessoa jurídica
SELECT * FROM pessoa AS p
	INNER JOIN pessoa_juridica AS pj
		ON p.id = pj.pessoa_id;
        
-- selecionando tanto pessoas jurífica como física
SELECT * FROM pessoa AS p
	LEFT JOIN pessoa_fisica as pf
		ON p.id = pf.pessoa_id
	LEFT JOIN pessoa_juridica as pj
		ON p.id = pj.pessoa_id;
        
-- selecionando pessoas e seus endereco quando houver
SELECT * FROM pessoa AS p
	LEFT JOIN endereco AS e
		ON p.id = e.pessoa_id;
        
-- selecionando somente pessoas que tem endereço
SELECT * FROM pessoa AS p
	INNER JOIN endereco AS e
		ON p.id = e.pessoa_id;
        
-- selecionando todas as pessoas e endereço quando houver
SELECT * FROM pessoa AS p
	LEFT JOIN pessoa_fisica as pf
		ON p.id = pf.pessoa_id
	LEFT JOIN pessoa_juridica as pj
		ON p.id = pj.pessoa_id
	LEFT JOIN endereco as e
		ON p.id = e.pessoa_id;
        
-- consultando uma view
SELECT * FROM view_pessoas;
        
-- selecionando os endereços e as pessoas
SELECT * FROM endereco AS e
	RIGHT JOIN pessoa AS p
		ON e.pessoa_id = p.id;
        
  -- selecionando todas as pessoas que tem dados de endereço
SELECT * FROM pessoa AS p
	LEFT JOIN pessoa_fisica as pf
		ON p.id = pf.pessoa_id
	LEFT JOIN pessoa_juridica as pj
		ON p.id = pj.pessoa_id
	INNER JOIN endereco as e
		ON p.id = e.pessoa_id;      
        
-- selecionando todas as pessoas fisicas que tem usuário
SELECT * FROM pessoa_fisica as pf
	INNER JOIN usuario AS u
		ON pf.pessoa_id = u.pessoa_fisica_pessoa_id;

-- agora eu quero selecionar todos os usuários cadastrados entre 2008 e 2012
-- ele é inclusivo, as datas de início e fim são considerados
SELECT * FROM pessoa WHERE data_cadastro BETWEEN '2008-01-01' AND '2012-12-31';

-- na união o número de colunas deve ser exatamente o mesmo em cada um dos SELECTS
-- nesse caso queremos saber o id e o número do documento (cpf e cnpj)
SELECT pessoa_id, cpf as documentos FROM pessoa_fisica
	UNION
SELECT pessoa_id, cnpj FROM pessoa_juridica;

-- fazendo nossa trigger disparar
INSERT INTO pessoa_fisica (pessoa_id, cpf) VALUES (3, '0551');

-- inserindo pessoa juridica usando uma procedure
CALL insertPessoaJuridica('Casa das Capinhas','222','Capinhas do Paragua S/A');

-- insert para dar erro
CALL insertPessoaJuridica('Casa dos Carregadores',NULL,'Carrega do Paragua S/A');

-- a pessoa será inserida aqui
SELECT * FROM pessoa;

-- mas não será inserida aqui
SELECT * FROM pessoa_juridica;

-- chamando nossa procedure atômicala
CALL insertPessoaJuridicaAtomica('Casa da Bolacha',NULL,'Bolachas S/A');

-- como deu erro não está em nenhum lugar
SELECT * FROM pessoa;
SELECT * FROM pessoa_juridica;

-- fazendo certo
CALL insertPessoaJuridicaAtomica('Casa da Bolacha','232','Bolachas S/A');

-- conferindo
SELECT * FROM pessoa;
SELECT * FROM pessoa_juridica;
