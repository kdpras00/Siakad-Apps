# Dokumentasi Integrasi Backend Flutter dengan Go

## Ringkasan
Aplikasi Flutter SIAKAD telah diintegrasikan dengan backend Go yang terhubung ke database MySQL. Semua fitur utama sudah tersambung dengan API backend.

## Struktur File yang Dibuat

### 1. Models (`lib/models/`)
- `user_model.dart` - Model untuk data user/mahasiswa
- `krs_model.dart` - Model untuk Kartu Rencana Studi
- `khs_model.dart` - Model untuk Kartu Hasil Studi
- `pembayaran_model.dart` - Model untuk data pembayaran

### 2. Services (`lib/services/`)
- `api_client.dart` - HTTP client untuk komunikasi dengan backend
- `auth_service.dart` - Service untuk autentikasi (login, register, change password)
- `krs_service.dart` - Service untuk data KRS
- `khs_service.dart` - Service untuk data KHS
- `pembayaran_service.dart` - Service untuk data pembayaran

### 3. Providers (`lib/providers/`)
- `auth_provider.dart` - State management untuk autentikasi
- `krs_provider.dart` - State management untuk KRS
- `khs_provider.dart` - State management untuk KHS
- `pembayaran_provider.dart` - State management untuk pembayaran

## Konfigurasi Backend

### Update URL Backend
Edit file `lib/src/config/constants.dart`:

```dart
static const String baseUrl = "http://localhost:8080/api";
// Atau jika backend di server lain:
// static const String baseUrl = "http://192.168.1.100:8080/api";
```

## Catatan Penting: Database Minimal

**Database hanya memiliki 2 tabel: `users` dan `information`**

Untuk fitur KRS, KHS, dan Pembayaran, backend diharapkan untuk **generate data secara dinamis** berdasarkan:
- Data user yang sedang login (semester, program studi, dll)
- Data hardcoded/static untuk mata kuliah (bisa dari config file)
- Atau bisa menyimpan di JSON field di tabel information dengan category khusus

Lihat file `UPDATE_ENDPOINT_BACKEND.md` untuk detail implementasi di backend Go.

## Endpoint API yang Diharapkan

### Autentikasi
- `POST /api/auth/login` - Login user
- `POST /api/auth/register` - Registrasi user baru
- `PUT /api/auth/change-password` - Ubah password (require auth)
- `GET /api/auth/profile` - Get profile user (require auth)
- `POST /api/auth/logout` - Logout (require auth)

**Response Login:**
```json
{
  "success": true,
  "message": "Login berhasil",
  "token": "jwt_token_here",
  "user": {
    "id": "1",
    "name": "Nama User",
    "nim": "0419108607",
    "email": "user@email.com",
    "phone": "081234567890",
    "program_studi": "Teknik Informatika",
    "semester": 7
  }
}
```

### Information
- `GET /api/information` - Get semua informasi (require auth)
- `GET /api/information/:id` - Get informasi by ID (require auth)

**Response Information:**
```json
{
  "data": [
    {
      "id": "1",
      "title": "Judul Informasi",
      "content": "Isi informasi lengkap...",
      "category": "Pengumuman",
      "created_at": "2024-10-20T10:00:00Z",
      "updated_at": "2024-10-20T10:00:00Z"
    }
  ]
}
```

### KRS (Generate dari Users)
- `GET /api/krs` - Get semua KRS user (require auth)
- `GET /api/krs/:id` - Get KRS by ID (require auth)
- `GET /api/krs/semester/:semester` - Get KRS by semester (require auth)

**Response KRS:**
```json
{
  "data": [
    {
      "id": "1",
      "semester": "Semester 1",
      "tahun_ajaran": "2024/2025",
      "status": "Aktif",
      "total_sks": 22,
      "details": [
        {
          "id": "1",
          "kode_mata_kuliah": "TI101",
          "nama_mata_kuliah": "Mobile Programming",
          "sks": 3,
          "dosen": "Syepry Maulana Husain, S.Kom, MTI",
          "jadwal": "Senin, 08:30 - 10:00 WIB",
          "ruangan": "Ruang A12.7"
        }
      ]
    }
  ]
}
```

