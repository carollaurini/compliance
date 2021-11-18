-- --------------------------------------------------------
-- Servidor:                     192.168.40.4
-- Versão do servidor:           8.0.25 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para compliance
CREATE DATABASE IF NOT EXISTS `compliance_producao` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `compliance_producao`;

-- Copiando estrutura para tabela compliance.ativo
CREATE TABLE IF NOT EXISTS `ativo` (
  `ativo` varchar(100) NOT NULL,
  `ativacao` varchar(15) NOT NULL DEFAULT 'Ativado',
  PRIMARY KEY (`ativo`),
  UNIQUE KEY `ativo_UNIQUE` (`ativo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view compliance.ativos_aprovados
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `ativos_aprovados` (
	`chave_autorizacao` INT(10) NOT NULL,
	`ativo` VARCHAR(100) NOT NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao` DATE NOT NULL,
	`data_ultima_autorizacao` DATETIME NULL,
	`nome_usuario` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`status` TINYINT(3) NOT NULL COMMENT 'autorizado (1) ou recusado (0)',
	`resultado` VARCHAR(9) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Copiando estrutura para view compliance.ativos_expirados
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `ativos_expirados` (
	`chave_autorizacao` INT(10) NOT NULL,
	`ativo` VARCHAR(100) NOT NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao` DATE NOT NULL,
	`data_ultima_autorizacao` DATETIME NULL,
	`nome_usuario` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`status` TINYINT(3) NOT NULL COMMENT 'autorizado (1) ou recusado (0)',
	`resultado` VARCHAR(9) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Copiando estrutura para view compliance.ativos_reprovados
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `ativos_reprovados` (
	`chave_autorizacao` INT(10) NOT NULL,
	`ativo` VARCHAR(100) NOT NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao` DATE NOT NULL,
	`data_ultima_autorizacao` DATETIME NULL,
	`nome_usuario` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`status` TINYINT(3) NOT NULL COMMENT 'autorizado (1) ou recusado (0)',
	`resultado` VARCHAR(9) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Copiando estrutura para tabela compliance.autorizacao_ativo
CREATE TABLE IF NOT EXISTS `autorizacao_ativo` (
  `data_autorizacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `data_vencimento_autorizacao` date NOT NULL,
  `status` tinyint NOT NULL COMMENT 'autorizado (1) ou recusado (0)',
  `nome_usuario` varchar(50) NOT NULL,
  `ativo` varchar(100) NOT NULL,
  `chave_autorizacao` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`chave_autorizacao`),
  KEY `ativo_idx` (`ativo`),
  CONSTRAINT `restricao_autorizacao_ativo` FOREIGN KEY (`ativo`) REFERENCES `ativo` (`ativo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb3;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela compliance.autorizacao_contraparte
CREATE TABLE IF NOT EXISTS `autorizacao_contraparte` (
  `data_autorizacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_vencimento_autorizacao` datetime NOT NULL,
  `status` tinyint NOT NULL,
  `nome_usuario` varchar(50) NOT NULL,
  `chave_autorizacao` int NOT NULL AUTO_INCREMENT,
  `contraparte` varchar(100) NOT NULL,
  PRIMARY KEY (`chave_autorizacao`),
  KEY `contraparte_idx` (`contraparte`),
  CONSTRAINT `restricao_autorizacao_contraparte` FOREIGN KEY (`contraparte`) REFERENCES `contraparte` (`contraparte`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb3;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela compliance.contraparte
CREATE TABLE IF NOT EXISTS `contraparte` (
  `contraparte` varchar(100) NOT NULL,
  `ativacao` varchar(15) NOT NULL DEFAULT 'Ativado',
  PRIMARY KEY (`contraparte`),
  UNIQUE KEY `contraparte_UNIQUE` (`contraparte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view compliance.contrapartes_aprovadas
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `contrapartes_aprovadas` (
	`chave_autorizacao` INT(10) NOT NULL,
	`contraparte` VARCHAR(100) NOT NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao` DATETIME NOT NULL,
	`data_ultima_autorizacao` DATETIME NULL,
	`nome_usuario` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`status` TINYINT(3) NOT NULL,
	`resultado` VARCHAR(9) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Copiando estrutura para view compliance.contrapartes_expiradas
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `contrapartes_expiradas` (
	`chave_autorizacao` INT(10) NOT NULL,
	`contraparte` VARCHAR(100) NOT NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao` DATETIME NOT NULL,
	`data_ultima_autorizacao` DATETIME NULL,
	`nome_usuario` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`status` TINYINT(3) NOT NULL,
	`resultado` VARCHAR(9) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Copiando estrutura para view compliance.contrapartes_reprovadas
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `contrapartes_reprovadas` (
	`chave_autorizacao` INT(10) NOT NULL,
	`contraparte` VARCHAR(100) NOT NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao` DATETIME NOT NULL,
	`data_ultima_autorizacao` DATETIME NULL,
	`nome_usuario` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`status` TINYINT(3) NOT NULL,
	`resultado` VARCHAR(9) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Copiando estrutura para procedure compliance.cria_usuario_compliance
DELIMITER //
CREATE DEFINER=`armory`@`%` PROCEDURE `cria_usuario_compliance`(
	IN `usuario_compliance` VARCHAR(50),
	IN `senha` VARCHAR(50)
)
BEGIN

   SET @SQL := CONCAT("CREATE USER '",usuario_compliance,"' IDENTIFIED BY '",senha,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;
  
   SET @SQL := CONCAT("GRANT INSERT, SELECT ON compliance.autorizacao_ativo TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;
   
   SET @SQL := CONCAT("GRANT INSERT, SELECT ON compliance.autorizacao_contraparte TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;
   
   SET @SQL := CONCAT("GRANT INSERT, SELECT, UPDATE(ativacao) ON compliance.ativo TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;
   
   SET @SQL := CONCAT("GRANT INSERT, SELECT,UPDATE(ativacao) ON compliance.contraparte TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`; 
   
   SET @SQL := CONCAT("GRANT SELECT ON compliance.resultados_solicitacoes TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`; 
   
   SET @SQL := CONCAT("GRANT SELECT ON compliance.ativos_aprovados TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;  
	
   SET @SQL := CONCAT("GRANT SELECT ON compliance.contrapartes_aprovadas TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;  
	SET @SQL := CONCAT("GRANT SELECT ON compliance.contrapartes_expiradas TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;  
	
    SET @SQL := CONCAT("GRANT SELECT ON compliance.contrapartes_reprovadas TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;  
   
	SET @SQL := CONCAT("GRANT SELECT ON compliance.ativos_expirados TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;   

	SET @SQL := CONCAT("GRANT SELECT ON compliance.ativos_reprovados TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;   

	SET @SQL := CONCAT("GRANT EXECUTE ON PROCEDURE compliance.cria_usuario_compliance TO '",usuario_compliance,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;   

END//
DELIMITER ;

-- Copiando estrutura para procedure compliance.cria_usuario_front_office
DELIMITER //
CREATE DEFINER=`armory`@`%` PROCEDURE `cria_usuario_front_office`(
	IN `usuario` VARCHAR(50),
	IN `senha` VARCHAR(50)
)
BEGIN	

	SET @SQL := CONCAT("CREATE USER '",usuario,"' IDENTIFIED BY '",senha,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;
   
   SET @SQL := CONCAT("GRANT INSERT, SELECT ON compliance.solicitacao TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;
   
   SET @SQL := CONCAT("GRANT INSERT, SELECT ON compliance.ativo TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;
   
   SET @SQL := CONCAT("GRANT INSERT, SELECT ON compliance.contraparte TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;  
	   
   SET @SQL := CONCAT("GRANT SELECT ON compliance.resultados_solicitacoes TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`; 

   SET @SQL := CONCAT("GRANT INSERT, SELECT, UPDATE(ativacao) ON compliance.ativo TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;
   
   SET @SQL := CONCAT("GRANT INSERT, SELECT, UPDATE(ativacao) ON compliance.contraparte TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
	EXECUTE `stmt`;

	SET @SQL := CONCAT("GRANT SELECT ON compliance.contrapartes_expiradas TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;  
	
    SET @SQL := CONCAT("GRANT SELECT ON compliance.contrapartes_reprovadas TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;  
   
	SET @SQL := CONCAT("GRANT SELECT ON compliance.contrapartes_aprovadas TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;  
   
	SET @SQL := CONCAT("GRANT SELECT ON compliance.ativos_expirados TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;   

	SET @SQL := CONCAT("GRANT SELECT ON compliance.ativos_reprovados TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;   
   
   	SET @SQL := CONCAT("GRANT SELECT ON compliance.ativos_aprovados TO '",usuario,"';");
	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;   
   
 
   
   SET @SQL := CONCAT("GRANT EXECUTE ON PROCEDURE compliance.cria_usuario_front_office TO '",usuario,"';");
  	PREPARE `stmt` FROM @`sql`;
   EXECUTE `stmt`;   
   
END//
DELIMITER ;

-- Copiando estrutura para view compliance.resultados_solicitacoes
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `resultados_solicitacoes` (
	`nome_usuario` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`data_solicitacao` TIMESTAMP NULL,
	`chave_pedido` INT(10) NULL,
	`ativo_solicitado` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`contraparte_solicitada` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`status_contraparte` TINYINT(3) NULL,
	`nome_usuario_compliance_contraparte` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao_contraparte` DATETIME NULL,
	`data_autorizacao_contraparte` DATETIME NULL,
	`nome_usuario_compliance_ativo` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao_ativo` DATE NULL,
	`status_ativo` TINYINT(3) NULL COMMENT 'autorizado (1) ou recusado (0)',
	`data_autorizacao_ativo` DATETIME NULL,
	`chave_autorizacao_ativo` BIGINT(19) NULL,
	`chave_autorizacao_contraparte` BIGINT(19) NULL,
	`resultado` VARCHAR(30) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- Copiando estrutura para view compliance.resultados_solicitacoes_sub
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `resultados_solicitacoes_sub` (
	`nome_usuario` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`data_solicitacao` TIMESTAMP NOT NULL,
	`chave_pedido` INT(10) NOT NULL,
	`ativo_solicitado` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`contraparte_solicitada` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`status_contraparte` TINYINT(3) NULL,
	`nome_usuario_compliance_contraparte` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao_contraparte` DATETIME NULL,
	`data_autorizacao_contraparte` DATETIME NULL,
	`nome_usuario_compliance_ativo` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`data_vencimento_autorizacao_ativo` DATE NULL,
	`status_ativo` TINYINT(3) NULL COMMENT 'autorizado (1) ou recusado (0)',
	`data_autorizacao_ativo` DATETIME NULL,
	`chave_autorizacao_ativo` BIGINT(19) NULL,
	`chave_autorizacao_contraparte` BIGINT(19) NULL
) ENGINE=MyISAM;

-- Copiando estrutura para view compliance.resultados_solicitacoes_sub1
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `resultados_solicitacoes_sub1` (
	`chave_pedido` INT(10) NOT NULL,
	`chave_ultima_autorizacao_contraparte` BIGINT(19) NULL,
	`chave_ultima_autorizacao_ativo` BIGINT(19) NULL,
	`chave_autorizacao_ativo` BIGINT(19) NULL,
	`chave_autorizacao_contraparte` BIGINT(19) NULL
) ENGINE=MyISAM;

-- Copiando estrutura para tabela compliance.solicitacao
CREATE TABLE IF NOT EXISTS `solicitacao` (
  `nome_usuario` varchar(50) NOT NULL,
  `data_solicitacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `chave_pedido` int NOT NULL AUTO_INCREMENT,
  `ativo_solicitado` varchar(100) DEFAULT NULL,
  `contraparte_solicitada` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`chave_pedido`),
  KEY `ativo_idx` (`ativo_solicitado`),
  KEY `contraparte_idx` (`contraparte_solicitada`),
  CONSTRAINT `restricao_solicitacao_ativo2` FOREIGN KEY (`ativo_solicitado`) REFERENCES `ativo` (`ativo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `restricao_solicitacao_contraparte2` FOREIGN KEY (`contraparte_solicitada`) REFERENCES `contraparte` (`contraparte`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8mb3;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para view compliance.ativos_aprovados
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `ativos_aprovados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`armory`@`%` SQL SECURITY DEFINER VIEW `ativos_aprovados` AS select `autorizacao_ativo`.`chave_autorizacao` AS `chave_autorizacao`,`autorizacao_ativo`.`ativo` AS `ativo`,`autorizacao_ativo`.`data_vencimento_autorizacao` AS `data_vencimento_autorizacao`,`submax`.`data_ultima_autorizacao` AS `data_ultima_autorizacao`,`autorizacao_ativo`.`nome_usuario` AS `nome_usuario`,`autorizacao_ativo`.`status` AS `status`,(case when ((`autorizacao_ativo`.`status` = 1) and (curtime() < `autorizacao_ativo`.`data_vencimento_autorizacao`)) then 'Aprovado' else 'Reprovado' end) AS `resultado` from (`autorizacao_ativo` join (select max(`autorizacao_ativo`.`data_autorizacao`) AS `data_ultima_autorizacao`,`autorizacao_ativo`.`ativo` AS `ativo_2` from `autorizacao_ativo` group by `autorizacao_ativo`.`ativo`) `submax` on(((`autorizacao_ativo`.`data_autorizacao` = `submax`.`data_ultima_autorizacao`) and (`autorizacao_ativo`.`ativo` = `submax`.`ativo_2`)))) having (`resultado` = 'Aprovado') order by `autorizacao_ativo`.`data_vencimento_autorizacao`;

-- Copiando estrutura para view compliance.ativos_expirados
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `ativos_expirados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`armory`@`%` SQL SECURITY DEFINER VIEW `ativos_expirados` AS select `autorizacao_ativo`.`chave_autorizacao` AS `chave_autorizacao`,`autorizacao_ativo`.`ativo` AS `ativo`,`autorizacao_ativo`.`data_vencimento_autorizacao` AS `data_vencimento_autorizacao`,`submax`.`data_ultima_autorizacao` AS `data_ultima_autorizacao`,`autorizacao_ativo`.`nome_usuario` AS `nome_usuario`,`autorizacao_ativo`.`status` AS `status`,(case when ((`autorizacao_ativo`.`status` = 1) and (curtime() > `autorizacao_ativo`.`data_vencimento_autorizacao`)) then 'Expirado' else 'Reprovado' end) AS `resultado` from (`autorizacao_ativo` join (select max(`autorizacao_ativo`.`data_autorizacao`) AS `data_ultima_autorizacao`,`autorizacao_ativo`.`ativo` AS `ativo_2` from `autorizacao_ativo` group by `autorizacao_ativo`.`ativo`) `submax` on(((`autorizacao_ativo`.`data_autorizacao` = `submax`.`data_ultima_autorizacao`) and (`autorizacao_ativo`.`ativo` = `submax`.`ativo_2`)))) having (`resultado` = 'Expirado') order by `autorizacao_ativo`.`data_vencimento_autorizacao`;

-- Copiando estrutura para view compliance.ativos_reprovados
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `ativos_reprovados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`armory`@`%` SQL SECURITY DEFINER VIEW `ativos_reprovados` AS select `autorizacao_ativo`.`chave_autorizacao` AS `chave_autorizacao`,`autorizacao_ativo`.`ativo` AS `ativo`,`autorizacao_ativo`.`data_vencimento_autorizacao` AS `data_vencimento_autorizacao`,`submax`.`data_ultima_autorizacao` AS `data_ultima_autorizacao`,`autorizacao_ativo`.`nome_usuario` AS `nome_usuario`,`autorizacao_ativo`.`status` AS `status`,(case when ((`autorizacao_ativo`.`status` = 1) and (curtime() < `autorizacao_ativo`.`data_vencimento_autorizacao`)) then 'Aprovado' else 'Reprovado' end) AS `resultado` from (`autorizacao_ativo` join (select max(`autorizacao_ativo`.`data_autorizacao`) AS `data_ultima_autorizacao`,`autorizacao_ativo`.`ativo` AS `ativo_2` from `autorizacao_ativo` group by `autorizacao_ativo`.`ativo`) `submax` on(((`autorizacao_ativo`.`data_autorizacao` = `submax`.`data_ultima_autorizacao`) and (`autorizacao_ativo`.`ativo` = `submax`.`ativo_2`)))) having (`resultado` = 'Reprovado') order by `autorizacao_ativo`.`data_vencimento_autorizacao`;

-- Copiando estrutura para view compliance.contrapartes_aprovadas
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `contrapartes_aprovadas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`armory`@`%` SQL SECURITY DEFINER VIEW `contrapartes_aprovadas` AS select `autorizacao_contraparte`.`chave_autorizacao` AS `chave_autorizacao`,`autorizacao_contraparte`.`contraparte` AS `contraparte`,`autorizacao_contraparte`.`data_vencimento_autorizacao` AS `data_vencimento_autorizacao`,`submax`.`data_ultima_autorizacao` AS `data_ultima_autorizacao`,`autorizacao_contraparte`.`nome_usuario` AS `nome_usuario`,`autorizacao_contraparte`.`status` AS `status`,(case when ((`autorizacao_contraparte`.`status` = 1) and (curtime() < `autorizacao_contraparte`.`data_vencimento_autorizacao`)) then 'Aprovado' else 'Reprovado' end) AS `resultado` from (`autorizacao_contraparte` join (select max(`autorizacao_contraparte`.`data_autorizacao`) AS `data_ultima_autorizacao`,`autorizacao_contraparte`.`contraparte` AS `contraparte_2` from `autorizacao_contraparte` group by `autorizacao_contraparte`.`contraparte`) `submax` on(((`autorizacao_contraparte`.`data_autorizacao` = `submax`.`data_ultima_autorizacao`) and (`autorizacao_contraparte`.`contraparte` = `submax`.`contraparte_2`)))) having (`resultado` = 'Aprovado') order by `autorizacao_contraparte`.`data_vencimento_autorizacao`;

-- Copiando estrutura para view compliance.contrapartes_expiradas
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `contrapartes_expiradas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`armory`@`%` SQL SECURITY DEFINER VIEW `contrapartes_expiradas` AS select `autorizacao_contraparte`.`chave_autorizacao` AS `chave_autorizacao`,`autorizacao_contraparte`.`contraparte` AS `contraparte`,`autorizacao_contraparte`.`data_vencimento_autorizacao` AS `data_vencimento_autorizacao`,`submax`.`data_ultima_autorizacao` AS `data_ultima_autorizacao`,`autorizacao_contraparte`.`nome_usuario` AS `nome_usuario`,`autorizacao_contraparte`.`status` AS `status`,(case when ((`autorizacao_contraparte`.`status` = 1) and (curtime() > `autorizacao_contraparte`.`data_vencimento_autorizacao`)) then 'Expirado' else 'Reprovado' end) AS `resultado` from (`autorizacao_contraparte` join (select max(`autorizacao_contraparte`.`data_autorizacao`) AS `data_ultima_autorizacao`,`autorizacao_contraparte`.`contraparte` AS `contraparte_2` from `autorizacao_contraparte` group by `autorizacao_contraparte`.`contraparte`) `submax` on(((`autorizacao_contraparte`.`data_autorizacao` = `submax`.`data_ultima_autorizacao`) and (`autorizacao_contraparte`.`contraparte` = `submax`.`contraparte_2`)))) having (`resultado` = 'Expirado') order by `autorizacao_contraparte`.`data_vencimento_autorizacao`;

-- Copiando estrutura para view compliance.contrapartes_reprovadas
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `contrapartes_reprovadas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`armory`@`%` SQL SECURITY DEFINER VIEW `contrapartes_reprovadas` AS select `autorizacao_contraparte`.`chave_autorizacao` AS `chave_autorizacao`,`autorizacao_contraparte`.`contraparte` AS `contraparte`,`autorizacao_contraparte`.`data_vencimento_autorizacao` AS `data_vencimento_autorizacao`,`submax`.`data_ultima_autorizacao` AS `data_ultima_autorizacao`,`autorizacao_contraparte`.`nome_usuario` AS `nome_usuario`,`autorizacao_contraparte`.`status` AS `status`,(case when ((`autorizacao_contraparte`.`status` = 1) and (curtime() < `autorizacao_contraparte`.`data_vencimento_autorizacao`)) then 'Aprovado' else 'Reprovado' end) AS `resultado` from (`autorizacao_contraparte` join (select max(`autorizacao_contraparte`.`data_autorizacao`) AS `data_ultima_autorizacao`,`autorizacao_contraparte`.`contraparte` AS `contraparte_2` from `autorizacao_contraparte` group by `autorizacao_contraparte`.`contraparte`) `submax` on(((`autorizacao_contraparte`.`data_autorizacao` = `submax`.`data_ultima_autorizacao`) and (`autorizacao_contraparte`.`contraparte` = `submax`.`contraparte_2`)))) having (`resultado` = 'Reprovado') order by `autorizacao_contraparte`.`data_vencimento_autorizacao`;

-- Copiando estrutura para view compliance.resultados_solicitacoes
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `resultados_solicitacoes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`armory`@`%` SQL SECURITY DEFINER VIEW `resultados_solicitacoes` AS select `c`.`nome_usuario` AS `nome_usuario`,`c`.`data_solicitacao` AS `data_solicitacao`,`c`.`chave_pedido` AS `chave_pedido`,`c`.`ativo_solicitado` AS `ativo_solicitado`,`c`.`contraparte_solicitada` AS `contraparte_solicitada`,`c`.`status_contraparte` AS `status_contraparte`,`c`.`nome_usuario_compliance_contraparte` AS `nome_usuario_compliance_contraparte`,`c`.`data_vencimento_autorizacao_contraparte` AS `data_vencimento_autorizacao_contraparte`,`c`.`data_autorizacao_contraparte` AS `data_autorizacao_contraparte`,`c`.`nome_usuario_compliance_ativo` AS `nome_usuario_compliance_ativo`,`c`.`data_vencimento_autorizacao_ativo` AS `data_vencimento_autorizacao_ativo`,`c`.`status_ativo` AS `status_ativo`,`c`.`data_autorizacao_ativo` AS `data_autorizacao_ativo`,`c`.`chave_autorizacao_ativo` AS `chave_autorizacao_ativo`,`c`.`chave_autorizacao_contraparte` AS `chave_autorizacao_contraparte`,if((((`c`.`status_ativo` is null) or (`c`.`status_ativo` = 0) or (`c`.`data_vencimento_autorizacao_ativo` < `c`.`data_solicitacao`)) and ((`c`.`status_contraparte` is null) or (`c`.`status_contraparte` = 0) or (`c`.`data_vencimento_autorizacao_contraparte` < `c`.`data_solicitacao`))),'ATIVO E CONTRAPARTE REPROVADOS',if(((`c`.`status_ativo` is null) or (`c`.`status_ativo` = 0) or (`c`.`data_vencimento_autorizacao_ativo` < `c`.`data_solicitacao`)),'ATIVO REPROVADO',if(((`c`.`status_contraparte` is null) or (`c`.`status_contraparte` = 0) or (`c`.`data_vencimento_autorizacao_contraparte` < `c`.`data_solicitacao`)),'CONTRAPARTE REPROVADA','APROVADO'))) AS `resultado` from (`resultados_solicitacoes_sub1` `a` left join `resultados_solicitacoes_sub` `c` on(((`a`.`chave_pedido` = `c`.`chave_pedido`) and (`a`.`chave_ultima_autorizacao_ativo` = `c`.`chave_autorizacao_ativo`) and (`a`.`chave_ultima_autorizacao_contraparte` = `c`.`chave_autorizacao_contraparte`)))) order by `c`.`chave_pedido`;

-- Copiando estrutura para view compliance.resultados_solicitacoes_sub
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `resultados_solicitacoes_sub`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `resultados_solicitacoes_sub` AS select `a`.`nome_usuario` AS `nome_usuario`,`a`.`data_solicitacao` AS `data_solicitacao`,`a`.`chave_pedido` AS `chave_pedido`,`a`.`ativo_solicitado` AS `ativo_solicitado`,`a`.`contraparte_solicitada` AS `contraparte_solicitada`,`b`.`status` AS `status_contraparte`,`b`.`nome_usuario` AS `nome_usuario_compliance_contraparte`,`b`.`data_vencimento_autorizacao` AS `data_vencimento_autorizacao_contraparte`,`b`.`data_autorizacao` AS `data_autorizacao_contraparte`,`c`.`nome_usuario` AS `nome_usuario_compliance_ativo`,`c`.`data_vencimento_autorizacao` AS `data_vencimento_autorizacao_ativo`,`c`.`status` AS `status_ativo`,`c`.`data_autorizacao` AS `data_autorizacao_ativo`,(case when (`c`.`chave_autorizacao` is null) then -(1) else `c`.`chave_autorizacao` end) AS `chave_autorizacao_ativo`,(case when (`b`.`chave_autorizacao` is null) then -(1) else `b`.`chave_autorizacao` end) AS `chave_autorizacao_contraparte` from ((`solicitacao` `a` left join `autorizacao_contraparte` `b` on(((`a`.`contraparte_solicitada` = `b`.`contraparte`) and (`b`.`data_autorizacao` <= `a`.`data_solicitacao`)))) left join `autorizacao_ativo` `c` on(((`a`.`ativo_solicitado` = `c`.`ativo`) and (`c`.`data_autorizacao` <= `a`.`data_solicitacao`))));

-- Copiando estrutura para view compliance.resultados_solicitacoes_sub1
-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `resultados_solicitacoes_sub1`;
CREATE ALGORITHM=UNDEFINED DEFINER=`armory`@`%` SQL SECURITY DEFINER VIEW `resultados_solicitacoes_sub1` AS select `a`.`chave_pedido` AS `chave_pedido`,`b`.`chave_ultima_autorizacao_contraparte` AS `chave_ultima_autorizacao_contraparte`,`b`.`chave_ultima_autorizacao_ativo` AS `chave_ultima_autorizacao_ativo`,(case when (`b`.`chave_autorizacao_ativo` is null) then -(1) else `b`.`chave_autorizacao_ativo` end) AS `chave_autorizacao_ativo`,(case when (`b`.`chave_autorizacao_contraparte` is null) then -(1) else `b`.`chave_autorizacao_contraparte` end) AS `chave_autorizacao_contraparte` from (`solicitacao` `a` left join (select `resultados_solicitacoes_sub`.`chave_pedido` AS `chave_pedido`,`resultados_solicitacoes_sub`.`chave_autorizacao_contraparte` AS `chave_autorizacao_contraparte`,`resultados_solicitacoes_sub`.`chave_autorizacao_ativo` AS `chave_autorizacao_ativo`,max(`resultados_solicitacoes_sub`.`chave_autorizacao_contraparte`) AS `chave_ultima_autorizacao_contraparte`,max(`resultados_solicitacoes_sub`.`chave_autorizacao_ativo`) AS `chave_ultima_autorizacao_ativo` from `resultados_solicitacoes_sub` group by `resultados_solicitacoes_sub`.`chave_pedido`) `b` on((`a`.`chave_pedido` = `b`.`chave_pedido`))) order by `a`.`chave_pedido`;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
