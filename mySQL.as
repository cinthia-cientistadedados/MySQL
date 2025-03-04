/*vamos analisar dados sobre o preço de Venda e
Aluguel de imóveis em São Paulo.
Imagine que você é um analista de dados e foi contratado por uma empresa imobiliária deseja realizar uma filtragem dos seus imóveis à venda e para 
aluguel, com o intuito de aplicar uma campanha de marketing nestes, com as seguintes características:
● Imóveis para aluguel em São Paulo com preço abaixo de R$ 1.500,00 e
com despesa de condomínio até R$ 300,00.
● Imóveis à venda com mais de 3 quartos e pelo menos 2 banheiros.
A resolução deste exercício pode ser conferida na aula prática, através deste*/

-- primeiro exercicio
SELECT *
FROM sao_paulo.imoveis
WHERE price <= 1500 AND condo <= 300 AND negotiation_type = 'rent';

SELECT distint negociation.type FROM sao_paulo.imoveis;

-- segundo exercicio
SELECT *
FROM sao_paulo.imoveis
WHERE negotiation_type = 'sale' AND rooms >=3 AND toilets >= 2;

-- realizar Subconsultas
/* um gerente de desenvolvimento e aplicação de produto e deseja identificar clientes que têm maior probabilidade de aceitar uma nova
campanha de marketing para carnes e derivados e novos produtos de condimentos para
o preparo da mesma.● Clientes que aceitaram as últimas 3 ofertas;
● Clientes que visitaram o site mais de 15 vezes no último mês e que têm alta despesa com produtos de carne;
● Utilize o banco de dados.*/
	
	-- visão da tabela
SELECT * FROM customer.customer_data limited 10;
	
	-- clientes que aceitaram as 3 últimas ofertas
	SELECT ID  /*SELECT COUNT(ID) as qtd_aceitaram_oferta*/
	FROM customer.customer_data
	WHERE AcceptCmp3 = 1
		OR AcceptCmp4 = 1
		OR AcceptCmp5 = 1;
		
	-- Clientes que visitaram o site mais de 15 vezes no último mês e que têm alta despesa com produtos de carne;
	SELECT *
	FROM customer.customer_data
	WHERE NumWebVisitsMonth >= 15
	HAVING MntMeatProducts > (SELECT AVG(MntMeatProducts) FROM customer_data);
	
	-- Calcular Estatísiticas sobre os dados. 
/*Um investidor que deseja tomar decisões informadas sobre a compra e venda de ações do Twitter. Seu objetivo é maximizar retornos entendendo os 
padrões de comportamento dos preços  das ações ao longo do tempo. Você possui acesso a um banco de dados com os preços das ações do Twitter de 
novembro de 2013 a outubro de 2022. Você busca encontrar:
● O preço de Fechamento mais Alto e mais Baixo;
● Data do Preço de Fechamento mais Alto;
● Volume Total de Negociações em um Mês Específico;
Essas estatísticas fornecem uma visão geral do comportamento do preço das ações do Twitter. Como investidor, você pode usar essas informações para 
tomar decisões informadas sobre compra ou venda de ações. Por exemplo, saber o preço mais alto e mais baixo pode ajudar a definir pontos de entrada
 e saída para transações.*/

	-- Visão da tabela
	SELECT * FROM twitter.twitter_stocks limited 10;
	
	-- exercício 1
	SELECT MAX(Close) AS Highest_Close_Price, MIN(Close) AS Lowest_Close_Price
	FROM twitter.twitter_stocks;
	
	-- exercício 2
	SELECT Date
	FROM twitter.twitter_stocks
	WHERE Close = (SELECT MAX(Close) FROM twitter_stocks);
	
	-- exercício 3
	SELECT SUM(Volume) AS Total_Volume
	FROM twitter.twitter_stocks
	WHERE YEAR(Date) = 2022 AND MONTH(Date) = 5;
	
	-- Agrupar e Ordenar Resultados com base em Atributos.
