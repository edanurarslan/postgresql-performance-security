-- ============================================================
-- 3. ADIM: İZLEME (MONITORING) VE BAKIM (MAINTENANCE)
-- Amacı: En çok kaynak tüketen sorguları ve disk durumunu izlemek.
-- ============================================================

-- İzleme eklentisini aktifleştir (Öncesinde postgresql.conf ayarı gerekir)
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- EN ÇOK CPU TÜKETEN İLK 5 SORGU (DBA Raporu)
SELECT 
    query, 
    calls, 
    round(total_exec_time::numeric, 2) AS total_ms,
    round(mean_exec_time::numeric, 2) AS avg_ms
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 5;

-- DİSK YÖNETİMİ: Ölü Satır (Dead Tuple) Kontrolü
-- Eğer n_dead_tup yüksekse VACUUM gerekir.
SELECT relname, n_dead_tup, last_vacuum, last_analyze 
FROM pg_stat_user_tables;
