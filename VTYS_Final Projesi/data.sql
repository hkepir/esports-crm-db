--Hilal Kepir 23360859088

INSERT INTO Organizasyonlar (organizasyon_adi, merkez) VALUES
('ESL', 'Koln'),
('BLAST', 'Kopenhag');

INSERT INTO Sponsorlar (sponsor_adi, sektor) VALUES
('Intel', 'Teknoloji'),
('Red Bull', 'Icecek');

INSERT INTO Takimlar (takim_adi, kurulus_tarihi) VALUES
('Natus Vincere', '2009-12-17'),
('FaZe Clan', '2010-05-30'),
('G2 Esports', '2014-02-24');

INSERT INTO Kullanicilar (takim_id, ad, email, kayit_tarihi) VALUES
(1, 'Oleksandr Kostyliev', 's1mple@mail.com', '2026-01-10'),
(2, 'Finn Andersen', 'karrigan@mail.com', '2026-02-15'),
(3, 'Nikola Kovac', 'niko@mail.com', '2026-03-20');

INSERT INTO Kullanici_Tercihleri (kullanici_id, oyun_turu, seviye) VALUES
(1, 'FPS', 'Profesyonel'),
(2, 'FPS', 'Profesyonel'),
(3, 'FPS', 'Profesyonel');

INSERT INTO Turnuvalar (organizasyon_id, turnuva_adi, baslangic_tarihi, odul_havuzu) VALUES
(1, 'ESL Pro League Season 23', '2026-07-01', 500000.00),
(2, 'BLAST Premier Spring', '2026-08-01', 750000.00);

INSERT INTO Sponsor_Anlasmalari (sponsor_id, turnuva_id, sponsorluk_tutari, baslangic_tarihi) VALUES
(1, 1, 75000.00, '2026-06-01'),
(2, 2, 90000.00, '2026-07-01');

INSERT INTO Maclar (turnuva_id, takim1_id, takim2_id, takim1_skor, takim2_skor, mac_tarihi, durum) VALUES
(1, 1, 2, 2, 1, '2026-07-02 18:00:00', 'Oynandi'), -- NaVi vs FaZe
(1, 2, 3, 0, 0, '2026-07-03 21:00:00', 'Bekleniyor'),-- FaZe vs G2
(2, 3, 1, 0, 2, '2026-08-05 19:30:00', 'Oynandi'); -- G2 vs NaVi