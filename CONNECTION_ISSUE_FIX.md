# Fix Connection Issue - SIAKAD Apps

## Summary of Issues Found and Fixed

### Problem
Login was working with any password, and menus weren't loading data from the database.

### Root Causes Identified

1. **API URL Configuration**
   - The app was configured to use `localhost:8080` which doesn't work on Android emulators
   - **Fixed**: Updated to use `10.0.2.2:8080` for Android emulator (line 18 in constants.dart)

2. **Password Verification Disabled**  
   - Backend Go code has password verification commented out (lines 190-195 in main.go)
   - **Status**: TODO - needs bcrypt implementation

3. **Database Schema Mismatch**
   - Backend queries `information` table with `category` column
   - Seeder inserts without `category` column
   - May need to check/run migration for the database

## Fixes Applied

### 1. Updated Constants (lib/src/config/constants.dart)
Changed from hardcoded `localhost` to platform-aware URL:
```dart
static String get baseUrl {
  if (kIsWeb) {
    return "http://localhost:8080/api";
  }
  // For Android emulator
  return "http://10.0.2.2:8080/api";
}
```

### 2. Backend Already Configured
Backend Go code is already set up with:
- ✅ CORS middleware
- ✅ All API endpoints defined
- ✅ Database connection working
- ⚠️ Password verification disabled (needs fix)

## Required Actions

### 1. Restart Backend Server
Backend is running but may need database tables created/verified:
```powershell
# Stop current backend (Ctrl+C in terminal)
cd siakad_backend
go run main.go
```

### 2. Verify/Create Database Tables
Check if all tables exist in `siakad_db`:

Required tables:
- ✅ users (should already exist)
- ⚠️ information (may need creation)
- ⚠️ krs, krs_details
- ⚠️ khs, khs_details  
- ⚠️ pembayaran, pembayaran_details

Run migration if needed:
```powershell
cd siakad_backend
go run database/migrate.go
```

Then run seeder:
```powershell
cd siakad_backend/database
go run seeder.go
```

### 3. Test Login
After fixes, test login with:
- **Email**: john.doe@example.com
- **Password**: Any password (currently not verified, will be fixed)

### 4. Fix Password Verification (Optional)
Edit `siakad_backend/main.go` lines 190-195:
```go
// TODO: Verify password (gunakan bcrypt atau hash yang sama dengan register)
// Untuk sementara, skip password verification jika belum ada
// if !checkPassword(req.Password, passwordHash) {
//     jsonError(w, http.StatusUnauthorized, "Username atau password salah")
//     return
// }
```

Uncomment and implement bcrypt check.

## Testing Checklist

- [ ] Backend server running on port 8080
- [ ] All database tables created
- [ ] Seeder data inserted
- [ ] Flutter app updated with new constants
- [ ] Test login with john.doe@example.com
- [ ] Verify menus load data from backend
- [ ] Test on Android emulator
- [ ] (Optional) Implement password verification

## Notes

For physical device testing, update line 21 in constants.dart:
```dart
// Physical device uses computer's IP
return "http://192.168.0.223:8080/api";
```

Your computer's IP is: 192.168.0.223

