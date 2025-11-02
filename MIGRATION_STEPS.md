# Langkah-Langkah Migration Database

## 📋 Checklist Migration

### ✅ Step 1: Backup Database (PENTING!)
Sebelum migration, backup database yang ada:

1. **Menggunakan phpMyAdmin:**
   - Pilih database `siakad_db`
   - Klik tab "Export"
   - Pilih method: "Quick" atau "Custom"
   - Klik "Go" untuk download file SQL backup

2. **Menggunakan Command Line:**
   ```bash
   mysqldump -u root -p siakad_db > siakad_db_backup_$(date +%Y%m%d).sql
   ```

### ✅ Step 2: Jalankan Migration SQL

**Metode A: Menggunakan phpMyAdmin (Paling Mudah)**

1. Buka phpMyAdmin: http://localhost/phpmyadmin
2. Pilih database `siakad_db` di sidebar kiri
3. Klik tab **"SQL"** di bagian atas
4. Buka file `siakad_backend/database/migration.sql`
5. Copy **SEMUA** isi file tersebut
6. Paste ke textarea SQL di phpMyAdmin
7. Klik tombol **"Go"** (atau tekan Ctrl+Enter)
8. Pastikan muncul pesan sukses: "X queries executed"

**Metode B: Menggunakan Command Line**

```bash
# Masuk ke direktori project
cd siakad_backend/database

# Login ke MySQL
mysql -u root -p

# Di dalam MySQL:
USE siakad_db;
source migration.sql;

# Atau langsung dari command line:
mysql -u root -p siakad_db < migration.sql
```

### ✅ Step 3: Verifikasi Migration

Jalankan query ini di phpMyAdmin atau MySQL CLI:

```sql
-- Lihat semua tabel
SHOW TABLES;

-- Hasilnya harus menampilkan:
-- information
-- users
-- krs
-- krs_details
-- khs
-- khs_details
-- pembayaran
-- pembayaran_details

-- Cek struktur tabel krs
DESCRIBE krs;

-- Cek struktur tabel khs
DESCRIBE khs;

-- Cek struktur tabel pembayaran
DESCRIBE pembayaran;
```

### ✅ Step 4: Insert Sample Data (Optional)

Untuk testing, bisa insert sample data. Edit bagian INSERT di `migration.sql`:

```sql
-- 1. Cek user_id yang ada
SELECT id, name, email FROM users;

-- 2. Insert KRS (ganti user_id dengan ID yang valid)
INSERT INTO krs (user_id, semester, tahun_ajaran, status, total_sks) 
VALUES (1, 'Semester 7', '2024/2025', 'Aktif', 22);

-- 3. Insert KRS Details
INSERT INTO krs_details (krs_id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan)
VALUES 
(LAST_INSERT_ID(), 'TI701', 'Mobile Programming', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:30 - 10:00 WIB', 'Ruang A12.7'),
(LAST_INSERT_ID(), 'TI702', 'Analisis dan Perancangan Sistem Informasi', 3, 'Yani Sugiani, M.Kom', 'Senin, 10:00 - 11:30 WIB', 'Ruang A12.8');

-- 4. Insert KHS
INSERT INTO khs (user_id, semester, ip, total_mata_kuliah) 
VALUES (1, 'Semester 1', 3.80, 15);

-- 5. Insert KHS Details
INSERT INTO khs_details (khs_id, kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka)
VALUES 
(LAST_INSERT_ID(), 'TI101', 'Algoritma Pemrograman', 3, 'A', 4.0),
(LAST_INSERT_ID(), 'TI102', 'Kalkulus 1', 3, 'B', 3.0);

-- 6. Insert Pembayaran
INSERT INTO pembayaran (user_id, semester, total_amount, paid_amount, remaining_amount, status)
VALUES (1, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas');

-- 7. Insert Pembayaran Details
INSERT INTO pembayaran_details (pembayaran_id, komponen, total, paid, remaining)
VALUES 
(LAST_INSERT_ID(), 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(LAST_INSERT_ID(), 'Biaya SKS', 3000000.00, 3000000.00, 0.00),
(LAST_INSERT_ID(), 'Biaya Praktikum', 4000000.00, 4000000.00, 0.00);
```

