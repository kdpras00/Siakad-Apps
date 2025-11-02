# Cara Check Apakah Data Sudah Ada di Database

## Langkah 1: Check Data Users

Buka phpMyAdmin atau MySQL Workbench, lalu jalankan query:

```sql
SELECT id, name, email, nim FROM users;
```

**Expected:** Harus ada minimal 4 user (John Doe, Jane Smith, Bob Wilson, Alice Johnson)

## Langkah 2: Check Data KRS

```sql
SELECT k.id, k.user_id, k.semester, u.name as nama_user 
FROM krs k 
JOIN users u ON k.user_id = u.id;
```

**Expected:** Harus ada minimal 4 KRS untuk 4 user

## Langkah 3: Check Data KHS

```sql
SELECT kh.id, kh.user_id, kh.semester, u.name as nama_user 
FROM khs kh 
JOIN users u ON kh.user_id = u.id;
```

**Expected:** Harus ada minimal beberapa KHS (John Doe punya 6 semester, Jane Smith 4, dll)

## Langkah 4: Check Data Pembayaran

```sql
SELECT p.id, p.user_id, p.semester, u.name as nama_user 
FROM pembayaran p 
JOIN users u ON p.user_id = u.id;
```

**Expected:** Harus ada minimal beberapa pembayaran untuk setiap user

## Jika Data Belum Ada

Jalankan seeder SQL:

1. Buka phpMyAdmin: http://localhost/phpmyadmin
2. Pilih database `siakad_db`
3. Klik tab "SQL"
4. Copy semua isi file `siakad_backend/database/seeder.sql`
5. Paste dan klik "Go"

Atau jalankan via command line:
```bash
mysql -u root -p siakad_db < siakad_backend/database/seeder.sql
```

## Troubleshooting

### Jika KRS/KHS/Pembayaran kosong untuk user tertentu:

1. Cek user_id yang login (dari token)
2. Pastikan ada data KRS/KHS/Pembayaran untuk user_id tersebut
3. Data di seeder menggunakan user_id = 1, 2, 3, 4
4. Jika login dengan user yang berbeda, data tidak akan muncul

### Cara Test dengan User yang Benar:

Login dengan:
- Email: `john.doe@example.com` → user_id = 1 (ada data KRS, KHS, Pembayaran)
- Email: `jane.smith@example.com` → user_id = 2 (ada data)
- Email: `bob.wilson@example.com` → user_id = 3 (ada data)
- Email: `alice.johnson@example.com` → user_id = 4 (ada data)

Password untuk semua: `password123`

## Check Console Backend

Saat membuka menu KRS/KHS/Pembayaran, cek console backend untuk melihat:
- `DEBUG: Querying KRS for user_id: X`
- `DEBUG: Total KRS found: X rows`
- Jika 0 rows, berarti data belum di-seed atau user_id tidak cocok

