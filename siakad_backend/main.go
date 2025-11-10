package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"

	"github.com/gorilla/mux"
	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
	"golang.org/x/crypto/bcrypt"
)

var db *sql.DB

func main() {
	// Load .env if exists
	godotenv.Load()

	// Database connection
	dbUser := getEnv("DB_USER", "root")
	dbPassword := getEnv("DB_PASSWORD", "")
	dbHost := getEnv("DB_HOST", "127.0.0.1")
	dbPort := getEnv("DB_PORT", "3306")
	dbName := getEnv("DB_NAME", "siakad_db")

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		dbUser, dbPassword, dbHost, dbPort, dbName)

	var err error
	db, err = sql.Open("mysql", dsn)
	if err != nil {
		log.Fatalf("Error connecting to database: %v", err)
	}
	defer db.Close()

	// Test connection
	if err = db.Ping(); err != nil {
		log.Fatalf("Error pinging database: %v", err)
	}

	fmt.Println("✓ Database connected successfully!")

	// Setup router
	r := mux.NewRouter()

	// CORS middleware
	r.Use(corsMiddleware)

	// Root handler untuk test
	r.HandleFunc("/", handleRoot).Methods("GET")
	r.HandleFunc("/api", handleAPIRoot).Methods("GET", "OPTIONS")

	// API routes
	api := r.PathPrefix("/api").Subrouter()

	// Auth routes
	api.HandleFunc("/auth/login", handleLogin).Methods("POST", "OPTIONS")
	api.HandleFunc("/auth/register", handleRegister).Methods("POST", "OPTIONS")
	api.HandleFunc("/auth/profile", handleProfile).Methods("GET", "OPTIONS")
	api.HandleFunc("/auth/change-password", handleChangePassword).Methods("PUT", "OPTIONS")
	api.HandleFunc("/auth/logout", handleLogout).Methods("POST", "OPTIONS")

	// Information routes
	api.HandleFunc("/information", handleGetInformation).Methods("GET", "OPTIONS")
	api.HandleFunc("/information/{id}", handleGetInformationByID).Methods("GET", "OPTIONS")

	// KRS routes (perlu implementasi query database)
	api.HandleFunc("/krs", handleGetKRS).Methods("GET", "OPTIONS")
	api.HandleFunc("/krs/{id}", handleGetKRSByID).Methods("GET", "OPTIONS")
	api.HandleFunc("/krs/semester/{semester}", handleGetKRSBySemester).Methods("GET", "OPTIONS")

	// KHS routes (perlu implementasi query database)
	api.HandleFunc("/khs/rekap", handleGetKHSRekap).Methods("GET", "OPTIONS")
	api.HandleFunc("/khs", handleGetKHS).Methods("GET", "OPTIONS")
	api.HandleFunc("/khs/semester/{semester}", handleGetKHSBySemester).Methods("GET", "OPTIONS")

	// Pembayaran routes (perlu implementasi query database)
	api.HandleFunc("/pembayaran", handleGetPembayaran).Methods("GET", "OPTIONS")
	api.HandleFunc("/pembayaran/semester/{semester}", handleGetPembayaranBySemester).Methods("GET", "OPTIONS")

	// Kerja Praktek routes
	api.HandleFunc("/kerja-praktek", handleGetKerjaPraktek).Methods("GET", "OPTIONS")

	// Skripsi routes
	api.HandleFunc("/skripsi", handleGetSkripsi).Methods("GET", "OPTIONS")

	// Start server
	port := getEnv("PORT", "8080")
	fmt.Printf("\n========================================\n")
	fmt.Printf("🚀 Server starting on port %s\n", port)
	fmt.Printf("========================================\n")
	fmt.Printf("API Base URL: http://localhost:%s/api\n", port)
	fmt.Printf("========================================\n\n")

	log.Fatal(http.ListenAndServe(":"+port, r))
}

// CORS middleware
func corsMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}

		next.ServeHTTP(w, r)
	})
}

// Helper functions
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

func jsonResponse(w http.ResponseWriter, status int, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(data)
}

func jsonError(w http.ResponseWriter, status int, message string) {
	jsonResponse(w, status, map[string]interface{}{
		"success": false,
		"message": message,
	})
}

// Helper function untuk extract user ID dari token
func getUserIDFromToken(r *http.Request) (int, error) {
	authHeader := r.Header.Get("Authorization")
	if authHeader == "" {
		log.Printf("DEBUG: Authorization header is empty")
		return 0, fmt.Errorf("Authorization header tidak ditemukan")
	}

	// Handle format "Bearer {token}"
	token := strings.TrimSpace(authHeader)
	if strings.HasPrefix(token, "Bearer ") {
		token = strings.TrimPrefix(token, "Bearer ")
		token = strings.TrimSpace(token)
	}

	log.Printf("DEBUG: Received token: %s", token)

	// Parse token format: token_{userID}_{email}
	var userID int
	n, err := fmt.Sscanf(token, "token_%d_", &userID)
	if err != nil || userID == 0 || n != 1 {
		log.Printf("DEBUG: Token parse failed - token: '%s', parsed count: %d, userID: %d, error: %v", token, n, userID, err)
		return 0, fmt.Errorf("Token tidak valid")
	}

	log.Printf("DEBUG: Successfully parsed userID: %d from token", userID)
	return userID, nil
}

