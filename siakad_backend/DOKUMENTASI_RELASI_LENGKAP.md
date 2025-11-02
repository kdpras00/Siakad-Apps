# 📊 Dokumentasi Lengkap Relasi Tabel SIAKAD

## 🎯 Ringkasan

Semua tabel di database SIAKAD **SUDAH TERHUBUNG DENGAN BENAR** menggunakan Foreign Key (FK). Backend Go juga sudah mengimplementasikan query dengan relasi yang benar.

## 🔗 Diagram Relasi Tabel

```
┌─────────────────┐
│     USERS       │ ← Tabel utama (Primary Key: id)
│  (id, name,     │
│   nim, email)   │
└────────┬────────┘
         │
         ├─────────────────────────────────────────────────────────────┐
         │                                                             │
         │ (user_id FK)                                                │
         │                                                             │
         ▼                                                             ▼
┌─────────────────┐                                         ┌─────────────────┐
│      KRS        │                                         │      KHS         │
│ (id, user_id,   │                                         │ (id, user_id,    │
│  semester,      │                                         │  semester, ip)   │
│  tahun_ajaran)  │                                         └────────┬────────┘
└────────┬────────┘                                                  │
         │                                                            │
         │ (krs_id FK)                                                │ (khs_id FK)
         │                                                            │
         ▼                                                            ▼
┌─────────────────┐                                         ┌─────────────────┐
│  KRS_DETAILS    │                                         │  KHS_DETAILS     │
│ (id, krs_id,    │                                         │ (id, khs_id,     │
│  kode_mk,       │                                         │  kode_mk,       │
│  nama_mk, sks)  │                                         │  nilai, ip)      │
└─────────────────┘                                         └─────────────────┘

         │
         │ (user_id FK)
         │
         ▼
┌─────────────────┐
│   PEMBAYARAN    │
│ (id, user_id,   │
│  semester,      │
│  total_amount)  │
└────────┬────────┘
         │
         │ (pembayaran_id FK)
         │
         ▼
┌─────────────────┐
│ PEMBAYARAN_     │
│    DETAILS      │
│ (id, pembayaran_│
│  id, komponen,  │
│  total, paid)   │
└─────────────────┘

         │
         │ (user_id FK)
         │
         ▼
┌─────────────────┐
│ KERJA_PRAKTEK   │
│ (id, user_id,   │
│  judul, status) │
└────────┬────────┘
         │
         │ (kp_id FK)
         │
         ▼
┌─────────────────┐
│ KP_TIMELINE     │
│ (id, kp_id,     │
│  step_name,     │
│  step_date)     │
└─────────────────┘

         │
         │ (user_id FK)
         │
         ▼
┌─────────────────┐
│    SKRIPSI      │
│ (id, user_id,   │
│  judul, status) │
└────────┬────────┘
         │
         │ (skripsi_id FK)
         │
         ▼
┌─────────────────┐
│ SKRIPSI_TIMELINE│
│ (id, skripsi_id,│
│  step_name,     │
│  step_date)     │
└─────────────────┘

┌─────────────────┐
│  INFORMATION    │ ← Tabel umum (tidak ada FK ke users)
│ (id, title,     │   Semua user bisa lihat semua informasi
│  content, date) │
└─────────────────┘
```

## ✅ Status Implementasi Backend

### 1. KRS Handler ✅ SUDAH BENAR
**File:** `siakad_backend/main.go` - `handleGetKRS()`

```go
// Query 1: Ambil KRS berdasarkan user_id
WHERE k.user_id = ?  ✅

// Query 2: Ambil KRS Details berdasarkan krs_id
WHERE krs_id = ?  ✅
```

**Relasi yang digunakan:**
- ✅ `users.id` → `krs.user_id`
- ✅ `krs.id` → `krs_details.krs_id`

### 2. KHS Handler ✅ SUDAH BENAR
**File:** `siakad_backend/main.go` - `handleGetKHS()`, `handleGetKHSRekap()`

```go
// Query 1: Ambil KHS berdasarkan user_id
WHERE user_id = ?  ✅

// Query 2: Ambil KHS Details berdasarkan khs_id
WHERE khs_id = ?  ✅
```

**Relasi yang digunakan:**
- ✅ `users.id` → `khs.user_id`
- ✅ `khs.id` → `khs_details.khs_id`

### 3. Pembayaran Handler ✅ SUDAH BENAR
**File:** `siakad_backend/main.go` - `handleGetPembayaran()`

```go
// Query 1: Ambil Pembayaran berdasarkan user_id
WHERE user_id = ?  ✅

// Query 2: Ambil Pembayaran Details berdasarkan pembayaran_id
WHERE pembayaran_id = ?  ✅
```

**Relasi yang digunakan:**
- ✅ `users.id` → `pembayaran.user_id`
- ✅ `pembayaran.id` → `pembayaran_details.pembayaran_id`

### 4. Kerja Praktek Handler ✅ SUDAH BENAR
**File:** `siakad_backend/main.go` - `handleGetKerjaPraktek()`

```go
// Query 1: Ambil KP berdasarkan user_id
WHERE user_id = ?  ✅

// Query 2: Ambil KP Timeline berdasarkan kp_id
WHERE kp_id = ?  ✅
```

**Relasi yang digunakan:**
- ✅ `users.id` → `kerja_praktek.user_id`
- ✅ `kerja_praktek.id` → `kerja_praktek_timeline.kp_id`

### 5. Skripsi Handler ✅ SUDAH BENAR
**File:** `siakad_backend/main.go` - `handleGetSkripsi()`

