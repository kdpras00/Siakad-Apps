-- ===================================================================
-- SEEDER LENGKAP UNTUK SEMUA TABEL DENGAN 5 USERS
-- ===================================================================
-- File ini akan mengisi SEMUA tabel dengan data lengkap:
-- 1. users (5 users)
-- 2. information (beberapa informasi umum)
-- 3. krs + krs_details (untuk setiap user)
-- 4. khs + khs_details (untuk setiap user sesuai semester)
-- 5. pembayaran + pembayaran_details (untuk setiap user)
-- 6. kerja_praktek + kerja_praktek_timeline (untuk user yang sudah KP)
-- 7. skripsi + skripsi_timeline (untuk user yang sudah Skripsi)
--
-- Semua data saling terhubung menggunakan Foreign Key
-- ===================================================================

-- Hapus data lama jika ada (optional, bisa di-comment jika tidak ingin)
DELETE FROM `skripsi_timeline`;
DELETE FROM `skripsi`;
DELETE FROM `kerja_praktek_timeline`;
DELETE FROM `kerja_praktek`;
DELETE FROM `pembayaran_details`;
DELETE FROM `pembayaran`;
DELETE FROM `khs_details`;
DELETE FROM `khs`;
DELETE FROM `krs_details`;
DELETE FROM `krs`;
DELETE FROM `information`;
DELETE FROM `users`;

-- ===================================================================
-- 1. TABEL USERS (5 Users)
-- ===================================================================

INSERT INTO `users` (`id`, `name`, `nim`, `email`, `password`, `phone`, `program_studi`, `semester`, `created_at`) VALUES
(1, 'Shevrie Maulana Husain', '0419108607', 'shevrie@umt.ac.id', 'password123', '081282123498', 'Teknik Informatika', '7 (Tujuh)', NOW()),
(2, 'Ahmad Rizki Pratama', '0419108601', 'ahmad.rizki@umt.ac.id', 'password123', '081234567890', 'Teknik Informatika', '5 (Lima)', NOW()),
(3, 'Siti Nurhaliza', '0419108602', 'siti.nurhaliza@umt.ac.id', 'password123', '081234567891', 'Teknik Informatika', '3 (Tiga)', NOW()),
(4, 'Budi Santoso', '0419108603', 'budi.santoso@umt.ac.id', 'password123', '081234567892', 'Teknik Informatika', '7 (Tujuh)', NOW()),
(5, 'Maya Indira', '0419108604', 'maya.indira@umt.ac.id', 'password123', '081234567893', 'Teknik Informatika', '1 (Satu)', NOW());

-- ===================================================================
-- 2. TABEL INFORMATION (Informasi Umum)
-- ===================================================================

INSERT INTO `information` (`id`, `title`, `content`, `date`, `created_at`) VALUES
(1, 'Pendaftaran KRS Semester Genap 2024/2025', 'Pendaftaran KRS untuk semester genap akan dibuka mulai tanggal 15 Januari 2025. Silakan melakukan pendaftaran melalui portal akademik.', '2025-01-10', NOW()),
(2, 'Jadwal Ujian Mid Semester', 'Ujian mid semester akan dilaksanakan pada tanggal 1-7 Maret 2025. Harap mempersiapkan diri dengan baik.', '2025-02-20', NOW()),
(3, 'Pengumuman Pembayaran SPP', 'Batas akhir pembayaran SPP semester genap adalah tanggal 20 Januari 2025. Harap melakukan pembayaran sebelum batas waktu.', '2025-01-05', NOW()),
(4, 'Seminar Kerja Praktek', 'Seminar proposal kerja praktek akan dilaksanakan pada tanggal 10 Februari 2025. Peserta diharapkan mempersiapkan presentasi.', '2025-02-01', NOW()),
(5, 'Ujian Skripsi Semester Genap', 'Pendaftaran ujian skripsi untuk semester genap dibuka mulai tanggal 1 Maret 2025. Harap melengkapi dokumen yang diperlukan.', '2025-02-25', NOW()),
(6, 'Workshop Pengembangan Mobile App', 'Workshop pengembangan aplikasi mobile akan diadakan pada tanggal 15 Februari 2025. Pendaftaran dibuka untuk semua mahasiswa.', '2025-02-10', NOW());

