SET SQL_SAFE_UPDATES = 0;
use compliance;

delete from autorizacao_ativo;
delete from autorizacao_contraparte;
delete from solicitacao;
delete from ativo;
delete from contraparte;
SET SQL_SAFE_UPDATES = 1;

drop user if exists compliance_compliance;
drop user if exists solicitador_compliance;
call compliance_producao.cria_usuario_compliance('compliance_compliance','compliance');
call compliance_producao.cria_usuario_front_office('solicitador_compliance','solicitador');
call compliance.cria_usuario_compliance('compliance_compliance','compliance');
call compliance.cria_usuario_front_office('solicitador_compliance','solicitador');
select * from mysql. user;

/*Insere os ativos/Contra A e B* se nao existirem*/
INSERT IGNORE INTO ativo VALUES ("Ativo A","Ativado",Default), ("Ativo B","Ativado",Default),("Ativo C","Ativado",Default),("Ativo D",Default,Default);
INSERT IGNORE INTO contraparte VALUES ("Contraparte A","Ativado"), ("Contraparte B","Ativado"),("Contraparte C","Ativado"),("Contraparte D","Ativado");

/*Delete registros antigos de autorizacao A e B*/
DELETE FROM autorizacao_ativo WHERE ativo="Ativo A" OR ativo="Ativo B";
												/*Data Aut.*/ /*Vencimento*/
INSERT INTO autorizacao_ativo VALUES 			("2021-01-31","2021-02-28", 1, "compliance_compliance", "Ativo A", 1),
												 ("2021-01-31","2021-12-31", 1, "compliance_compliance", "Ativo B", 2),
												 ("2021-03-31","2021-12-31", 0, "compliance_compliance", "Ativo B", 3),
												 ("2021-04-30","2021-12-31", 1, "compliance_compliance", "Ativo A", 4),
                                                 ("2021-08-02","2021-08-02", 1, "compliance_compliance", "Ativo C", 5),/*Expirado*/
                                                 ("2021-01-31","2021-02-28", 1, "compliance_compliance", "Ativo D", 6),/*Autorizado 2x na mesma data*/
                                                 ("2021-01-31","2021-02-28", 0, "compliance_compliance", "Ativo D", 7),
												 ("2021-02-09","2021-02-28", 1, "compliance_compliance", "Ativo D", 8);
													
DELETE FROM autorizacao_contraparte WHERE contraparte="Contraparte A" OR contraparte="Contraparte B";
														/*Data Aut.*/ /*Vencimento*/
INSERT INTO autorizacao_contraparte VALUES 				("2021-01-31","2021-02-28", 1, "compliance_compliance", 1, "Contraparte A"),
														 ("2021-01-31","2021-12-31", 1, "compliance_compliance", 2, "Contraparte B"),
														 ("2021-03-31","2021-12-31", 0, "compliance_compliance", 3, "Contraparte B"),
														 ("2021-04-30","2021-12-31", 1, "compliance_compliance", 4, "Contraparte A"),
                                                         ("2021-08-02","2021-08-02", 1, "compliance_compliance", 5, "contraparte C"),
														 ("2021-01-31","2021-02-28", 1, "compliance_compliance", 6, "contraparte D"),
                                                         ("2021-01-31","2021-02-28", 0, "compliance_compliance", 7, "contraparte D"),
                                                         ("2021-02-09","2021-02-28", 1, "compliance_compliance", 8, "contraparte D");
                                                         
/*DELETE FROM solicitacao WHERE contraparte_solicitada="Contraparte A" OR contraparte_solicitada="Contraparte B" OR ativo_solicitado="Ativo A" OR ativo_solicitado="Ativo B";*/

-- Será rejeitada por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-01-01", 1, "Ativo A", "Contraparte A");
-- Será rejeitada por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-01-01", 2, "Ativo A", "Contraparte B");
-- Será aprovada
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-02-01", 3, "Ativo A", "Contraparte B");
-- Será aprovada
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-02-01", 4, "Ativo A", "Contraparte A");
-- Será rejeitada por ativo
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-03-01", 5, "Ativo A", "Contraparte B");
-- Será rejeitada por contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-03-01", 6, "Ativo B", "Contraparte A");
-- Será rejeitada por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-04-01", 7, "Ativo B", "Contraparte A");
-- Será rejeitada por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-04-01", 8, "Ativo A", "Contraparte B");
-- Será rejeitada por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-04-01", 9, "Ativo A", "Contraparte B");
-- Será aprovada
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-05-01", 10, "Ativo A", "Contraparte A");
-- Será rejeitada por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-05-01", 11, "Ativo B", "Contraparte B");
-- Será rejeitada por contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-05-01", 12, "Ativo A", "Contraparte B");
-- Será rejeitada por ativo
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-05-01", 13, "Ativo B", "Contraparte A");
-- Sera reprovado por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-02-01", 14, "Ativo D", "Contraparte D");
-- Sera reprovado por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-01-20", 15, "Ativo D", "Contraparte D");
-- Sera reprovado por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-02-07", 16, "Ativo D", "Contraparte D");
-- Sera reprovado por ativo e contraparte -  pois expiram no dia
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-02-08", 17, "Ativo D", "Contraparte D");
-- Sera reprovado por ativo e contraparte
INSERT INTO solicitacao VALUES ("mb@armoryinvest.com_compliance", "2021-02-09", 18, "Ativo D", "Contraparte D");