--Hilal Kepir 23360859088

DROP TABLE IF EXISTS Maclar;
DROP TABLE IF EXISTS Sponsor_Anlasmalari;
DROP TABLE IF EXISTS Turnuvalar;
DROP TABLE IF EXISTS Kullanici_Tercihleri;
DROP TABLE IF EXISTS Kullanicilar;
DROP TABLE IF EXISTS Takimlar;
DROP TABLE IF EXISTS Sponsorlar;
DROP TABLE IF EXISTS Organizasyonlar;

CREATE TABLE Organizasyonlar (
    organizasyon_id INT AUTO_INCREMENT PRIMARY KEY,
    organizasyon_adi VARCHAR(100) NOT NULL,
    merkez VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Sponsorlar (
    sponsor_id INT AUTO_INCREMENT PRIMARY KEY,
    sponsor_adi VARCHAR(100) NOT NULL,
    sektor VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Takimlar (
    takim_id INT AUTO_INCREMENT PRIMARY KEY,
    takim_adi VARCHAR(100) NOT NULL UNIQUE,
    kurulus_tarihi DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Kullanicilar (
    kullanici_id INT AUTO_INCREMENT PRIMARY KEY,
    takim_id INT,
    ad VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    kayit_tarihi DATE,
    FOREIGN KEY (takim_id) REFERENCES Takimlar(takim_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Kullanici_Tercihleri (
    tercih_id INT AUTO_INCREMENT PRIMARY KEY,
    kullanici_id INT,
    oyun_turu VARCHAR(50),
    seviye VARCHAR(30),
    FOREIGN KEY (kullanici_id) REFERENCES Kullanicilar(kullanici_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Turnuvalar (
    turnuva_id INT AUTO_INCREMENT PRIMARY KEY,
    organizasyon_id INT,
    turnuva_adi VARCHAR(100) NOT NULL,
    baslangic_tarihi DATE,
    odul_havuzu DECIMAL(12,2),
    FOREIGN KEY (organizasyon_id) REFERENCES Organizasyonlar(organizasyon_id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Sponsor_Anlasmalari (
    anlasma_id INT AUTO_INCREMENT PRIMARY KEY,
    sponsor_id INT,
    turnuva_id INT,
    sponsorluk_tutari DECIMAL(12,2),
    baslangic_tarihi DATE,
    FOREIGN KEY (sponsor_id) REFERENCES Sponsorlar(sponsor_id) ON DELETE CASCADE,
    FOREIGN KEY (turnuva_id) REFERENCES Turnuvalar(turnuva_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Maclar (
    mac_id INT AUTO_INCREMENT PRIMARY KEY,
    turnuva_id INT,
    takim1_id INT,
    takim2_id INT,
    takim1_skor INT DEFAULT 0,
    takim2_skor INT DEFAULT 0,
    mac_tarihi DATETIME,
    durum VARCHAR(20) DEFAULT 'Bekleniyor',
    FOREIGN KEY (turnuva_id) REFERENCES Turnuvalar(turnuva_id) ON DELETE CASCADE,
    FOREIGN KEY (takim1_id) REFERENCES Takimlar(takim_id) ON DELETE CASCADE,
    FOREIGN KEY (takim2_id) REFERENCES Takimlar(takim_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;