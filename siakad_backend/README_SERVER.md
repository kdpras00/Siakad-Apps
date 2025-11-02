# Cara Menjalankan Backend Go Server

## 🚀 Quick Start

### Metode 1: Menggunakan Batch File (Termudah)

Dari folder root project:
```bash
.\siakad_backend\RUN_SERVER.bat
```

### Metode 2: Manual

```bash
cd siakad_backend
go mod tidy
go run main.go
```

## ✅ Prerequisites

1. **Go installed** (cek: `go version`)
2. **MySQL running** (XAMPP atau MySQL service)
3. **Database `siakad_db` sudah dibuat** (sudah ada)

## 🔧 Konfigurasi

### Port Server

Default: **8080**

Bisa diubah dengan environment variable:
```bash
set PORT=3000
go run main.go
```

Atau buat file `.env`:
```env
PORT=8080
DB_USER=root
DB_PASSWORD=
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=siakad_db
```

### Database

Default configuration (XAMPP):
- User: `root`
- Password: (kosong)
- Host: `127.0.0.1`
- Port: `3306`
- Database: `siakad_db`

## 📍 Endpoint yang Tersedia

### ✅ Sudah Diimplementasikan:

1. **POST /api/auth/login** - Login user
2. **POST /api/auth/register** - Registrasi user baru
3. **GET /api/auth/profile** - Get profile (require Authorization header)
4. **PUT /api/auth/change-password** - Ubah password (TODO)
5. **POST /api/auth/logout** - Logout
6. **GET /api/information** - List semua informasi
7. **GET /api/information/{id}** - Detail informasi

### ⏳ Perlu Implementasi (Return Empty/Mock):

8. **GET /api/krs** - List KRS (perlu query database)
9. **GET /api/krs/{id}** - KRS by ID
10. **GET /api/krs/semester/{semester}** - KRS by semester
11. **GET /api/khs/rekap** - Rekap KHS
12. **GET /api/khs** - List KHS
13. **GET /api/khs/semester/{semester}** - KHS by semester
14. **GET /api/pembayaran** - List pembayaran
15. **GET /api/pembayaran/semester/{semester}** - Pembayaran by semester

## 🧪 Test Server

Setelah server running, test dengan:

### Test Login:
```bash
curl -X POST http://localhost:8080/api/auth/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"test\",\"password\":\"test123\"}"
```

### Test Information:
```bash
curl http://localhost:8080/api/information
```

### Test di Browser:
- Buka: http://localhost:8080/api/information
- Harus return JSON data

## 🐛 Troubleshooting

### Error: "Error connecting to database"
- Pastikan MySQL service running
- Pastikan database `siakad_db` sudah ada
- Periksa kredensial di `.env` atau default

### Error: "port already in use"
- Port 8080 sudah dipakai aplikasi lain
- Ganti port: `set PORT=3001` lalu `go run main.go`

### Error: "module not found"
```bash
cd siakad_backend
go mod tidy
```

### Error: "Access denied"
- Periksa username/password MySQL
- Default XAMPP: username=root, password=kosong

## 📝 Catatan

1. **CORS sudah di-enable** - Flutter bisa akses dari browser
2. **Token Authentication** - Simple implementation, untuk production gunakan JWT library
3. **Password Hash** - Untuk production, gunakan bcrypt (TODO)
4. **KRS/KHS/Pembayaran** - Endpoint masih perlu implementasi query ke database

## 🔄 Update Handlers

Untuk implementasi KRS, KHS, Pembayaran, lihat:
- `database/HANDLER_EXAMPLE.md` - Contoh implementasi

## ✅ Status

- ✅ Server framework setup
- ✅ Database connection
- ✅ Auth endpoints (login, register, profile)
- ✅ Information endpoints
- ⏳ KRS/KHS/Pembayaran endpoints (perlu implementasi)

---

**Server siap digunakan untuk testing Flutter app!**

