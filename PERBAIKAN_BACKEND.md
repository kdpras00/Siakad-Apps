# Dokumentasi Perbaikan Backend

## Ringkasan Masalah dan Solusi

Dokumen ini menjelaskan masalah yang terjadi saat login dan mengecek profile, serta solusi yang telah diimplementasikan.

## Masalah yang Ditemukan

### 1. ❌ Error 401 Unauthorized pada `/api/auth/profile`

**Penyebab:**
- Backend tidak menghandle format token "Bearer {token}" dengan benar
- Flutter mengirim token dalam format: `Authorization: Bearer token_1_email@example.com`
- Backend hanya membaca header "Authorization" tanpa menghapus prefix "Bearer "
- Parsing token dengan `fmt.Sscanf` gagal karena format tidak sesuai

**Solusi:**
- ✅ Menambahkan helper function `getUserIDFromToken()` yang:
  - Membaca header "Authorization"
  - Menghapus prefix "Bearer " jika ada
  - Mem-parse token dengan format `token_{userID}_{email}`
  - Mengembalikan user ID atau error jika token tidak valid
- ✅ Update `handleProfile()` untuk menggunakan helper function ini

### 2. ❌ Error 500 Internal Server Error pada `/api/information`

**Penyebab:**
- Error handling tidak lengkap saat query database
- Tidak ada penanganan untuk `rows.Err()` setelah iterasi
- Tidak ada fallback value untuk field yang mungkin NULL

**Solusi:**
- ✅ Menambahkan error logging dengan `log.Printf()`
- ✅ Menambahkan pengecekan `rows.Err()` setelah iterasi
- ✅ Menambahkan fallback value (empty string) untuk field NULL
- ✅ Error message lebih informatif untuk debugging

### 3. ❌ Error 501 Not Implemented pada `/api/khs/rekap`, `/api/khs`, dan `/api/pembayaran`

**Penyebab:**
- Handler untuk endpoint KHS dan Pembayaran belum diimplementasikan
- Handler hanya mengembalikan response 501 Not Implemented

**Solusi:**
- ✅ Implementasi lengkap handler `handleGetKHSRekap()`:
  - Query semua KHS berdasarkan user_id
  - Menghitung IPK secara dinamis dari semua nilai
  - Mengembalikan rekap lengkap dengan detail per semester
- ✅ Implementasi handler `handleGetKHS()`:
  - Query semua KHS untuk user yang sedang login
  - Menyertakan detail nilai mata kuliah
- ✅ Implementasi handler `handleGetKHSBySemester()`:
  - Query KHS berdasarkan semester tertentu
- ✅ Implementasi handler `handleGetPembayaran()`:
  - Query semua pembayaran untuk user yang sedang login
  - Menyertakan detail komponen pembayaran
- ✅ Implementasi handler `handleGetPembayaranBySemester()`:
  - Query pembayaran berdasarkan semester tertentu

### 4. ✅ Perbaikan Tambahan

- ✅ Implementasi handler KRS yang sudah ada tapi belum lengkap:
  - `handleGetKRS()` - sekarang query dari database dengan detail lengkap
  - `handleGetKRSByID()` - verifikasi ownership sebelum return data
  - `handleGetKRSBySemester()` - query berdasarkan semester

## File yang Diubah

### 1. `siakad_backend/main.go`
- ✅ Menambahkan import `strings` package
- ✅ Menambahkan helper function `getUserIDFromToken()`
- ✅ Update `handleProfile()` untuk menggunakan helper function
- ✅ Update `handleGetInformation()` dengan error handling yang lebih baik
- ✅ Implementasi lengkap semua handler KRS, KHS, dan Pembayaran

### 2. `siakad_backend/database/seeder.sql` (File Baru)
- ✅ Seeder lengkap untuk semua tabel:
  - 4 sample users
  - 5 sample information
  - KRS dengan detail untuk 4 user
  - KHS dengan detail nilai untuk beberapa user
  - Pembayaran dengan detail komponen untuk semua user

### 3. `siakad_backend/database/README_SEEDER.md` (File Baru)
- ✅ Dokumentasi cara menggunakan seeder

## Cara Menggunakan

### 1. Jalankan Seeder Database

```bash
# Metode 1: phpMyAdmin
# - Buka phpMyAdmin
# - Pilih database siakad_db
# - Tab SQL
# - Copy-paste isi siakad_backend/database/seeder.sql
# - Klik Go

# Metode 2: Command Line
mysql -u root -p siakad_db < siakad_backend/database/seeder.sql
```

Lihat `siakad_backend/database/README_SEEDER.md` untuk detail lengkap.

### 2. Restart Backend Server

```bash
cd siakad_backend
go run main.go
```

### 3. Test Login

Gunakan kredensial dari seeder:
- Email: `john.doe@example.com` atau NIM: `0419108607`
- Password: `password123`

## Testing Endpoint

Setelah restart backend, semua endpoint seharusnya berfungsi:

### ✅ `/api/auth/profile`
- **Sebelum:** 401 Unauthorized
- **Sesudah:** 200 OK dengan data user

### ✅ `/api/information`
- **Sebelum:** 500 Internal Server Error
- **Sesudah:** 200 OK dengan list information

### ✅ `/api/khs/rekap`
- **Sebelum:** 501 Not Implemented
- **Sesudah:** 200 OK dengan rekap KHS lengkap (IPK, total mata kuliah, dll)

### ✅ `/api/khs`
- **Sebelum:** 501 Not Implemented
- **Sesudah:** 200 OK dengan list semua KHS

### ✅ `/api/pembayaran`
- **Sebelum:** 501 Not Implemented
- **Sesudah:** 200 OK dengan list semua pembayaran

## Security Notes

⚠️ **PENTING:** 
- Token saat ini menggunakan format sederhana `token_{userID}_{email}`. Untuk production, gunakan JWT (JSON Web Token) library.
- Password disimpan dalam plain text. Untuk production, gunakan bcrypt atau hashing lainnya.

## Next Steps

1. ✅ **Sudah Selesai:** Semua handler sudah diimplementasikan
2. ⏳ **Optional:** Implementasi JWT untuk token authentication
3. ⏳ **Optional:** Implementasi password hashing dengan bcrypt
4. ⏳ **Optional:** Menambahkan middleware untuk authentication

## Troubleshooting

### Masih dapat 401 Unauthorized?
- Pastikan token dikirim dengan format: `Bearer token_1_email@example.com`
- Pastikan backend sudah di-restart setelah perubahan
- Cek log backend untuk melihat error message

### Masih dapat 500 Internal Server Error?
- Pastikan database sudah di-migrate
- Pastikan seeder sudah dijalankan
- Cek log backend untuk melihat error message
- Pastikan tabel `information` ada dan strukturnya benar

### Data tidak muncul?
- Pastikan seeder sudah dijalankan dengan benar
- Cek apakah data ada di database dengan query:
  ```sql
  SELECT COUNT(*) FROM users;
  SELECT COUNT(*) FROM information;
  ```

## Support

Jika masih ada masalah:
1. Cek log backend (console output)
2. Cek log browser (Network tab di Developer Tools)
3. Verifikasi database dengan query SQL
4. Pastikan migration dan seeder sudah dijalankan

