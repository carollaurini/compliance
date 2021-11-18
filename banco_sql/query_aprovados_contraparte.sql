Select chave_autorizacao, contraparte, data_vencimento_autorizacao , data_ultima_autorizacao,nome_usuario,status,
		case when status =1 and CURRENT_TIME < data_vencimento_autorizacao then "Aprovado"
        else "Reprovado" end as resultado
    from compliance.autorizacao_contraparte
    inner join 
    (
        Select max(data_autorizacao) as data_ultima_autorizacao, contraparte as contraparte_2
        from compliance.autorizacao_contraparte
        Group by contraparte
    ) SubMax 
    
    on autorizacao_contraparte.data_autorizacao = SubMax.data_ultima_autorizacao
    and autorizacao_contraparte.contraparte = SubMax.contraparte_2 
    having resultado="Aprovado"
    order by data_vencimento_autorizacao
    ;