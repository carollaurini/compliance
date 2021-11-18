/*Pega a ultima autorizacao*/
create table resultados_solicitacoes_sub1v
select a.chave_pedido ,
b.chave_ultima_autorizacao_contraparte,
b.chave_ultima_autorizacao_ativo ,

case when b.chave_autorizacao_ativo is null then -1 else b.chave_autorizacao_ativo end as chave_autorizacao_ativo,
case when b.chave_autorizacao_contraparte is null then -1 else b.chave_autorizacao_contraparte end as chave_autorizacao_contraparte
from compliance.solicitacao as a
left join ( SELECT chave_pedido as chave_pedido,
			chave_autorizacao_contraparte,
            chave_autorizacao_ativo,
            MAX(chave_autorizacao_contraparte) AS chave_ultima_autorizacao_contraparte,
            MAX(chave_autorizacao_ativo) AS chave_ultima_autorizacao_ativo
			FROM compliance.resultados_solicitacoes_sub 
			GROUP BY chave_pedido) as b
 on a.chave_pedido = b.chave_pedido
 order by chave_pedido;
 


 

