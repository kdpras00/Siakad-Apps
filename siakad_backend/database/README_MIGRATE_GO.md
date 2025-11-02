# Migration dengan Go

Program Go untuk menjalankan migration SQL secara otomatis.

## Fitur

- ✅ Membaca file SQL migration
- ✅ Execute multiple statements
- ✅ Handle error dengan baik
- ✅ Support .env untuk konfigurasi database
- ✅ Skip statement jika table sudah exists (warning)
- ✅ Auto skip USE statement (tidak diperlukan)

## Cara Menggunakan

### 1. Setup Environment

Copy file `.env.example` ke `.env` di root folder `siakad_backend`:

```bash
cd siakad_backend
copy .env.example .env
```

Edit `.env` sesuai konfigurasi database Anda:

```env
DB_USER=root
DB_PASSWORD=        # Kosongkan jika tidak pakai password
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=siakad_db
```

### 2. Install Dependencies

```bash
cd siakad_backend
go mod download
```

Atau jika belum ada `go.mod`:

```bash
cd siakad_backend
go mod init siakad_backend
go get github.com/go-sql-driver/mysql
go get github.com/joho/godotenv
```

### 3. Jalankan Migration

**Dari root folder siakad_backend:**

```bash
go run database/migrate.go
```

**Atau dengan file migration custom:**

```bash
go run database/migrate.go path/to/custom_migration.sql
```

**Atau compile dulu:**

```bash
# Compile
go build -o migrate.exe database/migrate.go

# Jalankan
./migrate.exe

# Atau dengan file custom
./migrate.exe path/to/custom_migration.sql
```

### 4. Verifikasi

Setelah migration selesai, verifikasi tabel:

```bash
# Menggunakan MySQL CLI
mysql -u root siakad_db -e "SHOW TABLES;"

# Atau melalui Go (bisa ditambahkan di migrate.go)
```

## Struktur File

```
siakad_backend/
├── .env                    # Konfigurasi database (buat dari .env.example)
├── .env.example            # Template konfigurasi
├── database/
│   ├── migrate.go          # Program migration
│   ├── migration.sql       # File SQL migration
│   └── README_MIGRATE_GO.md
└── go.mod                  # Go modules
```

## Error Handling

Program akan:
- ✅ Menampilkan warning jika table already exists (tidak akan gagal)
- ✅ Stop dan tampilkan error jika ada masalah koneksi
- ✅ Stop dan tampilkan error jika statement SQL invalid

## Contoh Output

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
Executing statement 1...
  ✓ Statement 1 executed successfully
Executing statement 2...
  ✓ Statement 2 executed successfully
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

## Integrasi dengan Backend

Anda bisa mengintegrasikan migration ke dalam backend Go utama:

### Option 1: Import sebagai package

```go
// di main.go atau cmd/migrate/main.go
package main

import (
    "siakad_backend/database"
)

func main() {
    // Run migration
    database.RunMigration()
    
    // Continue dengan server
    // ...
}
```

### Option 2: Command line flag

Tambahkan flag untuk migrate:

```go
package main

import (
    "flag"
    "siakad_backend/database"
)

func main() {
    migrate := flag.Bool("migrate", false, "Run database migration")
    flag.Parse()
    
    if *migrate {
        database.RunMigration()
        return
    }
    
    // Continue dengan server
}
```

Jalankan:
```bash
go run main.go -migrate
```

## Troubleshooting

### Error: "module not found"
```bash
cd siakad_backend
go mod init siakad_backend
go mod tidy
```

### Error: "Access denied"
- Periksa username/password di `.env`
- Pastikan MySQL service berjalan
- Pastikan database `siakad_db` sudah ada

### Error: "no such file or directory"
- Pastikan file `migration.sql` ada di folder `database/`
- Atau gunakan path lengkap saat menjalankan: `go run database/migrate.go database/migration.sql`

## Catatan

- Program akan otomatis skip `USE database` statement karena sudah connect ke database spesifik
- Comment (-- dan /* */) akan di-skip
- Multiple statements bisa di-handle dalam satu file
- Table yang sudah ada akan di-skip dengan warning (tidak error)

