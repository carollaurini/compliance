DROP TRIGGER IF EXISTS `compliance`.`solicitacao_ativo_BEFORE_INSERT`;

DELIMITER $$
USE `compliance`$$
CREATE DEFINER = CURRENT_USER TRIGGER `compliance`.`solicitacao_ativo_BEFORE_INSERT` BEFORE INSERT ON `solicitacao_ativo` FOR EACH ROW
BEGIN
	SET new.nome_usuario = CURRENT_USER();
END$$
DELIMITER ;