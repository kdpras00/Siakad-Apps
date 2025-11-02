# 🔐 Bcrypt Password Support - Backend Update

## ✅ Yang Sudah Diperbaiki

Backend sekarang **sudah mendukung bcrypt hash password**!

### Perubahan yang Dilakukan:

1. ✅ **Menambahkan bcrypt library** ke `go.mod`

   ```bash
   go get golang.org/x/crypto/bcrypt
   ```

2. ✅ **Mengupdate password verification** di `handleLogin()`:

   - Backend sekarang bisa verify **bcrypt hash** (yang dimulai dengan `$2a$`, `$2b$`, atau `$2y$`)
   - Juga tetap support **plain text password** (untuk backward compatibility)

3. ✅ **Mengupdate password hashing** di `handleRegister()`:
   - Password baru yang di-register akan di-hash dengan bcrypt secara otomatis

---

## 🔍 Fungsi `verifyPassword()`

Backend menggunakan fungsi helper yang **cerdas**:

```go
func verifyPassword(inputPassword, storedPassword string) bool {
    // Jika password di DB adalah bcrypt hash
    if strings.HasPrefix(storedPassword, "$2a$") ||
       strings.HasPrefix(storedPassword, "$2b$") ||
       strings.HasPrefix(storedPassword, "$2y$") {
        // Verify menggunakan bcrypt
        err := bcrypt.CompareHashAndPassword([]byte(storedPassword), []byte(inputPassword))
        return err == nil
    }

    // Jika bukan hash, bandingkan plain text (backward compatibility)
    return inputPassword == storedPassword
}
```

**Fungsi ini akan:**

- ✅ Otomatis detect apakah password di DB adalah bcrypt hash atau plain text
- ✅ Verify bcrypt hash jika memang hash
- ✅ Fallback ke plain text comparison jika bukan hash
- ✅ Support migration dari plain text ke bcrypt secara bertahap

---

## 🔑 Informasi Password untuk Bcrypt Hash

### ⚠️ Masalah: Password Asli Tidak Diketahui

Password di `seeder_complete_all_tables.sql` menggunakan bcrypt hash:

```
$2a$10$rOz85JcK8lE3h5bVqjK0AeHnQbFvKxYmZp0ZtP5nU6vW8sE9qA0bG
```

**Bcrypt adalah one-way hash**, jadi tidak bisa di-decode untuk mendapatkan password asli.

### 🛠️ Solusi:

#### Opsi 1: Generate Hash Baru dari Password yang Diketahui

Jika Anda ingin menggunakan password `password123`, generate hash baru:

**Dengan Go:**

```go
package main
import (
    "fmt"
    "golang.org/x/crypto/bcrypt"
)

func main() {
    hash, _ := bcrypt.GenerateFromPassword([]byte("password123"), bcrypt.DefaultCost)
    fmt.Println(string(hash))
}
```

**Atau gunakan tool online:** https://bcrypt-generator.com/

#### Opsi 2: Update Password di Database

Update password langsung di database dengan hash baru:

```sql
-- Update semua user dengan hash password123
UPDATE users SET password = '$2a$10$[hash_baru_dari_password123]';
```

---

## 🧪 Testing

### Test dengan Bcrypt Hash:

1. **Pastikan password di database adalah bcrypt hash** (dimulai dengan `$2a$`)
2. **Gunakan password asli** untuk login (password yang digunakan saat generate hash)
3. **Backend akan otomatis verify** menggunakan bcrypt

### Test dengan Plain Text:

1. **Pastikan password di database adalah plain text** (tidak dimulai dengan `$2a$`)
2. **Backend akan otomatis fallback** ke plain text comparison
3. Login dengan password yang sama seperti di database

---

## 📝 Contoh Hash Password

Hash dari password `password123` (contoh):

```
$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy
```

**Setiap hash akan berbeda** meskipun password sama (karena salt).

---

## 🔄 Migration Strategy

Backend mendukung **gradual migration**:

1. ✅ **Existing users** dengan plain text password → tetap bisa login
2. ✅ **New users** dari register → otomatis pakai bcrypt hash
3. ✅ **Users dengan bcrypt hash** → bisa login dengan password asli

**Untuk migrate semua users ke bcrypt:**

```sql
-- Script untuk update semua password ke bcrypt hash
-- (Perlu generate hash untuk setiap user terlebih dahulu)
```

---

## 🎯 Kesimpulan

✅ Backend **sudah support bcrypt hash password**
✅ Backend **tetap support plain text** (backward compatible)
✅ Login akan berhasil jika:

- Password di DB adalah bcrypt hash, dan input password adalah password asli
- Password di DB adalah plain text, dan input password sama dengan di DB

⚠️ **Yang perlu diketahui**: Password asli dari hash yang ada di seeder tidak bisa diketahui. Anda perlu:

- Generate hash baru dari password yang diketahui (misalnya `password123`)
- Atau tetap gunakan plain text di seeder untuk development

---

**Terakhir diupdate**: Setelah implementasi bcrypt support
