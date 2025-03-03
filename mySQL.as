/*vamos analisar dados sobre o preço de Venda e
Aluguel de imóveis em São Paulo.
Imagine que você é um analista de dados e foi contratado por uma empresa imobiliária deseja realizar uma filtragem dos seus imóveis à venda e para aluguel, com o
intuito de aplicar uma campanha de marketing nestes, com as seguintes características:
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
	
	