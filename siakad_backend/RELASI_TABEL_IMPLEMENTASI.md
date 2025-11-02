# Implementasi Relasi Tabel di Backend Go

## Prinsip Dasar

Semua handler backend HARUS:
1. ✅ **Mengambil user_id dari token** untuk memastikan data yang diambil sesuai dengan user yang login
2. ✅ **Menggunakan WHERE user_id = ?** pada query utama
3. ✅ **Query detail menggunakan foreign key** (krs_id, khs_id, pembayaran_id, kp_id, skripsi_id)
4. ✅ **Verifikasi ownership** - pastikan data yang diambil benar milik user yang sedang login

## Implementasi Handler

### 1. KRS Handler (Sudah Benar ✅)

```go
func handleGetKRS(w http.ResponseWriter, r *http.Request) {
    // 1. Ambil user_id dari token
    userID, err := getUserIDFromToken(r)
    
    // 2. Query KRS berdasarkan user_id
    rows, err := db.Query(`
        SELECT k.id, k.semester, k.tahun_ajaran, k.status, k.total_sks
        FROM krs k
        WHERE k.user_id = ?  -- ✅ Relasi ke users
        ORDER BY k.semester DESC
    `, userID)
    
    // 3. Untuk setiap KRS, query details menggunakan krs_id
    detailRows, err := db.Query(`
        SELECT id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan
        FROM krs_details
        WHERE krs_id = ?  -- ✅ Relasi ke krs
        ORDER BY kode_mata_kuliah
    `, krsID)
}
```

**Relasi yang digunakan:**
- ✅ `users.id` → `krs.user_id`
- ✅ `krs.id` → `krs_details.krs_id`

### 2. KHS Handler (Sudah Benar ✅)

```go
func handleGetKHS(w http.ResponseWriter, r *http.Request) {
    // 1. Ambil user_id dari token
    userID, err := getUserIDFromToken(r)
    
    // 2. Query KHS berdasarkan user_id
    rows, err := db.Query(`
        SELECT id, semester, ip, total_mata_kuliah
        FROM khs
        WHERE user_id = ?  -- ✅ Relasi ke users
        ORDER BY semester DESC
    `, userID)
    
    // 3. Query details menggunakan khs_id
    detailRows, err := db.Query(`
        SELECT id, kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka
        FROM khs_details
        WHERE khs_id = ?  -- ✅ Relasi ke khs
        ORDER BY kode_mata_kuliah
    `, khsID)
}
```

**Relasi yang digunakan:**
- ✅ `users.id` → `khs.user_id`
- ✅ `khs.id` → `khs_details.khs_id`

### 3. Pembayaran Handler (Sudah Benar ✅)

```go
func handleGetPembayaran(w http.ResponseWriter, r *http.Request) {
    // 1. Ambil user_id dari token
    userID, err := getUserIDFromToken(r)
    
    // 2. Query pembayaran berdasarkan user_id
    rows, err := db.Query(`
        SELECT id, semester, total_amount, paid_amount, remaining_amount, status
        FROM pembayaran
        WHERE user_id = ?  -- ✅ Relasi ke users
        ORDER BY semester DESC
    `, userID)
    
    // 3. Query details menggunakan pembayaran_id
    detailRows, err := db.Query(`
        SELECT id, komponen, total, paid, remaining
        FROM pembayaran_details
        WHERE pembayaran_id = ?  -- ✅ Relasi ke pembayaran
        ORDER BY komponen
    `, pembayaranID)
}
```

**Relasi yang digunakan:**
- ✅ `users.id` → `pembayaran.user_id`
- ✅ `pembayaran.id` → `pembayaran_details.pembayaran_id`

### 4. Kerja Praktek Handler (Sudah Benar ✅)

