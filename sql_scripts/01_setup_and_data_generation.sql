-- ============================================================
-- 1. ADIM: TABLO YAPISI VE VERİ GENERASYONU
-- Amacı: Yüksek hacimli veri seti (3 Milyon Satır) oluşturmak.
-- ============================================================

-- Tabloları temizle (Varsa)
DROP TABLE IF EXISTS siparisler;
DROP TABLE IF EXISTS kullanicilar;

-- Kullanıcılar Tablosu (1 Milyon Satır)
CREATE TABLE kullanicilar (
    id SERIAL PRIMARY KEY,
    isim TEXT,
    sehir TEXT,
    kayit_tarihi TIMESTAMP DEFAULT NOW()
);

-- Siparişler Tablosu (2 Milyon Satır)
CREATE TABLE siparisler (
    id SERIAL PRIMARY KEY,
    kullanici_id INTEGER REFERENCES kullanicilar(id),
    tutar DECIMAL(10,2),
    siparis_tarihi TIMESTAMP DEFAULT NOW()
);

-- Rastgele Veri Basma (Generate Series)
INSERT INTO kullanicilar (isim, sehir)
SELECT 
    'Kullanici_' || i,
    (ARRAY['Ankara', 'Istanbul', 'Izmir', 'Bursa', 'Antalya'])[floor(random() * 5 + 1)]
FROM generate_series(1, 1000000) s(i);

INSERT INTO siparisler (kullanici_id, tutar, siparis_tarihi)
SELECT 
    floor(random() * 1000000 + 1),
    (random() * 1000)::decimal(10,2),
    NOW() - (random() * interval '365 days')
FROM generate_series(1, 2000000) s(i);

-- İstatistikleri topla
ANALYZE kullanicilar;
ANALYZE siparisler;