// ============================================
// ROOT HANDLERS
// ============================================

func handleRoot(w http.ResponseWriter, r *http.Request) {
	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"message": "SIAKAD Backend API Server",
		"version": "1.0.0",
		"api_base": "/api",
		"endpoints": map[string]interface{}{
			"auth": map[string]string{
				"login":         "POST /api/auth/login",
				"register":      "POST /api/auth/register",
				"profile":       "GET /api/auth/profile",
				"change-password": "PUT /api/auth/change-password",
				"logout":        "POST /api/auth/logout",
			},
			"information": map[string]string{
				"list":   "GET /api/information",
				"detail": "GET /api/information/{id}",
			},
			"krs": map[string]string{
				"list":     "GET /api/krs",
				"detail":   "GET /api/krs/{id}",
				"semester": "GET /api/krs/semester/{semester}",
			},
			"khs": map[string]string{
				"rekap":   "GET /api/khs/rekap",
				"list":    "GET /api/khs",
				"semester": "GET /api/khs/semester/{semester}",
			},
			"pembayaran": map[string]string{
				"list":     "GET /api/pembayaran",
				"semester": "GET /api/pembayaran/semester/{semester}",
			},
		},
	})
}

func handleAPIRoot(w http.ResponseWriter, r *http.Request) {
	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"message": "SIAKAD API",
		"version": "1.0.0",
		"status":  "running",
		"endpoints": map[string]interface{}{
			"auth": map[string]string{
				"login":         "POST /api/auth/login",
				"register":      "POST /api/auth/register",
				"profile":       "GET /api/auth/profile",
				"change-password": "PUT /api/auth/change-password",
				"logout":        "POST /api/auth/logout",
			},
			"information": map[string]string{
				"list":   "GET /api/information",
				"detail": "GET /api/information/{id}",
			},
			"krs": map[string]string{
				"list":     "GET /api/krs",
				"detail":   "GET /api/krs/{id}",
				"semester": "GET /api/krs/semester/{semester}",
			},
			"khs": map[string]string{
				"rekap":   "GET /api/khs/rekap",
				"list":    "GET /api/khs",
				"semester": "GET /api/khs/semester/{semester}",
			},
			"pembayaran": map[string]string{
				"list":     "GET /api/pembayaran",
				"semester": "GET /api/pembayaran/semester/{semester}",
			},
		},
	})
}

// ============================================
// AUTH HANDLERS
// ============================================

// verifyPassword verifies password input against stored password hash
// Supports both bcrypt hash (starts with $2a$, $2b$, or $2y$) and plain text (for backward compatibility)
func verifyPassword(inputPassword, storedPassword string) bool {
	// Check if stored password is a bcrypt hash (starts with $2a$, $2b$, or $2y$)
	if strings.HasPrefix(storedPassword, "$2a$") || 
	   strings.HasPrefix(storedPassword, "$2b$") || 
	   strings.HasPrefix(storedPassword, "$2y$") {
		// Use bcrypt to verify
		err := bcrypt.CompareHashAndPassword([]byte(storedPassword), []byte(inputPassword))
		return err == nil
	}
	
	// Fallback to plain text comparison (for backward compatibility)
	return inputPassword == storedPassword
}

