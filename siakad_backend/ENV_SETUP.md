# Setup Environment Variables untuk Migration Go

## Cara 1: Menggunakan .env file (Recommended)

1. Buat file `.env` di folder `siakad_backend/`:

```env
DB_USER=root
DB_PASSWORD=
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=siakad_db
```

2. Jika pakai password, isi `DB_PASSWORD`:
```env
DB_PASSWORD=yourpassword
```

## Cara 2: Menggunakan Environment Variables System

**Windows (PowerShell):**
```powershell
$env:DB_USER="root"
$env:DB_PASSWORD=""
$env:DB_HOST="127.0.0.1"
$env:DB_PORT="3306"
$env:DB_NAME="siakad_db"
```

**Windows (CMD):**
```cmd
set DB_USER=root
set DB_PASSWORD=
set DB_HOST=127.0.0.1
set DB_PORT=3306
set DB_NAME=siakad_db
```

**Linux/Mac:**
```bash
export DB_USER=root
export DB_PASSWORD=
export DB_HOST=127.0.0.1
export DB_PORT=3306
export DB_NAME=siakad_db
```

## Cara 3: Tanpa .env (Default Values)

Jika tidak ada `.env` file, program akan menggunakan default values:
- DB_USER: root
- DB_PASSWORD: (kosong)
- DB_HOST: 127.0.0.1
- DB_PORT: 3306
- DB_NAME: siakad_db

## Test Connection

Setelah setup, test dengan:
```bash
cd siakad_backend
go run database/migrate.go
```

