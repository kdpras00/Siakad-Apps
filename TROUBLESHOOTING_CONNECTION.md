# 🔧 Troubleshooting: ERR_CONNECTION_REFUSED

## ❌ Error yang Terjadi

```
Failed to load resource: net::ERR_CONNECTION_REFUSED
http://localhost:8080/api/auth/login
http://localhost:8080/api/auth/register
```

## 🔍 Penyebab

**Backend Go server belum berjalan di port 8080**

Flutter mencoba connect ke `http://localhost:8080/api`, tapi tidak ada server yang listening di port tersebut.

## ✅ Solusi: Jalankan Backend Server

### Cara 1: Menggunakan Batch File (Termudah) ⭐

Dari folder root project:
```bash
.\siakad_backend\RUN_SERVER.bat
```

### Cara 2: Manual

Buka **Terminal baru** (jangan tutup, biarkan running):

```bash
cd siakad_backend
go run main.go
```

**Output yang diharapkan:**
```
✓ Database connected successfully!

========================================
🚀 Server starting on port 8080
========================================
API Base URL: http://localhost:8080/api
========================================
```

### Cara 3: Compile dan Run

```bash
cd siakad_backend
go build -o server.exe main.go
.\server.exe
```

## 🧪 Verifikasi Server Running

### Test di Browser:
Buka: http://localhost:8080/api/information

Harus return JSON (bisa kosong jika belum ada data):
```json
{"data":[]}
```

### Test dengan curl:
```bash
curl http://localhost:8080/api/information
```

### Cek Port Listening:
```bash
netstat -an | findstr :8080
```

Harus muncul:
```
TCP    0.0.0.0:8080           0.0.0.0:0              LISTENING
```

## 📋 Checklist

Sebelum test Flutter, pastikan:

- [ ] ✅ MySQL service running (XAMPP)
- [ ] ✅ Database `siakad_db` sudah ada
- [ ] ✅ Migration sudah dijalankan
- [ ] ✅ **Backend Go server running** ← INI YANG PENTING!
- [ ] ✅ Server listening di port 8080
- [ ] ✅ Test endpoint di browser/curl berhasil

## 🎯 Urutan Menjalankan

1. **Terminal 1** - Backend Server:
   ```bash
   cd siakad_backend
   go run main.go
   ```
   **JANGAN TUTUP TERMINAL INI!**

2. **Terminal 2** - Flutter App:
   ```bash
   flutter run -d chrome
   ```

## 🐛 Masalah Lain

### Error: "port already in use"
Port 8080 sudah dipakai aplikasi lain.

**Solusi:**
1. Cek apa yang pakai port 8080:
   ```bash
   netstat -ano | findstr :8080
   ```
2. Stop aplikasi tersebut, atau
3. Ganti port backend:
   ```bash
   # Set port baru
   set PORT=3000
   go run main.go
   ```
4. Update URL di Flutter: `lib/src/config/constants.dart`
   ```dart
   static const String baseUrl = "http://localhost:3000/api";
   ```

### Error: "Database connection failed"
- Pastikan MySQL running
- Pastikan database `siakad_db` sudah ada
- Periksa kredensial

### Error: "module not found"
```bash
cd siakad_backend
go mod tidy
```

## 📝 Catatan Penting

1. **Backend HARUS running** sebelum test Flutter
2. **Jangan tutup terminal** tempat backend running
3. **Port 8080** harus available
4. **Database** harus running dan accessible

## ✅ Setelah Backend Running

1. Test endpoint di browser: http://localhost:8080/api/information
2. Jika return JSON → Server OK ✅
3. Baru test Flutter app
4. Error ERR_CONNECTION_REFUSED akan hilang

---

**Intinya: Jalankan backend Go server dulu sebelum test Flutter!** 🚀

