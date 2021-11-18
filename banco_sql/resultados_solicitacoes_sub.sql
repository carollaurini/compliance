use compliance;

/*Retorna todas as autorizações existentes criadas antes da solicitação.*/
create table resultados_solicitacoes_sub
SELECT a.*,
            b.status AS status_contraparte,
            b.nome_usuario AS nome_usuario_compliance_contraparte,
            b.data_vencimento_autorizacao AS data_vencimento_autorizacao_contraparte,
            b.data_autorizacao AS data_autorizacao_contraparte,
            c.nome_usuario AS nome_usuario_compliance_ativo,
            c.data_vencimento_autorizacao AS data_vencimento_autorizacao_ativo,
            c.status AS status_ativo,
            c.data_autorizacao AS data_autorizacao_ativo,
            case when c.chave_autorizacao is null then -1 else c.chave_autorizacao end as chave_autorizacao_ativo,
            case when b.chave_autorizacao is null then -1 else b.chave_autorizacao end as chave_autorizacao_contraparte
    FROM
        solicitacao AS a
    left JOIN compliance.autorizacao_contraparte AS b ON a.contraparte_solicitada = b.contraparte
		AND b.data_autorizacao <= a.data_solicitacao
    left JOIN compliance.autorizacao_ativo AS c ON a.ativo_solicitado = c.ativo
		AND c.data_autorizacao <= a.data_solicitacao
        order by chave_pedido;
        
