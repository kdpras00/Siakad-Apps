-- Seeder untuk menambahkan data KRS, KHS, dan Pembayaran untuk user_id 14, 15, dan 16
-- Catatan: User dengan ID 14 (Jane Smith), 15 (Bob Wilson), dan 16 (Alice Johnson) sudah ada di database

-- ============================================
-- USER ID 14 - Jane Smith (Semester 5)
-- ============================================

-- 1. Tambahkan KRS untuk user_id 14 (Semester 5)
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`, `updated_at`) 
VALUES (14, 'Semester 5', '2024/2025', 'Aktif', 22, NOW(), NOW());
SET @krs_id_14 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_14, 'TI501', 'Pemrograman iOS', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_14, 'TI502', 'Framework Web', 3, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_14, 'TI503', 'Machine Learning', 3, 'Rina Kurniawati, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_14, 'TI504', 'DevOps', 2, 'Dr. Andi Firmansyah, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_14, 'TI505', 'Testing & QA', 2, 'Budi Santoso, M.Kom', 'Jumat, 08:00-10:00', 'A12.4'),
(@krs_id_14, 'TI506', 'Arsitektur Software', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 13:00-15:00', 'A12.3'),
(@krs_id_14, 'TI507', 'Manajemen Proyek TI', 2, 'Yani Sugiani, M.Kom', 'Selasa, 13:00-15:00', 'A12.2'),
(@krs_id_14, 'TI508', 'Big Data', 2, 'Rina Kurniawati, M.Kom', 'Rabu, 08:00-10:00', 'A12.1'),
(@krs_id_14, 'TI509', 'Blockchain', 2, 'Dr. Andi Firmansyah, M.Kom', 'Kamis, 13:00-15:00', 'A12.0');

-- 2. Tambahkan KHS untuk user_id 14 (Semester 1-4)
-- Semester 1 (8 mata kuliah, total 18 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (14, 'Semester 1', 3.70, 8, NOW(), NOW());
SET @khs_id_14_s1 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_14_s1, 'TI101', 'Algoritma Pemrograman', 3, 'A-', 3.75),
(@khs_id_14_s1, 'TI102', 'Matematika Diskrit', 3, 'B+', 3.5),
(@khs_id_14_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'A', 4.0),
(@khs_id_14_s1, 'TI104', 'Pendidikan Agama', 2, 'A-', 3.75),
(@khs_id_14_s1, 'TI105', 'Bahasa Indonesia', 2, 'B+', 3.5),
(@khs_id_14_s1, 'TI106', 'Bahasa Inggris', 2, 'A', 4.0),
(@khs_id_14_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A-', 3.75),
(@khs_id_14_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5);

-- Semester 2 (7 mata kuliah, total 18 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (14, 'Semester 2', 3.75, 7, NOW(), NOW());
SET @khs_id_14_s2 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_14_s2, 'TI201', 'Struktur Data', 3, 'A', 4.0),
(@khs_id_14_s2, 'TI202', 'Basis Data', 3, 'A-', 3.75),
(@khs_id_14_s2, 'TI203', 'Pemrograman Berorientasi Objek', 3, 'B+', 3.5),
(@khs_id_14_s2, 'TI204', 'Jaringan Komputer', 3, 'A', 4.0),
(@khs_id_14_s2, 'TI205', 'Interaksi Manusia Komputer', 2, 'A-', 3.75),
(@khs_id_14_s2, 'TI206', 'Statistika', 2, 'B+', 3.5),
(@khs_id_14_s2, 'TI207', 'Kewarganegaraan', 2, 'A', 4.0);

-- Semester 3 (8 mata kuliah, total 20 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (14, 'Semester 3', 3.80, 8, NOW(), NOW());
SET @khs_id_14_s3 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_14_s3, 'TI301', 'Rekayasa Perangkat Lunak', 3, 'A', 4.0),
(@khs_id_14_s3, 'TI302', 'Sistem Operasi', 3, 'A-', 3.75),
(@khs_id_14_s3, 'TI303', 'Pemrograman Web', 3, 'B+', 3.5),
(@khs_id_14_s3, 'TI304', 'Keamanan Informasi', 2, 'A', 4.0),
(@khs_id_14_s3, 'TI305', 'Multimedia', 2, 'A-', 3.75),
(@khs_id_14_s3, 'TI306', 'Pemrograman Mobile Dasar', 3, 'B+', 3.5),
(@khs_id_14_s3, 'TI307', 'Manajemen Basis Data', 2, 'A', 4.0),
(@khs_id_14_s3, 'TI308', 'Komunikasi Data', 2, 'A-', 3.75);

-- Semester 4 (8 mata kuliah, total 20 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (14, 'Semester 4', 3.82, 8, NOW(), NOW());
SET @khs_id_14_s4 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_14_s4, 'TI401', 'Pemrograman Web Lanjutan', 3, 'A-', 3.75),
(@khs_id_14_s4, 'TI402', 'Sistem Informasi', 3, 'B+', 3.5),
(@khs_id_14_s4, 'TI403', 'Kecerdasan Buatan', 3, 'A', 4.0),
(@khs_id_14_s4, 'TI404', 'Cloud Computing', 2, 'A-', 3.75),
(@khs_id_14_s4, 'TI405', 'Pemrograman Android', 3, 'B+', 3.5),
(@khs_id_14_s4, 'TI406', 'Analisis Sistem', 2, 'A', 4.0),
(@khs_id_14_s4, 'TI407', 'Desain Database', 2, 'A-', 3.75),
(@khs_id_14_s4, 'TI408', 'Komputasi Paralel', 2, 'B+', 3.5);

-- 3. Tambahkan Pembayaran untuk user_id 14
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES 
(14, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(14, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(14, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(14, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(14, 'Semester 5', 11000000.00, 5500000.00, 5500000.00, 'Belum Lunas', NOW(), NOW());

-- Tambahkan detail pembayaran untuk user_id 14
SET @pembayaran_id_14_s1 = (SELECT id FROM pembayaran WHERE user_id = 14 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @pembayaran_id_14_s2 = (SELECT id FROM pembayaran WHERE user_id = 14 AND semester = 'Semester 2' ORDER BY id DESC LIMIT 1);
SET @pembayaran_id_14_s3 = (SELECT id FROM pembayaran WHERE user_id = 14 AND semester = 'Semester 3' ORDER BY id DESC LIMIT 1);
SET @pembayaran_id_14_s4 = (SELECT id FROM pembayaran WHERE user_id = 14 AND semester = 'Semester 4' ORDER BY id DESC LIMIT 1);
SET @pembayaran_id_14_s5 = (SELECT id FROM pembayaran WHERE user_id = 14 AND semester = 'Semester 5' ORDER BY id DESC LIMIT 1);

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_14_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_14_s1, 'SPP', 7000000.00, 7000000.00, 0.00),
(@pembayaran_id_14_s2, 'SPP', 10000000.00, 10000000.00, 0.00),
(@pembayaran_id_14_s3, 'SPP', 10500000.00, 10500000.00, 0.00),
(@pembayaran_id_14_s4, 'SPP', 10500000.00, 10500000.00, 0.00),
(@pembayaran_id_14_s5, 'SPP', 11000000.00, 5500000.00, 5500000.00);

-- ============================================
-- USER ID 15 - Bob Wilson (Semester 3)
-- ============================================

-- 1. Tambahkan KRS untuk user_id 15 (Semester 3)
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`, `updated_at`) 
VALUES (15, 'Semester 3', '2024/2025', 'Aktif', 20, NOW(), NOW());
SET @krs_id_15 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_15, 'TI301', 'Rekayasa Perangkat Lunak', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_15, 'TI302', 'Sistem Operasi', 3, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_15, 'TI303', 'Pemrograman Web', 3, 'Rina Kurniawati, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_15, 'TI304', 'Keamanan Informasi', 2, 'Dr. Andi Firmansyah, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_15, 'TI305', 'Multimedia', 2, 'Budi Santoso, M.Kom', 'Jumat, 08:00-10:00', 'A12.4'),
(@krs_id_15, 'TI306', 'Pemrograman Mobile Dasar', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 13:00-15:00', 'A12.3'),
(@krs_id_15, 'TI307', 'Manajemen Basis Data', 2, 'Yani Sugiani, M.Kom', 'Selasa, 13:00-15:00', 'A12.2'),
(@krs_id_15, 'TI308', 'Komunikasi Data', 2, 'Rina Kurniawati, M.Kom', 'Rabu, 08:00-10:00', 'A12.1');

-- 2. Tambahkan KHS untuk user_id 15 (Semester 1-2)
-- Semester 1 (8 mata kuliah, total 18 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (15, 'Semester 1', 3.65, 8, NOW(), NOW());
SET @khs_id_15_s1 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_15_s1, 'TI101', 'Algoritma Pemrograman', 3, 'B+', 3.5),
(@khs_id_15_s1, 'TI102', 'Matematika Diskrit', 3, 'B', 3.0),
(@khs_id_15_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'A-', 3.75),
(@khs_id_15_s1, 'TI104', 'Pendidikan Agama', 2, 'A', 4.0),
(@khs_id_15_s1, 'TI105', 'Bahasa Indonesia', 2, 'B+', 3.5),
(@khs_id_15_s1, 'TI106', 'Bahasa Inggris', 2, 'A-', 3.75),
(@khs_id_15_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A', 4.0),
(@khs_id_15_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5);

-- Semester 2 (7 mata kuliah, total 18 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (15, 'Semester 2', 3.68, 7, NOW(), NOW());
SET @khs_id_15_s2 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_15_s2, 'TI201', 'Struktur Data', 3, 'B+', 3.5),
(@khs_id_15_s2, 'TI202', 'Basis Data', 3, 'A-', 3.75),
(@khs_id_15_s2, 'TI203', 'Pemrograman Berorientasi Objek', 3, 'B', 3.0),
(@khs_id_15_s2, 'TI204', 'Jaringan Komputer', 3, 'B+', 3.5),
(@khs_id_15_s2, 'TI205', 'Interaksi Manusia Komputer', 2, 'A-', 3.75),
(@khs_id_15_s2, 'TI206', 'Statistika', 2, 'B+', 3.5),
(@khs_id_15_s2, 'TI207', 'Kewarganegaraan', 2, 'A', 4.0);

-- 3. Tambahkan Pembayaran untuk user_id 15
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES 
(15, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(15, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(15, 'Semester 3', 10500000.00, 5250000.00, 5250000.00, 'Belum Lunas', NOW(), NOW());

SET @pembayaran_id_15_s1 = (SELECT id FROM pembayaran WHERE user_id = 15 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @pembayaran_id_15_s2 = (SELECT id FROM pembayaran WHERE user_id = 15 AND semester = 'Semester 2' ORDER BY id DESC LIMIT 1);
SET @pembayaran_id_15_s3 = (SELECT id FROM pembayaran WHERE user_id = 15 AND semester = 'Semester 3' ORDER BY id DESC LIMIT 1);

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_15_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_15_s1, 'SPP', 7000000.00, 7000000.00, 0.00),
(@pembayaran_id_15_s2, 'SPP', 10000000.00, 10000000.00, 0.00),
(@pembayaran_id_15_s3, 'SPP', 10500000.00, 5250000.00, 5250000.00);

-- ============================================
-- USER ID 16 - Alice Johnson (Semester 1)
-- ============================================

-- 1. Tambahkan KRS untuk user_id 16 (Semester 1)
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`, `updated_at`) 
VALUES (16, 'Semester 1', '2024/2025', 'Aktif', 18, NOW(), NOW());
SET @krs_id_16 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_16, 'TI101', 'Algoritma Pemrograman', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_16, 'TI102', 'Matematika Diskrit', 3, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_16, 'TI103', 'Pengantar Teknologi Informasi', 2, 'Rina Kurniawati, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_16, 'TI104', 'Pendidikan Agama', 2, 'Dr. Andi Firmansyah, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_16, 'TI105', 'Bahasa Indonesia', 2, 'Budi Santoso, M.Kom', 'Jumat, 08:00-10:00', 'A12.4'),
(@krs_id_16, 'TI106', 'Bahasa Inggris', 2, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 13:00-15:00', 'A12.3'),
(@krs_id_16, 'TI107', 'Pendidikan Pancasila', 2, 'Yani Sugiani, M.Kom', 'Selasa, 13:00-15:00', 'A12.2'),
(@krs_id_16, 'TI108', 'Pengantar Sistem Operasi', 2, 'Rina Kurniawati, M.Kom', 'Rabu, 08:00-10:00', 'A12.1');

-- 2. User semester 1 belum punya KHS (masih dalam proses)
-- KHS akan dibuat setelah ujian semester

-- 3. Tambahkan Pembayaran untuk user_id 16
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES 
(16, 'Semester 1', 10000000.00, 5000000.00, 5000000.00, 'Belum Lunas', NOW(), NOW());

SET @pembayaran_id_16_s1 = (SELECT id FROM pembayaran WHERE user_id = 16 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_16_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_16_s1, 'SPP', 7000000.00, 2000000.00, 5000000.00);

