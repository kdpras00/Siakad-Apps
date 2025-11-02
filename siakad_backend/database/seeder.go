package main

import (
	"database/sql"
	"fmt"
	"io"
	"log"
	"os"
	"strings"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
)

func main() {
	// Load environment variables (optional, bisa pakai default)
	envFiles := []string{".env", "../.env", "../../.env"}
	for _, envFile := range envFiles {
		if err := godotenv.Load(envFile); err == nil {
			log.Printf("Loaded .env from: %s\n", envFile)
			break
		}
	}

	// Database configuration dengan default values
	dbUser := getEnv("DB_USER", "root")
	dbPassword := getEnv("DB_PASSWORD", "")
	dbHost := getEnv("DB_HOST", "127.0.0.1")
	dbPort := getEnv("DB_PORT", "3306")
	dbName := getEnv("DB_NAME", "siakad_db")

	// Build DSN (Data Source Name)
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		dbUser, dbPassword, dbHost, dbPort, dbName)

	fmt.Println("========================================")
	fmt.Println("Database Seeder - SIAKAD")
	fmt.Println("========================================")
	fmt.Printf("Connecting to: %s@%s:%s/%s\n", dbUser, dbHost, dbPort, dbName)
	fmt.Println()

	// Connect to database
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		log.Fatalf("Error connecting to database: %v", err)
	}
	defer db.Close()

	// Test connection
	err = db.Ping()
	if err != nil {
		log.Fatalf("Error pinging database: %v", err)
	}

	fmt.Println("✓ Connected to database successfully!")
	fmt.Println()

	// Read seeder file
	seederFile := "seeder.sql"
	if len(os.Args) > 1 {
		seederFile = os.Args[1]
	} else {
		// Cari file seeder.sql di current directory atau parent
		possiblePaths := []string{
			"seeder.sql",
			"database/seeder.sql",
			"../database/seeder.sql",
			"../../database/seeder.sql",
		}
		for _, path := range possiblePaths {
			if _, err := os.Stat(path); err == nil {
				seederFile = path
				break
			}
		}
	}

	fmt.Printf("Reading seeder file: %s\n", seederFile)
	file, err := os.Open(seederFile)
	if err != nil {
		log.Fatalf("Error opening seeder file: %v", err)
	}
	defer file.Close()
	
	sqlContent, err := io.ReadAll(file)
	if err != nil {
		log.Fatalf("Error reading seeder file: %v", err)
	}

	fmt.Println("✓ Seeder file read successfully!")
	fmt.Println()

	// Ask for confirmation
	fmt.Println("⚠️  WARNING: This will insert data into the database!")
	fmt.Println("   Existing data might be duplicated if IDs conflict.")
	fmt.Println()
	fmt.Print("Do you want to continue? (yes/no): ")
	
	var confirm string
	fmt.Scanln(&confirm)
	
	if strings.ToLower(confirm) != "yes" && strings.ToLower(confirm) != "y" {
		fmt.Println("Seeder cancelled by user.")
		return
	}

	fmt.Println()
	fmt.Println("Executing seeder...")
	fmt.Println("----------------------------------------")

	err = runSeeder(db, string(sqlContent))
	if err != nil {
		log.Fatalf("Seeder failed: %v", err)
	}

	fmt.Println("----------------------------------------")
	fmt.Println()
	fmt.Println("========================================")
	fmt.Println("✓ Seeder completed successfully!")
	fmt.Println("========================================")
	fmt.Println()
	
	// Verify inserted data
	fmt.Println("Verifying inserted data...")
	verifyData(db)
	fmt.Println()
	
	fmt.Println("Seeder finished! You can now test the API with:")
	fmt.Println("  Email: john.doe@example.com")
	fmt.Println("  Password: password123")
	fmt.Println()
}

