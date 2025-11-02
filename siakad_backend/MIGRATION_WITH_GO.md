# Migration Database dengan Go

Program Go untuk menjalankan migration SQL secara otomatis. Sudah diuji dan berhasil! ✅

## ✨ Fitur

- ✅ Membaca file SQL migration otomatis
- ✅ Execute multiple SQL statements
- ✅ Handle error dengan baik (warning jika table sudah exists)
- ✅ Support .env untuk konfigurasi (optional)
- ✅ Auto-detect file migration.sql
- ✅ Skip USE statement (tidak diperlukan)
- ✅ Skip comment lines

## 🚀 Quick Start

### Cara 1: Langsung Run (Paling Mudah)

Dari folder `siakad_backend`:

```bash
go run database/migrate.go
```

Program akan:
- Connect ke database `siakad_db` (default)
- Membaca file `database/migration.sql`
- Execute semua statement
- Tampilkan hasil

### Cara 2: Menggunakan Batch File

Dari folder root project:

```bash
.\siakad_backend\run_migrate.bat
```

### Cara 3: Dengan File Migration Custom

```bash
go run database/migrate.go path/to/custom_migration.sql
```

## 📋 Prerequisites

1. **Go installed** (sudah ada, karena ada go.sum)
2. **Dependencies installed**:
   ```bash
   cd siakad_backend
   go mod tidy
   ```

## ⚙️ Konfigurasi Database

### Option 1: Default Values (Tidak Perlu Setup)

Jika tidak ada `.env` file, program menggunakan default:
- User: `root`
- Password: (kosong)
- Host: `127.0.0.1`
- Port: `3306`
- Database: `siakad_db`

**Ini cocok untuk XAMPP default setup!**

### Option 2: Menggunakan .env File

Buat file `.env` di folder `siakad_backend/`:

```env
DB_USER=root
DB_PASSWORD=
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=siakad_db
```

Program akan otomatis load file ini jika ada.

### Option 3: Environment Variables

Set di system environment:

**Windows (PowerShell):**
```powershell
$env:DB_USER="root"
$env:DB_PASSWORD="mypassword"
$env:DB_NAME="siakad_db"
```

**Windows (CMD):**
```cmd
set DB_USER=root
set DB_PASSWORD=mypassword
```

## 📁 Struktur File

```
siakad_backend/
├── database/
│   ├── migrate.go          # Program migration
│   ├── migration.sql       # File SQL migration
│   └── config.go           # Config helper (optional)
├── .env                    # Konfigurasi (optional)
├── run_migrate.bat         # Batch file untuk run
└── go.mod                  # Go modules
```

## 🔍 Verifikasi

Setelah migration, verifikasi tabel:

```bash
# Menggunakan MySQL CLI
mysql -u root siakad_db -e "SHOW TABLES;"

# Atau di phpMyAdmin
# Pilih database siakad_db > tab Structure
```

Harus muncul 8 tabel:
- information
- users
- krs
- krs_details
- khs
- khs_details
- pembayaran
- pembayaran_details

## 🛠️ Cara Kerja

1. **Load Config**: Cari `.env` file atau pakai default
2. **Connect DB**: Connect ke MySQL menggunakan config
3. **Read SQL**: Baca file `migration.sql`
4. **Parse SQL**: Split menjadi individual statements
5. **Execute**: Execute setiap statement secara berurutan
6. **Report**: Tampilkan hasil (sukses/error)

## 📝 Contoh Output

```
========================================
Database Migration - SIAKAD
========================================
Connecting to: root@127.0.0.1:3306/siakad_db

✓ Connected to database successfully!

Reading migration file: database/migration.sql
✓ Migration file read successfully!

Executing migration...
----------------------------------------
Executing statement 2...
  ✓ Statement 2 executed successfully
Executing statement 3...
  ✓ Statement 3 executed successfully
...
----------------------------------------

========================================
✓ Migration completed successfully!
========================================

Tables created:
  - krs
  - krs_details
  - khs
  - khs_details
  - pembayaran
  - pembayaran_details
```

## 🐛 Troubleshooting

### Error: "module not found"

```bash
cd siakad_backend
go mod tidy
```

### Error: "Access denied"

1. Periksa username/password di `.env` atau default
2. Pastikan MySQL service berjalan
3. Pastikan database `siakad_db` sudah ada

**Buat database jika belum ada:**
```sql
CREATE DATABASE IF NOT EXISTS siakad_db;
```

### Error: "no such file or directory"

Program akan otomatis mencari file `migration.sql` di:
- `database/migration.sql`
- `../database/migration.sql`
- Current directory

Atau gunakan path lengkap:
```bash
go run database/migrate.go database/migration.sql
```

### Error: "Table already exists"

**Ini tidak error!** Program akan tampilkan warning dan lanjut ke statement berikutnya.

Jika ingin drop tabel dulu, gunakan `rollback.sql`:
```bash
go run database/migrate.go database/rollback.sql
go run database/migrate.go database/migration.sql
```

## 🔄 Rollback Migration

Jika ingin menghapus tabel yang dibuat:

```bash
go run database/migrate.go database/rollback.sql
```

Atau manual di MySQL:
```sql
DROP TABLE IF EXISTS pembayaran_details;
DROP TABLE IF EXISTS pembayaran;
DROP TABLE IF EXISTS khs_details;
DROP TABLE IF EXISTS khs;
DROP TABLE IF EXISTS krs_details;
DROP TABLE IF EXISTS krs;
```

## 📚 Integrasi dengan Backend

Anda bisa memanggil migration dari main program:

```go
// di main.go
package main

import (
    "os/exec"
)

func main() {
    // Run migration sebelum start server
    if os.Getenv("RUN_MIGRATION") == "true" {
        cmd := exec.Command("go", "run", "database/migrate.go")
        cmd.Run()
    }
    
    // Start server...
}
```

Atau import sebagai package (perlu refactor sedikit).

## ✅ Keuntungan Migration dengan Go

1. **Otomatis**: Tidak perlu buka phpMyAdmin atau CLI
2. **Terintegrasi**: Bisa dijalankan dari aplikasi
3. **Error Handling**: Lebih baik daripada manual
4. **Portable**: Bisa dijalankan di mana saja (Windows/Linux/Mac)
5. **Version Control**: File migration.sql bisa di-commit ke Git

## 🎯 Next Steps

Setelah migration berhasil:

1. ✅ Update backend Go handlers (lihat `database/HANDLER_EXAMPLE.md`)
2. ✅ Test endpoint dengan Postman/curl
3. ✅ Test di Flutter app
4. ✅ Insert sample data jika perlu

---

**Happy Coding! 🚀**