func handleLogin(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		log.Printf("DEBUG: Failed to decode request body: %v", err)
		jsonError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	log.Printf("DEBUG: Login attempt - Username: '%s', Password length: %d", req.Username, len(req.Password))

	// Query user from database
	var id int
	var name, email, nim, passwordHash string
	var phoneNS, programStudiNS, semesterNS sql.NullString

	query := `SELECT id, name, email, nim, phone, program_studi, semester, password 
	          FROM users 
	          WHERE (email = ? OR nim = ?) 
	          LIMIT 1`

	err := db.QueryRow(query, req.Username, req.Username).Scan(
		&id, &name, &email, &nim, &phoneNS, &programStudiNS, &semesterNS, &passwordHash)

	if err == sql.ErrNoRows {
		log.Printf("DEBUG: User not found - Username: '%s'", req.Username)
		jsonError(w, http.StatusUnauthorized, "Username atau password salah")
		return
	}
	if err != nil {
		log.Printf("DEBUG: Database error in handleLogin: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}

	log.Printf("DEBUG: User found - ID: %d, Email: %s, Password hash length: %d", id, email, len(passwordHash))
	log.Printf("DEBUG: Comparing passwords - Input: '%s' (len:%d) vs DB: '%s' (len:%d, is_bcrypt: %v)", 
		req.Password, len(req.Password), passwordHash, len(passwordHash), strings.HasPrefix(passwordHash, "$2"))

	// VERIFY PASSWORD - Support both bcrypt hash and plain text
	if !verifyPassword(req.Password, passwordHash) {
		log.Printf("DEBUG: Password mismatch! Input: '%s' != DB hash", req.Password)
		log.Printf("Login failed: Password mismatch for user %s (user_id: %d)", req.Username, id)
		jsonError(w, http.StatusUnauthorized, "Username atau password salah")
		return
	}
	
	log.Printf("Login successful: User %s (user_id: %d, email: %s)", req.Username, id, email)

	// Generate token (simple version, untuk production gunakan JWT)
	token := fmt.Sprintf("token_%d_%s", id, email)

	// Safely unwrap nullable strings
	phone := ""
	if phoneNS.Valid {
		phone = phoneNS.String
	}
	programStudi := ""
	if programStudiNS.Valid {
		programStudi = programStudiNS.String
	}
	semester := ""
	if semesterNS.Valid {
		semester = semesterNS.String
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"success": true,
		"message": "Login berhasil",
		"token":   token,
		"user": map[string]interface{}{
			"id":            id,
			"name":          name,
			"email":         email,
			"nim":           nim,
			"phone":         phone,
			"program_studi": programStudi,
			"semester":      semester,
		},
	})
}

func handleRegister(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Name     string `json:"name"`
		NIM      string `json:"nim"`
		Email    string `json:"email"`
		Password string `json:"password"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		jsonError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	// Check if email or NIM already exists
	var count int
	db.QueryRow("SELECT COUNT(*) FROM users WHERE email = ? OR nim = ?", req.Email, req.NIM).Scan(&count)
	if count > 0 {
		jsonError(w, http.StatusConflict, "Email atau NIM sudah terdaftar")
		return
	}

	// Hash password dengan bcrypt
	passwordHashBytes, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	if err != nil {
		log.Printf("Error hashing password: %v", err)
		jsonError(w, http.StatusInternalServerError, "Gagal memproses password")
		return
	}
	passwordHash := string(passwordHashBytes)

	// Insert user
	result, err := db.Exec(
		`INSERT INTO users (name, nim, email, password, program_studi, semester) 
		 VALUES (?, ?, ?, ?, ?, ?)`,
		req.Name, req.NIM, req.Email, passwordHash, "Teknik Informatika", "1")

	if err != nil {
		jsonError(w, http.StatusInternalServerError, "Gagal mendaftarkan user: "+err.Error())
		return
	}

	userID, _ := result.LastInsertId()

	jsonResponse(w, http.StatusCreated, map[string]interface{}{
		"success": true,
		"message": "Registrasi berhasil",
		"user_id": userID,
	})
}

func handleProfile(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	// Query user
	var id int
	var name, email, nim string
	var phoneNS, programStudiNS, semesterNS sql.NullString

	err = db.QueryRow(
		"SELECT id, name, email, nim, phone, program_studi, semester FROM users WHERE id = ?",
		userID,
	).Scan(&id, &name, &email, &nim, &phoneNS, &programStudiNS, &semesterNS)

	if err == sql.ErrNoRows {
		jsonError(w, http.StatusNotFound, "User tidak ditemukan")
		return
	}
	if err != nil {
		log.Printf("Database error in handleProfile: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}

	// unwrap nullable fields
	phone := ""
	if phoneNS.Valid {
		phone = phoneNS.String
	}
	programStudi := ""
	if programStudiNS.Valid {
		programStudi = programStudiNS.String
	}
	semester := ""
	if semesterNS.Valid {
		semester = semesterNS.String
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"user": map[string]interface{}{
			"id":            id,
			"name":          name,
			"nim":           nim,
			"email":         email,
			"phone":         phone,
			"program_studi": programStudi,
			"semester":      semester,
		},
	})
}

func handleChangePassword(w http.ResponseWriter, r *http.Request) {
	// Require auth
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	// Parse body
	var req struct {
		OldPassword string `json:"old_password"`
		NewPassword string `json:"new_password"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		jsonError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	if len(req.NewPassword) < 6 {
		jsonError(w, http.StatusBadRequest, "Password baru minimal 6 karakter")
		return
	}

	// Get current password hash
	var currentHash string
	err = db.QueryRow("SELECT password FROM users WHERE id = ? LIMIT 1", userID).Scan(&currentHash)
	if err == sql.ErrNoRows {
		jsonError(w, http.StatusNotFound, "User tidak ditemukan")
		return
	}
	if err != nil {
		log.Printf("Database error in handleChangePassword (select): %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}

	// Verify old password
	if !verifyPassword(req.OldPassword, currentHash) {
		jsonError(w, http.StatusUnauthorized, "Password lama tidak sesuai")
		return
	}

	// Hash new password
	newHashBytes, err := bcrypt.GenerateFromPassword([]byte(req.NewPassword), bcrypt.DefaultCost)
	if err != nil {
		log.Printf("Error hashing new password: %v", err)
		jsonError(w, http.StatusInternalServerError, "Gagal memproses password baru")
		return
	}
	newHash := string(newHashBytes)

	// Update DB
	_, err = db.Exec("UPDATE users SET password = ? WHERE id = ?", newHash, userID)
	if err != nil {
		log.Printf("Database error in handleChangePassword (update): %v", err)
		jsonError(w, http.StatusInternalServerError, "Gagal mengubah password")
		return
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"success": true,
		"message": "Password berhasil diubah",
	})
}

func handleLogout(w http.ResponseWriter, r *http.Request) {
	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"success": true,
		"message": "Logout berhasil",
	})
}

