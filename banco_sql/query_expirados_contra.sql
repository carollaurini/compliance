CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `armory`@`%` 
    SQL SECURITY DEFINER
VIEW `compliance`.`cantrapartes_expiradas` AS
    SELECT 
        `compliance`.`autorizacao_contraparte`.`chave_autorizacao` AS `chave_autorizacao`,
        `compliance`.`autorizacao_contraparte`.`contraparte` AS `contraparte`,
        `compliance`.`autorizacao_contraparte`.`data_vencimento_autorizacao` AS `data_vencimento_autorizacao`,
        `submax`.`data_ultima_autorizacao` AS `data_ultima_autorizacao`,
        `compliance`.`autorizacao_contraparte`.`nome_usuario` AS `nome_usuario`,
        `compliance`.`autorizacao_contraparte`.`status` AS `status`,
        (CASE
            WHEN
                ((`compliance`.`autorizacao_contraparte`.`status` = 1)
                    AND (CURTIME() > `compliance`.`autorizacao_contraparte`.`data_vencimento_autorizacao`))
            THEN
                'Expirado'
            ELSE 'Reprovado'
        END) AS `resultado`
    FROM
        (`compliance`.`autorizacao_contraparte`
        JOIN (SELECT 
            MAX(`compliance`.`autorizacao_contraparte`.`data_autorizacao`) AS `data_ultima_autorizacao`,
                `compliance`.`autorizacao_contraparte`.`contraparte` AS `contraparte_2`
        FROM
            `compliance`.`autorizacao_contraparte`
        GROUP BY `compliance`.`autorizacao_contraparte`.`contraparte`) `submax` ON (((`compliance`.`autorizacao_contraparte`.`data_autorizacao` = `submax`.`data_ultima_autorizacao`)
            AND (`compliance`.`autorizacao_contraparte`.`contraparte` = `submax`.`contraparte_2`))))
    HAVING (`resultado` = 'Expirado')
    ORDER BY `compliance`.`autorizacao_contraparte`.`data_vencimento_autorizacao`