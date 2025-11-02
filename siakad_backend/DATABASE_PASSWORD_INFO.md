# Informasi Password Database MySQL

## 🔑 Default Password XAMPP

Jika Anda menggunakan **XAMPP**, default password MySQL biasanya:

```
Username: root
Password: (KOSONG - tidak ada password)
```

## 🔍 Cara Mengecek Password Anda

### Metode 1: Coba Login Tanpa Password

```bash
# Coba connect tanpa password (XAMPP default)
C:\xampp\mysql\bin\mysql.exe -u root siakad_db
```

Jika berhasil masuk → **Password: KOSONG** ✅

### Metode 2: Coba Login dengan Password

Jika gagal tanpa password, mungkin ada password. Coba:
- Password default XAMPP lainnya biasanya kosong
- Atau password yang Anda set sendiri saat install

### Metode 3: Reset Password MySQL

Jika lupa password dan perlu reset:

1. **Stop MySQL service** di XAMPP Control Panel
2. **Edit file** `C:\xampp\mysql\bin\my.ini`
3. Tambahkan di bawah `[mysqld]`:
   ```
   skip-grant-tables
   ```
4. **Start MySQL service** lagi
5. **Login tanpa password**:
   ```bash
   C:\xampp\mysql\bin\mysql.exe -u root
   ```
6. **Reset password**:
   ```sql
   USE mysql;
   UPDATE user SET authentication_string=PASSWORD('') WHERE User='root';
   FLUSH PRIVILEGES;
   ```
7. **Hapus** `skip-grant-tables` dari `my.ini`
8. **Restart MySQL**

## 📝 Konfigurasi di Project

### Default Configuration (XAMPP)

Program migration Go menggunakan default:
- **User**: `root`
- **Password**: `""` (kosong)
- **Host**: `127.0.0.1`
- **Port**: `3306`
- **Database**: `siakad_db`

### Jika Password Tidak Kosong

Buat file `.env` di folder `siakad_backend/`:

```env
DB_USER=root
DB_PASSWORD=password_anda_disini
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=siakad_db
```

Atau set environment variable:

**Windows PowerShell:**
```powershell
$env:DB_PASSWORD="password_anda"
```

**Windows CMD:**
```cmd
set DB_PASSWORD=password_anda
```

## 🧪 Test Koneksi

### Test dengan MySQL CLI

```bash
# Tanpa password (XAMPP default)
C:\xampp\mysql\bin\mysql.exe -u root siakad_db

# Dengan password (jika ada)
C:\xampp\mysql\bin\mysql.exe -u root -p siakad_db
# Akan diminta input password
```

### Test dengan Go Migration

```bash
cd siakad_backend
go run database/migrate.go
```

Jika berhasil connect → Password sudah benar ✅

Jika error "Access denied" → Perlu set password di `.env`

## 💡 Tips

1. **XAMPP Default**: Biasanya password kosong (empty string)
2. **Jika Error**: Kemungkinan besar perlu set password
3. **Security**: Untuk production, sebaiknya pakai password yang kuat
4. **Development**: Password kosong untuk XAMPP adalah normal

## 🆘 Troubleshooting

### Error: "Access denied for user 'root'@'localhost'"

**Solusi 1**: Set password di `.env` file
```env
DB_PASSWORD=password_anda
```

**Solusi 2**: Reset password MySQL (lihat Metode 3 di atas)

### Error: "Can't connect to MySQL server"

**Solusi**: 
1. Pastikan MySQL service running di XAMPP
2. Periksa port (default 3306)
3. Periksa firewall

### Cara Cek Password Aktif

1. Buka phpMyAdmin: http://localhost/phpmyadmin
2. Lihat apakah bisa login dengan:
   - Username: `root`
   - Password: (kosongkan)

Jika berhasil → Password memang kosong ✅

## 📋 Quick Reference

| Setup | Username | Password |
|-------|----------|----------|
| XAMPP Default | root | (kosong) |
| Custom Setup | root | (yang Anda set) |
| Production | (custom) | (harus strong) |

---

**Catatan**: Untuk development dengan XAMPP, password kosong adalah normal dan aman karena hanya local.

