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
	
	
	
	
	
	
	
	
