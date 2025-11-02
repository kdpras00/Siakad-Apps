-- ===================================================================
-- SEEDER USER ID 13 - John Doe (Semester 7)
-- ===================================================================
-- Relasi yang dibuat:
-- 1. Users → KRS → KRS Details (foreign key: krs.user_id → users.id, krs_details.krs_id → krs.id)
-- 2. Users → KHS → KHS Details (foreign key: khs.user_id → users.id, khs_details.khs_id → khs.id)
-- 3. Users → Pembayaran → Pembayaran Details (foreign key: pembayaran.user_id → users.id, pembayaran_details.pembayaran_id → pembayaran.id)
-- 4. Users → Kerja Praktek → KP Timeline (foreign key: kerja_praktek.user_id → users.id, kerja_praktek_timeline.kp_id → kerja_praktek.id)
-- 5. Users → Skripsi → Skripsi Timeline (foreign key: skripsi.user_id → users.id, skripsi_timeline.skripsi_id → skripsi.id)
-- ===================================================================
-- Catatan: Pastikan user dengan ID 13 sudah ada di tabel users sebelum menjalankan seeder ini.
-- ===================================================================

-- 1. Tambahkan KRS untuk user_id 13
INSERT INTO `krs` (`user_id`, `semester`, `tahun_ajaran`, `status`, `total_sks`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 7', '2024/2025', 'Aktif', 20, NOW(), NOW());

SET @krs_id_13 = LAST_INSERT_ID();

-- Tambahkan detail KRS untuk user_id 13
INSERT INTO `krs_details` (`krs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `dosen`, `jadwal`, `ruangan`) VALUES
(@krs_id_13, 'TI701', 'Pemrograman Mobile', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:00-10:00', 'A12.7'),
(@krs_id_13, 'TI702', 'Kerja Praktek', 3, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 13:00-15:00', 'Lab A'),
(@krs_id_13, 'TI703', 'Skripsi', 6, 'Syepry Maulana Husain, S.Kom, MTI', 'Jumat, 10:00-12:00', 'A12.8'),
(@krs_id_13, 'TI704', 'Manajemen Proyek', 2, 'Yani Sugiani, M.Kom', 'Selasa, 08:00-10:00', 'A12.6'),
(@krs_id_13, 'TI705', 'Etika Profesi', 2, 'Rina Kurniawati, M.Kom', 'Kamis, 10:00-12:00', 'A12.5'),
(@krs_id_13, 'TI706', 'Kewirausahaan', 2, 'Budi Santoso, M.Kom', 'Selasa, 13:00-15:00', 'A12.4'),
(@krs_id_13, 'TI707', 'Sistem Informasi Manajemen', 2, 'Dr. Andi Firmansyah, M.Kom', 'Rabu, 08:00-10:00', 'A12.3');

-- 2. Tambahkan KHS untuk user_id 13 (Semester 1-6)
-- Semester 1 (8 mata kuliah, total 18 SKS)
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

-- Semester 2 (7 mata kuliah, total 18 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 2', 3.80, 7, NOW(), NOW());
SET @khs_id_13_s2 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_13_s2, 'TI201', 'Struktur Data', 3, 'A', 4.0),
(@khs_id_13_s2, 'TI202', 'Basis Data', 3, 'A-', 3.75),
(@khs_id_13_s2, 'TI203', 'Pemrograman Berorientasi Objek', 3, 'A', 4.0),
(@khs_id_13_s2, 'TI204', 'Jaringan Komputer', 3, 'B+', 3.5),
(@khs_id_13_s2, 'TI205', 'Interaksi Manusia Komputer', 2, 'A-', 3.75),
(@khs_id_13_s2, 'TI206', 'Statistika', 2, 'B+', 3.5),
(@khs_id_13_s2, 'TI207', 'Kewarganegaraan', 2, 'A', 4.0);

-- Semester 3 (8 mata kuliah, total 20 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 3', 3.70, 8, NOW(), NOW());
SET @khs_id_13_s3 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_13_s3, 'TI301', 'Rekayasa Perangkat Lunak', 3, 'A-', 3.75),
(@khs_id_13_s3, 'TI302', 'Sistem Operasi', 3, 'B+', 3.5),
(@khs_id_13_s3, 'TI303', 'Pemrograman Web', 3, 'A', 4.0),
(@khs_id_13_s3, 'TI304', 'Keamanan Informasi', 2, 'A-', 3.75),
(@khs_id_13_s3, 'TI305', 'Multimedia', 2, 'B+', 3.5),
(@khs_id_13_s3, 'TI306', 'Pemrograman Mobile Dasar', 3, 'A', 4.0),
(@khs_id_13_s3, 'TI307', 'Manajemen Basis Data', 2, 'A-', 3.75),
(@khs_id_13_s3, 'TI308', 'Komunikasi Data', 2, 'B+', 3.5);

-- Semester 4 (8 mata kuliah, total 20 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 4', 3.85, 8, NOW(), NOW());
SET @khs_id_13_s4 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_13_s4, 'TI401', 'Pemrograman Web Lanjutan', 3, 'A', 4.0),
(@khs_id_13_s4, 'TI402', 'Sistem Informasi', 3, 'A-', 3.75),
(@khs_id_13_s4, 'TI403', 'Kecerdasan Buatan', 3, 'B+', 3.5),
(@khs_id_13_s4, 'TI404', 'Cloud Computing', 2, 'A', 4.0),
(@khs_id_13_s4, 'TI405', 'Pemrograman Android', 3, 'A', 4.0),
(@khs_id_13_s4, 'TI406', 'Analisis Sistem', 2, 'A-', 3.75),
(@khs_id_13_s4, 'TI407', 'Desain Database', 2, 'A', 4.0),
(@khs_id_13_s4, 'TI408', 'Komputasi Paralel', 2, 'B+', 3.5);

-- Semester 5 (9 mata kuliah, total 22 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 5', 3.80, 9, NOW(), NOW());
SET @khs_id_13_s5 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_13_s5, 'TI501', 'Pemrograman iOS', 3, 'A', 4.0),
(@khs_id_13_s5, 'TI502', 'Framework Web', 3, 'A-', 3.75),
(@khs_id_13_s5, 'TI503', 'Machine Learning', 3, 'B+', 3.5),
(@khs_id_13_s5, 'TI504', 'DevOps', 2, 'A', 4.0),
(@khs_id_13_s5, 'TI505', 'Testing & QA', 2, 'A-', 3.75),
(@khs_id_13_s5, 'TI506', 'Arsitektur Software', 3, 'A', 4.0),
(@khs_id_13_s5, 'TI507', 'Manajemen Proyek TI', 2, 'A-', 3.75),
(@khs_id_13_s5, 'TI508', 'Big Data', 2, 'B+', 3.5),
(@khs_id_13_s5, 'TI509', 'Blockchain', 2, 'A', 4.0);

-- Semester 6 (9 mata kuliah, total 22 SKS)
INSERT INTO `khs` (`user_id`, `semester`, `ip`, `total_mata_kuliah`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 6', 3.88, 9, NOW(), NOW());
SET @khs_id_13_s6 = LAST_INSERT_ID();

INSERT INTO `khs_details` (`khs_id`, `kode_mata_kuliah`, `nama_mata_kuliah`, `sks`, `nilai`, `nilai_angka`) VALUES
(@khs_id_13_s6, 'TI601', 'Pemrograman Flutter', 3, 'A', 4.0),
(@khs_id_13_s6, 'TI602', 'API Development', 3, 'A-', 3.75),
(@khs_id_13_s6, 'TI603', 'UI/UX Design', 2, 'A', 4.0),
(@khs_id_13_s6, 'TI604', 'Microservices', 3, 'B+', 3.5),
(@khs_id_13_s6, 'TI605', 'IoT Development', 2, 'A-', 3.75),
(@khs_id_13_s6, 'TI606', 'Cyber Security', 3, 'A', 4.0),
(@khs_id_13_s6, 'TI607', 'Agile Development', 2, 'A', 4.0),
(@khs_id_13_s6, 'TI608', 'Data Science', 2, 'A-', 3.75),
(@khs_id_13_s6, 'TI609', 'Enterprise Architecture', 2, 'B+', 3.5);

-- 3. Tambahkan Pembayaran untuk user_id 13
-- Semester 1
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW());
SET @pembayaran_id_13_s1 = LAST_INSERT_ID();

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_13_s1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
(@pembayaran_id_13_s1, 'SPP', 7000000.00, 7000000.00, 0.00);

-- Semester 2
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas', NOW(), NOW());
SET @pembayaran_id_13_s2 = LAST_INSERT_ID();

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_13_s2, 'SPP', 10000000.00, 10000000.00, 0.00);

-- Semester 3
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW());
SET @pembayaran_id_13_s3 = LAST_INSERT_ID();

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_13_s3, 'SPP', 10500000.00, 10500000.00, 0.00);

-- Semester 4
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas', NOW(), NOW());
SET @pembayaran_id_13_s4 = LAST_INSERT_ID();

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_13_s4, 'SPP', 10500000.00, 10500000.00, 0.00);

-- Semester 5
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 5', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW(), NOW());
SET @pembayaran_id_13_s5 = LAST_INSERT_ID();

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_13_s5, 'SPP', 11000000.00, 11000000.00, 0.00);

-- Semester 6
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 6', 11000000.00, 11000000.00, 0.00, 'Lunas', NOW(), NOW());
SET @pembayaran_id_13_s6 = LAST_INSERT_ID();

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_13_s6, 'SPP', 11000000.00, 11000000.00, 0.00);

-- Semester 7
INSERT INTO `pembayaran` (`user_id`, `semester`, `total_amount`, `paid_amount`, `remaining_amount`, `status`, `created_at`, `updated_at`) 
VALUES (13, 'Semester 7', 11500000.00, 5750000.00, 5750000.00, 'Belum Lunas', NOW(), NOW());
SET @pembayaran_id_13_s7 = LAST_INSERT_ID();

INSERT INTO `pembayaran_details` (`pembayaran_id`, `komponen`, `total`, `paid`, `remaining`) VALUES
(@pembayaran_id_13_s7, 'SPP', 11500000.00, 5750000.00, 5750000.00);

-- 4. Tambahkan Kerja Praktek untuk user_id 13
INSERT INTO `kerja_praktek` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`, `updated_at`) 
VALUES (13, 'Aplikasi E-Commerce Berbasis Mobile', 'PT. Digital Solution', 'Jl. Teknologi No. 45, Jakarta', 'Dr. Andi Firmansyah, M.Kom', 'Lulus', NOW(), NOW());
SET @kp_id_13 = LAST_INSERT_ID();

INSERT INTO `kerja_praktek_timeline` (`kp_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@kp_id_13, 'Pengajuan Proposal', '2024-01-10', TRUE, 'document'),
(@kp_id_13, 'Seminar Proposal', '2024-02-15', TRUE, 'presentation'),
(@kp_id_13, 'Bimbingan KP', '2024-03-01', TRUE, 'mentor'),
(@kp_id_13, 'Ujian KP', '2024-06-10', TRUE, 'exam'),
(@kp_id_13, 'Revisi Laporan', '2024-06-18', TRUE, 'edit');

-- 5. Tambahkan Skripsi untuk user_id 13
INSERT INTO `skripsi` (`user_id`, `judul`, `tempat_penelitian`, `alamat_penelitian`, `pembimbing`, `status`, `created_at`, `updated_at`) 
VALUES (13, 'Sistem Informasi Manajemen Perpustakaan Digital', 'Universitas Muhammadiyah Tangerang', 'Jl. Perintis Kemerdekaan I No. 33, Tangerang', 'Syepry Maulana Husain, S.Kom, MTI', 'On Progress', NOW(), NOW());
SET @skripsi_id_13 = LAST_INSERT_ID();

INSERT INTO `skripsi_timeline` (`skripsi_id`, `step_name`, `step_date`, `is_done`, `icon_name`) VALUES
(@skripsi_id_13, 'Pengajuan Proposal', '2024-07-05', TRUE, 'document'),
(@skripsi_id_13, 'Seminar Proposal', '2024-08-20', TRUE, 'presentation'),
(@skripsi_id_13, 'Bimbingan Skripsi', '2024-09-05', TRUE, 'mentor'),
(@skripsi_id_13, 'Ujian Skripsi', NULL, FALSE, 'exam'),
(@skripsi_id_13, 'Revisi', NULL, FALSE, 'edit');

