--Hilal Kepir 23360859088

-- SORGU 1: Kullanicilarin Takim Bilgileri ve Kisisel Tercihleri
-- Aciklama: Kullanicilar, Takimlar ve Kullanici_Tercihleri tablolarini 
-- JOIN ederek oyuncunun hangi takimda oynadigini ve oyun tercihini gosterir.

SELECT 
    k.ad AS 'Oyuncu Adi',
    t.takim_adi AS 'Oynadigi Takim',
    kt.oyun_turu AS 'Uzmanlik Alani',
    kt.seviye AS 'Oyun Seviyesi'
FROM Kullanicilar k
LEFT JOIN Takimlar t ON k.takim_id = t.takim_id
LEFT JOIN Kullanici_Tercihleri kt ON k.kullanici_id = kt.kullanici_id;

-- SORGU 2: Turnuvalar, Duzenleyen Organizasyonlar ve Turnuva Maclari
-- Aciklama: Turnuvalar tablosunu organizasyon_id uzerinden Organizasyonlar'a,
-- turnuva_id uzerinden de Maclar tablosuna baglar. 
-- Hangi turnuvanin hangi organizasyona ait oldugunu ve o turnuvada yapilan maclarin tarihlerini listeler.

SELECT
    o.organizasyon_adi AS 'Organizasyon Adi',
    t.turnuva_adi AS 'Turnuva Adi',
    t.odul_havuzu AS 'Odul Havuzu',
    m.mac_tarihi AS 'Mac Tarihi',
    m.durum AS 'MAc Durumu'
FROM Turnuvalar t
INNER JOIN Organizasyonlar o ON t.organizasyon_id = o.organizasyon_id
INNER JOIN Maclar m ON t.turnuva_id = m.turnuva_id;