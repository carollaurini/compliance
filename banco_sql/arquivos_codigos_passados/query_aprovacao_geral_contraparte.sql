
select chave_pedido, chave_autorizacao, nome_usuario, nome_usuario_compliance, contraparte_solicitado,
		data_solicitacao, data_ultima_autorizacao, data_vencimento_autorizacao, status
from solicitacao_contraparte
left join (Select chave_autorizacao, contraparte, data_vencimento_autorizacao , data_ultima_autorizacao,nome_usuario as nome_usuario_compliance,status
    from autorizacao_contraparte
    inner join 
    (
        Select max(data_autorizacao) as data_ultima_autorizacao, contraparte as contraparte_2
        from autorizacao_contraparte
        Group by contraparte
    ) SubMax 
    on autorizacao_contraparte.data_autorizacao = SubMax.data_ultima_autorizacao
    and autorizacao_contraparte.contraparte = SubMax.contraparte_2 
 ) as b 
on solicitacao_contraparte.contraparte_solicitado = b.contraparte 
;
