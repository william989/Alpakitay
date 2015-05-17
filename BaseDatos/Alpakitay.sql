-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bd_alpakitay
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd_alpakitay
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_alpakitay` DEFAULT CHARACTER SET utf8 ;
USE `bd_alpakitay` ;

-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Usuario` (
  `us_ID` INT NOT NULL AUTO_INCREMENT,
  `us_usename` VARCHAR(15) NULL,
  `us_password` VARCHAR(15) NULL,
  `us_email` VARCHAR(45) NULL,
  PRIMARY KEY (`us_ID`),
  UNIQUE INDEX `us_ID_UNIQUE` (`us_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Rol` (
  `rol_ID` INT NOT NULL AUTO_INCREMENT,
  `rol_codigo` INT(8) NULL,
  `rol_descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`rol_ID`),
  UNIQUE INDEX `rol_ID_UNIQUE` (`rol_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`UsuarioRol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`UsuarioRol` (
  `rol_ID` INT NOT NULL AUTO_INCREMENT,
  `us_ID` INT NOT NULL,
  PRIMARY KEY (`rol_ID`, `us_ID`),
  INDEX `fk_UsuarioRol_Usuario1_idx` (`us_ID` ASC),
  CONSTRAINT `fk_UsuarioRol_Rol`
    FOREIGN KEY (`rol_ID`)
    REFERENCES `bd_alpakitay`.`Rol` (`rol_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UsuarioRol_Usuario1`
    FOREIGN KEY (`us_ID`)
    REFERENCES `bd_alpakitay`.`Usuario` (`us_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Departamento` (
  `dep_ID` INT NOT NULL,
  `dep_nombre` VARCHAR(30) NULL,
  PRIMARY KEY (`dep_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Provincia` (
  `prov_ID` INT NOT NULL,
  `prov_nombre` VARCHAR(30) NULL,
  `dep_ID` INT NOT NULL,
  PRIMARY KEY (`prov_ID`, `dep_ID`),
  INDEX `fk_Provincia_Departamento1_idx` (`dep_ID` ASC),
  CONSTRAINT `fk_Provincia_Departamento1`
    FOREIGN KEY (`dep_ID`)
    REFERENCES `bd_alpakitay`.`Departamento` (`dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Distrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Distrito` (
  `dis_ID` INT NOT NULL,
  `dis_nombre` VARCHAR(30) NULL,
  `prov_ID` INT NOT NULL,
  `dep_ID` INT NOT NULL,
  PRIMARY KEY (`dis_ID`, `prov_ID`, `dep_ID`),
  INDEX `fk_Distrito_Provincia1_idx` (`prov_ID` ASC, `dep_ID` ASC),
  CONSTRAINT `fk_Distrito_Provincia1`
    FOREIGN KEY (`prov_ID` , `dep_ID`)
    REFERENCES `bd_alpakitay`.`Provincia` (`prov_ID` , `dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Anexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Anexo` (
  `an_ID` INT NOT NULL AUTO_INCREMENT,
  `an_codigo` VARCHAR(10) NULL,
  `an_nombre` VARCHAR(15) NULL,
  `dis_ID` INT NOT NULL,
  `prov_ID` INT NOT NULL,
  `dep_ID` INT NOT NULL,
  PRIMARY KEY (`an_ID`, `dis_ID`, `prov_ID`, `dep_ID`),
  INDEX `fk_Anexo_Distrito1_idx` (`dis_ID` ASC, `prov_ID` ASC, `dep_ID` ASC),
  CONSTRAINT `fk_Anexo_Distrito1`
    FOREIGN KEY (`dis_ID` , `prov_ID` , `dep_ID`)
    REFERENCES `bd_alpakitay`.`Distrito` (`dis_ID` , `prov_ID` , `dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Ganadero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Ganadero` (
  `gan_ID` INT NOT NULL AUTO_INCREMENT,
  `rol_ID` INT NOT NULL,
  `us_ID` INT NOT NULL,
  `gan_DNI` INT(8) NULL,
  `gan_fechNacimiento` DATE NULL,
  `gan_instruccion` VARCHAR(45) NULL,
  `gan_predio` VARCHAR(45) NULL,
  `gan_parentesco` VARCHAR(20) NULL,
  `gan_procedencia` VARCHAR(20) NULL,
  `gan_tiempPermanencia` VARCHAR(45) NULL,
  `gan_condicion` VARCHAR(20) NULL,
  `gan_observaciones` VARCHAR(50) NULL,
  `gan_ganadoCol` VARCHAR(30) NULL COMMENT 'asd',
  `gan_sector` VARCHAR(30) NULL,
  `an_ID` INT NOT NULL,
  `dis_ID` INT NOT NULL,
  `prov_ID` INT NOT NULL,
  `dep_ID` INT NOT NULL,
  INDEX `fk_Ganadero_UsuarioRol1_idx` (`rol_ID` ASC, `us_ID` ASC),
  INDEX `fk_Ganadero_Anexo1_idx` (`an_ID` ASC, `dis_ID` ASC, `prov_ID` ASC, `dep_ID` ASC),
  PRIMARY KEY (`gan_ID`),
  CONSTRAINT `fk_Ganadero_UsuarioRol1`
    FOREIGN KEY (`rol_ID` , `us_ID`)
    REFERENCES `bd_alpakitay`.`UsuarioRol` (`rol_ID` , `us_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ganadero_Anexo1`
    FOREIGN KEY (`an_ID` , `dis_ID` , `prov_ID` , `dep_ID`)
    REFERENCES `bd_alpakitay`.`Anexo` (`an_ID` , `dis_ID` , `prov_ID` , `dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Ganado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Ganado` (
  `ga_ID` INT NOT NULL AUTO_INCREMENT,
  `ga_sector` VARCHAR(20) NULL,
  `ga_fecNacimiento` DATE NULL,
  `ga_sexo` VARCHAR(10) NULL,
  `ga_raza` VARCHAR(20) NULL,
  `ga_fecMedicion` DATE NULL,
  `ga_color` VARCHAR(20) NULL,
  `ga_medCabeza` DECIMAL(2) NULL,
  `ga_medTalla` DECIMAL(2) NULL,
  `ga_apariencia Gral` VARCHAR(45) NULL,
  `ga_medFinura` DECIMAL(2) NULL,
  `ga_medUniformidad` DECIMAL(2) NULL,
  `ga_medDensidad` DECIMAL(2) NULL,
  `ga_medRisos` DECIMAL(2) NULL,
  `ga_medPuntaje` INT NULL,
  `ga_clasificacion` VARCHAR(25) NULL,
  `ga_beneficiado` VARCHAR(25) NULL,
  `gan_ID` INT NOT NULL,
  `an_ID` INT NOT NULL,
  `dis_ID` INT NOT NULL,
  `prov_ID` INT NOT NULL,
  `dep_ID` INT NOT NULL,
  `ga_ID_madre` INT NULL,
  `ga_ID_padre` INT NULL,
  PRIMARY KEY (`ga_ID`),
  INDEX `fk_Ganado_Ganadero1_idx` (`gan_ID` ASC),
  INDEX `fk_Ganado_Anexo1_idx` (`an_ID` ASC, `dis_ID` ASC, `prov_ID` ASC, `dep_ID` ASC),
  CONSTRAINT `fk_Ganado_Ganadero1`
    FOREIGN KEY (`gan_ID`)
    REFERENCES `bd_alpakitay`.`Ganadero` (`gan_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ganado_Anexo1`
    FOREIGN KEY (`an_ID` , `dis_ID` , `prov_ID` , `dep_ID`)
    REFERENCES `bd_alpakitay`.`Anexo` (`an_ID` , `dis_ID` , `prov_ID` , `dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`HistoriaClinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`HistoriaClinica` (
  `hc_ID` INT NOT NULL,
  `hc_aptoReproducirse` VARCHAR(2) NULL,
  `ga_ID` INT NOT NULL,
  PRIMARY KEY (`hc_ID`),
  INDEX `fk_HistoriaClinica_Ganado1_idx` (`ga_ID` ASC),
  CONSTRAINT `fk_HistoriaClinica_Ganado1`
    FOREIGN KEY (`ga_ID`)
    REFERENCES `bd_alpakitay`.`Ganado` (`ga_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Consulta` (
  `con_ID` INT NOT NULL,
  `con_diagnostico` VARCHAR(45) NULL,
  `con_tratamiento` VARCHAR(45) NULL,
  `hc_ID` INT NOT NULL,
  PRIMARY KEY (`con_ID`),
  INDEX `fk_Consulta_HistoriaClinica1_idx` (`hc_ID` ASC),
  CONSTRAINT `fk_Consulta_HistoriaClinica1`
    FOREIGN KEY (`hc_ID`)
    REFERENCES `bd_alpakitay`.`HistoriaClinica` (`hc_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Campania`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Campania` (
  `cam_ID` INT NOT NULL,
  `cam_nombre` VARCHAR(45) NULL,
  `cam_fecInicio` DATE NULL,
  `cam_fecFinal` DATE NULL,
  PRIMARY KEY (`cam_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Estado` (
  `est_ID` INT NOT NULL AUTO_INCREMENT,
  `est_codigo` VARCHAR(10) NULL,
  `est_descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`est_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`Resultado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`Resultado` (
  `res_ID` INT NOT NULL AUTO_INCREMENT,
  `res_codigo` VARCHAR(10) NULL,
  `res_descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`res_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`MejoramientoGenetico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`MejoramientoGenetico` (
  `mg_ID` INT NOT NULL,
  `mg_resultadoID` INT NULL,
  `mg_fecEvento` DATE NULL,
  `cam_ID` INT NOT NULL,
  `est_ID` INT NOT NULL,
  `res_ID` INT NOT NULL,
  `ga_ID_macho` INT NOT NULL,
  `ga_ID_hembra` INT NOT NULL,
  PRIMARY KEY (`mg_ID`),
  INDEX `fk_MejoramientoGenetico_Campania1_idx` (`cam_ID` ASC),
  INDEX `fk_MejoramientoGenetico_Estado1_idx` (`est_ID` ASC),
  INDEX `fk_MejoramientoGenetico_Resultado1_idx` (`res_ID` ASC),
  INDEX `fk_MejoramientoGenetico_Ganado1_idx` (`ga_ID_macho` ASC),
  INDEX `fk_MejoramientoGenetico_Ganado2_idx` (`ga_ID_hembra` ASC),
  CONSTRAINT `fk_MejoramientoGenetico_Campania1`
    FOREIGN KEY (`cam_ID`)
    REFERENCES `bd_alpakitay`.`Campania` (`cam_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MejoramientoGenetico_Estado1`
    FOREIGN KEY (`est_ID`)
    REFERENCES `bd_alpakitay`.`Estado` (`est_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MejoramientoGenetico_Resultado1`
    FOREIGN KEY (`res_ID`)
    REFERENCES `bd_alpakitay`.`Resultado` (`res_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MejoramientoGenetico_Ganado1`
    FOREIGN KEY (`ga_ID_macho`)
    REFERENCES `bd_alpakitay`.`Ganado` (`ga_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MejoramientoGenetico_Ganado2`
    FOREIGN KEY (`ga_ID_hembra`)
    REFERENCES `bd_alpakitay`.`Ganado` (`ga_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`departamento` (
  `dep_ID` INT(11) NOT NULL,
  `dep_nombre` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`dep_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`provincia` (
  `prov_ID` INT(11) NOT NULL,
  `prov_nombre` VARCHAR(30) NULL DEFAULT NULL,
  `dep_ID` INT(11) NOT NULL,
  PRIMARY KEY (`prov_ID`, `dep_ID`),
  INDEX `fk_Provincia_Departamento1_idx` (`dep_ID` ASC),
  CONSTRAINT `fk_Provincia_Departamento1`
    FOREIGN KEY (`dep_ID`)
    REFERENCES `bd_alpakitay`.`departamento` (`dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`distrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`distrito` (
  `dis_ID` INT(11) NOT NULL,
  `dis_nombre` VARCHAR(30) NULL DEFAULT NULL,
  `prov_ID` INT(11) NOT NULL,
  `dep_ID` INT(11) NOT NULL,
  PRIMARY KEY (`dis_ID`, `prov_ID`, `dep_ID`),
  INDEX `fk_Distrito_Provincia1_idx` (`prov_ID` ASC, `dep_ID` ASC),
  CONSTRAINT `fk_Distrito_Provincia1`
    FOREIGN KEY (`prov_ID` , `dep_ID`)
    REFERENCES `bd_alpakitay`.`provincia` (`prov_ID` , `dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`anexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`anexo` (
  `an_ID` INT(11) NOT NULL,
  `an_codigo` VARCHAR(10) NULL DEFAULT NULL,
  `an_nombre` VARCHAR(15) NULL DEFAULT NULL,
  `dis_ID` INT(11) NOT NULL,
  `prov_ID` INT(11) NOT NULL,
  `dep_ID` INT(11) NOT NULL,
  PRIMARY KEY (`an_ID`, `dis_ID`, `prov_ID`, `dep_ID`),
  INDEX `fk_Anexo_Distrito1_idx` (`dis_ID` ASC, `prov_ID` ASC, `dep_ID` ASC),
  CONSTRAINT `fk_Anexo_Distrito1`
    FOREIGN KEY (`dis_ID` , `prov_ID` , `dep_ID`)
    REFERENCES `bd_alpakitay`.`distrito` (`dis_ID` , `prov_ID` , `dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`campania`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`campania` (
  `cam_ID` INT(11) NOT NULL,
  `cam_nombre` VARCHAR(45) NULL DEFAULT NULL,
  `cam_fecInicio` DATE NULL DEFAULT NULL,
  `cam_fecFinal` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`cam_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`rol` (
  `rol_ID` INT(11) NOT NULL,
  `rol_codigo` INT(8) NULL DEFAULT NULL,
  `rol_descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`rol_ID`),
  UNIQUE INDEX `rol_ID_UNIQUE` (`rol_ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`usuario` (
  `us_ID` INT(11) NOT NULL,
  `us_usename` VARCHAR(15) NULL DEFAULT NULL,
  `us_password` VARCHAR(15) NULL DEFAULT NULL,
  `us_email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`us_ID`),
  UNIQUE INDEX `us_ID_UNIQUE` (`us_ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`usuariorol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`usuariorol` (
  `rol_ID` INT(11) NOT NULL,
  `us_ID` INT(11) NOT NULL,
  PRIMARY KEY (`rol_ID`, `us_ID`),
  INDEX `fk_UsuarioRol_Usuario1_idx` (`us_ID` ASC),
  CONSTRAINT `fk_UsuarioRol_Rol`
    FOREIGN KEY (`rol_ID`)
    REFERENCES `bd_alpakitay`.`rol` (`rol_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UsuarioRol_Usuario1`
    FOREIGN KEY (`us_ID`)
    REFERENCES `bd_alpakitay`.`usuario` (`us_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`ganadero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`ganadero` (
  `gan_ID` INT(11) NOT NULL,
  `rol_ID` INT(11) NOT NULL,
  `us_ID` INT(11) NOT NULL,
  `gan_DNI` INT(8) NULL DEFAULT NULL,
  `gan_fechNacimiento` DATE NULL DEFAULT NULL,
  `gan_instruccion` VARCHAR(45) NULL DEFAULT NULL,
  `gan_predio` VARCHAR(45) NULL DEFAULT NULL,
  `gan_parentesco` VARCHAR(20) NULL DEFAULT NULL,
  `gan_procedencia` VARCHAR(20) NULL DEFAULT NULL,
  `gan_tiempPermanencia` VARCHAR(45) NULL DEFAULT NULL,
  `gan_condicion` VARCHAR(20) NULL DEFAULT NULL,
  `gan_observaciones` VARCHAR(50) NULL DEFAULT NULL,
  `gan_ganadoCol` VARCHAR(30) NULL DEFAULT NULL COMMENT 'asd',
  `gan_sector` VARCHAR(30) NULL DEFAULT NULL,
  `an_ID` INT(11) NOT NULL,
  `dis_ID` INT(11) NOT NULL,
  `prov_ID` INT(11) NOT NULL,
  `dep_ID` INT(11) NOT NULL,
  PRIMARY KEY (`gan_ID`),
  INDEX `fk_Ganadero_UsuarioRol1_idx` (`rol_ID` ASC, `us_ID` ASC),
  INDEX `fk_Ganadero_Anexo1_idx` (`an_ID` ASC, `dis_ID` ASC, `prov_ID` ASC, `dep_ID` ASC),
  CONSTRAINT `fk_Ganadero_Anexo1`
    FOREIGN KEY (`an_ID` , `dis_ID` , `prov_ID` , `dep_ID`)
    REFERENCES `bd_alpakitay`.`anexo` (`an_ID` , `dis_ID` , `prov_ID` , `dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ganadero_UsuarioRol1`
    FOREIGN KEY (`rol_ID` , `us_ID`)
    REFERENCES `bd_alpakitay`.`usuariorol` (`rol_ID` , `us_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`ganado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`ganado` (
  `ga_ID` INT(11) NOT NULL,
  `ga_sector` VARCHAR(20) NULL DEFAULT NULL,
  `ga_fecNacimiento` DATE NULL DEFAULT NULL,
  `ga_sexo` VARCHAR(10) NULL DEFAULT NULL,
  `ga_raza` VARCHAR(20) NULL DEFAULT NULL,
  `ga_fecMedicion` DATE NULL DEFAULT NULL,
  `ga_color` VARCHAR(20) NULL DEFAULT NULL,
  `ga_medCabeza` DECIMAL(2,0) NULL DEFAULT NULL,
  `ga_medTalla` DECIMAL(2,0) NULL DEFAULT NULL,
  `ga_apariencia Gral` VARCHAR(45) NULL DEFAULT NULL,
  `ga_medFinura` DECIMAL(2,0) NULL DEFAULT NULL,
  `ga_medUniformidad` DECIMAL(2,0) NULL DEFAULT NULL,
  `ga_medDensidad` DECIMAL(2,0) NULL DEFAULT NULL,
  `ga_medRisos` DECIMAL(2,0) NULL DEFAULT NULL,
  `ga_medPuntaje` INT(11) NULL DEFAULT NULL,
  `ga_clasificacion` VARCHAR(25) NULL DEFAULT NULL,
  `ga_beneficiado` VARCHAR(25) NULL DEFAULT NULL,
  `gan_ID` INT(11) NOT NULL,
  `an_ID` INT(11) NOT NULL,
  `dis_ID` INT(11) NOT NULL,
  `prov_ID` INT(11) NOT NULL,
  `dep_ID` INT(11) NOT NULL,
  `ga_ID_madre` INT(11) NULL DEFAULT NULL,
  `ga_ID_padre` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ga_ID`),
  INDEX `fk_Ganado_Ganadero1_idx` (`gan_ID` ASC),
  INDEX `fk_Ganado_Anexo1_idx` (`an_ID` ASC, `dis_ID` ASC, `prov_ID` ASC, `dep_ID` ASC),
  CONSTRAINT `fk_Ganado_Anexo1`
    FOREIGN KEY (`an_ID` , `dis_ID` , `prov_ID` , `dep_ID`)
    REFERENCES `bd_alpakitay`.`anexo` (`an_ID` , `dis_ID` , `prov_ID` , `dep_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ganado_Ganadero1`
    FOREIGN KEY (`gan_ID`)
    REFERENCES `bd_alpakitay`.`ganadero` (`gan_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`historiaclinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`historiaclinica` (
  `hc_ID` INT(11) NOT NULL,
  `hc_aptoReproducirse` VARCHAR(2) NULL DEFAULT NULL,
  `ga_ID` INT(11) NOT NULL,
  PRIMARY KEY (`hc_ID`),
  INDEX `fk_HistoriaClinica_Ganado1_idx` (`ga_ID` ASC),
  CONSTRAINT `fk_HistoriaClinica_Ganado1`
    FOREIGN KEY (`ga_ID`)
    REFERENCES `bd_alpakitay`.`ganado` (`ga_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`consulta` (
  `con_ID` INT(11) NOT NULL,
  `con_diagnostico` VARCHAR(45) NULL DEFAULT NULL,
  `con_tratamiento` VARCHAR(45) NULL DEFAULT NULL,
  `hc_ID` INT(11) NOT NULL,
  PRIMARY KEY (`con_ID`),
  INDEX `fk_Consulta_HistoriaClinica1_idx` (`hc_ID` ASC),
  CONSTRAINT `fk_Consulta_HistoriaClinica1`
    FOREIGN KEY (`hc_ID`)
    REFERENCES `bd_alpakitay`.`historiaclinica` (`hc_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`estado` (
  `est_ID` INT(11) NOT NULL,
  `est_codigo` VARCHAR(10) NULL DEFAULT NULL,
  `est_descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`est_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`resultado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`resultado` (
  `res_ID` INT(11) NOT NULL,
  `res_codigo` VARCHAR(10) NULL DEFAULT NULL,
  `res_descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`res_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_alpakitay`.`mejoramientogenetico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_alpakitay`.`mejoramientogenetico` (
  `mg_ID` INT(11) NOT NULL,
  `mg_resultadoID` INT(11) NULL DEFAULT NULL,
  `mg_fecEvento` DATE NULL DEFAULT NULL,
  `cam_ID` INT(11) NOT NULL,
  `est_ID` INT(11) NOT NULL,
  `res_ID` INT(11) NOT NULL,
  `ga_ID_macho` INT(11) NOT NULL,
  `ga_ID_hembra` INT(11) NOT NULL,
  PRIMARY KEY (`mg_ID`),
  INDEX `fk_MejoramientoGenetico_Campania1_idx` (`cam_ID` ASC),
  INDEX `fk_MejoramientoGenetico_Estado1_idx` (`est_ID` ASC),
  INDEX `fk_MejoramientoGenetico_Resultado1_idx` (`res_ID` ASC),
  INDEX `fk_MejoramientoGenetico_Ganado1_idx` (`ga_ID_macho` ASC),
  INDEX `fk_MejoramientoGenetico_Ganado2_idx` (`ga_ID_hembra` ASC),
  CONSTRAINT `fk_MejoramientoGenetico_Campania1`
    FOREIGN KEY (`cam_ID`)
    REFERENCES `bd_alpakitay`.`campania` (`cam_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MejoramientoGenetico_Estado1`
    FOREIGN KEY (`est_ID`)
    REFERENCES `bd_alpakitay`.`estado` (`est_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MejoramientoGenetico_Ganado1`
    FOREIGN KEY (`ga_ID_macho`)
    REFERENCES `bd_alpakitay`.`ganado` (`ga_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MejoramientoGenetico_Ganado2`
    FOREIGN KEY (`ga_ID_hembra`)
    REFERENCES `bd_alpakitay`.`ganado` (`ga_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MejoramientoGenetico_Resultado1`
    FOREIGN KEY (`res_ID`)
    REFERENCES `bd_alpakitay`.`resultado` (`res_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