-- ===================================================================
-- 3. TABEL KRS + KRS_DETAILS (Untuk semua user)
-- ===================================================================

-- User 1 - Semester 7
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`) 
VALUES (1, 'Semester 7', '2024/2025', 'Aktif', 20, NOW());
SET @krs_id_1 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_1, 'TI701', 'Pemrograman Mobile', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_1, 'TI702', 'Kerja Praktek', 3, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_1, 'TI703', 'Skripsi', 6, 'Syepry Maulana Husain, S.Kom, MTI', 'Jumat, 10:00-12:00', 'A12.8'),
(@krs_id_1, 'TI704', 'Manajemen Proyek', 2, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_1, 'TI705', 'Etika Profesi', 2, 'Rina Kurniawati, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_1, 'TI706', 'Kewirausahaan', 2, 'Budi Santoso, M.Kom', 'Selasa, 13:00-15:00', 'A12.4'),
(@krs_id_1, 'TI707', 'Sistem Informasi Manajemen', 2, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 08:00-10:00', 'A12.3');

-- User 2 - Semester 5
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`) 
VALUES (2, 'Semester 5', '2024/2025', 'Aktif', 22, NOW());
SET @krs_id_2 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_2, 'TI501', 'Pemrograman iOS', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_2, 'TI502', 'Framework Web', 3, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_2, 'TI503', 'Machine Learning', 3, 'Rina Kurniawati, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_2, 'TI504', 'DevOps', 2, 'Dr. Andi Firmansyah, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_2, 'TI505', 'Testing & QA', 2, 'Budi Santoso, M.Kom', 'Jumat, 08:00-10:00', 'A12.4'),
(@krs_id_2, 'TI506', 'Arsitektur Software', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 13:00-15:00', 'A12.3'),
(@krs_id_2, 'TI507', 'Manajemen Proyek TI', 2, 'Yani Sugiani, M.Kom', 'Selasa, 13:00-15:00', 'A12.2'),
(@krs_id_2, 'TI508', 'Big Data', 2, 'Rina Kurniawati, M.Kom', 'Rabu, 08:00-10:00', 'A12.1'),
(@krs_id_2, 'TI509', 'Blockchain', 2, 'Dr. Andi Firmansyah, M.Kom', 'Kamis, 13:00-15:00', 'A12.0');

-- User 3 - Semester 3
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`) 
VALUES (3, 'Semester 3', '2024/2025', 'Aktif', 20, NOW());
SET @krs_id_3 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_3, 'TI301', 'Rekayasa Perangkat Lunak', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_3, 'TI302', 'Sistem Operasi', 3, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_3, 'TI303', 'Pemrograman Web', 3, 'Rina Kurniawati, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_3, 'TI304', 'Keamanan Informasi', 2, 'Dr. Andi Firmansyah, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_3, 'TI305', 'Multimedia', 2, 'Budi Santoso, M.Kom', 'Jumat, 08:00-10:00', 'A12.4'),
(@krs_id_3, 'TI306', 'Pemrograman Mobile Dasar', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 13:00-15:00', 'A12.3'),
(@krs_id_3, 'TI307', 'Manajemen Basis Data', 2, 'Yani Sugiani, M.Kom', 'Selasa, 13:00-15:00', 'A12.2'),
(@krs_id_3, 'TI308', 'Komunikasi Data', 2, 'Rina Kurniawati, M.Kom', 'Rabu, 08:00-10:00', 'A12.1');

-- User 4 - Semester 7
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`) 
VALUES (4, 'Semester 7', '2024/2025', 'Aktif', 20, NOW());
SET @krs_id_4 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_4, 'TI701', 'Pemrograman Mobile', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_4, 'TI702', 'Kerja Praktek', 3, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_4, 'TI703', 'Skripsi', 6, 'Syepry Maulana Husain, S.Kom, MTI', 'Jumat, 10:00-12:00', 'A12.8'),
(@krs_id_4, 'TI704', 'Manajemen Proyek', 2, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_4, 'TI705', 'Etika Profesi', 2, 'Rina Kurniawati, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_4, 'TI706', 'Kewirausahaan', 2, 'Budi Santoso, M.Kom', 'Selasa, 13:00-15:00', 'A12.4'),
(@krs_id_4, 'TI707', 'Sistem Informasi Manajemen', 2, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 08:00-10:00', 'A12.3');

-- User 5 - Semester 1
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`) 
VALUES (5, 'Semester 1', '2024/2025', 'Aktif', 18, NOW());
SET @krs_id_5 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_5, 'TI101', 'Algoritma Pemrograman', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_5, 'TI102', 'Matematika Diskrit', 3, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_5, 'TI103', 'Pengantar Teknologi Informasi', 2, 'Rina Kurniawati, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_5, 'TI104', 'Pendidikan Agama', 2, 'Dr. Andi Firmansyah, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_5, 'TI105', 'Bahasa Indonesia', 2, 'Budi Santoso, M.Kom', 'Jumat, 08:00-10:00', 'A12.4'),
(@krs_id_5, 'TI106', 'Bahasa Inggris', 2, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 13:00-15:00', 'A12.3'),
(@krs_id_5, 'TI107', 'Pendidikan Pancasila', 2, 'Yani Sugiani, M.Kom', 'Selasa, 13:00-15:00', 'A12.2'),
(@krs_id_5, 'TI108', 'Pengantar Sistem Operasi', 2, 'Rina Kurniawati, M.Kom', 'Rabu, 08:00-10:00', 'A12.1');

-- ===================================================================
-- 4. TABEL KHS + KHS_DETAILS (Untuk semua user sesuai semester)
-- ===================================================================

-- User 1 - Semester 1-6 (Semester 7 belum selesai)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`) VALUES
(1, 'Semester 1', 3.80, 8, NOW()),
(1, 'Semester 2', 3.85, 7, NOW()),
(1, 'Semester 3', 3.82, 8, NOW()),
(1, 'Semester 4', 3.88, 8, NOW()),
(1, 'Semester 5', 3.85, 9, NOW()),
(1, 'Semester 6', 3.90, 9, NOW());

SET @khs_id_1_s1 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @khs_id_1_s2 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 2' ORDER BY id DESC LIMIT 1);
SET @khs_id_1_s3 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 3' ORDER BY id DESC LIMIT 1);
SET @khs_id_1_s4 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 4' ORDER BY id DESC LIMIT 1);
SET @khs_id_1_s5 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 5' ORDER BY id DESC LIMIT 1);
SET @khs_id_1_s6 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 6' ORDER BY id DESC LIMIT 1);

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_1_s1, 'TI101', 'Algoritma Pemrograman', 3, 'A', 4.0),
(@khs_id_1_s1, 'TI102', 'Matematika Diskrit', 3, 'A', 4.0),
(@khs_id_1_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'A-', 3.75),
(@khs_id_1_s1, 'TI104', 'Pendidikan Agama', 2, 'A', 4.0),
(@khs_id_1_s1, 'TI105', 'Bahasa Indonesia', 2, 'A-', 3.75),
(@khs_id_1_s1, 'TI106', 'Bahasa Inggris', 2, 'A', 4.0),
(@khs_id_1_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A', 4.0),
(@khs_id_1_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5),
(@khs_id_1_s2, 'TI201', 'Struktur Data', 3, 'A', 4.0),
(@khs_id_1_s2, 'TI202', 'Basis Data', 3, 'A-', 3.75),
(@khs_id_1_s2, 'TI203', 'Pemrograman Berorientasi Objek', 3, 'A', 4.0),
(@khs_id_1_s2, 'TI204', 'Jaringan Komputer', 3, 'A', 4.0),
(@khs_id_1_s2, 'TI205', 'Interaksi Manusia Komputer', 2, 'A-', 3.75),
(@khs_id_1_s2, 'TI206', 'Statistika', 2, 'B+', 3.5),
(@khs_id_1_s2, 'TI207', 'Kewarganegaraan', 2, 'A', 4.0);

-- User 2 - Semester 1-4 (Semester 5 sedang berjalan)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`) VALUES
(2, 'Semester 1', 3.70, 8, NOW()),
(2, 'Semester 2', 3.75, 7, NOW()),
(2, 'Semester 3', 3.80, 8, NOW()),
(2, 'Semester 4', 3.82, 8, NOW());

SET @khs_id_2_s1 = (SELECT id FROM khs WHERE user_id = 2 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @khs_id_2_s2 = (SELECT id FROM khs WHERE user_id = 2 AND semester = 'Semester 2' ORDER BY id DESC LIMIT 1);

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_2_s1, 'TI101', 'Algoritma Pemrograman', 3, 'A-', 3.75),
(@khs_id_2_s1, 'TI102', 'Matematika Diskrit', 3, 'B+', 3.5),
(@khs_id_2_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'A', 4.0),
(@khs_id_2_s1, 'TI104', 'Pendidikan Agama', 2, 'A-', 3.75),
(@khs_id_2_s1, 'TI105', 'Bahasa Indonesia', 2, 'B+', 3.5),
(@khs_id_2_s1, 'TI106', 'Bahasa Inggris', 2, 'A', 4.0),
(@khs_id_2_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A-', 3.75),
(@khs_id_2_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5),
(@khs_id_2_s2, 'TI201', 'Struktur Data', 3, 'A', 4.0),
(@khs_id_2_s2, 'TI202', 'Basis Data', 3, 'A-', 3.75),
(@khs_id_2_s2, 'TI203', 'Pemrograman Berorientasi Objek', 3, 'B+', 3.5),
(@khs_id_2_s2, 'TI204', 'Jaringan Komputer', 3, 'A', 4.0),
(@khs_id_2_s2, 'TI205', 'Interaksi Manusia Komputer', 2, 'A-', 3.75),
(@khs_id_2_s2, 'TI206', 'Statistika', 2, 'B+', 3.5),
(@khs_id_2_s2, 'TI207', 'Kewarganegaraan', 2, 'A', 4.0);

-- User 3 - Semester 1-2 (Semester 3 sedang berjalan)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`) VALUES
(3, 'Semester 1', 3.65, 8, NOW()),
(3, 'Semester 2', 3.68, 7, NOW());