```go
func handleGetKerjaPraktek(w http.ResponseWriter, r *http.Request) {
    // 1. Ambil user_id dari token
    userID, err := getUserIDFromToken(r)
    
    // 2. Query KP berdasarkan user_id
    err = db.QueryRow(`
        SELECT id, judul, tempat_penelitian, alamat_penelitian, pembimbing, status
        FROM kerja_praktek
        WHERE user_id = ?  -- ✅ Relasi ke users
        LIMIT 1
    `, userID).Scan(...)
    
    // 3. Query timeline menggunakan kp_id
    timelineRows, err := db.Query(`
        SELECT step_name, step_date, is_done, icon_name
        FROM kerja_praktek_timeline
        WHERE kp_id = ?  -- ✅ Relasi ke kerja_praktek
        ORDER BY id ASC
    `, kpID)
}
```

**Relasi yang digunakan:**
- ✅ `users.id` → `kerja_praktek.user_id`
- ✅ `kerja_praktek.id` → `kerja_praktek_timeline.kp_id`

### 5. Skripsi Handler (Sudah Benar ✅)

```go
func handleGetSkripsi(w http.ResponseWriter, r *http.Request) {
    // 1. Ambil user_id dari token
    userID, err := getUserIDFromToken(r)
    
    // 2. Query Skripsi berdasarkan user_id
    err = db.QueryRow(`
        SELECT id, judul, tempat_penelitian, alamat_penelitian, pembimbing, status
        FROM skripsi
        WHERE user_id = ?  -- ✅ Relasi ke users
        LIMIT 1
    `, userID).Scan(...)
    
    // 3. Query timeline menggunakan skripsi_id
    timelineRows, err := db.Query(`
        SELECT step_name, step_date, is_done, icon_name
        FROM skripsi_timeline
        WHERE skripsi_id = ?  -- ✅ Relasi ke skripsi
        ORDER BY id ASC
    `, skripsiID)
}
```

**Relasi yang digunakan:**
- ✅ `users.id` → `skripsi.user_id`
- ✅ `skripsi.id` → `skripsi_timeline.skripsi_id`

### 6. Information Handler (Sudah Benar ✅)

```go
func handleGetInformation(w http.ResponseWriter, r *http.Request) {
    // Information tidak terikat ke user tertentu (tabel umum)
    rows, err := db.Query(`
        SELECT id, title, content, date, created_at
        FROM information
        ORDER BY created_at DESC, id DESC
    `)
    // Tidak perlu WHERE user_id karena informasi untuk semua user
}
```

**Relasi:** Tidak ada relasi ke users (tabel umum)

## Checklist Implementasi

Pastikan semua handler sudah:

- [x] Mengambil `user_id` dari token
- [x] Query utama menggunakan `WHERE user_id = ?`
- [x] Query detail menggunakan foreign key (krs_id, khs_id, dll)
- [x] Verifikasi ownership (khusus untuk by ID)
- [x] Handle error dengan baik
- [x] Return data dalam format yang sesuai dengan model Flutter

## Contoh Query dengan JOIN (Alternatif)

Jika ingin menggunakan JOIN untuk optimasi, bisa menggunakan:

```go
// KRS dengan JOIN
rows, err := db.Query(`
    SELECT 
        k.id, k.semester, k.tahun_ajaran, k.status, k.total_sks,
        kd.id as detail_id, kd.kode_mata_kuliah, kd.nama_mata_kuliah, 
        kd.sks, kd.dosen, kd.jadwal, kd.ruangan
    FROM krs k
    LEFT JOIN krs_details kd ON k.id = kd.krs_id
    WHERE k.user_id = ?
    ORDER BY k.semester DESC, kd.kode_mata_kuliah
`, userID)
```

Namun, implementasi saat ini (query terpisah) sudah benar dan lebih mudah dibaca.

## Kesimpulan

✅ **Semua handler sudah benar** menggunakan relasi foreign key:
- ✅ KRS → KRS Details
- ✅ KHS → KHS Details  
- ✅ Pembayaran → Pembayaran Details
- ✅ Kerja Praktek → Kerja Praktek Timeline
- ✅ Skripsi → Skripsi Timeline
- ✅ Semua terhubung ke Users melalui user_id

Tidak ada perubahan yang diperlukan pada backend, semua sudah implementasi dengan benar! 🎉

