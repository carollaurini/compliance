
/*drop user  'compliance_compliance'@'%';
drop user 'solicitador_compliance'@'%';
*/
call cria_usuario_compliance('compliance_compliance','compliance');
call cria_usuario_front_office('solicitador_compliance','solicitador');
select * from mysql. user;