### ✅ Step 5: Update Backend Go

1. **Buat Handler Baru** untuk KRS, KHS, Pembayaran
   - Lihat contoh di `siakad_backend/database/HANDLER_EXAMPLE.md`
   - Implementasi sesuai struktur database Anda

2. **Update Routes** di backend Go:
   ```go
   router.HandleFunc("/api/krs", GetKRS).Methods("GET")
   router.HandleFunc("/api/krs/semester/{semester}", GetKRSBySemester).Methods("GET")
   router.HandleFunc("/api/khs/rekap", GetKHSRekap).Methods("GET")
   router.HandleFunc("/api/khs", GetAllKHS).Methods("GET")
   router.HandleFunc("/api/pembayaran", GetPembayaran).Methods("GET")
   ```

3. **Test Backend** dengan Postman atau curl:
   ```bash
   # Login dulu untuk dapat token
   curl -X POST http://localhost:8080/api/auth/login \
     -H "Content-Type: application/json" \
     -d '{"username":"test","password":"test123"}'

   # Test KRS dengan token
   curl -X GET http://localhost:8080/api/krs \
     -H "Authorization: Bearer YOUR_TOKEN_HERE"
   ```

### ✅ Step 6: Test di Flutter

1. **Pastikan URL Backend Benar** di `lib/src/config/constants.dart`
2. **Run Aplikasi Flutter**:
   ```bash
   flutter pub get
   flutter run
   ```
3. **Login** dengan kredensial yang ada di database
4. **Test Semua Fitur**:
   - ✅ Informasi (harus muncul data dari tabel information)
   - ✅ KRS (harus muncul data dari tabel krs)
   - ✅ KHS (harus muncul data dari tabel khs)
   - ✅ Pembayaran (harus muncul data dari tabel pembayaran)
   - ✅ Profile (harus muncul data dari tabel users)

## 🐛 Troubleshooting

### Error: "Table already exists"
```sql
-- Hapus tabel yang sudah ada
DROP TABLE IF EXISTS pembayaran_details;
DROP TABLE IF EXISTS pembayaran;
DROP TABLE IF EXISTS khs_details;
DROP TABLE IF EXISTS khs;
DROP TABLE IF EXISTS krs_details;
DROP TABLE IF EXISTS krs;

-- Jalankan migration.sql lagi
```

### Error: "Foreign key constraint fails"
- Pastikan tabel `users` sudah ada dan memiliki data
- Pastikan `user_id` yang digunakan ada di tabel `users`
- Cek dengan: `SELECT id FROM users;`

### Error: "Access denied"
- Pastikan user MySQL memiliki privilege CREATE dan ALTER
- Login sebagai root: `mysql -u root -p`

### Data Tidak Muncul di Flutter
1. Cek console Flutter untuk error message
2. Test endpoint dengan Postman terlebih dahulu
3. Pastikan format response sesuai dokumentasi
4. Periksa apakah token masih valid

## 📝 Checklist Setelah Migration

- [ ] Migration SQL berhasil dijalankan
- [ ] Semua tabel muncul di phpMyAdmin
- [ ] Sample data berhasil di-insert
- [ ] Backend Go bisa query ke tabel baru
- [ ] Endpoint API sudah diimplementasikan
- [ ] Flutter bisa fetch data dari backend
- [ ] Semua fitur (KRS, KHS, Pembayaran) menampilkan data dengan benar

## 📚 Dokumentasi Terkait

- `siakad_backend/database/migration.sql` - Script migration
- `siakad_backend/database/README_MIGRATION.md` - Dokumentasi struktur tabel
- `siakad_backend/database/HANDLER_EXAMPLE.md` - Contoh handler Go
- `siakad_backend/database/rollback.sql` - Script untuk rollback (hapus tabel)

---

**Catatan**: Setelah migration selesai, aplikasi Flutter akan otomatis mengambil data dari database melalui backend Go. Tidak perlu generate data lagi!