// ============================================
// INFORMATION HANDLERS
// ============================================

func handleGetInformation(w http.ResponseWriter, r *http.Request) {
	// Query sesuai struktur SQL actual: id, title, content, date, created_at
	rows, err := db.Query("SELECT id, title, content, date, created_at FROM information ORDER BY created_at DESC, id DESC")
	if err != nil {
		log.Printf("Database error in handleGetInformation: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error: "+err.Error())
		return
	}
	defer rows.Close()

	var informationList []map[string]interface{}
	for rows.Next() {
		var id int
		var title, content sql.NullString
		var date sql.NullString // date field
		var createdAt sql.NullTime // created_at timestamp

		err := rows.Scan(&id, &title, &content, &date, &createdAt)
		if err != nil {
			log.Printf("Error scanning row: %v", err)
			continue
		}

		info := map[string]interface{}{
			"id": id,
		}
		
		if title.Valid {
			info["title"] = title.String
		} else {
			info["title"] = ""
		}
		
		if content.Valid {
			info["content"] = content.String
		} else {
			info["content"] = ""
		}
		
		// Gunakan created_at jika ada, jika tidak gunakan date
		if createdAt.Valid {
			info["created_at"] = createdAt.Time.Format("2006-01-02T15:04:05Z")
		} else if date.Valid {
			// Jika created_at tidak ada, gunakan date sebagai created_at
			info["created_at"] = date.String
		} else {
			info["created_at"] = ""
		}
		
		// updated_at tidak ada di SQL, set empty
		info["updated_at"] = ""
		
		// category tidak ada di SQL, set empty
		info["category"] = ""

		informationList = append(informationList, info)
	}

	// Check for errors from iteration
	if err = rows.Err(); err != nil {
		log.Printf("Error iterating rows: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error: "+err.Error())
		return
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": informationList,
	})
}

func handleGetInformationByID(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	// Query sesuai struktur SQL actual: id, title, content, date, created_at
	var title, content sql.NullString
	var date sql.NullString
	var createdAt sql.NullTime

	err := db.QueryRow(
		"SELECT title, content, date, created_at FROM information WHERE id = ?",
		id,
	).Scan(&title, &content, &date, &createdAt)

	if err == sql.ErrNoRows {
		jsonError(w, http.StatusNotFound, "Informasi tidak ditemukan")
		return
	}
	if err != nil {
		log.Printf("Database error in handleGetInformationByID: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error: "+err.Error())
		return
	}

	info := map[string]interface{}{
		"id": id,
	}
	
	if title.Valid {
		info["title"] = title.String
	} else {
		info["title"] = ""
	}
	
	if content.Valid {
		info["content"] = content.String
	} else {
		info["content"] = ""
	}
	
	// category tidak ada di SQL
	info["category"] = ""
	
	// Gunakan created_at jika ada, jika tidak gunakan date
	if createdAt.Valid {
		info["created_at"] = createdAt.Time.Format("2006-01-02T15:04:05Z")
	} else if date.Valid {
		info["created_at"] = date.String
	} else {
		info["created_at"] = ""
	}
	
	// updated_at tidak ada di SQL
	info["updated_at"] = ""

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": info,
	})
}

// ============================================
// KRS HANDLERS
// ============================================

