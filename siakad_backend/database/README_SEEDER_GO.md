# Dokumentasi Seeder dengan Go

Program Go untuk menjalankan seeder SQL secara otomatis.

## Fitur

- ✅ Membaca file SQL seeder
- ✅ Execute multiple INSERT statements
- ✅ Handle error dengan baik (skip duplicate entries)
- ✅ Support .env untuk konfigurasi database
- ✅ Verification data setelah seeder selesai
- ✅ Confirmation prompt untuk safety

## Cara Menggunakan

### 1. Pastikan Migration Sudah Dijalankan

Seeder memerlukan tabel yang sudah ada. Pastikan migration sudah dijalankan:

```bash
cd siakad_backend
go run database/migrate.go
```

### 2. Setup Environment (Optional)

Jika menggunakan .env file, pastikan sudah ada:

```env
DB_USER=root
DB_PASSWORD=
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=siakad_db
```

Jika tidak pakai .env, akan menggunakan default values di atas.

### 3. Jalankan Seeder

**Metode 1: Menggunakan Batch File (Paling Mudah) ⭐**

```bash
# Dari root folder siakad_backend
.\run_seeder.bat
```

**Metode 2: Menggunakan Go Run**

```bash
# Dari root folder siakad_backend
cd database
go run seeder.go
```

**Metode 3: Dari Root Folder**

```bash
# Dari root folder siakad_backend
go run database/seeder.go
```

**Metode 4: Dengan File Seeder Custom**

```bash
go run database/seeder.go path/to/custom_seeder.sql
```

### 4. Konfirmasi

Program akan menanyakan konfirmasi:
```
⚠️  WARNING: This will insert data into the database!
   Existing data might be duplicated if IDs conflict.

Do you want to continue? (yes/no):
```

Ketik `yes` atau `y` untuk melanjutkan.

### 5. Hasil

Setelah selesai, program akan menampilkan:
- Jumlah statement yang berhasil
- Verifikasi data (jumlah record per tabel)
- Kredensial untuk testing

## Data yang Akan Diinsert

### Users (4 user)
- John Doe (NIM: 0419108607, Email: john.doe@example.com) - Semester 7
- Jane Smith (NIM: 0419108608, Email: jane.smith@example.com) - Semester 5
- Bob Wilson (NIM: 0419108609, Email: bob.wilson@example.com) - Semester 3
- Alice Johnson (NIM: 0419108610, Email: alice.johnson@example.com) - Semester 1

**Password default**: `password123` (untuk semua user)

### Data Lainnya
- 5 informasi/pengumuman
- KRS lengkap untuk 4 user
- KHS dengan detail nilai untuk beberapa user
- Pembayaran dengan detail komponen untuk semua user

## Troubleshooting

### Error: "table doesn't exist"
**Solusi:** Jalankan migration terlebih dahulu:
```bash
go run database/migrate.go
```

### Error: "Duplicate entry"
**Penyebab:** Data sudah ada di database
**Solusi:** 
- Seeder akan skip duplicate entries dengan warning
- Jika ingin reset, hapus data manual atau uncomment bagian DELETE di seeder.sql

### Error: "foreign key constraint fails"
**Penyebab:** Foreign key reference tidak valid
**Solusi:** 
- Pastikan migration sudah dijalankan dengan benar
- Pastikan data users sudah ada sebelum insert KRS/KHS/Pembayaran
- Seeder sudah urut untuk menghindari masalah ini

### Error: "connection refused"
**Penyebab:** MySQL tidak berjalan atau kredensial salah
**Solusi:**
- Pastikan MySQL/XAMPP sudah running
- Periksa kredensial di .env file
- Test koneksi manual dengan MySQL CLI

## Verifikasi Manual

Setelah seeder selesai, verifikasi dengan query:

```sql
SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_information FROM information;
SELECT COUNT(*) as total_krs FROM krs;
SELECT COUNT(*) as total_krs_details FROM krs_details;
SELECT COUNT(*) as total_khs FROM khs;
SELECT COUNT(*) as total_khs_details FROM khs_details;
SELECT COUNT(*) as total_pembayaran FROM pembayaran;
SELECT COUNT(*) as total_pembayaran_details FROM pembayaran_details;
```

**Expected Results:**
- users: 4
- information: 5
- krs: 4
- krs_details: ~25-28
- khs: 8
- khs_details: ~21
- pembayaran: 12
- pembayaran_details: ~16

## Testing API

Setelah seeder selesai, test API dengan:

**Login:**
```bash
POST http://localhost:8080/api/auth/login
{
  "username": "john.doe@example.com",
  "password": "password123"
}
```

**Get Profile:**
```bash
GET http://localhost:8080/api/auth/profile
Authorization: Bearer {token}
```

**Get Information:**
```bash
GET http://localhost:8080/api/information
Authorization: Bearer {token}
```

**Get KRS:**
```bash
GET http://localhost:8080/api/krs
Authorization: Bearer {token}
```

**Get KHS:**
```bash
GET http://localhost:8080/api/khs/rekap
Authorization: Bearer {token}
```

**Get Pembayaran:**
```bash
GET http://localhost:8080/api/pembayaran
Authorization: Bearer {token}
```

## Catatan Penting

1. **Password**: Semua user menggunakan password `password123` (plain text, tidak di-hash). Untuk production, gunakan bcrypt.

2. **Duplicate Data**: Seeder akan skip duplicate entries dengan warning. Jika ingin reset, hapus data manual terlebih dahulu.

3. **Foreign Keys**: Data sudah urut untuk menghindari foreign key constraint errors.

4. **Safety**: Program meminta konfirmasi sebelum execute untuk mencegah accidental data insertion.

## Perbedaan dengan Manual SQL

| Metode | Keuntungan |
|--------|-----------|
| **Go Seeder** | ✅ Otomatis<br>✅ Error handling baik<br>✅ Verification otomatis<br>✅ Safety confirmation<br>✅ Support .env |
| **Manual SQL** | ✅ Bisa edit langsung<br>✅ Bisa lihat query detail<br>✅ Lebih fleksibel |

Gunakan Go Seeder untuk convenience, atau manual SQL jika ingin lebih control.

