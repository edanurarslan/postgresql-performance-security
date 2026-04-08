-- ============================================================
-- 2. ADIM: PERFORMANS ANALİZİ VE İNDEKSEME STRATEJİLERİ
-- Amacı: Query Plan analizi ve %75 performans artışı sağlamak.
-- ============================================================

-- TEST 1: İndekssiz Sorgu (Sequential Scan)
-- Beklenen Süre: ~185ms
EXPLAIN ANALYZE
SELECT k.isim, s.tutar, s.siparis_tarihi
FROM kullanicilar k
JOIN siparisler s ON k.id = s.kullanici_id
WHERE k.sehir = 'Ankara' AND s.tutar > 800;

-- OPTİMİZASYON: Covering Index (Kapsayan İndeks) Uygulaması
-- INCLUDE yan cümlesi ile Heap (tablo) erişimi minimize edilir.
CREATE INDEX idx_kullanicilar_sehir_include ON kullanicilar(sehir) INCLUDE (isim);
CREATE INDEX idx_siparisler_tutar_include ON siparisler(tutar) INCLUDE (siparis_tarihi, kullanici_id);

-- TEST 2: İndeksli Sorgu (Index Only Scan)
-- Beklenen Süre: ~95ms
EXPLAIN ANALYZE
SELECT k.isim, s.tutar, s.siparis_tarihi
FROM kullanicilar k
JOIN siparisler s ON k.id = s.kullanici_id
WHERE k.sehir = 'Ankara' AND s.tutar > 800;
