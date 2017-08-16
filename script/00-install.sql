-- MySQL Script generated by MySQL Workbench
-- Qua 16 Ago 2017 07:33:03 BRT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema shoptop
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `shoptop` ;

-- -----------------------------------------------------
-- Schema shoptop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `shoptop` DEFAULT CHARACTER SET utf8 ;
USE `shoptop` ;

-- -----------------------------------------------------
-- Table `shoptop`.`pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`pessoa` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`pessoa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`pessoa_juridica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`pessoa_juridica` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`pessoa_juridica` (
  `pessoa_id` INT NOT NULL,
  `razao_social` VARCHAR(100) NOT NULL,
  `cnpj` VARCHAR(45) NOT NULL,
  INDEX `fk_pessoa_juridica_pessoa_idx` (`pessoa_id` ASC),
  PRIMARY KEY (`pessoa_id`),
  CONSTRAINT `fk_pessoa_juridica_pessoa`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `shoptop`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`pessoa_fisica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`pessoa_fisica` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`pessoa_fisica` (
  `pessoa_id` INT NOT NULL,
  `cpf` VARCHAR(15) NOT NULL,
  INDEX `fk_pessoa_fisica_pessoa1_idx` (`pessoa_id` ASC),
  PRIMARY KEY (`pessoa_id`),
  CONSTRAINT `fk_pessoa_fisica_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `shoptop`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`usuario` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`usuario` (
  `pessoa_fisica_pessoa_id` INT NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `ativo` TINYINT(1) NULL DEFAULT 1,
  INDEX `fk_usuario_pessoa_fisica1_idx` (`pessoa_fisica_pessoa_id` ASC),
  PRIMARY KEY (`pessoa_fisica_pessoa_id`),
  CONSTRAINT `fk_usuario_pessoa_fisica1`
    FOREIGN KEY (`pessoa_fisica_pessoa_id`)
    REFERENCES `shoptop`.`pessoa_fisica` (`pessoa_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`endereco_tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`endereco_tipo` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`endereco_tipo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`estado` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sigla` CHAR(2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`cidade` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`cidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `estado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidade_estado1_idx` (`estado_id` ASC),
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`estado_id`)
    REFERENCES `shoptop`.`estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`endereco` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(15) NULL,
  `endereco_tipo_id` INT NOT NULL,
  `cidade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_endereco_pessoa1_idx` (`pessoa_id` ASC),
  INDEX `fk_endereco_endereco_tipo1_idx` (`endereco_tipo_id` ASC),
  INDEX `fk_endereco_cidade1_idx` (`cidade_id` ASC),
  CONSTRAINT `fk_endereco_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `shoptop`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_endereco_tipo1`
    FOREIGN KEY (`endereco_tipo_id`)
    REFERENCES `shoptop`.`endereco_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_cidade1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `shoptop`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`telefone` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`telefone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `endereco_id` INT NOT NULL,
  `numero` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_telefone_endereco1_idx` (`endereco_id` ASC),
  CONSTRAINT `fk_telefone_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `shoptop`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`produto` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`produto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `valor_unitario` FLOAT NOT NULL,
  `fornecedor_id` INT NOT NULL,
  `estoque` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produto_pessoa_juridica1_idx` (`fornecedor_id` ASC),
  CONSTRAINT `fk_produto_pessoa_juridica1`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `shoptop`.`pessoa_juridica` (`pessoa_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`usuario_produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`usuario_produto` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`usuario_produto` (
  `usuario_pessoa_fisica_pessoa_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `valor_unitario` FLOAT NOT NULL,
  `qtdade` INT NOT NULL,
  `valor_total` FLOAT NOT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`usuario_pessoa_fisica_pessoa_id`, `produto_id`),
  INDEX `fk_usuario_has_produto_produto1_idx` (`produto_id` ASC),
  INDEX `fk_usuario_has_produto_usuario1_idx` (`usuario_pessoa_fisica_pessoa_id` ASC),
  CONSTRAINT `fk_usuario_has_produto_usuario1`
    FOREIGN KEY (`usuario_pessoa_fisica_pessoa_id`)
    REFERENCES `shoptop`.`usuario` (`pessoa_fisica_pessoa_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_produto_produto1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `shoptop`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`categoria` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`desconto_maximo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`desconto_maximo` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`desconto_maximo` (
  `id` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `porcentagem` FLOAT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoptop`.`produto_categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shoptop`.`produto_categoria` ;

CREATE TABLE IF NOT EXISTS `shoptop`.`produto_categoria` (
  `produto_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  `desconto_maximo_id` INT NULL,
  PRIMARY KEY (`produto_id`, `categoria_id`),
  INDEX `fk_produto_has_categoria_categoria1_idx` (`categoria_id` ASC),
  INDEX `fk_produto_has_categoria_produto1_idx` (`produto_id` ASC),
  INDEX `fk_produto_categoria_desconto_maximo1_idx` (`desconto_maximo_id` ASC),
  CONSTRAINT `fk_produto_has_categoria_produto1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `shoptop`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_categoria_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `shoptop`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_categoria_desconto_maximo1`
    FOREIGN KEY (`desconto_maximo_id`)
    REFERENCES `shoptop`.`desconto_maximo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `shoptop` ;

-- -----------------------------------------------------
-- Placeholder table for view `shoptop`.`view_pessoas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shoptop`.`view_pessoas` (`id` INT, `nome` INT, `data_cadastro` INT, `cpf` INT, `razao_social` INT, `cnpj` INT);

-- -----------------------------------------------------
-- procedure insertPessoaJuridica
-- -----------------------------------------------------

USE `shoptop`;
DROP procedure IF EXISTS `shoptop`.`insertPessoaJuridica`;

DELIMITER $$
USE `shoptop`$$
CREATE PROCEDURE `insertPessoaJuridica` (
IN nome VARCHAR(45), IN cnpj VARCHAR(45) ,IN razao_social VARCHAR(45))
BEGIN
	INSERT INTO pessoa (nome) VALUES (nome);
    INSERT INTO pessoa_juridica (pessoa_id,cnpj,razao_social) VALUES
		(last_insert_id(),cnpj,razao_social);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertPessoaJuridicaAtomica
-- -----------------------------------------------------

USE `shoptop`;
DROP procedure IF EXISTS `shoptop`.`insertPessoaJuridicaAtomica`;

DELIMITER $$
USE `shoptop`$$
CREATE PROCEDURE `insertPessoaJuridicaAtomica` (
IN nome VARCHAR(45), IN cnpj VARCHAR(45) ,IN razao_social VARCHAR(45))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;
	START TRANSACTION;
	INSERT INTO pessoa (nome) VALUES (nome);
    INSERT INTO pessoa_juridica (pessoa_id,cnpj,razao_social) VALUES
		(last_insert_id(),cnpj,razao_social);
	COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `shoptop`.`view_pessoas`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `shoptop`.`view_pessoas` ;
DROP TABLE IF EXISTS `shoptop`.`view_pessoas`;
USE `shoptop`;
CREATE  OR REPLACE VIEW `view_pessoas` AS
SELECT 
	p.*,
    pf.cpf as cpf,
    pj.razao_social as razao_social,
    pj.cnpj as cnpj
FROM pessoa AS p
	LEFT JOIN pessoa_fisica as pf
		ON p.id = pf.pessoa_id
	LEFT JOIN pessoa_juridica as pj
		ON p.id = pj.pessoa_id
	LEFT JOIN endereco as e
		ON p.id = e.pessoa_id;
USE `shoptop`;

DELIMITER $$

USE `shoptop`$$
DROP TRIGGER IF EXISTS `shoptop`.`pessoa_fisica_BEFORE_INSERT` $$
USE `shoptop`$$
CREATE DEFINER = CURRENT_USER TRIGGER `shoptop`.`pessoa_fisica_BEFORE_INSERT` BEFORE INSERT ON `pessoa_fisica` FOR EACH ROW
BEGIN
    IF((SELECT count(*) FROM pessoa_juridica WHERE pessoa_id = new.pessoa_id) > 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ops! Essa pessoa já está cadastrada como pessoa jurídica';
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `shoptop`.`pessoa`
-- -----------------------------------------------------
START TRANSACTION;
USE `shoptop`;
INSERT INTO `shoptop`.`pessoa` (`id`, `nome`, `data_cadastro`) VALUES (1, 'João das Cove', '2010-11-12 00:00:00');
INSERT INTO `shoptop`.`pessoa` (`id`, `nome`, `data_cadastro`) VALUES (2, 'Vó do Badanha', '2011-11-12 03:00:00');
INSERT INTO `shoptop`.`pessoa` (`id`, `nome`, `data_cadastro`) VALUES (3, 'Oficina Pai do Cirilo', '2015-12-30 00:20:00');
INSERT INTO `shoptop`.`pessoa` (`id`, `nome`, `data_cadastro`) VALUES (4, 'Thomas Imports', '2017-01-23 01:11:22');
INSERT INTO `shoptop`.`pessoa` (`id`, `nome`, `data_cadastro`) VALUES (5, 'Neymar Jr', '2008-02-28 14:55:00');
INSERT INTO `shoptop`.`pessoa` (`id`, `nome`, `data_cadastro`) VALUES (6, 'Jonas Esticado', '2016-02-12 23:59:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `shoptop`.`pessoa_juridica`
-- -----------------------------------------------------
START TRANSACTION;
USE `shoptop`;
INSERT INTO `shoptop`.`pessoa_juridica` (`pessoa_id`, `razao_social`, `cnpj`) VALUES (3, 'Seu Cirilo mecânica LTDA - EPP', '123333');
INSERT INTO `shoptop`.`pessoa_juridica` (`pessoa_id`, `razao_social`, `cnpj`) VALUES (4, 'T Mercado de Importados - LTDA', '2432423');

COMMIT;


-- -----------------------------------------------------
-- Data for table `shoptop`.`pessoa_fisica`
-- -----------------------------------------------------
START TRANSACTION;
USE `shoptop`;
INSERT INTO `shoptop`.`pessoa_fisica` (`pessoa_id`, `cpf`) VALUES (1, '000');
INSERT INTO `shoptop`.`pessoa_fisica` (`pessoa_id`, `cpf`) VALUES (2, '111');
INSERT INTO `shoptop`.`pessoa_fisica` (`pessoa_id`, `cpf`) VALUES (5, '222');
INSERT INTO `shoptop`.`pessoa_fisica` (`pessoa_id`, `cpf`) VALUES (6, '333');

COMMIT;


-- -----------------------------------------------------
-- Data for table `shoptop`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `shoptop`;
INSERT INTO `shoptop`.`usuario` (`pessoa_fisica_pessoa_id`, `login`, `senha`, `ativo`) VALUES (1, 'essecarasoueu', '123', 1);
INSERT INTO `shoptop`.`usuario` (`pessoa_fisica_pessoa_id`, `login`, `senha`, `ativo`) VALUES (2, 'amomeucachorro', '456', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `shoptop`.`endereco_tipo`
-- -----------------------------------------------------
START TRANSACTION;
USE `shoptop`;
INSERT INTO `shoptop`.`endereco_tipo` (`id`, `descricao`) VALUES (1, 'residencial');
INSERT INTO `shoptop`.`endereco_tipo` (`id`, `descricao`) VALUES (2, 'comercial');
INSERT INTO `shoptop`.`endereco_tipo` (`id`, `descricao`) VALUES (3, 'financeiro');

COMMIT;


-- -----------------------------------------------------
-- Data for table `shoptop`.`estado`
-- -----------------------------------------------------
START TRANSACTION;
USE `shoptop`;
INSERT INTO `shoptop`.`estado` (`id`, `nome`, `sigla`) VALUES (1, 'Santa Catarina', 'SC');
INSERT INTO `shoptop`.`estado` (`id`, `nome`, `sigla`) VALUES (2, 'Paraná', 'PR');

COMMIT;


-- -----------------------------------------------------
-- Data for table `shoptop`.`cidade`
-- -----------------------------------------------------
START TRANSACTION;
USE `shoptop`;
INSERT INTO `shoptop`.`cidade` (`id`, `nome`, `estado_id`) VALUES (1, 'Videira', 1);
INSERT INTO `shoptop`.`cidade` (`id`, `nome`, `estado_id`) VALUES (2, 'Pinheiro Preto', 1);
INSERT INTO `shoptop`.`cidade` (`id`, `nome`, `estado_id`) VALUES (3, 'Foz do Iguaçu', 2);
INSERT INTO `shoptop`.`cidade` (`id`, `nome`, `estado_id`) VALUES (4, 'Pato Branco Daí', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `shoptop`.`endereco`
-- -----------------------------------------------------
START TRANSACTION;
USE `shoptop`;
INSERT INTO `shoptop`.`endereco` (`id`, `pessoa_id`, `rua`, `bairro`, `numero`, `endereco_tipo_id`, `cidade_id`) VALUES (1, 1, 'Das Bromélias', 'Jaguarão', '2', 1, 1);
INSERT INTO `shoptop`.`endereco` (`id`, `pessoa_id`, `rua`, `bairro`, `numero`, `endereco_tipo_id`, `cidade_id`) VALUES (2, 1, 'General Augusto Cove', 'Militar', '333', 2, 1);
INSERT INTO `shoptop`.`endereco` (`id`, `pessoa_id`, `rua`, `bairro`, `numero`, `endereco_tipo_id`, `cidade_id`) VALUES (3, 3, 'XV de Novembro', 'Centro', '', 2, 3);
INSERT INTO `shoptop`.`endereco` (`id`, `pessoa_id`, `rua`, `bairro`, `numero`, `endereco_tipo_id`, `cidade_id`) VALUES (4, 4, 'Floriano Peixoto', 'Glória', '22', 2, 2);

COMMIT;

