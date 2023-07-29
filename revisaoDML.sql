create database loja;

use loja;

/* SELECT FROM WHERE */

/*Exiba todos os clientes*/
select * 
from clientes;

/*Exiba o nome, sexo e salário de todos os vendedores*/
select nome, sexo, salario
from vendedores;

/*Exiba o cpf, nome e nascimento de todos os clientes do sexo feminino.*/
select cpf, nome, nascimento
from clientes
where sexo = 'f';

/*Exiba os clientes que recebem um salário maior do que uma vez e meia o
salário mínimo vigente*/
select *
from clientes
where salario > 1.5 * 1320;

/*Exiba os clientes que não informaram o sexo ou o salário*/
select *
from clientes
where sexo is null or salario is null;

/*Exiba todas as cliente ordenando as datas de nascimento do menor valor para o maior*/
select *
from clientes
order by nascimento;

/*Exiba o nome e o preço dos cinco produtos a partir do 20º*/
select nome, preco, numero
from produtos
order by numero asc
limit 20, 5;

/*Quais são os tipos de status existentes para compras?*/
select distinct status
from compras;

/*Exiba as compras realizadas entre 01/01/2021 e 03/01/2021 que não foram 
suspensas nem canceladas*/
select *
from compras
where data between '2021-01-01' and '2021-01-03' and (status <> 'cancelado' and status <> 'suspenso');

/*Exiba todas os vendedores cujo primeiro nome começa com a letra ‘L’ e o segundo 
com a letra ‘M’*/ 
select *
from vendedores
where nome like 'L% M%';

/* MANIPULAÇÃO DE DATA E HORA */

/*Precisamos de uma lista dos aniversariantes do mês que vem.*/
select *
from clientes
where month(nascimento) = month(now() + interval 1 month);

/*Exiba uma lista com código e cpf das vendas realizadas há no máximo 3 meses.*/
select codigo, cpf, data
from compras
where data >= now() - interval 3 month;

/*Exiba uma lista com código e cpf das vendas realizadas há pelo menos 3 meses que
não foram canceladas ou devolvidas*/
select codigo, cpf, data, status
from compras
where data <= now() - interval 3 month and (status <> 'devolvido' and status <> 'cancelado');

/*Exiba uma lista com código, cpf e a quantidade de produtos das vendas realizadas
há pelo menos um ano, no período da manhã e que possuem o caractere ‘%’ no
campo status*/
select codigo, cpf, quantidade
from compras
where data <= now() - interval 1 year and 
(hora between '06:00:00' and '11:59:59') and
status like '%\%%';

/* FUNÇÃO DE AGREGAÇÃO */

/*Exiba a quantidade de clientes do sexo masculino*/
select count(*)
from clientes
where sexo = 'm';

/*Exiba a quantidade de compras realizadas no ano corrente*/
select count(*)
from compras;

/*Exiba a somatória e o salário médio dos vendedores que possuem entre 30 e
45 anos*/
select sum(salario) as somaSalario, avg(salario) as mediaSalario
from vendedores
where (year(now()) - year(nascimento) >= 30) and (year(now()) - year(nascimento) <= 45);  

/*Exiba soma das compras canceladas ou devolvidas*/
select sum(quantidade) 
from compras
where status = 'cancelado' or
status = 'devolvido';

/*Exiba a maior e a menor idade dos clientes.*/
select min(year(now()) - year(nascimento)) as menorIdade, max(year(now()) - year(nascimento)) as maiorIdade
from clientes;