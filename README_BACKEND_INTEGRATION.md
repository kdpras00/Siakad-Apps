# Integrasi Backend - Quick Start Guide

## ⚠️ PENTING: Database Minimal

Database hanya memiliki **2 tabel**:
- `users` - Data user/mahasiswa
- `information` - Data informasi/pengumuman

Untuk fitur **KRS, KHS, dan Pembayaran**, backend harus **generate data secara dinamis** karena tidak ada tabel khusus untuk fitur tersebut.

## Langkah Setup

### 1. Update URL Backend

Edit file: `lib/src/config/constants.dart`

```dart
static const String baseUrl = "http://localhost:8080/api";
// Atau untuk emulator Android:
// static const String baseUrl = "http://10.0.2.2:8080/api";
// Atau IP address komputer:
// static const String baseUrl = "http://192.168.1.100:8080/api";
```

### 2. Backend Endpoints yang Diperlukan

#### ✅ Sudah Ada (Table: users & information)
- `POST /api/auth/login` - Login
- `POST /api/auth/register` - Registrasi
- `GET /api/auth/profile` - Profile user
- `PUT /api/auth/change-password` - Ubah password
- `POST /api/auth/logout` - Logout
- `GET /api/information` - List informasi
- `GET /api/information/:id` - Detail informasi

#### ⚠️ Perlu Generate (Tidak Ada Table)
- `GET /api/krs` - List KRS (generate dari user)
- `GET /api/krs/semester/:semester` - KRS per semester
- `GET /api/khs/rekap` - Rekap KHS (IPK, total mata kuliah)
- `GET /api/khs` - List semua KHS
- `GET /api/khs/semester/:semester` - KHS per semester
- `GET /api/pembayaran` - List pembayaran
- `GET /api/pembayaran/semester/:semester` - Pembayaran per semester

### 3. Implementasi Backend (Generate Data)

Karena tidak ada tabel KRS/KHS/Pembayaran, backend perlu generate data:

**Contoh di Go:**
```go
// Handler untuk KRS
func GetKRS(w http.ResponseWriter, r *http.Request) {
    user := getUserFromSession(r) // Ambil dari token
    
    // Generate KRS berdasarkan semester user
    krs := generateKRSData(user.Semester)
    
    json.NewEncoder(w).Encode(map[string]interface{}{
        "data": []map[string]interface{}{krs},
    })
}
```

**Detail implementasi**: Lihat file `UPDATE_ENDPOINT_BACKEND.md`

## Response Format

Semua endpoint harus return JSON dengan format:

**Success:**
```json
{
  "data": [...],
  "message": "Success message (optional)"
}
```

**Error:**
```json
{
  "message": "Error message",
  "success": false
}
```

## Autentikasi

- Endpoint auth (login, register) tidak perlu token
- Semua endpoint lain memerlukan token di header:
  ```
  Authorization: Bearer {token}
  ```

## Testing

1. **Start Backend Go**
   ```bash
   cd siakad_backend
   go run main.go
   ```

2. **Update URL di Flutter** (lihat step 1)

3. **Run Flutter App**
   ```bash
   flutter pub get
   flutter run
   ```

4. **Test Login**
   - Gunakan kredensial dari database users
   - Setelah login, semua data akan di-fetch dari backend

## Troubleshooting

### ❌ Connection Error
- Pastikan backend Go running
- Periksa URL di `constants.dart`
- Untuk Android emulator, gunakan `10.0.2.2` bukan `localhost`

### ❌ Unauthorized (401)
- Token mungkin expired, lakukan login ulang
- Periksa apakah backend validate token dengan benar

### ❌ Data Tidak Muncul
- Periksa console untuk error message
- Periksa format response dari backend
- Pastikan endpoint mengembalikan format yang sesuai

### ❌ 404 Not Found
- Periksa apakah endpoint sudah diimplementasikan di backend
- Periksa path endpoint (harus `/api/...`)

## Dokumentasi Lengkap

- `INTEGRASI_BACKEND.md` - Dokumentasi lengkap API
- `UPDATE_ENDPOINT_BACKEND.md` - Panduan implementasi backend untuk generate data

## Status Implementasi

✅ **Sudah Terintegrasi:**
- Login/Register/Change Password
- Profile User
- Information (Pengumuman)

⚠️ **Menunggu Backend (Generate Data):**
- KRS
- KHS  
- Pembayaran

---

**Note**: Aplikasi Flutter sudah siap untuk semua fitur. Backend hanya perlu mengimplementasikan endpoint yang generate data untuk KRS, KHS, dan Pembayaran.