### KHS (Generate dari Users)
- `GET /api/khs/rekap` - Get rekap KHS (IPK, total mata kuliah) (require auth)
- `GET /api/khs` - Get semua KHS (require auth)
- `GET /api/khs/semester/:semester` - Get KHS by semester (require auth)

**Response KHS Rekap:**
```json
{
  "data": {
    "ipk": 3.52,
    "total_mata_kuliah": 112,
    "semester_list": [
      {
        "id": "1",
        "semester": "Semester 1",
        "ip": 3.8,
        "total_mata_kuliah": 15,
        "details": [
          {
            "id": "1",
            "kode_mata_kuliah": "TI101",
            "nama_mata_kuliah": "Algoritma Pemrograman",
            "sks": 3,
            "nilai": "A",
            "nilai_angka": 4.0
          }
        ]
      }
    ]
  }
}
```

### Pembayaran (Generate dari Users)
- `GET /api/pembayaran` - Get semua pembayaran (require auth)
- `GET /api/pembayaran/semester/:semester` - Get pembayaran by semester (require auth)

**Response Pembayaran:**
```json
{
  "data": [
    {
      "id": "1",
      "semester": "Semester 1",
      "total_amount": 10000000,
      "paid_amount": 10000000,
      "remaining_amount": 0,
      "status": "Lunas",
      "details": [
        {
          "id": "1",
          "komponen": "Uang Bangunan",
          "total": 3000000,
          "paid": 3000000,
          "remaining": 0
        }
      ]
    }
  ]
}
```

## Autentikasi

Semua endpoint kecuali login dan register memerlukan token JWT yang dikirim melalui header:
```
Authorization: Bearer {token}
```

Token disimpan otomatis setelah login berhasil menggunakan `SharedPreferences`.

## Cara Menggunakan

1. **Update URL Backend**
   - Edit `lib/src/config/constants.dart`
   - Set `baseUrl` sesuai dengan alamat backend Go Anda

2. **Pastikan Backend Berjalan**
   - Backend Go harus sudah running
   - Database MySQL sudah terhubung
   - Endpoint API sesuai dengan dokumentasi di atas

3. **Jalankan Aplikasi**
   ```bash
   flutter pub get
   flutter run
   ```

4. **Testing**
   - Login dengan kredensial yang valid
   - Setelah login, semua data akan di-fetch dari backend
   - Jika ada error, periksa console untuk detail error

## Catatan Penting

1. **Format Response**: Backend harus mengembalikan response dalam format JSON yang sesuai dengan model yang sudah dibuat.

2. **Error Handling**: Aplikasi sudah memiliki error handling untuk:
   - Network errors
   - Invalid responses
   - Authentication errors

3. **Loading States**: Semua view sudah memiliki loading indicator saat fetch data.

4. **Refresh Data**: Untuk refresh data, user bisa:
   - Pull to refresh (jika diimplementasikan)
   - Klik tombol "Coba Lagi" jika ada error

## Troubleshooting

1. **Error: Connection refused**
   - Pastikan backend Go sedang berjalan
   - Periksa URL di `constants.dart`
   - Periksa firewall/network settings

2. **Error: Unauthorized**
   - Token mungkin sudah expired
   - Lakukan login ulang
   - Periksa apakah backend menerima format Authorization header yang benar

3. **Data tidak muncul**
   - Periksa console untuk error messages
   - Pastikan response dari backend sesuai format yang diharapkan
   - Periksa network logs di backend

4. **Build Error**
   - Jalankan `flutter pub get` ulang
   - Pastikan semua dependencies terinstall dengan benar

## Next Steps

1. Implementasi pull-to-refresh untuk semua list
2. Offline caching menggunakan local database (SQLite/Hive)
3. Push notifications untuk notifikasi penting
4. Implementasi fitur Tugas Akhir jika belum ada

## Support

Jika ada pertanyaan atau masalah, periksa:
1. Console logs untuk error messages
2. Network tab untuk melihat request/response
3. Backend logs untuk server-side errors