func handleGetKRS(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	// Query KRS berdasarkan user_id
	rows, err := db.Query(`
		SELECT k.id, k.semester, k.tahun_ajaran, k.status, k.total_sks
		FROM krs k
		WHERE k.user_id = ?
		ORDER BY k.semester DESC
	`, userID)
	if err != nil {
		log.Printf("Database error in handleGetKRS: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}
	defer rows.Close()

	log.Printf("DEBUG: Querying KRS for user_id: %d", userID)
	
	var krsList []map[string]interface{}
	var rowCount int
	for rows.Next() {
		rowCount++
		var krsID int
		var semester, tahunAjaran, status string
		var totalSKS int

		err := rows.Scan(&krsID, &semester, &tahunAjaran, &status, &totalSKS)
		if err != nil {
			log.Printf("Error scanning KRS row: %v", err)
			continue
		}
		
		log.Printf("DEBUG: Found KRS - ID: %d, Semester: %s", krsID, semester)

		// Query details untuk setiap KRS
		detailRows, err := db.Query(`
			SELECT id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan
			FROM krs_details
			WHERE krs_id = ?
			ORDER BY kode_mata_kuliah
		`, krsID)
		if err != nil {
			log.Printf("Error querying KRS details: %v", err)
			continue
		}

		var details []map[string]interface{}
		for detailRows.Next() {
			var detailID int
			var kodeMK, namaMK, dosen, jadwal, ruangan string
			var sks int

			err := detailRows.Scan(&detailID, &kodeMK, &namaMK, &sks, &dosen, &jadwal, &ruangan)
			if err != nil {
				log.Printf("Error scanning KRS detail row: %v", err)
				continue
			}

			details = append(details, map[string]interface{}{
				"id":              detailID,
				"kode_mata_kuliah": kodeMK,
				"nama_mata_kuliah": namaMK,
				"sks":             sks,
				"dosen":           dosen,
				"jadwal":          jadwal,
				"ruangan":         ruangan,
			})
		}
		detailRows.Close()

		krsList = append(krsList, map[string]interface{}{
			"id":         krsID,
			"semester":   semester,
			"tahun_ajaran": tahunAjaran,
			"status":     status,
			"total_sks":  totalSKS,
			"details":    details,
		})
	}
	
	log.Printf("DEBUG: Total KRS found: %d rows", rowCount)
	if rowCount == 0 {
		log.Printf("DEBUG: No KRS data found for user_id: %d. Make sure data is seeded in database.", userID)
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": krsList,
	})
}

func handleGetKRSByID(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	vars := mux.Vars(r)
	krsID := vars["id"]

	// Query KRS by ID dan verifikasi ownership
	var semester, tahunAjaran, status string
	var totalSKS int
	var krsUserID int

	err = db.QueryRow(`
		SELECT id, user_id, semester, tahun_ajaran, status, total_sks
		FROM krs
		WHERE id = ?
	`, krsID).Scan(&krsID, &krsUserID, &semester, &tahunAjaran, &status, &totalSKS)

	if err == sql.ErrNoRows {
		jsonError(w, http.StatusNotFound, "KRS tidak ditemukan")
		return
	}
	if err != nil {
		log.Printf("Database error: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}

	if krsUserID != userID {
		jsonError(w, http.StatusForbidden, "Anda tidak memiliki akses ke KRS ini")
		return
	}

	// Query details
	detailRows, err := db.Query(`
		SELECT id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan
		FROM krs_details
		WHERE krs_id = ?
		ORDER BY kode_mata_kuliah
	`, krsID)
	if err != nil {
		log.Printf("Error querying KRS details: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}
	defer detailRows.Close()

	var details []map[string]interface{}
	for detailRows.Next() {
		var detailID int
		var kodeMK, namaMK, dosen, jadwal, ruangan string
		var sks int

		err := detailRows.Scan(&detailID, &kodeMK, &namaMK, &sks, &dosen, &jadwal, &ruangan)
		if err != nil {
			log.Printf("Error scanning detail: %v", err)
			continue
		}

		details = append(details, map[string]interface{}{
			"id":              detailID,
			"kode_mata_kuliah": kodeMK,
			"nama_mata_kuliah": namaMK,
			"sks":             sks,
			"dosen":           dosen,
			"jadwal":          jadwal,
			"ruangan":         ruangan,
		})
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": map[string]interface{}{
			"id":         krsID,
			"semester":   semester,
			"tahun_ajaran": tahunAjaran,
			"status":     status,
			"total_sks":  totalSKS,
			"details":    details,
		},
	})
}

func handleGetKRSBySemester(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	vars := mux.Vars(r)
	semester := vars["semester"]

	// Query KRS by semester
	var krsID int
	var tahunAjaran, status string
	var totalSKS int

	err = db.QueryRow(`
		SELECT id, tahun_ajaran, status, total_sks
		FROM krs
		WHERE user_id = ? AND semester = ?
	`, userID, semester).Scan(&krsID, &tahunAjaran, &status, &totalSKS)

	if err == sql.ErrNoRows {
		jsonResponse(w, http.StatusOK, map[string]interface{}{
			"data": []interface{}{},
		})
		return
	}
	if err != nil {
		log.Printf("Database error: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}

	// Query details
	detailRows, err := db.Query(`
		SELECT id, kode_mata_kuliah, nama_mata_kuliah, sks, dosen, jadwal, ruangan
		FROM krs_details
		WHERE krs_id = ?
		ORDER BY kode_mata_kuliah
	`, krsID)
	if err != nil {
		log.Printf("Error querying details: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}
	defer detailRows.Close()

	var details []map[string]interface{}
	for detailRows.Next() {
		var detailID int
		var kodeMK, namaMK, dosen, jadwal, ruangan string
		var sks int

		err := detailRows.Scan(&detailID, &kodeMK, &namaMK, &sks, &dosen, &jadwal, &ruangan)
		if err != nil {
			continue
		}

		details = append(details, map[string]interface{}{
			"id":              detailID,
			"kode_mata_kuliah": kodeMK,
			"nama_mata_kuliah": namaMK,
			"sks":             sks,
			"dosen":           dosen,
			"jadwal":          jadwal,
			"ruangan":         ruangan,
		})
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": []map[string]interface{}{
			{
				"id":         krsID,
				"semester":   semester,
				"tahun_ajaran": tahunAjaran,
				"status":     status,
				"total_sks":  totalSKS,
				"details":    details,
			},
		},
	})
}

// ============================================
// KHS HANDLERS
// ============================================

func handleGetKHSRekap(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	// Query semua KHS untuk user
	rows, err := db.Query(`
		SELECT id, semester, ip, total_mata_kuliah
		FROM khs
		WHERE user_id = ?
		ORDER BY semester ASC
	`, userID)
	if err != nil {
		log.Printf("Database error in handleGetKHSRekap: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}
	defer rows.Close()

	log.Printf("DEBUG: Querying KHS for user_id: %d", userID)
	
	var semesterList []map[string]interface{}
	var totalMataKuliah int
	var totalBobot float64
	var totalSKS int
	var rowCount int

	for rows.Next() {
		rowCount++
		var khsID int
		var semester string
		var ip float64
		var jumlahMK int

		err := rows.Scan(&khsID, &semester, &ip, &jumlahMK)
		if err != nil {
			log.Printf("Error scanning KHS row: %v", err)
			continue
		}

		// Query details untuk setiap KHS
		detailRows, err := db.Query(`
			SELECT kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka
			FROM khs_details
			WHERE khs_id = ?
			ORDER BY kode_mata_kuliah
		`, khsID)
		if err != nil {
			log.Printf("Error querying KHS details: %v", err)
			continue
		}

		var details []map[string]interface{}
		for detailRows.Next() {
			var kodeMK, namaMK, nilai string
			var sks int
			var nilaiAngka float64

			err := detailRows.Scan(&kodeMK, &namaMK, &sks, &nilai, &nilaiAngka)
			if err != nil {
				log.Printf("Error scanning detail: %v", err)
				continue
			}

			totalSKS += sks
			totalBobot += nilaiAngka * float64(sks)

			details = append(details, map[string]interface{}{
				"kode_mata_kuliah": kodeMK,
				"nama_mata_kuliah": namaMK,
				"sks":             sks,
				"nilai":           nilai,
				"nilai_angka":     nilaiAngka,
			})
		}
		detailRows.Close()

		totalMataKuliah += jumlahMK

		semesterList = append(semesterList, map[string]interface{}{
			"id":               khsID,
			"semester":        semester,
			"ip":              ip,
			"total_mata_kuliah": jumlahMK,
			"details":         details,
		})
	}
	
	log.Printf("DEBUG: Total KHS found: %d rows", rowCount)
	if rowCount == 0 {
		log.Printf("DEBUG: No KHS data found for user_id: %d. Make sure data is seeded in database.", userID)
	}

	// Hitung IPK
	var ipk float64
	if totalSKS > 0 {
		ipk = totalBobot / float64(totalSKS)
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": map[string]interface{}{
			"ipk":              ipk,
			"total_mata_kuliah": totalMataKuliah,
			"semester_list":    semesterList,
		},
	})
}

func handleGetKHS(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	// Query semua KHS untuk user
	rows, err := db.Query(`
		SELECT id, semester, ip, total_mata_kuliah
		FROM khs
		WHERE user_id = ?
		ORDER BY semester DESC
	`, userID)
	if err != nil {
		log.Printf("Database error in handleGetKHS: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}
	defer rows.Close()

	var khsList []map[string]interface{}
	for rows.Next() {
		var khsID int
		var semester string
		var ip float64
		var jumlahMK int

		err := rows.Scan(&khsID, &semester, &ip, &jumlahMK)
		if err != nil {
			log.Printf("Error scanning row: %v", err)
			continue
		}

		// Query details
		detailRows, err := db.Query(`
			SELECT id, kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka
			FROM khs_details
			WHERE khs_id = ?
			ORDER BY kode_mata_kuliah
		`, khsID)
		if err != nil {
			log.Printf("Error querying details: %v", err)
			continue
		}

		var details []map[string]interface{}
		for detailRows.Next() {
			var detailID int
			var kodeMK, namaMK, nilai string
			var sks int
			var nilaiAngka float64

			err := detailRows.Scan(&detailID, &kodeMK, &namaMK, &sks, &nilai, &nilaiAngka)
			if err != nil {
				log.Printf("Error scanning detail: %v", err)
				continue
			}

			details = append(details, map[string]interface{}{
				"id":              detailID,
				"kode_mata_kuliah": kodeMK,
				"nama_mata_kuliah": namaMK,
				"sks":             sks,
				"nilai":           nilai,
				"nilai_angka":     nilaiAngka,
			})
		}
		detailRows.Close()

		khsList = append(khsList, map[string]interface{}{
			"id":               khsID,
			"semester":        semester,
			"ip":              ip,
			"total_mata_kuliah": jumlahMK,
			"details":         details,
		})
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": khsList,
	})
}

func handleGetKHSBySemester(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	vars := mux.Vars(r)
	semester := vars["semester"]

	// Query KHS by semester
	var khsID int
	var ip float64
	var jumlahMK int

	err = db.QueryRow(`
		SELECT id, ip, total_mata_kuliah
		FROM khs
		WHERE user_id = ? AND semester = ?
	`, userID, semester).Scan(&khsID, &ip, &jumlahMK)

	if err == sql.ErrNoRows {
		jsonResponse(w, http.StatusOK, map[string]interface{}{
			"data": []interface{}{},
		})
		return
	}
	if err != nil {
		log.Printf("Database error: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}

	// Query details
	detailRows, err := db.Query(`
		SELECT id, kode_mata_kuliah, nama_mata_kuliah, sks, nilai, nilai_angka
		FROM khs_details
		WHERE khs_id = ?
		ORDER BY kode_mata_kuliah
	`, khsID)
	if err != nil {
		log.Printf("Error querying details: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}
	defer detailRows.Close()

	var details []map[string]interface{}
	for detailRows.Next() {
		var detailID int
		var kodeMK, namaMK, nilai string
		var sks int
		var nilaiAngka float64

		err := detailRows.Scan(&detailID, &kodeMK, &namaMK, &sks, &nilai, &nilaiAngka)
		if err != nil {
			log.Printf("Error scanning detail: %v", err)
			continue
		}

		details = append(details, map[string]interface{}{
			"id":              detailID,
			"kode_mata_kuliah": kodeMK,
			"nama_mata_kuliah": namaMK,
			"sks":             sks,
			"nilai":           nilai,
			"nilai_angka":     nilaiAngka,
		})
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": []map[string]interface{}{
			{
				"id":               khsID,
				"semester":        semester,
				"ip":              ip,
				"total_mata_kuliah": jumlahMK,
				"details":         details,
			},
		},
	})
}

// ============================================
// PEMBAYARAN HANDLERS
// ============================================

func handleGetPembayaran(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	// Query semua pembayaran untuk user
	rows, err := db.Query(`
		SELECT id, semester, total_amount, paid_amount, remaining_amount, status
		FROM pembayaran
		WHERE user_id = ?
		ORDER BY semester DESC
	`, userID)
	if err != nil {
		log.Printf("Database error in handleGetPembayaran: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}
	defer rows.Close()

	log.Printf("DEBUG: Querying Pembayaran for user_id: %d", userID)
	
	var pembayaranList []map[string]interface{}
	var rowCount int
	for rows.Next() {
		rowCount++
		var pembayaranID int
		var semester, status string
		var totalAmount, paidAmount, remainingAmount float64

		err := rows.Scan(&pembayaranID, &semester, &totalAmount, &paidAmount, &remainingAmount, &status)
		if err != nil {
			log.Printf("Error scanning row: %v", err)
			continue
		}

		// Query details
		detailRows, err := db.Query(`
			SELECT id, komponen, total, paid, remaining
			FROM pembayaran_details
			WHERE pembayaran_id = ?
			ORDER BY komponen
		`, pembayaranID)
		if err != nil {
			log.Printf("Error querying details: %v", err)
			continue
		}

		var details []map[string]interface{}
		for detailRows.Next() {
			var detailID int
			var komponen string
			var total, paid, remaining float64

			err := detailRows.Scan(&detailID, &komponen, &total, &paid, &remaining)
			if err != nil {
				log.Printf("Error scanning detail: %v", err)
				continue
			}

			details = append(details, map[string]interface{}{
				"id":        detailID,
				"komponen":  komponen,
				"total":     total,
				"paid":      paid,
				"remaining": remaining,
			})
		}
		detailRows.Close()

		pembayaranList = append(pembayaranList, map[string]interface{}{
			"id":              pembayaranID,
			"semester":       semester,
			"total_amount":   totalAmount,
			"paid_amount":    paidAmount,
			"remaining_amount": remainingAmount,
			"status":         status,
			"details":        details,
		})
	}
	
	log.Printf("DEBUG: Total Pembayaran found: %d rows", rowCount)
	if rowCount == 0 {
		log.Printf("DEBUG: No Pembayaran data found for user_id: %d. Make sure data is seeded in database.", userID)
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": pembayaranList,
	})
}

func handleGetPembayaranBySemester(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	vars := mux.Vars(r)
	semester := vars["semester"]

	// Query pembayaran by semester
	var pembayaranID int
	var totalAmount, paidAmount, remainingAmount float64
	var status string

	err = db.QueryRow(`
		SELECT id, total_amount, paid_amount, remaining_amount, status
		FROM pembayaran
		WHERE user_id = ? AND semester = ?
	`, userID, semester).Scan(&pembayaranID, &totalAmount, &paidAmount, &remainingAmount, &status)

	if err == sql.ErrNoRows {
		jsonResponse(w, http.StatusOK, map[string]interface{}{
			"data": []interface{}{},
		})
		return
	}
	if err != nil {
		log.Printf("Database error: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}

	// Query details
	detailRows, err := db.Query(`
		SELECT id, komponen, total, paid, remaining
		FROM pembayaran_details
		WHERE pembayaran_id = ?
		ORDER BY komponen
	`, pembayaranID)
	if err != nil {
		log.Printf("Error querying details: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}
	defer detailRows.Close()

	var details []map[string]interface{}
	for detailRows.Next() {
		var detailID int
		var komponen string
		var total, paid, remaining float64

		err := detailRows.Scan(&detailID, &komponen, &total, &paid, &remaining)
		if err != nil {
			log.Printf("Error scanning detail: %v", err)
			continue
		}

		details = append(details, map[string]interface{}{
			"id":        detailID,
			"komponen":  komponen,
			"total":     total,
			"paid":      paid,
			"remaining": remaining,
		})
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": []map[string]interface{}{
			{
				"id":              pembayaranID,
				"semester":       semester,
				"total_amount":   totalAmount,
				"paid_amount":    paidAmount,
				"remaining_amount": remainingAmount,
				"status":         status,
				"details":        details,
			},
		},
	})
}

// ============================================
// KERJA PRAKTEK HANDLERS
// ============================================

func handleGetKerjaPraktek(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	log.Printf("DEBUG: Querying Kerja Praktek for user_id: %d", userID)

	// Query KP untuk user
	var kpID int
	var judul, tempatPenelitian, alamatPenelitian, pembimbing, status string

	err = db.QueryRow(`
		SELECT id, judul, tempat_penelitian, alamat_penelitian, pembimbing, status
		FROM kerja_praktek
		WHERE user_id = ?
		LIMIT 1
	`, userID).Scan(&kpID, &judul, &tempatPenelitian, &alamatPenelitian, &pembimbing, &status)

	if err == sql.ErrNoRows {
		log.Printf("DEBUG: No KP data found for user_id: %d", userID)
		// Return empty data instead of error
		jsonResponse(w, http.StatusOK, map[string]interface{}{
			"data": nil,
		})
		return
	}
	if err != nil {
		log.Printf("DEBUG: Database error in handleGetKerjaPraktek: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}

	log.Printf("DEBUG: Found KP - ID: %d, Status: %s", kpID, status)

	// Query timeline
	timelineRows, err := db.Query(`
		SELECT step_name, step_date, is_done, icon_name
		FROM kerja_praktek_timeline
		WHERE kp_id = ?
		ORDER BY id ASC
	`, kpID)
	if err != nil {
		log.Printf("Error querying KP timeline: %v", err)
	} else {
		defer timelineRows.Close()
	}

	var timeline []map[string]interface{}
	if timelineRows != nil {
		for timelineRows.Next() {
			var stepName, iconName string
			var stepDate sql.NullTime
			var isDone bool

			err := timelineRows.Scan(&stepName, &stepDate, &isDone, &iconName)
			if err != nil {
				log.Printf("Error scanning timeline: %v", err)
				continue
			}

			dateStr := ""
			if stepDate.Valid {
				dateStr = stepDate.Time.Format("02-01-2006")
			}

			timeline = append(timeline, map[string]interface{}{
				"step_name": stepName,
				"step_date": dateStr,
				"is_done":   isDone,
				"icon_name": iconName,
			})
		}
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": map[string]interface{}{
			"id":                kpID,
			"judul":             judul,
			"tempat_penelitian": tempatPenelitian,
			"alamat_penelitian": alamatPenelitian,
			"pembimbing":        pembimbing,
			"status":            status,
			"timeline":          timeline,
		},
	})
}

// ============================================
// SKRIPSI HANDLERS
// ============================================

func handleGetSkripsi(w http.ResponseWriter, r *http.Request) {
	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		jsonError(w, http.StatusUnauthorized, err.Error())
		return
	}

	log.Printf("DEBUG: Querying Skripsi for user_id: %d", userID)

	// Query Skripsi untuk user
	var skripsiID int
	var judul, tempatPenelitian, alamatPenelitian, pembimbing, status string

	err = db.QueryRow(`
		SELECT id, judul, tempat_penelitian, alamat_penelitian, pembimbing, status
		FROM skripsi
		WHERE user_id = ?
		LIMIT 1
	`, userID).Scan(&skripsiID, &judul, &tempatPenelitian, &alamatPenelitian, &pembimbing, &status)

	if err == sql.ErrNoRows {
		log.Printf("DEBUG: No Skripsi data found for user_id: %d", userID)
		// Return empty data instead of error
		jsonResponse(w, http.StatusOK, map[string]interface{}{
			"data": nil,
		})
		return
	}
	if err != nil {
		log.Printf("DEBUG: Database error in handleGetSkripsi: %v", err)
		jsonError(w, http.StatusInternalServerError, "Database error")
		return
	}

	log.Printf("DEBUG: Found Skripsi - ID: %d, Status: %s", skripsiID, status)

	// Query timeline
	timelineRows, err := db.Query(`
		SELECT step_name, step_date, is_done, icon_name
		FROM skripsi_timeline
		WHERE skripsi_id = ?
		ORDER BY id ASC
	`, skripsiID)
	if err != nil {
		log.Printf("Error querying Skripsi timeline: %v", err)
	} else {
		defer timelineRows.Close()
	}

	var timeline []map[string]interface{}
	if timelineRows != nil {
		for timelineRows.Next() {
			var stepName, iconName string
			var stepDate sql.NullTime
			var isDone bool

			err := timelineRows.Scan(&stepName, &stepDate, &isDone, &iconName)
			if err != nil {
				log.Printf("Error scanning timeline: %v", err)
				continue
			}

			dateStr := ""
			if stepDate.Valid {
				dateStr = stepDate.Time.Format("02-01-2006")
			}

			timeline = append(timeline, map[string]interface{}{
				"step_name": stepName,
				"step_date": dateStr,
				"is_done":   isDone,
				"icon_name": iconName,
			})
		}
	}

	jsonResponse(w, http.StatusOK, map[string]interface{}{
		"data": map[string]interface{}{
			"id":                skripsiID,
			"judul":             judul,
			"tempat_penelitian": tempatPenelitian,
			"alamat_penelitian": alamatPenelitian,
			"pembimbing":        pembimbing,
			"status":            status,
			"timeline":          timeline,
		},
	})
}

