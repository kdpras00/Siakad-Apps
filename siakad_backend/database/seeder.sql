-- Seeder Script untuk SIAKAD Database
-- Menyediakan sample data untuk semua tabel

USE siakad_db;

-- ============================================
-- CLEAR EXISTING DATA (Optional)
-- ============================================
-- Hati-hati: Script ini akan menghapus semua data!
-- Uncomment jika ingin reset database

-- DELETE FROM pembayaran_details;
-- DELETE FROM pembayaran;
-- DELETE FROM khs_details;
-- DELETE FROM khs;
-- DELETE FROM krs_details;
-- DELETE FROM krs;
-- DELETE FROM information;
-- DELETE FROM users;

-- ============================================
-- SEED: users
-- ============================================
INSERT INTO users (name, nim, email, password, phone, program_studi, semester) VALUES
('John Doe', '0419108607', 'john.doe@example.com', 'password123', '081234567890', 'Teknik Informatika', '7'),
('Jane Smith', '0419108608', 'jane.smith@example.com', 'password123', '081234567891', 'Teknik Informatika', '5'),
('Bob Wilson', '0419108609', 'bob.wilson@example.com', 'password123', '081234567892', 'Teknik Informatika', '3'),
('Alice Johnson', '0419108610', 'alice.johnson@example.com', 'password123', '081234567893', 'Teknik Informatika', '1');

-- ============================================
-- SEED: information
-- ============================================
-- ============================================
-- SEED: information (tanpa kolom category)
-- ============================================
INSERT INTO information (title, content, date) VALUES
('Pengumuman Wisuda 2024', 'Selamat kepada seluruh mahasiswa yang akan mengikuti wisuda 2024. Acara akan dilaksanakan pada tanggal 15 Desember 2024 di Auditorium Kampus.', '2024-12-15'),
('Pembukaan Pendaftaran KRS Semester Genap 2024/2025', 'Pendaftaran KRS untuk semester genap 2024/2025 akan dibuka mulai tanggal 1 Januari 2025. Harap segera melakukan pendaftaran sebelum deadline yang ditentukan.', '2025-01-01'),
('Informasi Pembayaran SPP', 'Kepada seluruh mahasiswa, pembayaran SPP semester genap harus dilakukan sebelum tanggal 10 Februari 2025. Silakan lakukan pembayaran melalui sistem pembayaran online.', '2025-02-10'),
('Jadwal Ujian Akhir Semester', 'Jadwal ujian akhir semester genap 2024/2025 telah diumumkan. Silakan cek jadwal Anda di portal mahasiswa.', '2025-06-10'),
('Pelatihan Workshop Flutter', 'Program studi Teknik Informatika akan mengadakan workshop Flutter untuk mahasiswa semester 5–7. Pendaftaran dibuka mulai tanggal 20 Januari 2025.', '2025-01-20');

-- ============================================
-- SEED: krs (Kartu Rencana Studi)
-- ============================================
-- KRS untuk user_id = 1 (John Doe - Semester 7)
INSERT INTO krs (user_id, semester, tahun_ajaran, status, total_sks) VALUES
(1, 'Semester 7', '2024/2025', 'Aktif', 22);

-- KRS untuk user_id = 2 (Jane Smith - Semester 5)
INSERT INTO krs (user_id, semester, tahun_ajaran, status, total_sks) VALUES
(2, 'Semester 5', '2024/2025', 'Aktif', 20);

-- KRS untuk user_id = 3 (Bob Wilson - Semester 3)
INSERT INTO krs (user_id, semester, tahun_ajaran, status, total_sks) VALUES
(3, 'Semester 3', '2024/2025', 'Aktif', 18);

-- KRS untuk user_id = 4 (Alice Johnson - Semester 1)
INSERT INTO krs (user_id, semester, tahun_ajaran, status, total_sks) VALUES
(4, 'Semester 1', '2024/2025', 'Aktif', 18);

