# Dokumentasi Relasi Database SIAKAD

## Struktur Relasi Tabel

Semua tabel terhubung dengan user melalui foreign key. Berikut adalah diagram relasi:

```
users (1)
  │
  ├─── krs (N) ──────── krs_details (N)
  │     └─ user_id FK ───┘ krs_id FK
  │
  ├─── khs (N) ──────── khs_details (N)
  │     └─ user_id FK ───┘ khs_id FK
  │
  ├─── pembayaran (N) ──────── pembayaran_details (N)
  │     └─ user_id FK ─────────────┘ pembayaran_id FK
  │
  ├─── kerja_praktek (1) ──────── kerja_praktek_timeline (N)
  │     └─ user_id FK ───────────────┘ kp_id FK
  │
  ├─── skripsi (1) ──────── skripsi_timeline (N)
  │     └─ user_id FK ─────────────┘ skripsi_id FK
  │
  └─── information (N) - Tidak ada relasi langsung ke users (tabel umum)
```

## Detail Relasi

### 1. Users → KRS → KRS Details
- **users.id** (PK) → **krs.user_id** (FK) → **krs_details.krs_id** (FK)
- Satu user bisa punya banyak KRS (berdasarkan semester)
- Satu KRS punya banyak detail mata kuliah

### 2. Users → KHS → KHS Details
- **users.id** (PK) → **khs.user_id** (FK) → **khs_details.khs_id** (FK)
- Satu user bisa punya banyak KHS (berdasarkan semester)
- Satu KHS punya banyak detail nilai mata kuliah

### 3. Users → Pembayaran → Pembayaran Details
- **users.id** (PK) → **pembayaran.user_id** (FK) → **pembayaran_details.pembayaran_id** (FK)
- Satu user bisa punya banyak pembayaran (berdasarkan semester)
- Satu pembayaran punya banyak detail komponen pembayaran

### 4. Users → Kerja Praktek → Kerja Praktek Timeline
- **users.id** (PK) → **kerja_praktek.user_id** (FK) → **kerja_praktek_timeline.kp_id** (FK)
- Satu user biasanya punya 1 Kerja Praktek (atau 0 jika belum daftar)
- Satu Kerja Praktek punya banyak timeline steps

### 5. Users → Skripsi → Skripsi Timeline
- **users.id** (PK) → **skripsi.user_id** (FK) → **skripsi_timeline.skripsi_id** (FK)
- Satu user biasanya punya 1 Skripsi (atau 0 jika belum daftar)
- Satu Skripsi punya banyak timeline steps

### 6. Information
- **information** adalah tabel umum, tidak ada relasi langsung ke users
- Semua user bisa melihat semua informasi

## Foreign Key Constraints

Semua foreign key menggunakan `ON DELETE CASCADE`, artinya:
- Jika user dihapus, semua data terkait (KRS, KHS, Pembayaran, KP, Skripsi) juga akan terhapus otomatis
- Jika KRS dihapus, semua KRS details akan terhapus otomatis
- Jika KP dihapus, semua KP timeline akan terhapus otomatis
- Dan seterusnya...

