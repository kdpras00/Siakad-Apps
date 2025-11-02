-- ===================================================================
-- SEEDER LENGKAP UNTUK 5 USER DENGAN RELASI YANG BENAR
-- ===================================================================
-- File ini akan menambahkan data lengkap untuk:
-- - User ID 1: Shevrie Maulana Husain (Semester 7)
-- - User ID 4: Test User (Semester 7)
-- - User ID 13: John Doe (Semester 7)
-- - User ID 14: Jane Smith (Semester 5)
-- - User ID 15: Bob Wilson (Semester 3)
--
-- Relasi yang dibuat:
-- 1. Users → KRS → KRS Details (foreign key: krs.user_id → users.id, krs_details.krs_id → krs.id)
-- 2. Users → KHS → KHS Details (foreign key: khs.user_id → users.id, khs_details.khs_id → khs.id)
-- 3. Users → Pembayaran → Pembayaran Details (foreign key: pembayaran.user_id → users.id, pembayaran_details.pembayaran_id → pembayaran.id)
-- 4. Users → Kerja Praktek → KP Timeline (foreign key: kerja_praktek.user_id → users.id, kerja_praktek_timeline.kp_id → kerja_praktek.id)
-- 5. Users → Skripsi → Skripsi Timeline (foreign key: skripsi.user_id → users.id, skripsi_timeline.skripsi_id → skripsi.id)
-- ===================================================================

-- ============================================
-- USER ID 1 - Shevrie Maulana Husain (Semester 7)
-- ============================================

