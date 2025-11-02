# Update Endpoint Backend untuk Database Minimal (users & information saja)

Karena database hanya memiliki 2 tabel (`users` dan `information`), berikut adalah panduan untuk backend Go agar dapat menyediakan data untuk semua fitur:

## 1. Endpoint Information (Sudah Ada)

```
GET /api/information
GET /api/information/:id
```

**Response Format:**
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

## 2. Endpoint Auth/Users (Sudah Ada)

```
POST /api/auth/login
POST /api/auth/register
PUT /api/auth/change-password
GET /api/auth/profile
POST /api/auth/logout
```

## 3. Endpoint KRS (Generate dari Users)

Karena tidak ada tabel KRS, backend bisa generate data KRS berdasarkan data user (semester, dll):

```
GET /api/krs
GET /api/krs/semester/:semester
```

**Backend Logic:**
- Ambil semester dari user yang sedang login
- Generate data KRS berdasarkan semester user
- Bisa menggunakan data statis atau generate dinamis

**Response Format:**
```json
{
  "data": [
    {
      "id": "1",
      "semester": "Semester 7",
      "tahun_ajaran": "2024/2025",
      "status": "Aktif",
      "total_sks": 22,
      "details": [
        {
          "id": "1",
          "kode_mata_kuliah": "TI701",
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

## 4. Endpoint KHS (Generate dari Users)

Generate data KHS berdasarkan user:

```
GET /api/khs/rekap
GET /api/khs
GET /api/khs/semester/:semester
```

**Response Format:**
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

## 5. Endpoint Pembayaran (Generate dari Users)

Generate data pembayaran berdasarkan user:

```
GET /api/pembayaran
GET /api/pembayaran/semester/:semester
```

**Response Format:**
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

## Implementasi di Backend Go

### Contoh Handler untuk KRS (Generate)

```go
func GetKRS(w http.ResponseWriter, r *http.Request) {
    // Ambil user dari session/token
    user := getUserFromSession(r)
    
    // Generate data KRS berdasarkan semester user
    semester := user.Semester
    tahunAjaran := "2024/2025"
    
    // Data mata kuliah bisa di-hardcode atau dari config
    mataKuliah := []map[string]interface{}{
        {
            "id": "1",
            "kode_mata_kuliah": "TI701",
            "nama_mata_kuliah": "Mobile Programming",
            "sks": 3,
            "dosen": "Syepry Maulana Husain, S.Kom, MTI",
            "jadwal": "Senin, 08:30 - 10:00 WIB",
            "ruangan": "Ruang A12.7",
        },
        // ... tambahkan mata kuliah lain
    }
    
    totalSKS := 0
    for _, mk := range mataKuliah {
        totalSKS += mk["sks"].(int)
    }
    
    krs := map[string]interface{}{
        "id": "1",
        "semester": fmt.Sprintf("Semester %d", semester),
        "tahun_ajaran": tahunAjaran,
        "status": "Aktif",
        "total_sks": totalSKS,
        "details": mataKuliah,
    }
    
    json.NewEncoder(w).Encode(map[string]interface{}{
        "data": []map[string]interface{}{krs},
    })
}
```

### Contoh Handler untuk KHS (Generate)

```go
func GetKHSRekap(w http.ResponseWriter, r *http.Request) {
    user := getUserFromSession(r)
    
    // Generate IPK dan data KHS
    ipk := 3.52 // Bisa dihitung dari database jika ada, atau hardcode
    totalMK := 112
    
    // Generate data per semester
    semesterList := []map[string]interface{}{}
    for i := 1; i <= user.Semester; i++ {
        ip := 3.5 + float64(i)*0.1 // Contoh perhitungan IP
        semesterList = append(semesterList, map[string]interface{}{
            "id": fmt.Sprintf("%d", i),
            "semester": fmt.Sprintf("Semester %d", i),
            "ip": ip,
            "total_mata_kuliah": 15,
            "details": []map[string]interface{}{
                {
                    "id": "1",
                    "kode_mata_kuliah": fmt.Sprintf("TI%d01", i),
                    "nama_mata_kuliah": "Mata Kuliah " + fmt.Sprintf("%d", i),
                    "sks": 3,
                    "nilai": "A",
                    "nilai_angka": 4.0,
                },
            },
        })
    }
    
    json.NewEncoder(w).Encode(map[string]interface{}{
        "data": map[string]interface{}{
            "ipk": ipk,
            "total_mata_kuliah": totalMK,
            "semester_list": semesterList,
        },
    })
}
```

### Contoh Handler untuk Pembayaran (Generate)

```go
func GetPembayaran(w http.ResponseWriter, r *http.Request) {
    user := getUserFromSession(r)
    
    pembayaranList := []map[string]interface{}{}
    for i := 1; i <= user.Semester; i++ {
        totalAmount := 10000000.0
        paidAmount := totalAmount // Asumsikan sudah lunas
        if i > 3 {
            paidAmount = totalAmount * 0.8 // Semester berikutnya belum lunas
        }
        
        pembayaranList = append(pembayaranList, map[string]interface{}{
            "id": fmt.Sprintf("%d", i),
            "semester": fmt.Sprintf("Semester %d", i),
            "total_amount": totalAmount,
            "paid_amount": paidAmount,
            "remaining_amount": totalAmount - paidAmount,
            "status": func() string {
                if paidAmount == totalAmount {
                    return "Lunas"
                }
                return "Belum Lunas"
            }(),
            "details": []map[string]interface{}{
                {
                    "id": "1",
                    "komponen": "Uang Bangunan",
                    "total": 3000000.0,
                    "paid": 3000000.0,
                    "remaining": 0.0,
                },
            },
        })
    }
    
    json.NewEncoder(w).Encode(map[string]interface{}{
        "data": pembayaranList,
    })
}
```

## Catatan Penting

1. **Data Generate**: Karena tidak ada tabel KRS, KHS, dan Pembayaran, backend bisa generate data ini secara dinamis berdasarkan:
   - Data user (semester, program studi, dll)
   - Data hardcoded/static untuk mata kuliah
   - Atau config file

2. **Autentikasi**: Semua endpoint kecuali login dan register harus require authentication (cek token dari header Authorization).

3. **Response Format**: Pastikan response format sesuai dengan yang diharapkan Flutter (cek model di `lib/models/`).

4. **Error Handling**: Jika ada error, return status code yang sesuai dan message:
   ```json
   {
     "message": "Error message",
     "success": false
   }
   ```

## Alternative: Tambahkan Data di Tabel Information

Jika ingin menyimpan data KRS/KHS/Pembayaran, bisa menggunakan tabel `information` dengan menambahkan field:
- `category`: untuk membedakan jenis informasi (KRS, KHS, Pembayaran, Pengumuman)
- `metadata`: JSON field untuk menyimpan data tambahan

Tapi lebih baik generate langsung dari backend seperti contoh di atas.

