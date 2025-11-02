-- Migration Script untuk SIAKAD Database
-- Menambahkan tabel: krs, krs_details, khs, khs_details, pembayaran, pembayaran_details

USE siakad_db;

-- ============================================
-- TABLE: krs (Kartu Rencana Studi)
-- ============================================
CREATE TABLE IF NOT EXISTS krs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    semester VARCHAR(50) NOT NULL,
    tahun_ajaran VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'Aktif',
    total_sks INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_semester (user_id, semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- TABLE: krs_details (Detail Mata Kuliah KRS)
-- ============================================
CREATE TABLE IF NOT EXISTS krs_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    krs_id INT NOT NULL,
    kode_mata_kuliah VARCHAR(20) NOT NULL,
    nama_mata_kuliah VARCHAR(255) NOT NULL,
    sks INT NOT NULL DEFAULT 0,
    dosen VARCHAR(255),
    jadwal VARCHAR(100),
    ruangan VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (krs_id) REFERENCES krs(id) ON DELETE CASCADE,
    INDEX idx_krs_id (krs_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- TABLE: khs (Kartu Hasil Studi)
-- ============================================
CREATE TABLE IF NOT EXISTS khs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    semester VARCHAR(50) NOT NULL,
    ip DECIMAL(3,2) DEFAULT 0.00,
    total_mata_kuliah INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_semester (user_id, semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- TABLE: khs_details (Detail Nilai Mata Kuliah)
-- ============================================
CREATE TABLE IF NOT EXISTS khs_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    khs_id INT NOT NULL,
    kode_mata_kuliah VARCHAR(20) NOT NULL,
    nama_mata_kuliah VARCHAR(255) NOT NULL,
    sks INT NOT NULL DEFAULT 0,
    nilai VARCHAR(2),
    nilai_angka DECIMAL(3,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (khs_id) REFERENCES khs(id) ON DELETE CASCADE,
    INDEX idx_khs_id (khs_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- TABLE: pembayaran (Pembayaran per Semester)
-- ============================================
CREATE TABLE IF NOT EXISTS pembayaran (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    semester VARCHAR(50) NOT NULL,
    total_amount DECIMAL(15,2) DEFAULT 0.00,
    paid_amount DECIMAL(15,2) DEFAULT 0.00,
    remaining_amount DECIMAL(15,2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'Belum Lunas',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_semester (user_id, semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- TABLE: pembayaran_details (Detail Komponen Pembayaran)
-- ============================================
CREATE TABLE IF NOT EXISTS pembayaran_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pembayaran_id INT NOT NULL,
    komponen VARCHAR(100) NOT NULL,
    total DECIMAL(15,2) DEFAULT 0.00,
    paid DECIMAL(15,2) DEFAULT 0.00,
    remaining DECIMAL(15,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pembayaran_id) REFERENCES pembayaran(id) ON DELETE CASCADE,
    INDEX idx_pembayaran_id (pembayaran_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- INSERT SAMPLE DATA (Optional)
-- ============================================
-- Contoh data untuk testing, sesuaikan dengan user_id yang ada

-- Sample KRS untuk user_id = 1
-- INSERT INTO krs (user_id, semester, tahun_ajaran, status, total_sks) 
-- VALUES (1, 'Semester 7', '2024/2025', 'Aktif', 22);

-- INSERT INTO krs_details (krs_id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan)
-- VALUES 
-- (1, 'TI701', 'Mobile Programming', 3, 'Syepry Maulana Husain, S.Kom, MTI', 'Senin, 08:30 - 10:00 WIB', 'Ruang A12.7'),
-- (1, 'TI702', 'Analisis dan Perancangan Sistem Informasi', 3, 'Yani Sugiani, M.Kom', 'Senin, 08:30 - 10:00 WIB', 'Ruang A12.7');

-- Sample KHS untuk user_id = 1
-- INSERT INTO khs (user_id, semester, ip, total_mata_kuliah) 
-- VALUES (1, 'Semester 1', 3.80, 15);

-- INSERT INTO khs_details (khs_id, kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka)
-- VALUES 
-- (1, 'TI101', 'Algoritma Pemrograman', 3, 'A', 4.0),
-- (1, 'TI102', 'Kalkulus 1', 3, 'B', 3.0);

-- Sample Pembayaran untuk user_id = 1
-- INSERT INTO pembayaran (user_id, semester, total_amount, paid_amount, remaining_amount, status)
-- VALUES (1, 'Semester 1', 10000000.00, 10000000.00, 0.00, 'Lunas');

-- INSERT INTO pembayaran_details (pembayaran_id, komponen, total, paid, remaining)
-- VALUES 
-- (1, 'Uang Bangunan', 3000000.00, 3000000.00, 0.00),
-- (1, 'Biaya SKS', 3000000.00, 3000000.00, 0.00);

