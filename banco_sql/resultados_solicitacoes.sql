 create table resultados_solicitacoesv 
 
 select c.* ,    IF((status_ativo IS NULL OR status_ativo = 0
            OR data_vencimento_autorizacao_ativo < data_solicitacao)
            AND (status_contraparte IS NULL
            OR status_contraparte = 0
            OR data_vencimento_autorizacao_contraparte < data_solicitacao),
        'ATIVO E CONTRAPARTE REPROVADOS',
        IF((status_ativo IS NULL)
                OR status_ativo = 0
                OR data_vencimento_autorizacao_ativo < data_solicitacao,
            'ATIVO REPROVADO',
            IF((status_contraparte IS NULL)
                    OR status_contraparte = 0
                    OR data_vencimento_autorizacao_contraparte < data_solicitacao,
                'CONTRAPARTE REPROVADA',
                'APROVADO'))) AS resultado
 from 
 resultados_solicitacoes_sub1v as a
 left join compliance.resultados_solicitacoes_sub as c
	ON a.chave_pedido = c.chave_pedido
	   AND a.chave_ultima_autorizacao_ativo = c.chave_autorizacao_ativo
	   AND a.chave_ultima_autorizacao_contraparte = c.chave_autorizacao_contraparte
order by chave_pedido;