SET @khs_id_3_s1 = (SELECT id FROM khs WHERE user_id = 3 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @khs_id_3_s2 = (SELECT id FROM khs WHERE user_id = 3 AND semester = 'Semester 2' ORDER BY id DESC LIMIT 1);

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_3_s1, 'TI101', 'Algoritma Pemrograman', 3, 'B+', 3.5),
(@khs_id_3_s1, 'TI102', 'Matematika Diskrit', 3, 'B', 3.0),
(@khs_id_3_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'A-', 3.75),
(@khs_id_3_s1, 'TI104', 'Pendidikan Agama', 2, 'A', 4.0),
(@khs_id_3_s1, 'TI105', 'Bahasa Indonesia', 2, 'B+', 3.5),
(@khs_id_3_s1, 'TI106', 'Bahasa Inggris', 2, 'A-', 3.75),
(@khs_id_3_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A', 4.0),
(@khs_id_3_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5),
(@khs_id_3_s2, 'TI201', 'Struktur Data', 3, 'B+', 3.5),
(@khs_id_3_s2, 'TI202', 'Basis Data', 3, 'A-', 3.75),
(@khs_id_3_s2, 'TI203', 'Pemrograman Berorientasi Objek', 3, 'B', 3.0),
(@khs_id_3_s2, 'TI204', 'Jaringan Komputer', 3, 'B+', 3.5),
(@khs_id_3_s2, 'TI205', 'Interaksi Manusia Komputer', 2, 'A-', 3.75),
(@khs_id_3_s2, 'TI206', 'Statistika', 2, 'B+', 3.5),
(@khs_id_3_s2, 'TI207', 'Kewarganegaraan', 2, 'A', 4.0);

-- User 4 - Semester 1-6 (Semester 7 sedang berjalan)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`) VALUES
(4, 'Semester 1', 3.75, 8, NOW()),
(4, 'Semester 2', 3.78, 7, NOW()),
(4, 'Semester 3', 3.80, 8, NOW()),
(4, 'Semester 4', 3.82, 8, NOW()),
(4, 'Semester 5', 3.85, 9, NOW()),
(4, 'Semester 6', 3.88, 9, NOW());

-- User 5 - Belum ada KHS (masih semester 1, belum ujian)

-- ===================================================================
-- 5. TABEL PEMBAYARAN + PEMBAYARAN_DETAILS (Untuk semua user)
-- ===================================================================

-- User 1 - Semester 1-7
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`) VALUES
(1, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW()),
(1, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW()),
(1, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW()),
(1, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW()),
(1, 'Semester 5', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW()),
(1, 'Semester 6', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW()),
(1, 'Semester 7', 11500000.00, 11500000.00, 0.00, 'Lunas', NOW());

