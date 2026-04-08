{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- ============================================================\
-- 4. ADIM: ER\uc0\u304 \u350 \u304 M Y\'d6NET\u304 M\u304  VE G\'dcVENL\u304 K (RBAC)\
-- Amac\uc0\u305 : Rol bazl\u305  yetkilendirme ve veri g\'fcvenli\u287 ini sa\u287 lamak.\
-- ============================================================\
\
-- 1. Analist Rol\'fc (Read-Only)\
CREATE ROLE analist_rolu WITH LOGIN PASSWORD 'EdaAnalist123';\
GRANT USAGE ON SCHEMA public TO analist_rolu;\
GRANT SELECT ON ALL TABLES IN SCHEMA public TO analist_rolu;\
\
-- 2. Geli\uc0\u351 tirici Rol\'fc (DML Yetkili, Delete Yasak)\
CREATE ROLE gelistirici_rolu WITH LOGIN PASSWORD 'EdaDev2026';\
GRANT USAGE ON SCHEMA public TO gelistirici_rolu;\
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO gelistirici_rolu;\
\
-- G\'dcVENL\uc0\u304 K TEST\u304  (Do\u287 rulama)\
-- Bu i\uc0\u351 lem 'Permission Denied' hatas\u305  vermelidir.\
SET ROLE analist_rolu;\
DELETE FROM siparisler WHERE id = 1;\
\
-- Eski yetkiye geri d\'f6n (Admin)\
RESET ROLE;}