// runSeeder executes SQL statements from seeder file
func runSeeder(db *sql.DB, sqlContent string) error {
	// Remove comments and empty lines, split by semicolon
	statements := parseSQL(string(sqlContent))

	// Execute each statement
	successCount := 0
	errorCount := 0
	
	for i, stmt := range statements {
		stmt = strings.TrimSpace(stmt)
		if stmt == "" {
			continue
		}

		// Skip USE statements (not needed when connected to specific DB)
		if strings.HasPrefix(strings.ToUpper(stmt), "USE ") {
			continue
		}

		// Skip DELETE statements if commented out (for safety)
		if strings.HasPrefix(strings.ToUpper(stmt), "DELETE FROM") {
			fmt.Printf("⚠ Skipping DELETE statement (for safety): %s\n", stmt[:min(50, len(stmt))])
			continue
		}

		// Show progress for INSERT statements
		if strings.HasPrefix(strings.ToUpper(stmt), "INSERT INTO") {
			tableName := extractTableName(stmt)
			fmt.Printf("Inserting into %s...", tableName)
		} else {
			fmt.Printf("Executing statement %d...", i+1)
		}

		_, err := db.Exec(stmt)
		if err != nil {
			// Check if error is because of duplicate entry (might be okay if data already exists)
			if strings.Contains(err.Error(), "Duplicate entry") {
				fmt.Printf(" ⚠ Warning: Duplicate entry (data might already exist)\n")
				errorCount++
				continue
			}
			
			// Foreign key constraint error (might be okay if foreign key doesn't exist yet)
			if strings.Contains(err.Error(), "foreign key constraint") {
				fmt.Printf(" ⚠ Warning: Foreign key constraint (might need to run migration first)\n")
				errorCount++
				continue
			}
			
			fmt.Printf(" ❌ Error: %v\n", err)
			errorCount++
			return fmt.Errorf("error executing statement: %v\nStatement: %s", err, stmt[:min(100, len(stmt))])
		}

		fmt.Printf(" ✓ Success\n")
		successCount++
	}

	fmt.Printf("\nSummary: %d successful, %d warnings/errors\n", successCount, errorCount)
	return nil
}

// extractTableName extracts table name from INSERT statement
func extractTableName(stmt string) string {
	stmt = strings.ToUpper(stmt)
	if strings.Contains(stmt, "INSERT INTO") {
		parts := strings.Fields(stmt)
		for i, part := range parts {
			if part == "INTO" && i+1 < len(parts) {
				return strings.ToLower(parts[i+1])
			}
		}
	}
	return "table"
}

// parseSQL splits SQL content into individual statements
func parseSQL(content string) []string {
	// Split by semicolon, but handle semicolons in strings
	lines := strings.Split(content, "\n")
	var cleanLines []string

	inComment := false
	for _, line := range lines {
		line = strings.TrimSpace(line)
		
		// Skip empty lines
		if line == "" {
			continue
		}

		// Handle single-line comments
		if strings.HasPrefix(line, "--") {
			continue
		}

		// Handle multi-line comments
		if strings.Contains(line, "/*") {
			inComment = true
		}
		if strings.Contains(line, "*/") {
			inComment = false
			continue
		}
		if inComment {
			continue
		}

		cleanLines = append(cleanLines, line)
	}

	// Join lines and split by semicolon
	joined := strings.Join(cleanLines, " ")
	
	var statements []string
	current := ""
	inString := false
	stringChar := byte(0)
	
	for i := 0; i < len(joined); i++ {
		char := joined[i]
		
		// Track if we're inside a string
		if (char == '\'' || char == '"') && (i == 0 || joined[i-1] != '\\') {
			if !inString {
				inString = true
				stringChar = char
			} else if char == stringChar {
				inString = false
				stringChar = 0
			}
		}
		
		current += string(char)
		
		// If semicolon and not in string, end statement
		if char == ';' && !inString {
			if strings.TrimSpace(current) != "" {
				statements = append(statements, strings.TrimSpace(current))
			}
			current = ""
		}
	}
	
	// Add last statement if exists
	if strings.TrimSpace(current) != "" {
		statements = append(statements, strings.TrimSpace(current))
	}

	return statements
}

// verifyData checks if data was inserted correctly
func verifyData(db *sql.DB) {
	tables := map[string]string{
		"users":                "SELECT COUNT(*) FROM users",
		"information":          "SELECT COUNT(*) FROM information",
		"krs":                  "SELECT COUNT(*) FROM krs",
		"krs_details":          "SELECT COUNT(*) FROM krs_details",
		"khs":                  "SELECT COUNT(*) FROM khs",
		"khs_details":          "SELECT COUNT(*) FROM khs_details",
		"pembayaran":           "SELECT COUNT(*) FROM pembayaran",
		"pembayaran_details":   "SELECT COUNT(*) FROM pembayaran_details",
	}

	for tableName, query := range tables {
		var count int
		err := db.QueryRow(query).Scan(&count)
		if err != nil {
			fmt.Printf("  ⚠ %s: Error checking count (%v)\n", tableName, err)
			continue
		}
		fmt.Printf("  ✓ %s: %d records\n", tableName, count)
	}
}

// min returns the minimum of two integers
func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

// getEnv gets environment variable or returns default value
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

