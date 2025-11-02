-- Rollback Script untuk menghapus tabel yang dibuat migration
-- HATI-HATI: Script ini akan menghapus semua data di tabel terkait!

USE siakad_db;

-- Hapus tabel dengan urutan yang benar (tabel detail dulu, baru parent)
DROP TABLE IF EXISTS pembayaran_details;
DROP TABLE IF EXISTS pembayaran;
DROP TABLE IF EXISTS khs_details;
DROP TABLE IF EXISTS khs;
DROP TABLE IF EXISTS krs_details;
DROP TABLE IF EXISTS krs;

-- Setelah rollback, database kembali hanya memiliki:
-- - users
-- - information

