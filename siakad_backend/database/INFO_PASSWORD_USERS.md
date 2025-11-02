# 📋 Informasi Password untuk Semua Users

## 🔑 Password Default untuk Semua User

**Password untuk SEMUA user di database adalah:**
```
password123
```

---

## 👥 Daftar Users dan Kredensial Login

### User 1 - Shevrie Maulana Husain
- **Email**: `shevrie@umt.ac.id`
- **NIM**: `0419108607`
- **Password**: `password123`
- **Program Studi**: Teknik Informatika
- **Semester**: 7 (Tujuh)

### User 2 - Ahmad Rizki Pratama
- **Email**: `ahmad.rizki@umt.ac.id`
- **NIM**: `0419108601`
- **Password**: `password123`
- **Program Studi**: Teknik Informatika
- **Semester**: 5 (Lima)

### User 3 - Siti Nurhaliza
- **Email**: `siti.nurhaliza@umt.ac.id`
- **NIM**: `0419108602`
- **Password**: `password123`
- **Program Studi**: Teknik Informatika
- **Semester**: 3 (Tiga)

### User 4 - Budi Santoso
- **Email**: `budi.santoso@umt.ac.id`
- **NIM**: `0419108603`
- **Password**: `password123`
- **Program Studi**: Teknik Informatika
- **Semester**: 7 (Tujuh)

### User 5 - Maya Indira
- **Email**: `maya.indira@umt.ac.id`
- **NIM**: `0419108604`
- **Password**: `password123`
- **Program Studi**: Teknik Informatika
- **Semester**: 1 (Satu)

---

## 🔐 Cara Login

Anda bisa login menggunakan **Email** atau **NIM** sebagai username:

**Contoh 1 (menggunakan Email):**
- Username: `shevrie@umt.ac.id`
- Password: `password123`

**Contoh 2 (menggunakan NIM):**
- Username: `0419108607`
- Password: `password123`

---

## ⚠️ Catatan Penting

1. **Password disimpan sebagai plain text** di database untuk keperluan development/testing
2. **Untuk production**, password harus di-hash menggunakan bcrypt atau hashing lainnya
3. **Jangan** gunakan password ini di environment production!

---

## 🔄 Update Password di Database

Jika Anda ingin mengupdate password di database (misalnya setelah menjalankan seeder yang salah), gunakan query berikut:

```sql
-- Update password untuk semua user
UPDATE users SET password = 'password123';

-- Atau update untuk user tertentu
UPDATE users SET password = 'password123' WHERE email = 'shevrie@umt.ac.id';
```

---

## 🛠️ Troubleshooting

### Login selalu gagal dengan error 401?

**Penyebab:**
1. Password di database berbeda dengan yang Anda masukkan
2. Password di database masih dalam format bcrypt hash (seharusnya plain text)

**Solusi:**
1. Pastikan Anda menggunakan password: `password123`
2. Pastikan password di database adalah plain text, bukan hash
3. Update password di database menggunakan query di atas
4. Restart backend server setelah update database

---

**Terakhir diupdate**: Setelah perbaikan seeder_complete_all_tables.sql

