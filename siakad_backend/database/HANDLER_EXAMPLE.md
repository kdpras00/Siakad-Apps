# Contoh Handler Backend Go Setelah Migration

Setelah migration database selesai, backend Go perlu diupdate untuk mengambil data langsung dari database. Berikut contoh handler untuk setiap endpoint:

## 1. KRS Handler

```go
package handlers

import (
    "database/sql"
    "encoding/json"
    "net/http"
    "strconv"
)

// GetKRS - Get semua KRS user yang sedang login
func GetKRS(w http.ResponseWriter, r *http.Request, db *sql.DB) {
    // Ambil user_id dari session/token
    userID := getUserIDFromToken(r) // Implementasi sesuai auth system Anda
    
    query := `
        SELECT k.id, k.semester, k.tahun_ajaran, k.status, k.total_sks
        FROM krs k
        WHERE k.user_id = ?
        ORDER BY k.semester DESC
    `
    
    rows, err := db.Query(query, userID)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    defer rows.Close()
    
    var krsList []map[string]interface{}
    for rows.Next() {
        var id int
        var semester, tahunAjaran, status string
        var totalSKS int
        
        err := rows.Scan(&id, &semester, &tahunAjaran, &status, &totalSKS)
        if err != nil {
            continue
        }
        
        // Get details untuk setiap KRS
        details := getKRSDetails(db, id)
        
        krsList = append(krsList, map[string]interface{}{
            "id": id,
            "semester": semester,
            "tahun_ajaran": tahunAjaran,
            "status": status,
            "total_sks": totalSKS,
            "details": details,
        })
    }
    
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(map[string]interface{}{
        "data": krsList,
    })
}

// GetKRSDetails - Get detail mata kuliah untuk KRS
func getKRSDetails(db *sql.DB, krsID int) []map[string]interface{} {
    query := `
        SELECT kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan
        FROM krs_details
        WHERE krs_id = ?
    `
    
    rows, err := db.Query(query, krsID)
    if err != nil {
        return []map[string]interface{}{}
    }
    defer rows.Close()
    
    var details []map[string]interface{}
    for rows.Next() {
        var kodeMK, namaMK, dosen, jadwal, ruangan string
        var sks int
        
        err := rows.Scan(&kodeMK, &namaMK, &sks, &dosen, &jadwal, &ruangan)
        if err != nil {
            continue
        }
        
        details = append(details, map[string]interface{}{
            "id": len(details) + 1,
            "kode_mata_kuliah": kodeMK,
            "nama_mata_kuliah": namaMK,
            "sks": sks,
            "dosen": dosen,
            "jadwal": jadwal,
            "ruangan": ruangan,
        })
    }
    
    return details
}

// GetKRSBySemester - Get KRS berdasarkan semester
func GetKRSBySemester(w http.ResponseWriter, r *http.Request, db *sql.DB) {
    semester := r.URL.Query().Get("semester") // atau dari path parameter
    userID := getUserIDFromToken(r)
    
    query := `
        SELECT k.id, k.semester, k.tahun_ajaran, k.status, k.total_sks
        FROM krs k
        WHERE k.user_id = ? AND k.semester = ?
        LIMIT 1
    `
    
    var id int
    var sem, tahunAjaran, status string
    var totalSKS int
    
    err := db.QueryRow(query, userID, semester).Scan(&id, &sem, &tahunAjaran, &status, &totalSKS)
    if err != nil {
        http.Error(w, "KRS not found", http.StatusNotFound)
        return
    }
    
    details := getKRSDetails(db, id)
    
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(map[string]interface{}{
        "data": map[string]interface{}{
            "id": id,
            "semester": sem,
            "tahun_ajaran": tahunAjaran,
            "status": status,
            "total_sks": totalSKS,
            "details": details,
        },
    })
}
```

## 2. KHS Handler

```go
// GetKHSRekap - Get rekap KHS (IPK dan total mata kuliah)
func GetKHSRekap(w http.ResponseWriter, r *http.Request, db *sql.DB) {
    userID := getUserIDFromToken(r)
    
    // Hitung IPK dari semua semester
    var ipk float64
    var totalMK int
    
    queryIPK := `
        SELECT 
            AVG(ip) as ipk,
            SUM(total_mata_kuliah) as total_mk
        FROM khs
        WHERE user_id = ? AND ip > 0
    `
    
    err := db.QueryRow(queryIPK, userID).Scan(&ipk, &totalMK)
    if err != nil {
        ipk = 0.0
        totalMK = 0
    }
    
    // Get semua KHS per semester
    queryKHS := `
        SELECT id, semester, ip, total_mata_kuliah
        FROM khs
        WHERE user_id = ?
        ORDER BY semester
    `
    
    rows, err := db.Query(queryKHS, userID)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    defer rows.Close()
    
    var semesterList []map[string]interface{}
    for rows.Next() {
        var id int
        var semester string
        var ip float64
        var totalMK int
        
        err := rows.Scan(&id, &semester, &ip, &totalMK)
        if err != nil {
            continue
        }
        
        details := getKHSDetails(db, id)
        
        semesterList = append(semesterList, map[string]interface{}{
            "id": id,
            "semester": semester,
            "ip": ip,
            "total_mata_kuliah": totalMK,
            "details": details,
        })
    }
    
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(map[string]interface{}{
        "data": map[string]interface{}{
            "ipk": ipk,
            "total_mata_kuliah": totalMK,
            "semester_list": semesterList,
        },
    })
}

// GetKHSDetails - Get detail nilai mata kuliah
func getKHSDetails(db *sql.DB, khsID int) []map[string]interface{} {
    query := `
        SELECT kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka
        FROM khs_details
        WHERE khs_id = ?
    `
    
    rows, err := db.Query(query, khsID)
    if err != nil {
        return []map[string]interface{}{}
    }
    defer rows.Close()
    
    var details []map[string]interface{}
    for rows.Next() {
        var kodeMK, namaMK, nilai string
        var sks int
        var nilaiAngka float64
        
        err := rows.Scan(&kodeMK, &namaMK, &sks, &nilai, &nilaiAngka)
        if err != nil {
            continue
        }
        
        details = append(details, map[string]interface{}{
            "id": len(details) + 1,
            "kode_mata_kuliah": kodeMK,
            "nama_mata_kuliah": namaMK,
            "sks": sks,
            "nilai": nilai,
            "nilai_angka": nilaiAngka,
        })
    }
    
    return details
}
```

