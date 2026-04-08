{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- ============================================================\
-- 3. ADIM: \uc0\u304 ZLEME (MONITORING) VE BAKIM (MAINTENANCE)\
-- Amac\uc0\u305 : En \'e7ok kaynak t\'fcketen sorgular\u305  ve disk durumunu izlemek.\
-- ============================================================\
\
-- \uc0\u304 zleme eklentisini aktifle\u351 tir (\'d6ncesinde postgresql.conf ayar\u305  gerekir)\
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;\
\
-- EN \'c7OK CPU T\'dcKETEN \uc0\u304 LK 5 SORGU (DBA Raporu)\
SELECT \
    query, \
    calls, \
    round(total_exec_time::numeric, 2) AS total_ms,\
    round(mean_exec_time::numeric, 2) AS avg_ms\
FROM pg_stat_statements\
ORDER BY total_exec_time DESC\
LIMIT 5;\
\
-- D\uc0\u304 SK Y\'d6NET\u304 M\u304 : \'d6l\'fc Sat\u305 r (Dead Tuple) Kontrol\'fc\
-- E\uc0\u287 er n_dead_tup y\'fcksekse VACUUM gerekir.\
SELECT relname, n_dead_tup, last_vacuum, last_analyze \
FROM pg_stat_user_tables;}