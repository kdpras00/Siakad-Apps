# 🔍 Debug Checklist - Data Tidak Masuk

## ✅ Checklist yang Harus Dicek:

### 1. **Backend Berjalan**
```bash
cd siakad_backend
go run main.go
```
**Pastikan muncul pesan:**
```
✓ Database connected successfully!
🚀 Server starting on port 8080
```

### 2. **Cek Console Browser (F12 → Console)**
Setelah buka aplikasi Flutter di Chrome, buka DevTools:
- Tekan **F12**
- Klik tab **Console**
- Lihat log yang muncul ketika membuka halaman KRS/KHS/Pembayaran

**Log yang harus muncul:**
```
🌐 API GET: http://localhost:8080/api/krs
🔑 Token: ***
📥 Response Status: 200
📥 Response Body: {...}
📦 KRS Response data: {...}
✅ KRS Provider: Loaded X items
```

### 3. **Cek Token Authentication**
Jika muncul error **401 Unauthorized**:
- Pastikan sudah login
- Cek apakah token tersimpan di SharedPreferences
- Coba logout dan login ulang

### 4. **Cek Data di Database**
```sql
-- Cek apakah ada data untuk user yang login
SELECT * FROM krs WHERE user_id = 1;
SELECT * FROM khs WHERE user_id = 1;
SELECT * FROM pembayaran WHERE user_id = 1;
SELECT * FROM kerja_praktek WHERE user_id = 1;
SELECT * FROM skripsi WHERE user_id = 1;
```

### 5. **Cek URL Backend**
File: `lib/src/config/constants.dart`
```dart
static String get baseUrl {
  if (kIsWeb) {
    return "http://localhost:8080/api";  // ← Pastikan port 8080
  }
  return "http://10.0.2.2:8080/api";
}
```

### 6. **Kemungkinan Masalah:**

#### ❌ **Response 200 tapi data kosong []**
- **Penyebab:** Database tidak punya data untuk user tersebut
- **Solusi:** Jalankan seeder untuk user tersebut

#### ❌ **Error: Connection refused / Failed host lookup**
- **Penyebab:** Backend tidak berjalan
- **Solusi:** Jalankan backend Go server

#### ❌ **Error: 401 Unauthorized**
- **Penyebab:** Token tidak valid atau tidak ada
- **Solusi:** Login ulang

#### ❌ **Error: Timeout**
- **Penyebab:** Backend tidak merespons dalam 10 detik
- **Solusi:** Restart backend atau cek koneksi database

## 🧪 Test Manual API

Buka browser dan coba akses:
```
http://localhost:8080/api
```

Harus muncul JSON dengan daftar endpoints.

## 📝 Log yang Harus Diperhatikan:

1. **🌐 API GET:** Menunjukkan URL yang dipanggil
2. **🔑 Token:** Menunjukkan apakah token ada (***) atau null
3. **📥 Response Status:** Harus 200, jika 401 = token invalid
4. **📥 Response Body:** Isi response dari backend
5. **✅/❌ Provider:** Apakah data berhasil di-load atau ada error

Jika semua log muncul tapi data tetap kosong, kemungkinan besar **data tidak ada di database untuk user tersebut**.

