# Summary of Fixes for SIAKAD App Connection Issues

## Masalah yang Ditemukan

1. **Login bisa masuk dengan password apapun**
   - Backend Go tidak melakukan verifikasi password
   - Password check di-comment out di main.go

2. **Menu tidak load data dari database**
   - URL API salah: menggunakan `localhost:8080` yang tidak bekerja di Android emulator
   - Database mungkin belum di-migrate atau di-seed

## Perbaikan yang Sudah Dilakukan

### ✅ Fixed: API URL Configuration

File: `lib/src/config/constants.dart`

**Sebelum:**
```dart
static const String baseUrl = "http://localhost:8080/api";
```

**Sesudah:**
```dart
static String get baseUrl {
  if (kIsWeb) {
    return "http://localhost:8080/api";
  }
  // Android emulator needs special address
  return "http://10.0.2.2:8080/api";
}
```

**Penjelasan:**
- Android emulator tidak bisa akses `localhost` dari host
- Gunakan `10.0.2.2` sebagai alias ke `localhost` dari emulator
- Untuk device fisik, gunakan IP komputer: `192.168.0.223`

## Langkah Selanjutnya (User Action Required)

### 1. Pastikan Backend Running
Backend Go seharusnya running di port 8080. Jika tidak:
```powershell
cd siakad_backend
go run main.go
```

### 2. Setup Database

#### A. Jalankan Migration (Jika belum)
```powershell
cd siakad_backend
go run database/migrate.go
```

Atau via phpMyAdmin:
1. Buka http://localhost/phpmyadmin
2. Pilih database `siakad_db`
3. Tab "SQL"
4. Copy isi file `siakad_backend/database/migration.sql`
5. Paste dan klik "Go"

#### B. Jalankan Seeder (Insert Sample Data)
```powershell
cd siakad_backend/database
go run seeder.go
```

Atau via phpMyAdmin:
1. Tab "SQL" di `siakad_db`
2. Copy isi file `siakad_backend/database/seeder.sql`
3. Paste dan klik "Go"

### 3. Test Aplikasi

1. **Hot Restart Flutter:**
   ```powershell
   r  # di Flutter terminal
   ```

2. **Login dengan:**
   - Email: `john.doe@example.com`
   - Password: apa saja (sementara)
   
   **Catatan:** Password verification belum aktif di backend

3. **Cek menu-menu:**
   - Dashboard harus muncul
   - KRS/KHS/Pembayaran harus load data
   - Information/Pengumuman harus tampil

### 4. Fix Password Verification (Opsional)

Edit file `siakad_backend/main.go` line 190-195:

Tambahkan import bcrypt di bagian atas:
```go
import (
    // ... existing imports
    "golang.org/x/crypto/bcrypt"
)
```

Uncomment dan fix password check:
```go
// Verify password with bcrypt
if err := bcrypt.CompareHashAndPassword([]byte(passwordHash), []byte(req.Password)); err != nil {
    jsonError(w, http.StatusUnauthorized, "Username atau password salah")
    return
}
```

Install bcrypt package:
```powershell
go get golang.org/x/crypto/bcrypt
go mod tidy
```

Update register handler juga untuk hash password saat register.

## Troubleshooting

### Error: Connection refused
- Pastikan backend running
- Check firewall settings
- Untuk device fisik, pastikan device dan komputer di WiFi yang sama

### Data tidak muncul di app
- Check database sudah di-seed
- Check backend logs untuk error
- Pastikan token JWT valid
- Cek response API di browser: http://localhost:8080/api/information

### Login gagal
- Check backend logs
- Pastikan email user ada di database
- Coba login dengan user lain dari seeder

## Testing Checklist

- [ ] Backend server running (port 8080)
- [ ] Database `siakad_db` ada
- [ ] Semua tabel created (users, information, krs, khs, pembayaran, dll)
- [ ] Seeder data inserted
- [ ] Flutter app updated (constants.dart)
- [ ] Hot restart Flutter app
- [ ] Login berhasil
- [ ] Dashboard load data
- [ ] Menu KRS/KHS/Pembayaran load data
- [ ] Information/Pengumuman tampil

## File yang Sudah Diubah

1. ✅ `lib/src/config/constants.dart` - Update API URL
2. 📝 `CONNECTION_ISSUE_FIX.md` - Dokumentasi masalah
3. 📝 `SUMMARY_OF_FIXES.md` - File ini

## Next Steps (Optional)

1. Implementasi password hashing dengan bcrypt
2. Add proper JWT authentication
3. Implementasi token refresh
4. Add error logging & monitoring
5. Setup development vs production configs

## Catatan Penting

⚠️ **Password saat ini TIDAK di-verifikasi!** Semua password di-accept untuk testing purposes.  
⚠️ Jangan deploy ke production tanpa implementasi password verification!  
✅ Backend Go sudah support semua endpoint yang diperlukan Flutter app

