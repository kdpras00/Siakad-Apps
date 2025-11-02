# 🚀 Quick Start Guide - Menjalankan Aplikasi

## ⚡ Cara Cepat Menjalankan Semua

### 1. Start Backend Go Server

**Terminal 1** (Backend):
```bash
cd siakad_backend
.\RUN_SERVER.bat
```

Atau manual:
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

### 2. Start Flutter App

**Terminal 2** (Frontend):
```bash
flutter pub get
flutter run -d chrome
```

## ✅ Checklist Sebelum Run

- [ ] MySQL service running (XAMPP)
- [ ] Database `siakad_db` sudah ada
- [ ] Migration sudah dijalankan (8 tabel sudah ada)
- [ ] Backend Go server running di port 8080
- [ ] Flutter dependencies sudah terinstall

## 🐛 Troubleshooting ERR_CONNECTION_REFUSED

### Masalah: Backend tidak running

**Solusi:**
1. Pastikan backend Go sudah dijalankan
2. Cek di terminal apakah ada output: `Server starting on port 8080`
3. Test dengan browser: http://localhost:8080/api/information
4. Jika masih error, cek firewall

### Masalah: Port 8080 sudah dipakai

**Solusi:**
1. Cek aplikasi lain yang pakai port 8080:
   ```bash
   netstat -ano | findstr :8080
   ```
2. Stop aplikasi tersebut atau ganti port:
   ```bash
   set PORT=3000
   go run main.go
   ```
3. Update URL di Flutter: `lib/src/config/constants.dart`

### Masalah: Database tidak connect

**Solusi:**
1. Pastikan MySQL service running di XAMPP
2. Test koneksi:
   ```bash
   mysql -u root siakad_db
   ```
3. Periksa kredensial di `.env` atau default

## 📋 Testing Endpoint

Setelah backend running, test endpoint:

### 1. Test Information (Public):
```
http://localhost:8080/api/information
```

### 2. Test Login:
```bash
POST http://localhost:8080/api/auth/login
Body: {"username":"test","password":"test123"}
```

### 3. Test Register:
```bash
POST http://localhost:8080/api/auth/register
Body: {"name":"Test User","nim":"0419108607","email":"test@test.com","password":"test123"}
```

## 📱 Test di Flutter

1. Buka aplikasi di browser/emulator
2. Coba login dengan kredensial yang ada di database
3. Jika berhasil, semua fitur akan otomatis fetch data

## 🎯 Urutan Menjalankan

1. **Start MySQL** (XAMPP Control Panel)
2. **Run Migration** (jika belum):
   ```bash
   cd siakad_backend
   go run database/migrate.go
   ```
3. **Start Backend**:
   ```bash
   cd siakad_backend
   go run main.go
   ```
4. **Start Flutter**:
   ```bash
   flutter run -d chrome
   ```

---

**Pastikan backend running sebelum test Flutter app!** ✅

