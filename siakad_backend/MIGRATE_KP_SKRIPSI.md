# Cara Migrate Tabel KP dan Skripsi

## Langkah 1: Jalankan Migration SQL

Buka phpMyAdmin atau MySQL Workbench, lalu jalankan file:

**File:** `siakad_backend/database/migration_kp_skripsi.sql`

Ini akan membuat 4 tabel baru:
- `kerja_praktek` - Data kerja praktek per user
- `kerja_praktek_timeline` - Timeline proses kerja praktek
- `skripsi` - Data skripsi per user
- `skripsi_timeline` - Timeline proses skripsi

### Via phpMyAdmin:
1. Buka http://localhost/phpmyadmin
2. Pilih database `siakad_db`
3. Klik tab "SQL"
4. Copy semua isi file `migration_kp_skripsi.sql`
5. Paste dan klik "Go"

### Via Command Line:
```bash
mysql -u root -p siakad_db < siakad_backend/database/migration_kp_skripsi.sql
```

## Langkah 2: Jalankan Seeder SQL

Setelah migration, jalankan seeder untuk insert sample data:

**File:** `siakad_backend/database/seeder_kp_skripsi.sql`

Ini akan mengisi data sample untuk:
- KP user_id = 1 (John Doe)
- KP user_id = 2 (Jane Smith)
- Skripsi user_id = 1 (John Doe)

### Via phpMyAdmin:
1. Buka tab "SQL" lagi
2. Copy semua isi file `seeder_kp_skripsi.sql`
3. Paste dan klik "Go"

### Via Command Line:
```bash
mysql -u root -p siakad_db < siakad_backend/database/seeder_kp_skripsi.sql
```

## Langkah 3: Verifikasi

Cek apakah tabel sudah dibuat dan data sudah terisi:

```sql
-- Cek tabel
SHOW TABLES LIKE '%kerja_praktek%';
SHOW TABLES LIKE '%skripsi%';

-- Cek data KP
SELECT * FROM kerja_praktek;
SELECT * FROM kerja_praktek_timeline;

-- Cek data Skripsi
SELECT * FROM skripsi;
SELECT * FROM skripsi_timeline;
```

## Langkah 4: Restart Backend

Setelah migration dan seeder selesai, restart backend server:

```bash
cd siakad_backend
go run main.go
```

Atau jika sudah dikompilasi:
```bash
./siakad_backend.exe
```

## Troubleshooting

### Error: "Table already exists"
- Tabel sudah ada, skip migration atau drop tabel terlebih dahulu:
```sql
DROP TABLE IF EXISTS skripsi_timeline;
DROP TABLE IF EXISTS skripsi;
DROP TABLE IF EXISTS kerja_praktek_timeline;
DROP TABLE IF EXISTS kerja_praktek;
```

### Error: "Foreign key constraint fails"
- Pastikan tabel `users` sudah ada dan berisi data
- Pastikan `user_id` yang digunakan ada di tabel `users`

### Data tidak muncul di aplikasi
- Pastikan sudah login dengan user yang memiliki data KP/Skripsi
- Data seeder hanya untuk user_id = 1 dan 2
- Cek console backend untuk melihat error log
- Cek apakah endpoint `/api/kerja-praktek` dan `/api/skripsi` sudah bisa diakses