/*Uma indústria do setor de Energia Renovável e Sustentabilidade que opera usinas hidrelétricas, 
parques eólicos e solares, está interessada em analisar os impactos ambientais dos incêndios florestais. A motivação é dupla: proteger os recursos 
naturais essenciais para a produção de energia e alinhar suas operações com práticas sustentáveis. Incêndios florestais podem afetar a vegetação 
que é crucial para manter os ecossistemas equilibrados e podem influenciar negativamente o clima local, impactando a eficiência e operação das 
instalações de energia. O intuito é agrupar e ordenar os dados de incêndios florestais para entender padrões e tendências ao longo dos anos e em 
diferentes estados. Isso ajudará a identificar áreas prioritárias para ações preventivas e mitigatórias.
● Busca-se:
○ Agrupar os dados por ano e estado para visualizar o total de incêndios por
ano em cada estado;
○ Ordenar os dados para identificar quais estados enfrentam mais incêndios;
○ Agrupar os dados por mês para entender a sazonalidade dos incêndios
florestais.
A análise irá ajudar na:
● Identificação de Tendências: saber quais anos e estados enfrentaram mais
incêndios pode ajudar a direcionar esforços de mitigação e prevenção;
● Alocação de Recursos: identificar estados mais afetados permite uma alocação
mais eficiente de recursos para combate e prevenção de incêndios;
● Planejamento Sazonal: entender a sazonalidade dos incêndios ajuda a planejar
ações preventivas em períodos críticos.*/
	-- exercicio 4
	-- Visão da tabela
	SELECT * FROM fire.brazilianfiredataset limited 10;
	
	-- exercicio 1
	SELECT Year, State, SUM(Number_of_Fires) AS Total_Fires
	FROM fire.brazilianfiredataset
	GROUP BY Year, State
	ORDER BY Year, State;
	
	-- exercício 2
	SELECT State, SUM(Number_of_Fires) AS Total_Fires
	FROM fire.brazilianfiredataset
	GROUP BY State
	ORDER BY Total_Fires DESC
	LIMITED 5; /*pode tirar o LIMITED*/
	
	-- exercício 3
	SELECT Month, SUM(Number_of_Fires) AS Total_Fires
	FROM fire.brazilianfiredataset
	GROUP BY Month
	ORDER BY FIELD(Month, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November','December');
	
	
-- criação do database
CREATE DATABASE netflix;

-- seleção do database
USE netflix;

-- criação de tabela 
CREATE TABLE Engagement (
    Title VARCHAR(500),
    Available_Globally VARCHAR(3),
    Release_Date VARCHAR(50),
    Hours_Viewed DOUBLE
);

CREATE TABLE Titles (
    show_id VARCHAR(10),
    type VARCHAR(10),
    title VARCHAR(500),
    director VARCHAR(255),
    cast TEXT,
    country VARCHAR(500),
    date_added VARCHAR(50), 
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in TEXT,
    description TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/engagement.csv'
INTO TABLE Engagement
CHARACTER SET 'latin1' -- ou 'latin1' dependendo da codificação do arquivo
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@Title, @Available_Globally, @Release_Date, @Hours_Viewed)
SET
    Title = NULLIF(@Title, 'NA'),
    Available_Globally = NULLIF(@Available_Globally, 'NA'),
    Release_Date = STR_TO_DATE(NULLIF(@Release_Date, 'NA'), '%Y-%m-%d'),
    Hours_Viewed = IF(@Hours_Viewed REGEXP '^-?[0-9]+(\.[0-9]*)?$', NULLIF(@Hours_Viewed, 'NA'), NULL);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/titles.csv'
INTO TABLE Titles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(show_id, type, title, director, cast, country, @date_added, release_year, rating, duration, listed_in, description)
SET 
    -- show_id = NULLIF(@show_id, 'NA'),
    -- type = NULLIF(@type, 'NA'),
    -- title = NULLIF(@title, 'NA'),
    -- director = NULLIF(@director, 'NA'),
    -- cast = NULLIF(@cast, 'NA'),
    -- country = NULLIF(@country, 'NA'),
    date_added = NULLIF(@date_added, 'NA');
    -- release_year = NULLIF(@release_year, 'NA'),
    -- rating = NULLIF(@rating, 'NA'),
    -- duration = NULLIF(@duration, 'NA'),
    -- listed_in = NULLIF(@listed_in, 'NA'),
    -- description = NULLIF(@description, 'NA');

SELECT * FROM netflix limited 10;

SELECT t.show_id, t.title, t.type, t.director, t.cast, t.country, t.date_added, t.release_year, t.rating, t.duration, t.listed_in, t.description, e.Hours_Viewed
FROM netflix.titles t
INNER JOIN netflix.engagement e ON t.title = e.Title;

SELECT t.show_id, t.title, t.type, t.director, t.cast, t.country, t.date_added, t.release_year, t.rating, t.duration, t.listed_in, t.description, e.Hours_Viewed
FROM netflix.titles t
RIGHT JOIN netflix.engagement e ON t.title = e.Title;

SELECT t.show_id, t.title, t.type, t.director, t.cast, t.country, t.date_added, t.release_year, t.rating, t.duration, t.listed_in, t.description, e.Hours_Viewed
FROM netflix.titles t
LEFT JOIN netflix.engagement e ON t.title = e.Title
UNION
SELECT t.show_id, t.title, t.type, t.director, t.cast, t.country, t.date_added, t.release_year, t.rating, t.duration, t.listed_in, t.description, e.Hours_Viewed
FROM netflix.titles t
RIGHT JOIN netflix.engagement e ON t.title = e.Title;
	
	
	
	
-- criação do database
CREATE DATABASE shopping;

-- seleção do database
USE shopping;

-- criação de tabela 
CREATE TABLE shopping_data (
    CustomerID VARCHAR(50),
    Genre VARCHAR(255),
    Age INT,
    Income double,
    Spending_score INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shopping_data.csv'
INTO TABLE shopping_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@CustomerID, @Genre, @Age, @Income, @Spending_score)
SET
    CustomerID = NULLIF(@CustomerID, 'NA'),
    Genre = NULLIF(@Genre, 'NA'),
    Age = NULLIF(@Age, 'NA'),
    Income = NULLIF(@Income, 'NA'),
    Spending_score = NULLIF(@Spending_score, 'NA');
	
-- Visão da tabela
SELECT * FROM shopping.shopping_data limited 10;
    
UPDATE shopping.shopping_data
SET Income = Income * 1.10
WHERE Spending_Score > 70;

DELETE FROM shopping.shopping_data
WHERE Spending_Score < 40;

select * from shopping.shopping_data where Spending_score < 40	
