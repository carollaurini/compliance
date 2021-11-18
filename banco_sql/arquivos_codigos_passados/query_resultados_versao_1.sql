
select  *,
If ((status_ativo is NULL OR status_ativo=0 OR data_vencimento_autorizacao_ativo < data_solicitacao)  AND 
(status_contraparte is NULL OR status_contraparte=0 OR data_vencimento_autorizacao_contraparte < data_solicitacao),'ATIVO E CONTRAPARTE REPROVADOS', 
 IF((status_ativo is NULL) OR status_ativo=0 OR data_vencimento_autorizacao_ativo<data_solicitacao, 'ATIVO REPROVADO',IF((status_contraparte is NULL) OR status_contraparte=0 OR data_vencimento_autorizacao_contraparte<data_solicitacao,'CONTRAPARTE REPROVADA','APROVADO'))) 
 as resultado

from compliance.solicitacao

left join (Select nome_usuario as nome_usuario_compliance_ativo,data_ultima_autorizacao as data_ultima_autorizacao_ativo, 
				  chave_autorizacao as chave_autorizacao_ativo, ativo, data_vencimento_autorizacao as data_vencimento_autorizacao_ativo , 
				  status as status_ativo
    from compliance.autorizacao_ativo
    inner join 
    (
        Select max(data_autorizacao) as data_ultima_autorizacao, ativo as ativo_2
        from compliance.autorizacao_ativo
        Group by ativo
    ) SubMax 
    on autorizacao_ativo.data_autorizacao = SubMax.data_ultima_autorizacao
    and autorizacao_ativo.ativo = SubMax.ativo_2 
 ) as b 
on compliance.solicitacao.ativo_solicitado = b.ativo 


left join (Select nome_usuario as nome_usuario_compliance_contraparte,data_ultima_autorizacao as data_ultima_autorizacao_contraparte,
					chave_autorizacao as chave_autorizacao_contraparte, contraparte, data_vencimento_autorizacao as data_vencimento_autorizacao_contraparte ,
                    status as status_contraparte
    from compliance.autorizacao_contraparte
    inner join 
    (
        Select max(data_autorizacao) as data_ultima_autorizacao, contraparte as contraparte_2
        from compliance.autorizacao_contraparte
        Group by contraparte
    ) SubMax 
    on autorizacao_contraparte.data_autorizacao = SubMax.data_ultima_autorizacao
    and autorizacao_contraparte.contraparte = SubMax.contraparte_2 
 ) as c 
on solicitacao.contraparte_solicitada = c.contraparte
;
