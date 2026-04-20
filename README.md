# VİDEO LİNK: https://youtu.be/JYZUe4iiHGc

# PostgreSQL Performance, Monitoring & Security Lab

Bu proje, 3 milyon satırlık bir veri seti üzerinde performans darboğazlarının tespiti, ileri seviye indeksleme stratejileri ve kurumsal seviyede güvenlik protokollerinin uygulanmasını içeren kapsamlı bir **Database Administration (DBA)** vaka çalışmasıdır.

## Proje Özeti
Yüksek hacimli veri trafiği altında çalışan bir sistemin; sadece hızlı değil, aynı zamanda izlenebilir ve güvenli bir mimariye nasıl dönüştürüldüğünü adım adım simüle eder.

### Operasyonel Sonuçlar ve Kazanımlar
Bugün gerçekleştirilen teknik yapılandırmalar ve elde edilen metrikler aşağıda tablolaştırılmıştır:

| Kategori | Yapılan İşlem | Karşılaşılan Teknik Engel | Uygulanan Çözüm | Elde Edilen Sonuç |
| :--- | :--- | :--- | :--- | :--- |
| **Sistem İzleme** | `pg_stat_statements` Aktivasyonu | *Shared Preload Libraries* hatası | `postgresql.conf` kernel seviyesi düzenlemesi | Tüm sorgu trafiği anlık izlenebilir hale geldi. |
| **Servis Yönetimi** | PostgreSQL Restart | *Cannot be run as root* güvenliği | `sudo -u postgres` ile kullanıcı izolasyonu | Veritabanı motoru güvenli modda yeniden başlatıldı. |
| **Disk Yönetimi** | Ölü Satır (Bloat) Analizi | Veri yoğunluğu kontrolü | `pg_stat_user_tables` denetimi | `n_dead_tup: 0` (Sıfır çöp veri) ile disk verimliliği onaylandı. |
| **Erişim Güvenliği** | `analist_rolu` Tanımlama | Yetkisiz silme riski | *Role-Based Access Control* (RBAC) | Sadece okuma (Read-only) yetkisiyle veri bütünlüğü korundu. |
| **Yetki Doğrulama** | Güvenlik Bariyeri Testi | Manuel yetki aşımı denemesi | `SET ROLE` ile yetki simülasyonu | **Permission Denied** (42501) hatasıyla erişim engellendi. |

---

## Temel Kazanımlar

### 1. Sorgu Optimizasyonu (Performance Tuning)
* **Öncesi:** Standart `JOIN` ve filtreleme işlemleri **185 ms** sürmekteydi.
* **Sonrası:** `INCLUDE` yan cümlesi ile oluşturulan **Covering Index** (Kapsayan İndeks) sayesinde sorgu süresi **95 ms** seviyesine düşürüldü.
* **Teknik:** `Sequential Scan` operasyonları, maliyeti çok daha düşük olan `Index Only Scan` operasyonlarına dönüştürüldü.

### 2. İzlenebilirlik (Monitoring)
* PostgreSQL'in "kara kutusu" olan `pg_stat_statements` modülü, işletim sistemi seviyesinde (Kernel level) yapılandırıldı.
* En çok CPU ve I/O tüketen "Top 5" ağır sorgu raporu oluşturularak proaktif bakım altyapısı kuruldu.

### 3. Katmanlı Güvenlik (Security)
* **Least Privilege (En Az Yetki)** prensibi uygulanarak roller ayrıştırıldı.
* Veritabanı sadece dış tehditlere karşı değil, iç yetki karmaşasına karşı da `GRANT/REVOKE` mekanizmalarıyla zırhlandırıldı.

---

## Proje Yapısı
* `/sql_scripts`: Veri üretimi, indeksleme, monitoring ve güvenlik sorguları.
* `/screenshots`: Query Plan analizleri ve güvenlik doğrulama (Permission Denied) görselleri.

---

## Nasıl Denenir?
1. `01_setup.sql` ile 3 milyon satırlık test ortamını kurun.
2. `02_performance.sql` içindeki indeksleme stratejilerini uygulayın.
3. İzleme modülü için `postgresql.conf` dosyasında gerekli `shared_preload_libraries` ayarını yapın ve servisi yeniden başlatın.
4. Rolleri oluşturarak güvenlik testlerini simüle edin.
