-- Migration Script untuk Tabel Kerja Praktek dan Skripsi
-- Menambahkan tabel: kerja_praktek, kerja_praktek_timeline, skripsi, skripsi_timeline

USE siakad_db;

-- ============================================
-- TABLE: kerja_praktek (Kerja Praktek)
-- ============================================
CREATE TABLE IF NOT EXISTS kerja_praktek (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    judul VARCHAR(500) NOT NULL,
    tempat_penelitian VARCHAR(255) NOT NULL,
    alamat_penelitian TEXT,
    pembimbing VARCHAR(255),
    status VARCHAR(50) DEFAULT 'DAFTAR JUDUL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- TABLE: kerja_praktek_timeline (Timeline Proses KP)
-- ============================================
CREATE TABLE IF NOT EXISTS kerja_praktek_timeline (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kp_id INT NOT NULL,
    step_name VARCHAR(100) NOT NULL,
    step_date DATE,
    is_done BOOLEAN DEFAULT FALSE,
    icon_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kp_id) REFERENCES kerja_praktek(id) ON DELETE CASCADE,
    INDEX idx_kp_id (kp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- TABLE: skripsi
-- ============================================
CREATE TABLE IF NOT EXISTS skripsi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    judul VARCHAR(500) NOT NULL,
    tempat_penelitian VARCHAR(255) NOT NULL,
    alamat_penelitian TEXT,
    pembimbing VARCHAR(255),
    status VARCHAR(50) DEFAULT 'DAFTAR JUDUL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- TABLE: skripsi_timeline (Timeline Proses Skripsi)
-- ============================================
CREATE TABLE IF NOT EXISTS skripsi_timeline (
    id INT AUTO_INCREMENT PRIMARY KEY,
    skripsi_id INT NOT NULL,
    step_name VARCHAR(100) NOT NULL,
    step_date DATE,
    is_done BOOLEAN DEFAULT FALSE,
    icon_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (skripsi_id) REFERENCES skripsi(id) ON DELETE CASCADE,
    INDEX idx_skripsi_id (skripsi_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