SET @pembayaran_id_1_s1 = (SELECT id FROM pembayaran WHERE user_id = 1 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @pembayaran_id_1_s7 = (SELECT id FROM pembayaran WHERE user_id = 1 AND semester = 'Semester 7' ORDER BY id DESC LIMIT 1);

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_1_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_1_s1, 'SPP', 7000000.00, 7000000.00, 0.00),
(@pembayaran_id_1_s7, 'SPP', 11500000.00, 11500000.00, 0.00);

-- User 2 - Semester 1-5
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`) VALUES
(2, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW()),
(2, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW()),
(2, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW()),
(2, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW()),
(2, 'Semester 5', 11000000.00, 5500000.00, 5500000.00, 'Belum Lunas', NOW());

SET @pembayaran_id_2_s1 = (SELECT id FROM pembayaran WHERE user_id = 2 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_2_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_2_s1, 'SPP', 7000000.00, 7000000.00, 0.00);

-- User 3 - Semester 1-3
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`) VALUES
(3, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW()),
(3, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW()),
(3, 'Semester 3', 10500000.00, 5250000.00, 5250000.00, 'Belum Lunas', NOW());

SET @pembayaran_id_3_s1 = (SELECT id FROM pembayaran WHERE user_id = 3 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_3_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_3_s1, 'SPP', 7000000.00, 7000000.00, 0.00);

