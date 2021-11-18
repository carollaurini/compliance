Select chave_autorizacao, ativo, data_vencimento_autorizacao , data_ultima_autorizacao,nome_usuario,status,
		case when status =1 and CURRENT_TIME < data_vencimento_autorizacao then "Aprovado"
        else "Reprovado" end as resultado
    from compliance.autorizacao_ativo
    inner join 
    (
        Select max(data_autorizacao) as data_ultima_autorizacao, ativo as ativo_2
        from compliance.autorizacao_ativo
        Group by ativo
    ) SubMax 
    
    on autorizacao_ativo.data_autorizacao = SubMax.data_ultima_autorizacao
    and autorizacao_ativo.ativo = SubMax.ativo_2 
    having resultado="Aprovado"
    order by data_vencimento_autorizacao
    ;