# Database Migration Guide

## Struktur Database Setelah Migration

Database `siakad_db` akan memiliki struktur berikut:

### Tabel yang Sudah Ada:
1. **users** - Data user/mahasiswa
2. **information** - Data informasi/pengumuman

### Tabel Baru (Setelah Migration):
3. **krs** - Kartu Rencana Studi
4. **krs_details** - Detail mata kuliah dalam KRS
5. **khs** - Kartu Hasil Studi
6. **khs_details** - Detail nilai mata kuliah dalam KHS
7. **pembayaran** - Data pembayaran per semester
8. **pembayaran_details** - Detail komponen pembayaran

## Cara Menjalankan Migration

### Metode 1: Menggunakan phpMyAdmin

1. **Buka phpMyAdmin** (http://localhost/phpmyadmin)
2. **Pilih database `siakad_db`**
3. **Klik tab "SQL"**
4. **Copy seluruh isi file `migration.sql`**
5. **Paste ke textarea SQL**
6. **Klik "Go" atau tekan Ctrl+Enter**
7. **Pastikan tidak ada error**, jika ada error, periksa apakah tabel sudah ada atau ada masalah dengan foreign key

### Metode 2: Menggunakan Command Line MySQL

```bash
# Login ke MySQL
mysql -u root -p

# Pilih database
USE siakad_db;

# Jalankan migration
source siakad_backend/database/migration.sql

# Atau langsung:
mysql -u root -p siakad_db < siakad_backend/database/migration.sql
```

### Metode 3: Menggunakan MySQL Workbench

1. Buka MySQL Workbench
2. Connect ke database server
3. File > Open SQL Script
4. Pilih file `migration.sql`
5. Klik icon "Execute" (⚡)

## Verifikasi Migration

Setelah migration selesai, verifikasi dengan:

```sql
-- Lihat semua tabel
SHOW TABLES;

-- Periksa struktur tabel
DESCRIBE krs;
DESCRIBE krs_details;
DESCRIBE khs;
DESCRIBE khs_details;
DESCRIBE pembayaran;
DESCRIBE pembayaran_details;
```

## Struktur Tabel

### 1. Tabel `krs`
- `id` - Primary Key
- `user_id` - Foreign Key ke `users.id`
- `semester` - Semester (contoh: "Semester 7")
- `tahun_ajaran` - Tahun ajaran (contoh: "2024/2025")
- `status` - Status KRS (Aktif, Cuti, dll)
- `total_sks` - Total SKS semester ini
- `created_at`, `updated_at` - Timestamps

### 2. Tabel `krs_details`
- `id` - Primary Key
- `krs_id` - Foreign Key ke `krs.id`
- `kode_mata_kuliah` - Kode MK (contoh: "TI701")
- `nama_mata_kuliah` - Nama mata kuliah
- `sks` - Jumlah SKS
- `dosen` - Nama dosen pengampu
- `jadwal` - Jadwal kuliah
- `ruangan` - Ruangan kuliah

### 3. Tabel `khs`
- `id` - Primary Key
- `user_id` - Foreign Key ke `users.id`
- `semester` - Semester
- `ip` - Indeks Prestasi (IP) semester ini
- `total_mata_kuliah` - Total mata kuliah yang diambil
- `created_at`, `updated_at` - Timestamps

### 4. Tabel `khs_details`
- `id` - Primary Key
- `khs_id` - Foreign Key ke `khs.id`
- `kode_mata_kuliah` - Kode MK
- `nama_mata_kuliah` - Nama mata kuliah
- `sks` - Jumlah SKS
- `nilai` - Nilai huruf (A, B, C, D, E)
- `nilai_angka` - Nilai angka (0.00 - 4.00)

### 5. Tabel `pembayaran`
- `id` - Primary Key
- `user_id` - Foreign Key ke `users.id`
- `semester` - Semester
- `total_amount` - Total biaya semester
- `paid_amount` - Jumlah yang sudah dibayar
- `remaining_amount` - Sisa pembayaran
- `status` - Status (Lunas, Belum Lunas)
- `created_at`, `updated_at` - Timestamps

### 6. Tabel `pembayaran_details`
- `id` - Primary Key
- `pembayaran_id` - Foreign Key ke `pembayaran.id`
- `komponen` - Nama komponen (Uang Bangunan, Biaya SKS, dll)
- `total` - Total komponen
- `paid` - Jumlah terbayar
- `remaining` - Sisa pembayaran

## Insert Sample Data

Setelah migration, Anda bisa insert sample data untuk testing. Edit bagian INSERT di `migration.sql` sesuai dengan `user_id` yang ada di tabel `users`:

```sql
-- Ganti user_id dengan ID user yang valid
INSERT INTO krs (user_id, semester, tahun_ajaran, status, total_sks) 
VALUES (1, 'Semester 7', '2024/2025', 'Aktif', 22);
```

## Troubleshooting

### Error: "Table already exists"
- Hapus tabel yang sudah ada terlebih dahulu:
  ```sql
  DROP TABLE IF EXISTS pembayaran_details;
  DROP TABLE IF EXISTS pembayaran;
  DROP TABLE IF EXISTS khs_details;
  DROP TABLE IF EXISTS khs;
  DROP TABLE IF EXISTS krs_details;
  DROP TABLE IF EXISTS krs;
  ```
- Lalu jalankan migration.sql lagi

### Error: "Foreign key constraint fails"
- Pastikan tabel `users` sudah ada dan memiliki data
- Pastikan `user_id` yang digunakan ada di tabel `users`

### Error: "Access denied"
- Pastikan user MySQL memiliki privilege CREATE dan ALTER
- Login sebagai root atau user dengan privilege penuh

## Setelah Migration

1. **Update Backend Go** untuk:
   - Membuat handler untuk CRUD KRS, KHS, Pembayaran
   - Update service layer untuk query ke database baru
   - Implementasi endpoint yang sudah didokumentasikan

2. **Test di Flutter**:
   - Pastikan URL backend sudah benar di `constants.dart`
   - Test semua fitur (KRS, KHS, Pembayaran)
   - Verifikasi data tampil dengan benar

## Catatan Penting

- **Backup Database** sebelum migration (jika ada data penting)
- **Foreign Keys** menggunakan `ON DELETE CASCADE`, jadi jika user dihapus, data terkait juga akan terhapus
- **Indexes** sudah ditambahkan untuk optimasi query berdasarkan `user_id` dan `semester`
- **Charset** menggunakan `utf8mb4` untuk support emoji dan karakter khusus