-- User 4 - Semester 1-7
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`) VALUES
(4, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW()),
(4, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW()),
(4, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW()),
(4, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW()),
(4, 'Semester 5', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW()),
(4, 'Semester 6', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW()),
(4, 'Semester 7', 11500000.00, 5750000.00, 5750000.00, 'Belum Lunas', NOW());

SET @pembayaran_id_4_s1 = (SELECT id FROM pembayaran WHERE user_id = 4 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_4_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_4_s1, 'SPP', 7000000.00, 7000000.00, 0.00);

-- User 5 - Semester 1
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`) VALUES
(5, 'Semester 1', 10000000.00, 5000000.00, 5000000.00, 'Belum Lunas', NOW());

SET @pembayaran_id_5_s1 = (SELECT id FROM pembayaran WHERE user_id = 5 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_5_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_5_s1, 'SPP', 7000000.00, 2000000.00, 5000000.00);

-- ===================================================================
-- 6. TABEL KERJA_PRAKTEK + KERJA_PRAKTEK_TIMELINE (User 1 & 4)
-- ===================================================================

-- User 1 - Kerja Praktek
INSERT INTO `kerja_praktek` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`) VALUES
(1, 'Sistem Informasi Akademik Berbasis Mobile', 'PT. Teknologi Indonesia', 'Jl. Raya Teknologi No. 123, Jakarta', 'Dr. Andi Firmansyah, M.Kom', 'Lulus', NOW());
SET @kp_id_1 = LAST_INSERT_ID();

INSERT INTO `kerja_praktek_timeline` (`kp_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@kp_id_1, 'Pengajuan Proposal', '2024-01-15', TRUE, 'document'),
(@kp_id_1, 'Seminar Proposal', '2024-02-20', TRUE, 'presentation'),
(@kp_id_1, 'Bimbingan KP', '2024-03-01', TRUE, 'mentor'),
(@kp_id_1, 'Ujian KP', '2024-06-15', TRUE, 'exam'),
(@kp_id_1, 'Revisi Laporan', '2024-06-20', TRUE, 'edit');

