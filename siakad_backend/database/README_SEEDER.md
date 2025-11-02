# 📚 Dokumentasi Seeder Database SIAKAD

## 📋 File Seeder yang Tersedia

### 1. `seeder_5_users_complete.sql` ⭐ **RECOMMENDED**
**Seeder lengkap untuk 5 user dengan semua relasi:**
- User ID 1: Shevrie Maulana Husain (Semester 7)
- User ID 4: Test User (Semester 7)
- User ID 13: John Doe (Semester 7)
- User ID 14: Jane Smith (Semester 5)
- User ID 15: Bob Wilson (Semester 3)

**Data yang dimasukkan:**
- ✅ KRS + KRS Details
- ✅ KHS + KHS Details
- ✅ Pembayaran + Pembayaran Details
- ✅ Kerja Praktek + KP Timeline (untuk user 1 & 13)
- ✅ Skripsi + Skripsi Timeline (untuk user 1 & 13)

### 2. `seeder_user_13.sql`
**Seeder khusus untuk User ID 13 (John Doe) - Semester 7**
- KRS + KRS Details (Semester 7)
- KHS + KHS Details (Semester 1-6)
- Pembayaran + Pembayaran Details (Semester 1-7)
- Kerja Praktek + KP Timeline
- Skripsi + Skripsi Timeline

### 3. `seeder_user_14_15_16.sql`
**Seeder untuk 3 user:**
- User ID 14: Jane Smith (Semester 5)
- User ID 15: Bob Wilson (Semester 3)
- User ID 16: Alice Johnson (Semester 1)

## 🔗 Relasi Database yang Diterapkan

Semua seeder mengikuti struktur relasi berikut:

```
users (1)
  │
  ├─── krs (N) ──────── krs_details (N)
  │     └─ user_id FK ───┘ krs_id FK
  │
  ├─── khs (N) ──────── khs_details (N)
  │     └─ user_id FK ───┘ khs_id FK
  │
  ├─── pembayaran (N) ──────── pembayaran_details (N)
  │     └─ user_id FK ─────────────┘ pembayaran_id FK
  │
  ├─── kerja_praktek (1) ──────── kerja_praktek_timeline (N)
  │     └─ user_id FK ───────────────┘ kp_id FK
  │
  └─── skripsi (1) ──────── skripsi_timeline (N)
        └─ user_id FK ─────────────┘ skripsi_id FK
```

## 🚀 Cara Menjalankan Seeder

### Via phpMyAdmin (Paling Mudah)

1. Buka http://localhost/phpmyadmin
2. Pilih database `siakad_db`
3. Klik tab **"SQL"**
4. Copy-paste isi file seeder yang ingin dijalankan
5. Klik **"Go"** untuk menjalankan

### Via Command Line (MySQL)

```bash
# Untuk seeder lengkap 5 user (RECOMMENDED)
mysql -u root -p siakad_db < siakad_backend/database/seeder_5_users_complete.sql

# Untuk seeder user 13 saja
mysql -u root -p siakad_db < siakad_backend/database/seeder_user_13.sql

# Untuk seeder user 14, 15, 16
mysql -u root -p siakad_db < siakad_backend/database/seeder_user_14_15_16.sql
```

### Via MySQL Client

```sql
-- Masuk ke MySQL
mysql -u root -p

-- Pilih database
USE siakad_db;

-- Jalankan seeder
SOURCE siakad_backend/database/seeder_5_users_complete.sql;
```

## ⚠️ Catatan Penting

1. **Pastikan user sudah ada di tabel `users`**
   - Seeder tidak akan menambahkan user baru
   - User harus sudah ada sebelum menjalankan seeder

2. **Foreign Key Constraint**
   - Semua foreign key menggunakan `ON DELETE CASCADE`
   - Jika menghapus user, semua data terkait akan ikut terhapus

3. **Duplikasi Data**
   - Seeder tidak menghapus data lama
   - Jika menjalankan seeder berkali-kali, akan ada data duplikat
   - Gunakan `DELETE` terlebih dahulu jika perlu reset data

