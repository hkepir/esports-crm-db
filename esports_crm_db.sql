-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

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
  `sifre` VARCHAR(45) NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`kullanici_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OYUNCULAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OYUNCULAR` (
  `oyuncu_id` INT NOT NULL,
  `kullanici_id` INT NULL,
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


-- -----------------------------------------------------
-- Table `mydb`.`ORGANIZASYONLAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ORGANIZASYONLAR` (
  `organizasyon_id` INT NOT NULL,
  `ad` VARCHAR(45) NULL,
  `mail` VARCHAR(45) NULL,
  `ulke` VARCHAR(45) NULL,
  PRIMARY KEY (`organizasyon_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TAKIM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TAKIM` (
  `takim_id` INT NOT NULL,
  `organizasyon_id` INT NULL,
  `takim_adi` VARCHAR(45) NULL,
  `olusturulma_tarihi` DATETIME NULL,
  `puan` INT NULL,
  PRIMARY KEY (`takim_id`),
  INDEX `organizasyon-takim_idx` (`organizasyon_id` ASC) VISIBLE,
  CONSTRAINT `organizasyon-takim`
    FOREIGN KEY (`organizasyon_id`)
    REFERENCES `mydb`.`ORGANIZASYONLAR` (`organizasyon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TAKIM_UYELERİ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TAKIM_UYELERİ` (
  `takim_id` INT NOT NULL,
  `oyuncu_id` INT NOT NULL,
  `katilma_tarihi` DATETIME NULL,
  `ayrilma_tarihi` DATETIME NULL,
  `aktif_mi` TINYINT NULL,
  `kaptan_mi` TINYINT NULL,
  PRIMARY KEY (`takim_id`, `oyuncu_id`),
  INDEX `oyuncu-uye_idx` (`oyuncu_id` ASC) VISIBLE,
  CONSTRAINT `takım-uye`
    FOREIGN KEY (`takim_id`)
    REFERENCES `mydb`.`TAKIM` (`takim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `oyuncu-uye`
    FOREIGN KEY (`oyuncu_id`)
    REFERENCES `mydb`.`OYUNCULAR` (`oyuncu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OYUNLAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OYUNLAR` (
  `oyun_id` INT NOT NULL,
  `oyun_adi` VARCHAR(45) NULL,
  `tur` VARCHAR(45) NULL,
  PRIMARY KEY (`oyun_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TURNUVALAR`
-- -----------------------------------------------------
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
    REFERENCES `mydb`.`OYUNLAR` (`oyun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `organizasyon-turnuva`
    FOREIGN KEY (`organizasyon_id`)
    REFERENCES `mydb`.`ORGANIZASYONLAR` (`organizasyon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TURNUVA_ASAMALARI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TURNUVA_ASAMALARI` (
  `asama_id` INT NOT NULL,
  `turnuva_id` INT NULL,
  `asama_tipi` VARCHAR(45) NULL,
  `asama_sirasi` VARCHAR(45) NULL,
  PRIMARY KEY (`asama_id`),
  INDEX `turnuva-asama_idx` (`turnuva_id` ASC) VISIBLE,
  CONSTRAINT `turnuva-asama`
    FOREIGN KEY (`turnuva_id`)
    REFERENCES `mydb`.`TURNUVALAR` (`turnuva_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MACLAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MACLAR` (
  `mac_id` INT NOT NULL,
  `asama_id` INT NULL,
  `takim1_id` INT NULL,
  `takim2_id` INT NULL,
  `kazanan_takim_id` INT NULL,
  `mac_tarihi` DATETIME NULL,
  `durum` VARCHAR(45) NULL,
  PRIMARY KEY (`mac_id`),
  INDEX `takim2-mac_idx` (`takim2_id` ASC) VISIBLE,
  INDEX `takim1-maç_idx` (`takim1_id` ASC) VISIBLE,
  INDEX `turnuva_aşaması- maç_idx` (`asama_id` ASC) VISIBLE,
  INDEX `kazanan_takım-maç_idx` (`kazanan_takim_id` ASC) VISIBLE,
  CONSTRAINT `turnuva_aşaması- maç`
    FOREIGN KEY (`asama_id`)
    REFERENCES `mydb`.`TURNUVA_ASAMALARI` (`asama_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `takim1-maç`
    FOREIGN KEY (`takim1_id`)
    REFERENCES `mydb`.`TAKIM` (`takim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `takim2-mac`
    FOREIGN KEY (`takim2_id`)
    REFERENCES `mydb`.`TAKIM` (`takim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `kazanan_takım-maç`
    FOREIGN KEY (`kazanan_takim_id`)
    REFERENCES `mydb`.`TAKIM` (`takim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Kullanici_Aktiviteleri`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Kullanici_Aktiviteleri` (
  `aktivite_id` INT NOT NULL,
  `kullanici_id` INT NULL,
  `aktivite_tipi` VARCHAR(45) NULL,
  `tarih` DATETIME NULL,
  `detay` VARCHAR(500) NULL,
  PRIMARY KEY (`aktivite_id`),
  INDEX `aktiviteler_kullanici_idx` (`kullanici_id` ASC) VISIBLE,
  CONSTRAINT `aktiviteler_kullanici`
    FOREIGN KEY (`kullanici_id`)
    REFERENCES `mydb`.`KULLANICILAR` (`kullanici_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Kullanici_Tercihleri`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Kullanici_Tercihleri` (
  `tercih_id` INT NOT NULL,
  `kullanici_id` INT NULL,
  `oyun_id` INT NULL,
  `tercih_seviyesi` TINYINT NULL,
  PRIMARY KEY (`tercih_id`),
  INDEX `kullanici-tercih_idx` (`kullanici_id` ASC) VISIBLE,
  CONSTRAINT `kullanici-tercih`
    FOREIGN KEY (`kullanici_id`)
    REFERENCES `mydb`.`KULLANICILAR` (`kullanici_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Turnuva_Degerlendirmeleri`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Turnuva_Degerlendirmeleri` (
  `degerlendirme_id` INT NOT NULL,
  `kullanici_id` INT NULL,
  `turnuva_id` INT NULL,
  `puan` INT NULL,
  `yorum` VARCHAR(500) NULL,
  PRIMARY KEY (`degerlendirme_id`),
  INDEX `degerlendirme kullanıcı_idx` (`kullanici_id` ASC) VISIBLE,
  INDEX `turnuva-degerlendirme_idx` (`turnuva_id` ASC) VISIBLE,
  CONSTRAINT `degerlendirme kullanıcı`
    FOREIGN KEY (`kullanici_id`)
    REFERENCES `mydb`.`KULLANICILAR` (`kullanici_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `turnuva-degerlendirme`
    FOREIGN KEY (`turnuva_id`)
    REFERENCES `mydb`.`TURNUVALAR` (`turnuva_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Oneriler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Oneriler` (
  `oneri_id` INT NOT NULL,
  `kullanici_id` INT NULL,
  `turnuva_id` INT NULL,
  `neden` VARCHAR(45) NULL,
  `oluşturulma_tarihi` DATETIME NULL,
  PRIMARY KEY (`oneri_id`),
  INDEX `oneri-oyuncu_idx` (`kullanici_id` ASC) VISIBLE,
  CONSTRAINT `oneri-oyuncu`
    FOREIGN KEY (`kullanici_id`)
    REFERENCES `mydb`.`KULLANICILAR` (`kullanici_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `oneri-turnuva`
    FOREIGN KEY ()
    REFERENCES `mydb`.`TURNUVALAR` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OYUNCU_ISTATISTIKLERI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OYUNCU_ISTATISTIKLERI` (
  `istatistik_id` INT NOT NULL,
  `mac_id` INT NULL,
  `oyuncu_id` INT NULL,
  `takim_id` INT NULL,
  `oldurme` INT NULL,
  `olum` INT NULL,
  `asist` INT NULL,
  PRIMARY KEY (`istatistik_id`),
  INDEX `oyuncu-istatistik_idx` (`oyuncu_id` ASC) VISIBLE,
  INDEX `mac-istatistik_idx` (`mac_id` ASC) VISIBLE,
  INDEX `takım-istatistik_idx` (`takim_id` ASC) VISIBLE,
  CONSTRAINT `oyuncu-istatistik`
    FOREIGN KEY (`oyuncu_id`)
    REFERENCES `mydb`.`OYUNCULAR` (`oyuncu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mac-istatistik`
    FOREIGN KEY (`mac_id`)
    REFERENCES `mydb`.`MACLAR` (`mac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `takım-istatistik`
    FOREIGN KEY (`takim_id`)
    REFERENCES `mydb`.`TAKIM` (`takim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TURNUVA_KAYITLARI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TURNUVA_KAYITLARI` (
  `takim_id` INT NOT NULL,
  `turnuva_id` INT NOT NULL,
  `kayit_tarihi` DATETIME NULL,
  `kayit_durumu` VARCHAR(45) NULL,
  PRIMARY KEY (`takim_id`, `turnuva_id`),
  INDEX `turnuvalar-turnuva kayıt_idx` (`turnuva_id` ASC) VISIBLE,
  CONSTRAINT `takımlar-turnuva_kayıt`
    FOREIGN KEY (`takim_id`)
    REFERENCES `mydb`.`TAKIM` (`takim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `turnuvalar-turnuva kayıt`
    FOREIGN KEY (`turnuva_id`)
    REFERENCES `mydb`.`TURNUVALAR` (`turnuva_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MAC_SKORLARI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MAC_SKORLARI` (
  `mac_id` INT NOT NULL,
  `takim_id` INT NOT NULL,
  `skor` INT NULL,
  PRIMARY KEY (`mac_id`, `takim_id`),
  INDEX `takım-skor_idx` (`takim_id` ASC) VISIBLE,
  CONSTRAINT `mac-skor`
    FOREIGN KEY (`mac_id`)
    REFERENCES `mydb`.`MACLAR` (`mac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `takım-skor`
    FOREIGN KEY (`takim_id`)
    REFERENCES `mydb`.`TAKIM` (`takim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ODULLER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ODULLER` (
  `odul_id` INT NOT NULL,
  `turnuva_id` INT NULL,
  `takim_id` INT NULL,
  `siralama` INT NULL,
  `miktar` FLOAT NULL,
  PRIMARY KEY (`odul_id`),
  INDEX `odul-turnuva_idx` (`turnuva_id` ASC) VISIBLE,
  INDEX `odul-takım_idx` (`takim_id` ASC) VISIBLE,
  UNIQUE INDEX `turnuva_id_UNIQUE` (`turnuva_id` ASC) VISIBLE,
  UNIQUE INDEX `siralama_UNIQUE` (`siralama` ASC) VISIBLE,
  CONSTRAINT `odul-turnuva`
    FOREIGN KEY (`turnuva_id`)
    REFERENCES `mydb`.`TURNUVALAR` (`turnuva_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `odul-takım`
    FOREIGN KEY (`takim_id`)
    REFERENCES `mydb`.`TAKIM` (`takim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SPONSORLAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SPONSORLAR` (
  `sponsor_id` INT NOT NULL,
  `sponsor_adi` VARCHAR(45) NULL,
  `sponsor_sektoru` VARCHAR(45) NULL,
  PRIMARY KEY (`sponsor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SPONSOR_ANLASMALARI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SPONSOR_ANLASMALARI` (
  `anlasma_id` INT NOT NULL,
  `sponsor_id` INT NULL,
  `turnuva_id` INT NULL,
  `tutar` FLOAT NULL,
  `baslangic_tarihi` DATETIME NULL,
  `bitis_tarihi` DATETIME NULL,
  PRIMARY KEY (`anlasma_id`),
  INDEX `sponsor-anlaşma_idx` (`sponsor_id` ASC) VISIBLE,
  INDEX `anlaşma-turnuva_idx` (`turnuva_id` ASC) VISIBLE,
  CONSTRAINT `sponsor-anlaşma`
    FOREIGN KEY (`sponsor_id`)
    REFERENCES `mydb`.`SPONSORLAR` (`sponsor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `anlaşma-turnuva`
    FOREIGN KEY (`turnuva_id`)
    REFERENCES `mydb`.`TURNUVALAR` (`turnuva_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
