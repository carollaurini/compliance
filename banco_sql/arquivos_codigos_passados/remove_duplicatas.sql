create table  compliance_producao.ativo3 
SELECT ativo, nullif(isin, "") as isin , ativacao from
(select * from compliance_producao.ativo2 where isin !="" group by isin  )
union 
(select * from compliance_producao.ativo2 where isin = "") ;

set sql_safe_updates = 0;
UPDATE ativo SET isin_registro = isin;
set sql_safe_updates = 1;

