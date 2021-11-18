
select chave_pedido, chave_autorizacao, nome_usuario, nome_usuario_compliance, ativo_solicitado,
		data_solicitacao, data_ultima_autorizacao, data_vencimento_autorizacao, status
from solicitacao_ativo
left join (Select chave_autorizacao, ativo, data_vencimento_autorizacao , data_ultima_autorizacao,nome_usuario as nome_usuario_compliance,status
    from autorizacao_ativo
    inner join 
    (
        Select max(data_autorizacao) as data_ultima_autorizacao, ativo as ativo_2
        from autorizacao_ativo
        Group by ativo
    ) SubMax 
    on autorizacao_ativo.data_autorizacao = SubMax.data_ultima_autorizacao
    and autorizacao_ativo.ativo = SubMax.ativo_2 
 ) as b 
on solicitacao_ativo.ativo_solicitado = b.ativo 
;
