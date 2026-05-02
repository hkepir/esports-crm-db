
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`KULLANICILAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`KULLANICILAR` (
  `kullanici_id` INT NOT NULL,
  `kullanici_adi` VARCHAR(45) NOT NULL,
  `kullanici_soyadi` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `sifre` VARCHAR(255) NOT NULL, -- Şifre alanı güvenli hashleme için 255 yapıldı
  `rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`kullanici_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`OYUNCULAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OYUNCULAR` (
  `oyuncu_id` INT NOT NULL,
  `kullanici_id` INT NOT NULL, -- Her oyuncu bir kullanıcı olmalıdır
  `nickname` VARCHAR(45) NOT NULL,
  `ulke` VARCHAR(45) NULL,
  PRIMARY KEY (`oyuncu_id`),
  INDEX `kullanıcı-oyuncu_idx` (`kullanici_id` ASC) VISIBLE,
  CONSTRAINT `kullanıcı-oyuncu`
    FOREIGN KEY (`kullanici_id`)
    REFERENCES `mydb`.`KULLANICILAR` (`kullanici_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`OYUNLAR` (
  `oyun_id` INT NOT NULL,
  `oyun_adi` VARCHAR(45) NULL,
  `tur` VARCHAR(45) NULL,
  PRIMARY KEY (`oyun_id`))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `mydb`.`TURNUVALAR` (
  `turnuva_id` INT NOT NULL,
  `organizasyon_id` INT NULL,
  `oyun_id` INT NULL,
  `baslangic_tarihi` DATETIME NULL,
  `bitis_tarihi` DATETIME NULL,
  `durum` VARCHAR(45) NULL,
  PRIMARY KEY (`turnuva_id`),
  INDEX `organizasyon-oyun_idx` (`oyun_id` ASC) VISIBLE,
  INDEX `organizasyon-turnuva_idx` (`organizasyon_id` ASC) VISIBLE,
  CONSTRAINT `organizasyon-oyun`
    FOREIGN KEY (`oyun_id`)
    REFERENCES `mydb`.`OYUNLAR` (`oyun_id`),
  CONSTRAINT `organizasyon-turnuva`
    FOREIGN KEY (`organizasyon_id`)
    REFERENCES `mydb`.`ORGANIZASYONLAR` (`organizasyon_id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Kullanici_Tercihleri` (
  `tercih_id` INT NOT NULL,
  `kullanici_id` INT NULL,
  `oyun_id` INT NULL,
  `tercih_seviyesi` TINYINT NULL,
  PRIMARY KEY (`tercih_id`),
  INDEX `kullanici-tercih_idx` (`kullanici_id` ASC) VISIBLE,
  INDEX `oyun-tercih_idx` (`oyun_id` ASC) VISIBLE,
  CONSTRAINT `kullanici-tercih`
    FOREIGN KEY (`kullanici_id`)
    REFERENCES `mydb`.`KULLANICILAR` (`kullanici_id`),
  CONSTRAINT `oyun-tercih`
    FOREIGN KEY (`oyun_id`)
    REFERENCES `mydb`.`OYUNLAR` (`oyun_id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`Oneriler` (
  `oneri_id` INT NOT NULL,
  `kullanici_id` INT NULL,
  `turnuva_id` INT NULL,
  `neden` VARCHAR(45) NULL,
  `oluşturulma_tarihi` DATETIME NULL,
  PRIMARY KEY (`oneri_id`),
  INDEX `oneri-oyuncu_idx` (`kullanici_id` ASC) VISIBLE,
  INDEX `oneri-turnuva_idx` (`turnuva_id` ASC) VISIBLE,
  CONSTRAINT `oneri-oyuncu`
    FOREIGN KEY (`kullanici_id`)
    REFERENCES `mydb`.`KULLANICILAR` (`kullanici_id`),
  CONSTRAINT `oneri-turnuva`
    FOREIGN KEY (`turnuva_id`) -- Boş parantezler dolduruldu
    REFERENCES `mydb`.`TURNUVALAR` (`turnuva_id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `mydb`.`ODULLER` (
  `odul_id` INT NOT NULL,
  `turnuva_id` INT NULL,
  `takim_id` INT NULL,
  `siralama` INT NULL,
  `miktar` FLOAT NULL,
  PRIMARY KEY (`odul_id`),
  INDEX `odul-turnuva_idx` (`turnuva_id` ASC) VISIBLE,
  INDEX `odul-takım_idx` (`takim_id` ASC) VISIBLE,
  -- Hatalı UNIQUE kısıtlamaları kaldırıldı, kompozit UNIQUE eklendi:
  UNIQUE INDEX `turnuva_siralama_UNIQUE` (`turnuva_id` ASC, `siralama` ASC) VISIBLE,
  CONSTRAINT `odul-turnuva`
    FOREIGN KEY (`turnuva_id`)
    REFERENCES `mydb`.`TURNUVALAR` (`turnuva_id`),
  CONSTRAINT `odul-takım`
    FOREIGN KEY (`takim_id`)
    REFERENCES `mydb`.`TAKIM` (`takim_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;