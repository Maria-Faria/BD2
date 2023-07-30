use loja;

/*INNER JOIN*/

/*Exiba todas as compras feitas pelos clientes*/
select *
from compras;

/*Exiba todos os produtos vendidos*/
select *
from produtos;

/*Exiba o cpf e nome dos clientes bem como o nome dos vendedores que 
realizaram suas compras*/
select clientes.cpf as clienteCPF, clientes.nome as cliente, vendedores.nome as vendedor
from clientes inner join compras on clientes.cpf = compras.cpf
              inner join vendedores on vendedores.registro = compras.registro;
              
/*Exiba o cpf e nome dos clientes e o nome e preço dos produtos que eles 
compraram*/
select clientes.cpf as clienteCPF, clientes.nome as cliente, produtos.nome as produto, produtos.preco as preco
from clientes inner join compras on clientes.cpf = compras.cpf
              inner join produtos on produtos.numero = compras.numero;
              
/* Exiba o cpf, nome dos clientes, nome do vendedor e nome do produto de 
todas as compras realizadas*/
select clientes.cpf as clienteCPF, clientes.nome as cliente, vendedores.nome as vendedor, produtos.nome as produto
from clientes inner join compras on clientes.cpf = compras.cpf
              inner join vendedores on vendedores.registro = compras.registro
              inner join produtos on produtos.numero = compras.numero;
              
/*Exiba todas as compras feitas pelos clientes cpf 85792570884*/
select *
from compras inner join clientes on compras.cpf = clientes.cpf
where clientes.cpf = 85792570884;

/* Exiba todas as vendas feitas pelo vendedor 145*/
select *
from compras inner join vendedores on compras.registro = vendedores.registro
where vendedores.registro = 145;

/*Exiba todos os dados das compras realizadas pela cliente Decca Kinnon ou 
pelo cliente Birch Mulloch*/
select * 
from compras inner join clientes on compras.cpf = clientes.cpf
where clientes.nome = "Decca Kinnon" or clientes.nome = "Birch Mulloch";

/*Exiba todos os clientes que compraram um celular Nokia*/
select *
from clientes inner join compras on clientes.cpf = compras.cpf
              inner join produtos on produtos.numero = compras.numero
where produtos.nome like "%nokia%";

/*Exiba todos os clientes que gastaram mais de R$ 2000,00 em produtos na 
loja*/
select clientes.nome as cliente, produtos.nome as produto, preco, compras.quantidade as qtd, compras.codigo as codigo
from clientes inner join compras on clientes.cpf = compras.cpf
			  inner join produtos on produtos.numero = compras.numero
where produtos.preco * compras.quantidade > 2000;

/*OUTER JOIN*/

/*Existe algum cliente que não realizou nenhuma compra?*/
select clientes.nome as cliente, clientes.cpf as clienteCPF, compras.cpf as comprasCPF
from clientes left outer join compras 
	 on clientes.cpf = compras.cpf
where compras.cpf is null;

/*Existe algum vendedor que não realizou nenhuma venda?*/
select vendedores.registro as vendedorRegistro, vendedores.nome as vendedor, compras.registro as comprasRegistro
from vendedores left outer join compras
	on vendedores.registro = compras.registro
where compras.registro is null;

/*Existe alguma venda que não possui produto?*/
select compras.codigo as compra, produtos.numero as produto, compras.numero as compraNumero
from compras left outer join produtos
	on produtos.numero = compras.numero
where produtos.numero is null;

/*Existe algum produto que ainda não foi vendido?*/
select produtos.numero as numeroProduto, produtos.nome as produto
from produtos left outer join compras
	on produtos.numero = compras.numero
where compras.numero is null;

/* Insira um vendedor e um novo produto no banco e perceba que eles 
aparecerão nas consultas que você criou*/
insert into vendedores values(120, 49281656833, 'Zé dos Santos', '2000-04-26', 'M', 12996702149, 2500, 30);
insert into produtos values(90, 'Notebook Samsung', 'descrição muito interessante sobre o produto', 3999.99, 3.5, '15x16x20', '2050-05-23');