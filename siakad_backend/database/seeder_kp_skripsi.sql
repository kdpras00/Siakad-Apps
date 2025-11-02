-- Seeder Script untuk Tabel Kerja Praktek dan Skripsi
-- Menyediakan sample data untuk tabel kerja_praktek, kerja_praktek_timeline, skripsi, skripsi_timeline

USE siakad_db;

-- ============================================
-- SEED: kerja_praktek
-- ============================================
-- Hapus data lama jika ada
DELETE FROM kerja_praktek_timeline;
DELETE FROM kerja_praktek;

-- KP untuk user_id = 1 (John Doe - Semester 7)
INSERT INTO kerja_praktek (user_id, judul, tempat_penelitian, alamat_penelitian, pembimbing, status) VALUES
(1, 'Analisa dan Perancangan Aplikasi Sistem Akademik Berbasis Mobile', 'Fakultas Teknik Universitas Muhammadiyah Tangerang', 'Jalan Perintis Kemerdekaan I Cikokol Tangerang', 'Syepry Maulana Husain, S.Kom, MTI', 'DAFTAR JUDUL');

-- KP untuk user_id = 2 (Jane Smith - Semester 5)
INSERT INTO kerja_praktek (user_id, judul, tempat_penelitian, alamat_penelitian, pembimbing, status) VALUES
(2, 'Pengembangan Sistem Informasi Manajemen Berbasis Web', 'PT. Teknologi Nusantara', 'Jl. Gatot Subroto No. 123 Jakarta', 'Yani Sugiani, M.Kom', 'VERIFIKASI AKADEMIK');

-- ============================================
-- SEED: kerja_praktek_timeline
-- ============================================
-- Timeline untuk KP user_id = 1 (kp_id = 1, karena user_id = 1 akan mendapat id pertama)
INSERT INTO kerja_praktek_timeline (kp_id, step_name, step_date, is_done, icon_name) VALUES
(1, 'Pendaftaran Judul', '2024-10-29', TRUE, 'assignment'),
(1, 'Verifikasi Keuangan', '2024-10-29', TRUE, 'monetization_on'),
(1, 'Verifikasi Akademik', '2024-10-29', FALSE, 'check_circle_outline');

-- Timeline untuk KP user_id = 2 (kp_id = 2)
INSERT INTO kerja_praktek_timeline (kp_id, step_name, step_date, is_done, icon_name) VALUES
(2, 'Pendaftaran Judul', '2024-09-15', TRUE, 'assignment'),
(2, 'Verifikasi Keuangan', '2024-09-20', TRUE, 'monetization_on'),
(2, 'Verifikasi Akademik', '2024-09-25', TRUE, 'check_circle_outline'),
(2, 'Penyusunan Proposal', '2024-10-01', TRUE, 'description'),
(2, 'Seminar Proposal', '2024-10-15', FALSE, 'presentation');

-- ============================================
-- SEED: skripsi
-- ============================================
-- Hapus data lama jika ada
DELETE FROM skripsi_timeline;
DELETE FROM skripsi;

-- Skripsi untuk user_id = 1 (John Doe - Semester 7)
INSERT INTO skripsi (user_id, judul, tempat_penelitian, alamat_penelitian, pembimbing, status) VALUES
(1, 'Implementasi Sistem Akademik Berbasis Mobile dengan Flutter dan Backend Go', 'Fakultas Teknik Universitas Muhammadiyah Tangerang', 'Jalan Perintis Kemerdekaan I Cikokol Tangerang', 'Syepry Maulana Husain, S.Kom, MTI', 'DAFTAR JUDUL');

-- Skripsi untuk user_id = 3 (Bob Wilson - Semester 3, belum ada skripsi)
-- User semester 3 biasanya belum mengambil skripsi, jadi kita skip

-- ============================================
-- SEED: skripsi_timeline
-- ============================================
-- Timeline untuk Skripsi user_id = 1 (skripsi_id = 1)
INSERT INTO skripsi_timeline (skripsi_id, step_name, step_date, is_done, icon_name) VALUES
(1, 'Pendaftaran Judul', '2024-10-29', TRUE, 'assignment'),
(1, 'Verifikasi Keuangan', '2024-10-29', TRUE, 'monetization_on'),
(1, 'Verifikasi Akademik', '2024-10-29', FALSE, 'check_circle_outline');

