-- ============================================================
-- 4. ADIM: ERİŞİM YÖNETİMİ VE GÜVENLİK (RBAC)
-- Amacı: Rol bazlı yetkilendirme ve veri güvenliğini sağlamak.
-- ============================================================

-- 1. Analist Rolü (Read-Only)
CREATE ROLE analist_rolu WITH LOGIN PASSWORD 'EdaAnalist123';
GRANT USAGE ON SCHEMA public TO analist_rolu;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO analist_rolu;

-- 2. Geliştirici Rolü (DML Yetkili, Delete Yasak)
CREATE ROLE gelistirici_rolu WITH LOGIN PASSWORD 'EdaDev2026';
GRANT USAGE ON SCHEMA public TO gelistirici_rolu;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO gelistirici_rolu;

-- GÜVENLİK TESTİ (Doğrulama)
-- Bu işlem 'Permission Denied' hatası vermelidir.
SET ROLE analist_rolu;
DELETE FROM siparisler WHERE id = 1;

-- Eski yetkiye geri dön (Admin)
RESET ROLE;
