{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- ============================================================\
-- 1. ADIM: TABLO YAPISI VE VER\uc0\u304  GENERASYONU\
-- Amac\uc0\u305 : Y\'fcksek hacimli veri seti (3 Milyon Sat\u305 r) olu\u351 turmak.\
-- ============================================================\
\
-- Tablolar\uc0\u305  temizle (Varsa)\
DROP TABLE IF EXISTS siparisler;\
DROP TABLE IF EXISTS kullanicilar;\
\
-- Kullan\uc0\u305 c\u305 lar Tablosu (1 Milyon Sat\u305 r)\
CREATE TABLE kullanicilar (\
    id SERIAL PRIMARY KEY,\
    isim TEXT,\
    sehir TEXT,\
    kayit_tarihi TIMESTAMP DEFAULT NOW()\
);\
\
-- Sipari\uc0\u351 ler Tablosu (2 Milyon Sat\u305 r)\
CREATE TABLE siparisler (\
    id SERIAL PRIMARY KEY,\
    kullanici_id INTEGER REFERENCES kullanicilar(id),\
    tutar DECIMAL(10,2),\
    siparis_tarihi TIMESTAMP DEFAULT NOW()\
);\
\
-- Rastgele Veri Basma (Generate Series)\
INSERT INTO kullanicilar (isim, sehir)\
SELECT \
    'Kullanici_' || i,\
    (ARRAY['Ankara', 'Istanbul', 'Izmir', 'Bursa', 'Antalya'])[floor(random() * 5 + 1)]\
FROM generate_series(1, 1000000) s(i);\
\
INSERT INTO siparisler (kullanici_id, tutar, siparis_tarihi)\
SELECT \
    floor(random() * 1000000 + 1),\
    (random() * 1000)::decimal(10,2),\
    NOW() - (random() * interval '365 days')\
FROM generate_series(1, 2000000) s(i);\
\
-- \uc0\u304 statistikleri topla\
ANALYZE kullanicilar;\
ANALYZE siparisler;}