-- 1. KRS untuk user_id 1 (Semester 7)
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`, `updated_at`) 
VALUES (1, 'Semester 7', '2024/2025', 'Aktif', 20, NOW(), NOW());
SET @krs_id_1 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_1, 'TI701', 'Pemrograman Mobile', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_1, 'TI702', 'Kerja Praktek', 3, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_1, 'TI703', 'Skripsi', 6, 'Syepry Maulana Husain, S.Kom, MTI', 'Jumat, 10:00-12:00', 'A12.8'),
(@krs_id_1, 'TI704', 'Manajemen Proyek', 2, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_1, 'TI705', 'Etika Profesi', 2, 'Rina Kurniawati, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_1, 'TI706', 'Kewirausahaan', 2, 'Budi Santoso, M.Kom', 'Selasa, 13:00-15:00', 'A12.4'),
(@krs_id_1, 'TI707', 'Sistem Informasi Manajemen', 2, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 08:00-10:00', 'A12.3');

-- 2. KHS untuk user_id 1 (Semester 1-6)
-- Semester 1
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (1, 'Semester 1', 3.80, 8, NOW(), NOW());
SET @khs_id_1_s1 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_1_s1, 'TI101', 'Algoritma Pemrograman', 3, 'A', 4.0),
(@khs_id_1_s1, 'TI102', 'Matematika Diskrit', 3, 'A', 4.0),
(@khs_id_1_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'A-', 3.75),
(@khs_id_1_s1, 'TI104', 'Pendidikan Agama', 2, 'A', 4.0),
(@khs_id_1_s1, 'TI105', 'Bahasa Indonesia', 2, 'A-', 3.75),
(@khs_id_1_s1, 'TI106', 'Bahasa Inggris', 2, 'A', 4.0),
(@khs_id_1_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A', 4.0),
(@khs_id_1_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5);

-- Semester 2
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (1, 'Semester 2', 3.85, 7, NOW(), NOW());
SET @khs_id_1_s2 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_1_s2, 'TI201', 'Struktur Data', 3, 'A', 4.0),
(@khs_id_1_s2, 'TI202', 'Basis Data', 3, 'A-', 3.75),
(@khs_id_1_s2, 'TI203', 'Pemrograman Berorientasi Objek', 3, 'A', 4.0),
(@khs_id_1_s2, 'TI204', 'Jaringan Komputer', 3, 'A', 4.0),
(@khs_id_1_s2, 'TI205', 'Interaksi Manusia Komputer', 2, 'A-', 3.75),
(@khs_id_1_s2, 'TI206', 'Statistika', 2, 'B+', 3.5),
(@khs_id_1_s2, 'TI207', 'Kewarganegaraan', 2, 'A', 4.0);

-- Semester 3-6 (singkat untuk efisiensi, bisa ditambah lengkap)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) VALUES
(1, 'Semester 3', 3.82, 8, NOW(), NOW()),
(1, 'Semester 4', 3.88, 8, NOW(), NOW()),
(1, 'Semester 5', 3.85, 9, NOW(), NOW()),
(1, 'Semester 6', 3.90, 9, NOW(), NOW());

SET @khs_id_1_s3 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 3' ORDER BY id DESC LIMIT 1);
SET @khs_id_1_s4 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 4' ORDER BY id DESC LIMIT 1);
SET @khs_id_1_s5 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 5' ORDER BY id DESC LIMIT 1);
SET @khs_id_1_s6 = (SELECT id FROM khs WHERE user_id = 1 AND semester = 'Semester 6' ORDER BY id DESC LIMIT 1);

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_1_s3, 'TI301', 'Rekayasa Perangkat Lunak', 3, 'A', 4.0),
(@khs_id_1_s3, 'TI302', 'Sistem Operasi', 3, 'A-', 3.75),
(@khs_id_1_s3, 'TI303', 'Pemrograman Web', 3, 'A', 4.0),
(@khs_id_1_s3, 'TI304', 'Keamanan Informasi', 2, 'A-', 3.75),
(@khs_id_1_s3, 'TI305', 'Multimedia', 2, 'A', 4.0),
(@khs_id_1_s3, 'TI306', 'Pemrograman Mobile Dasar', 3, 'A-', 3.75),
(@khs_id_1_s3, 'TI307', 'Manajemen Basis Data', 2, 'B+', 3.5),
(@khs_id_1_s3, 'TI308', 'Komunikasi Data', 2, 'A', 4.0);

-- 3. Pembayaran untuk user_id 1
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(1, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(1, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(1, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(1, 'Semester 5', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW(), NOW()),
(1, 'Semester 6', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW(), NOW()),
(1, 'Semester 7', 11500000.00, 11500000.00, 0.00, 'Lunas', NOW(), NOW());

SET @pembayaran_id_1_s1 = (SELECT id FROM pembayaran WHERE user_id = 1 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @pembayaran_id_1_s7 = (SELECT id FROM pembayaran WHERE user_id = 1 AND semester = 'Semester 7' ORDER BY id DESC LIMIT 1);

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_1_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_1_s1, 'SPP', 7000000.00, 7000000.00, 0.00),
(@pembayaran_id_1_s7, 'SPP', 11500000.00, 11500000.00, 0.00);

-- 4. Kerja Praktek untuk user_id 1
INSERT INTO `kerja_praktek` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Sistem Informasi Akademik Berbasis Mobile', 'PT. Teknologi Indonesia', 'Jl. Raya Teknologi No. 123, Jakarta', 'Dr. Andi Firmansyah, M.Kom', 'Lulus', NOW(), NOW());
SET @kp_id_1 = LAST_INSERT_ID();

INSERT INTO `kerja_praktek_timeline` (`kp_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@kp_id_1, 'Pengajuan Proposal', '2024-01-15', TRUE, 'document'),
(@kp_id_1, 'Seminar Proposal', '2024-02-20', TRUE, 'presentation'),
(@kp_id_1, 'Bimbingan KP', '2024-03-01', TRUE, 'mentor'),
(@kp_id_1, 'Ujian KP', '2024-06-15', TRUE, 'exam'),
(@kp_id_1, 'Revisi Laporan', '2024-06-20', TRUE, 'edit');

-- 5. Skripsi untuk user_id 1
INSERT INTO `skripsi` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Aplikasi Mobile Learning untuk Pendidikan Tinggi', 'Universitas Muhammadiyah Tangerang', 'Jl. Perintis Kemerdekaan I No. 33, Tangerang', 'Syepry Maulana Husain, S.Kom, MTI', 'On Progress', NOW(), NOW());
SET @skripsi_id_1 = LAST_INSERT_ID();