4. **Relasi Data**
   - Setiap KRS memiliki detail di `krs_details`
   - Setiap KHS memiliki detail di `khs_details`
   - Setiap Pembayaran memiliki detail di `pembayaran_details`
   - Setiap KP memiliki timeline di `kerja_praktek_timeline`
   - Setiap Skripsi memiliki timeline di `skripsi_timeline`

## 📊 Data yang Akan Tersedia Setelah Seeder

### User ID 1 (Shevrie Maulana Husain - Semester 7)
- ✅ KRS: Semester 7 (7 mata kuliah, 20 SKS)
- ✅ KHS: Semester 1-6
- ✅ Pembayaran: Semester 1-7 (Semester 7 Lunas)
- ✅ Kerja Praktek: Lulus (dengan timeline)
- ✅ Skripsi: On Progress (dengan timeline)

### User ID 4 (Test User - Semester 7)
- ✅ KRS: Semester 7 (7 mata kuliah, 20 SKS)
- ✅ KHS: Semester 1-6
- ✅ Pembayaran: Semester 1-7 (Semester 7 Belum Lunas 50%)

### User ID 13 (John Doe - Semester 7)
- ✅ KRS: Semester 7 (7 mata kuliah, 20 SKS)
- ✅ KHS: Semester 1-6
- ✅ Pembayaran: Semester 1-7 (Semester 7 Belum Lunas 50%)
- ✅ Kerja Praktek: Lulus (dengan timeline)
- ✅ Skripsi: On Progress (dengan timeline)

### User ID 14 (Jane Smith - Semester 5)
- ✅ KRS: Semester 5 (9 mata kuliah, 22 SKS)
- ✅ KHS: Semester 1-4
- ✅ Pembayaran: Semester 1-5 (Semester 5 Belum Lunas 50%)

### User ID 15 (Bob Wilson - Semester 3)
- ✅ KRS: Semester 3 (8 mata kuliah, 20 SKS)
- ✅ KHS: Semester 1-2
- ✅ Pembayaran: Semester 1-3 (Semester 3 Belum Lunas 50%)

## 🔍 Verifikasi Seeder

Setelah menjalankan seeder, verifikasi dengan query berikut:

```sql
-- Cek KRS untuk semua user
SELECT u.name, k.semester, COUNT(kd.id) as jumlah_mata_kuliah
FROM users u
LEFT JOIN krs k ON u.id = k.user_id
LEFT JOIN krs_details kd ON k.id = kd.krs_id
WHERE u.id IN (1, 4, 13, 14, 15)
GROUP BY u.id, k.id;

-- Cek KHS untuk semua user
SELECT u.name, kh.semester, kh.ip, COUNT(khd.id) as jumlah_mata_kuliah
FROM users u
LEFT JOIN khs kh ON u.id = kh.user_id
LEFT JOIN khs_details khd ON kh.id = khd.khs_id
WHERE u.id IN (1, 4, 13, 14, 15)
GROUP BY u.id, kh.id;

-- Cek Pembayaran untuk semua user
SELECT u.name, p.semester, p.status, COUNT(pd.id) as jumlah_komponen
FROM users u
LEFT JOIN pembayaran p ON u.id = p.user_id
LEFT JOIN pembayaran_details pd ON p.id = pd.pembayaran_id
WHERE u.id IN (1, 4, 13, 14, 15)
GROUP BY u.id, p.id;
```

## 🎯 Kesimpulan

Semua seeder sudah mengikuti **alur relasi yang benar**:
- ✅ Users → KRS → KRS Details
- ✅ Users → KHS → KHS Details
- ✅ Users → Pembayaran → Pembayaran Details
- ✅ Users → Kerja Praktek → KP Timeline
- ✅ Users → Skripsi → Skripsi Timeline

**Semua data saling terhubung menggunakan Foreign Key!** 🎉