## 3. Pembayaran Handler

```go
// GetPembayaran - Get semua pembayaran user
func GetPembayaran(w http.ResponseWriter, r *http.Request, db *sql.DB) {
    userID := getUserIDFromToken(r)
    
    query := `
        SELECT id, semester, total_amount, paid_amount, remaining_amount, status
        FROM pembayaran
        WHERE user_id = ?
        ORDER BY semester DESC
    `
    
    rows, err := db.Query(query, userID)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    defer rows.Close()
    
    var pembayaranList []map[string]interface{}
    for rows.Next() {
        var id int
        var semester, status string
        var totalAmount, paidAmount, remainingAmount float64
        
        err := rows.Scan(&id, &semester, &totalAmount, &paidAmount, &remainingAmount, &status)
        if err != nil {
            continue
        }
        
        details := getPembayaranDetails(db, id)
        
        pembayaranList = append(pembayaranList, map[string]interface{}{
            "id": id,
            "semester": semester,
            "total_amount": totalAmount,
            "paid_amount": paidAmount,
            "remaining_amount": remainingAmount,
            "status": status,
            "details": details,
        })
    }
    
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(map[string]interface{}{
        "data": pembayaranList,
    })
}

// GetPembayaranDetails - Get detail komponen pembayaran
func getPembayaranDetails(db *sql.DB, pembayaranID int) []map[string]interface{} {
    query := `
        SELECT komponen, total, paid, remaining
        FROM pembayaran_details
        WHERE pembayaran_id = ?
    `
    
    rows, err := db.Query(query, pembayaranID)
    if err != nil {
        return []map[string]interface{}{}
    }
    defer rows.Close()
    
    var details []map[string]interface{}
    for rows.Next() {
        var komponen string
        var total, paid, remaining float64
        
        err := rows.Scan(&komponen, &total, &paid, &remaining)
        if err != nil {
            continue
        }
        
        details = append(details, map[string]interface{}{
            "id": len(details) + 1,
            "komponen": komponen,
            "total": total,
            "paid": paid,
            "remaining": remaining,
        })
    }
    
    return details
}
```

## 4. Helper Function untuk Get User ID dari Token

```go
// getUserIDFromToken - Extract user_id dari JWT token atau session
func getUserIDFromToken(r *http.Request) int {
    // Implementasi sesuai dengan auth system Anda
    // Contoh jika menggunakan JWT:
    // token := r.Header.Get("Authorization")
    // claims := parseJWT(token)
    // return claims.UserID
    
    // Untuk sementara, return 1 (sesuaikan dengan implementasi Anda)
    return 1
}
```

## 5. Routing (Contoh dengan Gorilla Mux)

```go
router.HandleFunc("/api/krs", middleware.AuthMiddleware(GetKRS)).Methods("GET")
router.HandleFunc("/api/krs/semester/{semester}", middleware.AuthMiddleware(GetKRSBySemester)).Methods("GET")
router.HandleFunc("/api/khs/rekap", middleware.AuthMiddleware(GetKHSRekap)).Methods("GET")
router.HandleFunc("/api/khs", middleware.AuthMiddleware(GetAllKHS)).Methods("GET")
router.HandleFunc("/api/pembayaran", middleware.AuthMiddleware(GetPembayaran)).Methods("GET")
```

## Catatan Penting

1. **Database Connection**: Pastikan `db *sql.DB` sudah di-inject ke handler
2. **Error Handling**: Tambahkan error handling yang lebih lengkap
3. **SQL Injection**: Gunakan prepared statement (sudah di contoh di atas)
4. **JSON Response**: Pastikan format response sesuai dengan yang diharapkan Flutter
5. **Authentication**: Pastikan semua endpoint menggunakan middleware auth
6. **User ID**: Pastikan `getUserIDFromToken` mengembalikan ID user yang benar dari token/session

## Testing

Setelah implementasi:

1. Test endpoint dengan Postman/curl
2. Verifikasi response format sesuai dengan model Flutter
3. Test dengan data yang sudah ada di database
4. Test error handling (user tidak ada, data kosong, dll)