-- User 4 - Kerja Praktek
INSERT INTO `kerja_praktek` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`) VALUES
(4, 'Aplikasi E-Commerce Berbasis Mobile', 'PT. Digital Solution', 'Jl. Teknologi No. 45, Jakarta', 'Dr. Andi Firmansyah, M.Kom', 'Lulus', NOW());
SET @kp_id_4 = LAST_INSERT_ID();

INSERT INTO `kerja_praktek_timeline` (`kp_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@kp_id_4, 'Pengajuan Proposal', '2024-01-10', TRUE, 'document'),
(@kp_id_4, 'Seminar Proposal', '2024-02-15', TRUE, 'presentation'),
(@kp_id_4, 'Bimbingan KP', '2024-03-01', TRUE, 'mentor'),
(@kp_id_4, 'Ujian KP', '2024-06-10', TRUE, 'exam'),
(@kp_id_4, 'Revisi Laporan', '2024-06-18', TRUE, 'edit');

-- ===================================================================
-- 7. TABEL SKRIPSI + SKRIPSI_TIMELINE (User 1 & 4)
-- ===================================================================

-- User 1 - Skripsi
INSERT INTO `skripsi` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`) VALUES
(1, 'Aplikasi Mobile Learning untuk Pendidikan Tinggi', 'Universitas Muhammadiyah Tangerang', 'Jl. Perintis Kemerdekaan I No. 33, Tangerang', 'Syepry Maulana Husain, S.Kom, MTI', 'On Progress', NOW());
SET @skripsi_id_1 = LAST_INSERT_ID();

INSERT INTO `skripsi_timeline` (`skripsi_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@skripsi_id_1, 'Pengajuan Proposal', '2024-07-01', TRUE, 'document'),
(@skripsi_id_1, 'Seminar Proposal', '2024-08-15', TRUE, 'presentation'),
(@skripsi_id_1, 'Bimbingan Skripsi', '2024-09-01', TRUE, 'mentor'),
(@skripsi_id_1, 'Ujian Skripsi', NULL, FALSE, 'exam'),
(@skripsi_id_1, 'Revisi', NULL, FALSE, 'edit');

-- User 4 - Skripsi
INSERT INTO `skripsi` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`) VALUES
(4, 'Sistem Informasi Manajemen Perpustakaan Digital', 'Universitas Muhammadiyah Tangerang', 'Jl. Perintis Kemerdekaan I No. 33, Tangerang', 'Syepry Maulana Husain, S.Kom, MTI', 'On Progress', NOW());
SET @skripsi_id_4 = LAST_INSERT_ID();

INSERT INTO `skripsi_timeline` (`skripsi_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@skripsi_id_4, 'Pengajuan Proposal', '2024-07-05', TRUE, 'document'),
(@skripsi_id_4, 'Seminar Proposal', '2024-08-20', TRUE, 'presentation'),
(@skripsi_id_4, 'Bimbingan Skripsi', '2024-09-05', TRUE, 'mentor'),
(@skripsi_id_4, 'Ujian Skripsi', NULL, FALSE, 'exam'),
(@skripsi_id_4, 'Revisi', NULL, FALSE, 'edit');

-- ===================================================================
-- SELESAI - Semua tabel sudah terisi dan saling terhubung
-- ===================================================================

