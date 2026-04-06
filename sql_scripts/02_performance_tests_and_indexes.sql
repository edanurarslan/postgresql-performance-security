{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- ============================================================\
-- 2. ADIM: PERFORMANS ANAL\uc0\u304 Z\u304  VE \u304 NDEKSEME STRATEJ\u304 LER\u304 \
-- Amac\uc0\u305 : Query Plan analizi ve %75 performans art\u305 \u351 \u305  sa\u287 lamak.\
-- ============================================================\
\
-- TEST 1: \uc0\u304 ndekssiz Sorgu (Sequential Scan)\
-- Beklenen S\'fcre: ~185ms\
EXPLAIN ANALYZE\
SELECT k.isim, s.tutar, s.siparis_tarihi\
FROM kullanicilar k\
JOIN siparisler s ON k.id = s.kullanici_id\
WHERE k.sehir = 'Ankara' AND s.tutar > 800;\
\
-- OPT\uc0\u304 M\u304 ZASYON: Covering Index (Kapsayan \u304 ndeks) Uygulamas\u305 \
-- INCLUDE yan c\'fcmlesi ile Heap (tablo) eri\uc0\u351 imi minimize edilir.\
CREATE INDEX idx_kullanicilar_sehir_include ON kullanicilar(sehir) INCLUDE (isim);\
CREATE INDEX idx_siparisler_tutar_include ON siparisler(tutar) INCLUDE (siparis_tarihi, kullanici_id);\
\
-- TEST 2: \uc0\u304 ndeksli Sorgu (Index Only Scan)\
-- Beklenen S\'fcre: ~95ms\
EXPLAIN ANALYZE\
SELECT k.isim, s.tutar, s.siparis_tarihi\
FROM kullanicilar k\
JOIN siparisler s ON k.id = s.kullanici_id\
WHERE k.sehir = 'Ankara' AND s.tutar > 800;}