```go
// Query 1: Ambil Skripsi berdasarkan user_id
WHERE user_id = ?  ✅

// Query 2: Ambil Skripsi Timeline berdasarkan skripsi_id
WHERE skripsi_id = ?  ✅
```

**Relasi yang digunakan:**
- ✅ `users.id` → `skripsi.user_id`
- ✅ `skripsi.id` → `skripsi_timeline.skripsi_id`

### 6. Information Handler ✅ SUDAH BENAR
**File:** `siakad_backend/main.go` - `handleGetInformation()`

```go
// Query: Ambil semua informasi (tidak ada filter user_id)
// Information adalah tabel umum untuk semua user
SELECT * FROM information  ✅
```

**Relasi:** Tidak ada (tabel umum)

## 📋 Checklist Relasi Tabel

| Tabel Utama | Tabel Detail | Foreign Key | Status Backend |
|------------|-------------|------------|----------------|
| `users` | `krs` | `krs.user_id` → `users.id` | ✅ SUDAH BENAR |
| `krs` | `krs_details` | `krs_details.krs_id` → `krs.id` | ✅ SUDAH BENAR |
| `users` | `khs` | `khs.user_id` → `users.id` | ✅ SUDAH BENAR |
| `khs` | `khs_details` | `khs_details.khs_id` → `khs.id` | ✅ SUDAH BENAR |
| `users` | `pembayaran` | `pembayaran.user_id` → `users.id` | ✅ SUDAH BENAR |
| `pembayaran` | `pembayaran_details` | `pembayaran_details.pembayaran_id` → `pembayaran.id` | ✅ SUDAH BENAR |
| `users` | `kerja_praktek` | `kerja_praktek.user_id` → `users.id` | ✅ SUDAH BENAR |
| `kerja_praktek` | `kerja_praktek_timeline` | `kerja_praktek_timeline.kp_id` → `kerja_praktek.id` | ✅ SUDAH BENAR |
| `users` | `skripsi` | `skripsi.user_id` → `users.id` | ✅ SUDAH BENAR |
| `skripsi` | `skripsi_timeline` | `skripsi_timeline.skripsi_id` → `skripsi.id` | ✅ SUDAH BENAR |

## 🔐 Constraint Foreign Key di Database

Semua foreign key menggunakan `ON DELETE CASCADE`:

```sql
-- KRS
ALTER TABLE `krs`
  ADD CONSTRAINT `krs_ibfk_1` 
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

-- KRS Details
ALTER TABLE `krs_details`
  ADD CONSTRAINT `krs_details_ibfk_1` 
  FOREIGN KEY (`krs_id`) REFERENCES `krs` (`id`) ON DELETE CASCADE;

-- KHS
ALTER TABLE `khs`
  ADD CONSTRAINT `khs_ibfk_1` 
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

-- KHS Details
ALTER TABLE `khs_details`
  ADD CONSTRAINT `khs_details_ibfk_1` 
  FOREIGN KEY (`khs_id`) REFERENCES `khs` (`id`) ON DELETE CASCADE;

-- Pembayaran
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` 
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

-- Pembayaran Details
ALTER TABLE `pembayaran_details`
  ADD CONSTRAINT `pembayaran_details_ibfk_1` 
  FOREIGN KEY (`pembayaran_id`) REFERENCES `pembayaran` (`id`) ON DELETE CASCADE;

-- Kerja Praktek
ALTER TABLE `kerja_praktek`
  ADD CONSTRAINT `kerja_praktek_ibfk_1` 
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

-- Kerja Praktek Timeline
ALTER TABLE `kerja_praktek_timeline`
  ADD CONSTRAINT `kerja_praktek_timeline_ibfk_1` 
  FOREIGN KEY (`kp_id`) REFERENCES `kerja_praktek` (`id`) ON DELETE CASCADE;

-- Skripsi
ALTER TABLE `skripsi`
  ADD CONSTRAINT `skripsi_ibfk_1` 
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

-- Skripsi Timeline
ALTER TABLE `skripsi_timeline`
  ADD CONSTRAINT `skripsi_timeline_ibfk_1` 
  FOREIGN KEY (`skripsi_id`) REFERENCES `skripsi` (`id`) ON DELETE CASCADE;
```

## 💡 Cara Kerja di Backend

### Alur Query Handler (Contoh: KRS)

```
1. User Login → Mendapat Token (berisi user_id)
                ↓
2. Request GET /api/krs
   → Middleware ekstrak user_id dari token
                ↓
3. Query KRS berdasarkan user_id:
   SELECT * FROM krs WHERE user_id = ?  ✅
                ↓
4. Untuk setiap KRS, query details:
   SELECT * FROM krs_details WHERE krs_id = ?  ✅
                ↓
5. Return JSON dengan struktur:
   {
     "data": [
       {
         "id": 1,
         "semester": "Semester 7",
         "details": [
           { "kode_mata_kuliah": "TI701", ... },
           { "kode_mata_kuliah": "TI702", ... }
         ]
       }
     ]
   }
```

## ✅ Kesimpulan

**SEMUA RELASI SUDAH BENAR!** ✅

1. ✅ Semua tabel terhubung dengan `users` melalui `user_id`
2. ✅ Semua tabel detail terhubung dengan tabel utama melalui foreign key
3. ✅ Backend sudah mengimplementasikan query dengan relasi yang benar
4. ✅ Semua handler menggunakan `WHERE user_id = ?` untuk security
5. ✅ Semua detail diambil menggunakan foreign key (krs_id, khs_id, dll)

**TIDAK ADA PERUBAHAN YANG DIPERLUKAN!** 🎉

Semua sudah implementasi dengan benar sesuai best practice database relationships.

