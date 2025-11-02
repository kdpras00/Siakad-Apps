# SIAKAD Apps - Sistem Informasi Akademik

Aplikasi mobile Sistem Informasi Akademik untuk Fakultas Teknik UMT, dibangun dengan Flutter dan backend Go yang terintegrasi dengan database MySQL.

## 🚀 Fitur Aplikasi

- ✅ **Autentikasi**: Login, Register, Change Password, Logout
- ✅ **Dashboard**: Menu utama dengan akses ke semua fitur
- ✅ **Informasi**: Pengumuman dan informasi penting
- ✅ **KRS**: Kartu Rencana Studi (mata kuliah yang diambil)
- ✅ **KHS**: Kartu Hasil Studi (nilai dan IPK)
- ✅ **Pembayaran**: Status pembayaran per semester
- ✅ **Profile**: Data profil mahasiswa
- ✅ **Tugas Akhir**: KP dan Skripsi

## 📋 Tech Stack

### Frontend
- **Framework**: Flutter 3.9.2+
- **State Management**: Provider
- **HTTP Client**: http package
- **Local Storage**: shared_preferences

### Backend
- **Language**: Go
- **Router**: Gorilla Mux
- **Database**: MySQL
- **Auth**: JWT/Sessions

### Database
- **MySQL** dengan 8 tabel:
  - users
  - information
  - krs, krs_details
  - khs, khs_details
  - pembayaran, pembayaran_details

## 📦 Instalasi & Setup

### 1. Prerequisites

- Flutter SDK (3.9.2+)
- Go (untuk backend)
- XAMPP (MySQL + phpMyAdmin)
- VS Code / Android Studio

### 2. Clone Repository

```bash
git clone <repository-url>
cd siakad_apps
```

### 3. Setup Database

**Jalankan Migration:**

Metode 1: Menggunakan Go (Recommended)
```bash
cd siakad_backend
go run database/migrate.go
```

Metode 2: Menggunakan Batch File
```bash
.\siakad_backend\run_migrate.bat
```

Metode 3: Menggunakan phpMyAdmin
1. Buka phpMyAdmin
2. Pilih database `siakad_db`
3. Tab "SQL"
4. Copy-paste `siakad_backend/database/migration.sql`
5. Klik "Go"

Metode 4: Menggunakan MySQL CLI
```bash
mysql -u root siakad_db < siakad_backend/database/migration.sql
```

### 4. Setup Backend Go

```bash
cd siakad_backend

# Install dependencies
go mod tidy

# Update handlers untuk query database
# Lihat: database/HANDLER_EXAMPLE.md

# Run backend
go run main.go
```

### 5. Setup Flutter

```bash
# Install dependencies
flutter pub get

# Update URL backend di lib/src/config/constants.dart
# static const String baseUrl = "http://localhost:8080/api";
```

### 6. Run Aplikasi

```bash
# Web
flutter run -d chrome

# Android
flutter run -d android

# iOS (hanya Mac)
flutter run -d ios
```

## 📖 Dokumentasi

- **`INTEGRASI_BACKEND.md`** - Dokumentasi lengkap integrasi Flutter-Go
- **`README_BACKEND_INTEGRATION.md`** - Quick start guide
- **`MIGRATION_STEPS.md`** - Panduan migration database
- **`siakad_backend/MIGRATION_WITH_GO.md`** - Migration dengan Go
- **`siakad_backend/database/README_MIGRATION.md`** - Struktur tabel
- **`siakad_backend/database/HANDLER_EXAMPLE.md`** - Contoh handler Go
- **`siakad_backend/ENV_SETUP.md`** - Setup environment variables
- **`UPDATE_ENDPOINT_BACKEND.md`** - Panduan implementasi backend

## 🔌 Konfigurasi Backend

Edit `lib/src/config/constants.dart`:

```dart
static const String baseUrl = "http://localhost:8080/api";
```

Untuk emulator Android:
```dart
static const String baseUrl = "http://10.0.2.2:8080/api";
```

Untuk device fisik:
```dart
static const String baseUrl = "http://192.168.1.100:8080/api";
```

## 📱 Screenshots

- Login Page
- Dashboard
- KRS/KHS Lists
- Profile

## 🛠️ Development

### Struktur Project

```
siakad_apps/
├── lib/
│   ├── main.dart
│   ├── models/           # Data models
│   ├── services/         # API services
│   ├── providers/        # State management
│   └── src/
│       ├── config/       # App configuration
│       └── features/     # Feature modules
│           ├── auth/
│           ├── home/
│           ├── information/
│           ├── krs/
│           ├── khs/
│           ├── pembayaran/
│           └── profile/
├── siakad_backend/
│   ├── database/
│   │   ├── migration.sql
│   │   ├── migrate.go
│   │   └── HANDLER_EXAMPLE.md
│   ├── handlers/
│   ├── models/
│   └── main.go
└── assets/
    └── images/
```

### Database Schema

- **users**: Data mahasiswa
- **information**: Pengumuman
- **krs**: Kartu rencana studi
- **krs_details**: Detail mata kuliah
- **khs**: Kartu hasil studi
- **khs_details**: Detail nilai
- **pembayaran**: Pembayaran semester
- **pembayaran_details**: Detail komponen pembayaran

## 🧪 Testing

### Test Backend
```bash
# Test login
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"test123"}'

# Test KRS
curl -X GET http://localhost:8080/api/krs \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### Test Flutter
```bash
flutter test
```

## 🐛 Troubleshooting

### Migration Error
- Pastikan MySQL berjalan
- Pastikan database `siakad_db` sudah ada
- Periksa kredensial MySQL

### Backend Connection Error
- Periksa URL di `constants.dart`
- Pastikan backend Go sudah running
- Untuk Android emulator, gunakan `10.0.2.2` bukan `localhost`

### Flutter Build Error
- Jalankan `flutter clean`
- `flutter pub get`
- `flutter run`

### Data Tidak Muncul
- Periksa console untuk error
- Verifikasi endpoint backend sudah diimplementasikan
- Pastikan format response sesuai model

## 📝 TODO

- [ ] Implementasi handler backend untuk semua endpoint
- [ ] Insert sample data ke database
- [ ] Test semua fitur end-to-end
- [ ] Implementasi pull-to-refresh
- [ ] Offline caching
- [ ] Push notifications

## 👥 Contributors

- Developer: [Your Name]

## 📄 License

[Your License]

## 🔗 Links

- [Documentation](INTEGRASI_BACKEND.md)
- [Migration Guide](MIGRATION_STEPS.md)
- [Backend Examples](siakad_backend/database/HANDLER_EXAMPLE.md)