-- ============================================
-- SEED: krs_details (Detail Mata Kuliah KRS)
-- ============================================
-- Detail KRS untuk Semester 7 (krs_id = 1)
INSERT INTO krs_details (krs_id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan) VALUES
(1, 'TI701', 'Mobile Programming', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:30 - 10:00 WIB', 'Ruang A12.7'),
(1, 'TI702', 'Analisis dan Perancangan Sistem Informasi', 3, 'Yani Sugiani, M.Kom', 'Selasa, 08:30 - 10:00 WIB', 'Ruang A12.8'),
(1, 'TI703', 'Pemrograman Web Lanjutan', 3, 'Ahmad Fauzi, S.Kom, M.Kom', 'Rabu, 08:30 - 10:00 WIB', 'Ruang A12.9'),
(1, 'TI704', 'Kecerdasan Buatan', 3, 'Dr. Budi Santoso, S.Kom, M.Kom', 'Kamis, 08:30 - 10:00 WIB', 'Ruang A12.10'),
(1, 'TI705', 'Sistem Basis Data Lanjutan', 3, 'Siti Nurhaliza, S.Kom, M.TI', 'Jumat, 08:30 - 10:00 WIB', 'Ruang A12.11'),
(1, 'TI706', 'Keamanan Sistem Informasi', 2, 'Andi Wijaya, S.Kom, M.Kom', 'Senin, 13:00 - 14:30 WIB', 'Ruang A12.12'),
(1, 'TI707', 'Proyek Akhir', 5, 'Pembimbing Akademik', 'TBA', 'TBA');

-- Detail KRS untuk Semester 5 (krs_id = 2)
INSERT INTO krs_details (krs_id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan) VALUES
(2, 'TI501', 'Pemrograman Berorientasi Objek', 3, 'Budi Pratama, S.Kom, M.Kom', 'Senin, 08:30 - 10:00 WIB', 'Ruang B10.1'),
(2, 'TI502', 'Struktur Data dan Algoritma', 3, 'Citra Dewi, S.Kom, M.TI', 'Selasa, 08:30 - 10:00 WIB', 'Ruang B10.2'),
(2, 'TI503', 'Sistem Basis Data', 3, 'Dedi Kurniawan, S.Kom, M.Kom', 'Rabu, 08:30 - 10:00 WIB', 'Ruang B10.3'),
(2, 'TI504', 'Rekayasa Perangkat Lunak', 3, 'Eka Sari, S.Kom, M.Kom', 'Kamis, 08:30 - 10:00 WIB', 'Ruang B10.4'),
(2, 'TI505', 'Jaringan Komputer', 3, 'Fajar Hidayat, S.Kom, M.TI', 'Jumat, 08:30 - 10:00 WIB', 'Ruang B10.5'),
(2, 'TI506', 'Interaksi Manusia dan Komputer', 2, 'Gita Lestari, S.Kom, M.Kom', 'Senin, 13:00 - 14:30 WIB', 'Ruang B10.6'),
(2, 'TI507', 'Pemrograman Web', 3, 'Hadi Santoso, S.Kom, M.Kom', 'Selasa, 13:00 - 14:30 WIB', 'Ruang B10.7');

-- Detail KRS untuk Semester 3 (krs_id = 3)
INSERT INTO krs_details (krs_id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan) VALUES
(3, 'TI301', 'Algoritma Pemrograman', 3, 'Indah Permata, S.Kom, M.Kom', 'Senin, 08:30 - 10:00 WIB', 'Ruang C8.1'),
(3, 'TI302', 'Kalkulus 2', 3, 'Joko Widodo, S.Si, M.Si', 'Selasa, 08:30 - 10:00 WIB', 'Ruang C8.2'),
(3, 'TI303', 'Pemrograman Web Dasar', 3, 'Kartika Sari, S.Kom, M.Kom', 'Rabu, 08:30 - 10:00 WIB', 'Ruang C8.3'),
(3, 'TI304', 'Sistem Operasi', 3, 'Lukman Hakim, S.Kom, M.TI', 'Kamis, 08:30 - 10:00 WIB', 'Ruang C8.4'),
(3, 'TI305', 'Organisasi dan Arsitektur Komputer', 2, 'Maya Sari, S.Kom, M.Kom', 'Jumat, 08:30 - 10:00 WIB', 'Ruang C8.5'),
(3, 'TI306', 'Pemrograman Desktop', 2, 'Nur Hidayat, S.Kom, M.Kom', 'Senin, 13:00 - 14:30 WIB', 'Ruang C8.6'),
(3, 'TI307', 'Statistika dan Probabilitas', 2, 'Oki Setiawan, S.Si, M.Si', 'Selasa, 13:00 - 14:30 WIB', 'Ruang C8.7');

-- Detail KRS untuk Semester 1 (krs_id = 4)
INSERT INTO krs_details (krs_id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan) VALUES
(4, 'TI101', 'Pengantar Teknologi Informasi', 3, 'Prita Utami, S.Kom, M.Kom', 'Senin, 08:30 - 10:00 WIB', 'Ruang D5.1'),
(4, 'TI102', 'Algoritma dan Pemrograman Dasar', 3, 'Qori Sandria, S.Kom, M.Kom', 'Selasa, 08:30 - 10:00 WIB', 'Ruang D5.2'),
(4, 'TI103', 'Kalkulus 1', 3, 'Rudi Hartono, S.Si, M.Si', 'Rabu, 08:30 - 10:00 WIB', 'Ruang D5.3'),
(4, 'TI104', 'Matematika Diskrit', 3, 'Siti Nurhaliza, S.Si, M.Si', 'Kamis, 08:30 - 10:00 WIB', 'Ruang D5.4'),
(4, 'TI105', 'Dasar Sistem Informasi', 2, 'Teguh Wijaya, S.Kom, M.Kom', 'Jumat, 08:30 - 10:00 WIB', 'Ruang D5.5'),
(4, 'TI106', 'Bahasa Inggris Teknis', 2, 'Umi Kalsum, S.Pd, M.Pd', 'Senin, 13:00 - 14:30 WIB', 'Ruang D5.6'),
(4, 'TI107', 'Pancasila dan Kewarganegaraan', 2, 'Vina Oktavia, S.Pd, M.Pd', 'Selasa, 13:00 - 14:30 WIB', 'Ruang D5.7');

-- ============================================
-- SEED: khs (Kartu Hasil Studi)
-- ============================================
-- KHS untuk user_id = 1 (John Doe) - Multiple semester
INSERT INTO khs (user_id, semester, ip, total_mata_kuliah) VALUES
(1, 'Semester 1', 3.85, 18),
(1, 'Semester 2', 3.80, 18),
(1, 'Semester 3', 3.75, 20),
(1, 'Semester 4', 3.90, 20),
(1, 'Semester 5', 3.82, 22),
(1, 'Semester 6', 3.88, 22);

-- KHS untuk user_id = 2 (Jane Smith)
INSERT INTO khs (user_id, semester, ip, total_mata_kuliah) VALUES
(2, 'Semester 1', 3.70, 18),
(2, 'Semester 2', 3.75, 18),
(2, 'Semester 3', 3.72, 20),
(2, 'Semester 4', 3.78, 20);

-- KHS untuk user_id = 3 (Bob Wilson)
INSERT INTO khs (user_id, semester, ip, total_mata_kuliah) VALUES
(3, 'Semester 1', 3.60, 18),
(3, 'Semester 2', 3.65, 18);

-- ============================================
-- SEED: khs_details (Detail Nilai Mata Kuliah)
-- ============================================
-- Detail KHS Semester 1 untuk user_id = 1 (khs_id = 1)
INSERT INTO khs_details (khs_id, kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka) VALUES
(1, 'TI101', 'Pengantar Teknologi Informasi', 3, 'A', 4.0),
(1, 'TI102', 'Algoritma dan Pemrograman Dasar', 3, 'A', 4.0),
(1, 'TI103', 'Kalkulus 1', 3, 'A-', 3.7),
(1, 'TI104', 'Matematika Diskrit', 3, 'A', 4.0),
(1, 'TI105', 'Dasar Sistem Informasi', 2, 'B+', 3.3),
(1, 'TI106', 'Bahasa Inggris Teknis', 2, 'A', 4.0),
(1, 'TI107', 'Pancasila dan Kewarganegaraan', 2, 'A', 4.0);

-- Detail KHS Semester 2 untuk user_id = 1 (khs_id = 2)
INSERT INTO khs_details (khs_id, kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka) VALUES
(2, 'TI201', 'Pemrograman Lanjutan', 3, 'A', 4.0),
(2, 'TI202', 'Kalkulus 2', 3, 'A-', 3.7),
(2, 'TI203', 'Algoritma dan Struktur Data', 3, 'A', 4.0),
(2, 'TI204', 'Sistem Basis Data', 3, 'B+', 3.3),
(2, 'TI205', 'Organisasi dan Arsitektur Komputer', 2, 'A', 4.0),
(2, 'TI206', 'Sistem Operasi', 2, 'A-', 3.7),
(2, 'TI207', 'Pendidikan Agama', 2, 'A', 4.0);

-- Detail KHS Semester 1 untuk user_id = 2 (khs_id = 7)
INSERT INTO khs_details (khs_id, kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka) VALUES
(7, 'TI101', 'Pengantar Teknologi Informasi', 3, 'B+', 3.3),
(7, 'TI102', 'Algoritma dan Pemrograman Dasar', 3, 'A-', 3.7),
(7, 'TI103', 'Kalkulus 1', 3, 'B', 3.0),
(7, 'TI104', 'Matematika Diskrit', 3, 'A-', 3.7),
(7, 'TI105', 'Dasar Sistem Informasi', 2, 'B+', 3.3),
(7, 'TI106', 'Bahasa Inggris Teknis', 2, 'A-', 3.7),
(7, 'TI107', 'Pancasila dan Kewarganegaraan', 2, 'A', 4.0);

-- ============================================
-- SEED: pembayaran (Pembayaran per Semester)
-- ============================================
-- Pembayaran untuk user_id = 1 (John Doe)
INSERT INTO pembayaran (user_id, semester, total_amount, paid_amount, remaining_amount, status) VALUES
(1, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas'),
(1, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas'),
(1, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas'),
(1, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas'),
(1, 'Semester 5', 11000000.00, 11000000.00, 0.00, 'Lunas'),
(1, 'Semester 6', 11000000.00, 11000000.00, 0.00, 'Lunas'),
(1, 'Semester 7', 11500000.00, 5750000.00, 5750000.00, 'Belum Lunas');

-- Pembayaran untuk user_id = 2 (Jane Smith)
INSERT INTO pembayaran (user_id, semester, total_amount, paid_amount, remaining_amount, status) VALUES
(2, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas'),
(2, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas'),
(2, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas'),
(2, 'Semester 4', 10500000.00, 10500000.00, 0.00, 'Lunas'),
(2, 'Semester 5', 11000000.00, 5500000.00, 5500000.00, 'Belum Lunas');

-- Pembayaran untuk user_id = 3 (Bob Wilson)
INSERT INTO pembayaran (user_id, semester, total_amount, paid_amount, remaining_amount, status) VALUES
(3, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas'),
(3, 'Semester 2', 10000000.00, 10000000.00, 0.00, 'Lunas'),
(3, 'Semester 3', 10500000.00, 10500000.00, 0.00, 'Lunas');

-- Pembayaran untuk user_id = 4 (Alice Johnson)
INSERT INTO pembayaran (user_id, semester, total_amount, paid_amount, remaining_amount, status) VALUES
(4, 'Semester 1', 10000000.00, 5000000.00, 5000000.00, 'Belum Lunas');

-- ============================================
-- SEED: pembayaran_details (Detail Komponen Pembayaran)
-- ============================================
-- Detail pembayaran Semester 1 untuk user_id = 1 (pembayaran_id = 1)
INSERT INTO pembayaran_details (pembayaran_id, komponen, total, paid, remaining) VALUES
(1, 'Uang Bangunan', 5000000.00, 5000000.00, 0.00),
(1, 'Biaya SKS (18 SKS)', 3600000.00, 3600000.00, 0.00),
(1, 'Biaya Praktikum', 1000000.00, 1000000.00, 0.00),
(1, 'Biaya Administrasi', 400000.00, 400000.00, 0.00);

-- Detail pembayaran Semester 7 untuk user_id = 1 (pembayaran_id = 7)
INSERT INTO pembayaran_details (pembayaran_id, komponen, total, paid, remaining) VALUES
(7, 'Uang Bangunan', 5000000.00, 2500000.00, 2500000.00),
(7, 'Biaya SKS (22 SKS)', 4400000.00, 2200000.00, 2200000.00),
(7, 'Biaya Praktikum', 1500000.00, 750000.00, 750000.00),
(7, 'Biaya Administrasi', 600000.00, 300000.00, 300000.00);

-- Detail pembayaran Semester 5 untuk user_id = 2 (pembayaran_id = 10)
INSERT INTO pembayaran_details (pembayaran_id, komponen, total, paid, remaining) VALUES
(10, 'Uang Bangunan', 5000000.00, 2500000.00, 2500000.00),
(10, 'Biaya SKS (20 SKS)', 4000000.00, 2000000.00, 2000000.00),
(10, 'Biaya Praktikum', 1500000.00, 750000.00, 750000.00),
(10, 'Biaya Administrasi', 500000.00, 250000.00, 250000.00);

-- Detail pembayaran Semester 1 untuk user_id = 4 (pembayaran_id = 12)
INSERT INTO pembayaran_details (pembayaran_id, komponen, total, paid, remaining) VALUES
(12, 'Uang Bangunan', 5000000.00, 2500000.00, 2500000.00),
(12, 'Biaya SKS (18 SKS)', 3600000.00, 1800000.00, 1800000.00),
(12, 'Biaya Praktikum', 1000000.00, 500000.00, 500000.00),
(12, 'Biaya Administrasi', 400000.00, 200000.00, 200000.00);

-- ============================================
-- VERIFICATION QUERIES
-- ============================================
-- Uncomment untuk melihat hasil seeder
-- SELECT COUNT(*) as total_users FROM users;
-- SELECT COUNT(*) as total_information FROM information;
-- SELECT COUNT(*) as total_krs FROM krs;
-- SELECT COUNT(*) as total_krs_details FROM krs_details;
-- SELECT COUNT(*) as total_khs FROM khs;
-- SELECT COUNT(*) as total_khs_details FROM khs_details;
-- SELECT COUNT(*) as total_pembayaran FROM pembayaran;
-- SELECT COUNT(*) as total_pembayaran_details FROM pembayaran_details;