INSERT INTO `skripsi_timeline` (`skripsi_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@skripsi_id_1, 'Pengajuan Proposal', '2024-07-01', TRUE, 'document'),
(@skripsi_id_1, 'Seminar Proposal', '2024-08-15', TRUE, 'presentation'),
(@skripsi_id_1, 'Bimbingan Skripsi', '2024-09-01', TRUE, 'mentor'),
(@skripsi_id_1, 'Ujian Skripsi', NULL, FALSE, 'exam'),
(@skripsi_id_1, 'Revisi', NULL, FALSE, 'edit');

-- ============================================
-- USER ID 4 - Test User (Semester 7)
-- ============================================

-- 1. KRS untuk user_id 4
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`, `updated_at`) 
VALUES (4, 'Semester 7', '2024/2025', 'Aktif', 20, NOW(), NOW());
SET @krs_id_4 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_4, 'TI701', 'Pemrograman Mobile', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_4, 'TI702', 'Kerja Praktek', 3, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_4, 'TI703', 'Skripsi', 6, 'Syepry Maulana Husain, S.Kom, MTI', 'Jumat, 10:00-12:00', 'A12.8'),
(@krs_id_4, 'TI704', 'Manajemen Proyek', 2, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_4, 'TI705', 'Etika Profesi', 2, 'Rina Kurniawati, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_4, 'TI706', 'Kewirausahaan', 2, 'Budi Santoso, M.Kom', 'Selasa, 13:00-15:00', 'A12.4'),
(@krs_id_4, 'TI707', 'Sistem Informasi Manajemen', 2, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 08:00-10:00', 'A12.3');

-- 2. KHS untuk user_id 4 (Semester 1-6)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) VALUES
(4, 'Semester 1', 3.75, 8, NOW(), NOW()),
(4, 'Semester 2', 3.78, 7, NOW(), NOW()),
(4, 'Semester 3', 3.80, 8, NOW(), NOW()),
(4, 'Semester 4', 3.82, 8, NOW(), NOW()),
(4, 'Semester 5', 3.85, 9, NOW(), NOW()),
(4, 'Semester 6', 3.88, 9, NOW(), NOW());

-- Detail KHS untuk user_id 4 (contoh untuk semester 1)
SET @khs_id_4_s1 = (SELECT id FROM khs WHERE user_id = 4 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_4_s1, 'TI101', 'Algoritma Pemrograman', 3, 'A-', 3.75),
(@khs_id_4_s1, 'TI102', 'Matematika Diskrit', 3, 'A', 4.0),
(@khs_id_4_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'B+', 3.5),
(@khs_id_4_s1, 'TI104', 'Pendidikan Agama', 2, 'A', 4.0),
(@khs_id_4_s1, 'TI105', 'Bahasa Indonesia', 2, 'A-', 3.75),
(@khs_id_4_s1, 'TI106', 'Bahasa Inggris', 2, 'B+', 3.5),
(@khs_id_4_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A', 4.0),
(@khs_id_4_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5);

-- 3. Pembayaran untuk user_id 4
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) VALUES
(4, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(4, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(4, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(4, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(4, 'Semester 5', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW(), NOW()),
(4, 'Semester 6', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW(), NOW()),
(4, 'Semester 7', 11500000.00, 5750000.00, 5750000.00, 'Belum Lunas', NOW(), NOW());

SET @pembayaran_id_4_s1 = (SELECT id FROM pembayaran WHERE user_id = 4 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_4_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_4_s1, 'SPP', 7000000.00, 7000000.00, 0.00);

-- ============================================
-- USER ID 13 - John Doe (Semester 7)
-- ============================================

-- 1. KRS untuk user_id 13
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 7', '2024/2025', 'Aktif', 20, NOW(), NOW());
SET @krs_id_13 = LAST_INSERT_ID();

INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_13, 'TI701', 'Pemrograman Mobile', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_13, 'TI702', 'Kerja Praktek', 3, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_13, 'TI703', 'Skripsi', 6, 'Syepry Maulana Husain, S.Kom, MTI', 'Jumat, 10:00-12:00', 'A12.8'),
(@krs_id_13, 'TI704', 'Manajemen Proyek', 2, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_13, 'TI705', 'Etika Profesi', 2, 'Rina Kurniawati, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_13, 'TI706', 'Kewirausahaan', 2, 'Budi Santoso, M.Kom', 'Selasa, 13:00-15:00', 'A12.4'),
(@krs_id_13, 'TI707', 'Sistem Informasi Manajemen', 2, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 08:00-10:00', 'A12.3');

-- 2. KHS untuk user_id 13 (Semester 1-6)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 1', 3.75, 8, NOW(), NOW());
SET @khs_id_13_s1 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_13_s1, 'TI101', 'Algoritma Pemrograman', 3, 'A', 4.0),
(@khs_id_13_s1, 'TI102', 'Matematika Diskrit', 3, 'A-', 3.75),
(@khs_id_13_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'B+', 3.5),
(@khs_id_13_s1, 'TI104', 'Pendidikan Agama', 2, 'A', 4.0),
(@khs_id_13_s1, 'TI105', 'Bahasa Indonesia', 2, 'A-', 3.75),
(@khs_id_13_s1, 'TI106', 'Bahasa Inggris', 2, 'B+', 3.5),
(@khs_id_13_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A', 4.0),
(@khs_id_13_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5);

INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) VALUES
(13, 'Semester 2', 3.80, 7, NOW(), NOW()),
(13, 'Semester 3', 3.70, 8, NOW(), NOW()),
(13, 'Semester 4', 3.85, 8, NOW(), NOW()),
(13, 'Semester 5', 3.80, 9, NOW(), NOW()),
(13, 'Semester 6', 3.88, 9, NOW(), NOW());

-- 3. Pembayaran untuk user_id 13
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) VALUES
(13, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(13, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(13, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(13, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(13, 'Semester 5', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW(), NOW()),
(13, 'Semester 6', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW(), NOW()),
(13, 'Semester 7', 11500000.00, 5750000.00, 5750000.00, 'Belum Lunas', NOW(), NOW());

SET @pembayaran_id_13_s1 = (SELECT id FROM pembayaran WHERE user_id = 13 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @pembayaran_id_13_s7 = (SELECT id FROM pembayaran WHERE user_id = 13 AND semester = 'Semester 7' ORDER BY id DESC LIMIT 1);

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_13_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_13_s1, 'SPP', 7000000.00, 7000000.00, 0.00),
(@pembayaran_id_13_s7, 'SPP', 11500000.00, 5750000.00, 5750000.00);

-- 4. Kerja Praktek untuk user_id 13
INSERT INTO `kerja_praktek` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`, `updated_at`) VALUES
(13, 'Aplikasi E-Commerce Berbasis Mobile', 'PT. Digital Solution', 'Jl. Teknologi No. 45, Jakarta', 'Dr. Andi Firmansyah, M.Kom', 'Lulus', NOW(), NOW());
SET @kp_id_13 = LAST_INSERT_ID();

INSERT INTO `kerja_praktek_timeline` (`kp_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@kp_id_13, 'Pengajuan Proposal', '2024-01-10', TRUE, 'document'),
(@kp_id_13, 'Seminar Proposal', '2024-02-15', TRUE, 'presentation'),
(@kp_id_13, 'Bimbingan KP', '2024-03-01', TRUE, 'mentor'),
(@kp_id_13, 'Ujian KP', '2024-06-10', TRUE, 'exam'),
(@kp_id_13, 'Revisi Laporan', '2024-06-18', TRUE, 'edit');

-- 5. Skripsi untuk user_id 13
INSERT INTO `skripsi` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`, `updated_at`) VALUES
(13, 'Sistem Informasi Manajemen Perpustakaan Digital', 'Universitas Muhammadiyah Tangerang', 'Jl. Perintis Kemerdekaan I No. 33, Tangerang', 'Syepry Maulana Husain, S.Kom, MTI', 'On Progress', NOW(), NOW());
SET @skripsi_id_13 = LAST_INSERT_ID();

INSERT INTO `skripsi_timeline` (`skripsi_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@skripsi_id_13, 'Pengajuan Proposal', '2024-07-05', TRUE, 'document'),
(@skripsi_id_13, 'Seminar Proposal', '2024-08-20', TRUE, 'presentation'),
(@skripsi_id_13, 'Bimbingan Skripsi', '2024-09-05', TRUE, 'mentor'),
(@skripsi_id_13, 'Ujian Skripsi', NULL, FALSE, 'exam'),
(@skripsi_id_13, 'Revisi', NULL, FALSE, 'edit');

-- ============================================
-- USER ID 14 - Jane Smith (Semester 5)
-- ============================================

-- 1. KRS untuk user_id 14 (Semester 5)
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

-- 2. KHS untuk user_id 14 (Semester 1-4)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) VALUES
(14, 'Semester 1', 3.70, 8, NOW(), NOW()),
(14, 'Semester 2', 3.75, 7, NOW(), NOW()),
(14, 'Semester 3', 3.80, 8, NOW(), NOW()),
(14, 'Semester 4', 3.82, 8, NOW(), NOW());

SET @khs_id_14_s1 = (SELECT id FROM khs WHERE user_id = 14 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @khs_id_14_s2 = (SELECT id FROM khs WHERE user_id = 14 AND semester = 'Semester 2' ORDER BY id DESC LIMIT 1);
SET @khs_id_14_s3 = (SELECT id FROM khs WHERE user_id = 14 AND semester = 'Semester 3' ORDER BY id DESC LIMIT 1);
SET @khs_id_14_s4 = (SELECT id FROM khs WHERE user_id = 14 AND semester = 'Semester 4' ORDER BY id DESC LIMIT 1);

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_14_s1, 'TI101', 'Algoritma Pemrograman', 3, 'A-', 3.75),
(@khs_id_14_s1, 'TI102', 'Matematika Diskrit', 3, 'B+', 3.5),
(@khs_id_14_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'A', 4.0),
(@khs_id_14_s1, 'TI104', 'Pendidikan Agama', 2, 'A-', 3.75),
(@khs_id_14_s1, 'TI105', 'Bahasa Indonesia', 2, 'B+', 3.5),
(@khs_id_14_s1, 'TI106', 'Bahasa Inggris', 2, 'A', 4.0),
(@khs_id_14_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A-', 3.75),
(@khs_id_14_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5),
(@khs_id_14_s2, 'TI201', 'Struktur Data', 3, 'A', 4.0),
(@khs_id_14_s2, 'TI202', 'Basis Data', 3, 'A-', 3.75),
(@khs_id_14_s2, 'TI203', 'Pemrograman Berorientasi Objek', 3, 'B+', 3.5),
(@khs_id_14_s2, 'TI204', 'Jaringan Komputer', 3, 'A', 4.0),
(@khs_id_14_s2, 'TI205', 'Interaksi Manusia Komputer', 2, 'A-', 3.75),
(@khs_id_14_s2, 'TI206', 'Statistika', 2, 'B+', 3.5),
(@khs_id_14_s2, 'TI207', 'Kewarganegaraan', 2, 'A', 4.0);

-- 3. Pembayaran untuk user_id 14
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) VALUES
(14, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(14, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(14, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(14, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW()),
(14, 'Semester 5', 11000000.00, 5500000.00, 5500000.00, 'Belum Lunas', NOW(), NOW());

SET @pembayaran_id_14_s1 = (SELECT id FROM pembayaran WHERE user_id = 14 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_14_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_14_s1, 'SPP', 7000000.00, 7000000.00, 0.00);

-- ============================================
-- USER ID 15 - Bob Wilson (Semester 3)
-- ============================================

-- 1. KRS untuk user_id 15 (Semester 3)
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

-- 2. KHS untuk user_id 15 (Semester 1-2)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) VALUES
(15, 'Semester 1', 3.65, 8, NOW(), NOW()),
(15, 'Semester 2', 3.68, 7, NOW(), NOW());

SET @khs_id_15_s1 = (SELECT id FROM khs WHERE user_id = 15 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
SET @khs_id_15_s2 = (SELECT id FROM khs WHERE user_id = 15 AND semester = 'Semester 2' ORDER BY id DESC LIMIT 1);

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_15_s1, 'TI101', 'Algoritma Pemrograman', 3, 'B+', 3.5),
(@khs_id_15_s1, 'TI102', 'Matematika Diskrit', 3, 'B', 3.0),
(@khs_id_15_s1, 'TI103', 'Pengantar Teknologi Informasi', 2, 'A-', 3.75),
(@khs_id_15_s1, 'TI104', 'Pendidikan Agama', 2, 'A', 4.0),
(@khs_id_15_s1, 'TI105', 'Bahasa Indonesia', 2, 'B+', 3.5),
(@khs_id_15_s1, 'TI106', 'Bahasa Inggris', 2, 'A-', 3.75),
(@khs_id_15_s1, 'TI107', 'Pendidikan Pancasila', 2, 'A', 4.0),
(@khs_id_15_s1, 'TI108', 'Pengantar Sistem Operasi', 2, 'B+', 3.5),
(@khs_id_15_s2, 'TI201', 'Struktur Data', 3, 'B+', 3.5),
(@khs_id_15_s2, 'TI202', 'Basis Data', 3, 'A-', 3.75),
(@khs_id_15_s2, 'TI203', 'Pemrograman Berorientasi Objek', 3, 'B', 3.0),
(@khs_id_15_s2, 'TI204', 'Jaringan Komputer', 3, 'B+', 3.5),
(@khs_id_15_s2, 'TI205', 'Interaksi Manusia Komputer', 2, 'A-', 3.75),
(@khs_id_15_s2, 'TI206', 'Statistika', 2, 'B+', 3.5),
(@khs_id_15_s2, 'TI207', 'Kewarganegaraan', 2, 'A', 4.0);

-- 3. Pembayaran untuk user_id 15
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) VALUES
(15, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(15, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW()),
(15, 'Semester 3', 10500000.00, 5250000.00, 5250000.00, 'Belum Lunas', NOW(), NOW());

SET @pembayaran_id_15_s1 = (SELECT id FROM pembayaran WHERE user_id = 15 AND semester = 'Semester 1' ORDER BY id DESC LIMIT 1);
INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_15_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_15_s1, 'SPP', 7000000.00, 7000000.00, 0.00);

-- ===================================================================
-- SELESAI - Semua relasi sudah terhubung dengan benar
-- ===================================================================

