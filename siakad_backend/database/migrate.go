package main

import (
	"database/sql"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strings"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
)

func main() {
	// Load environment variables (optional, bisa pakai default)
	// Cari .env file di current directory atau parent directory
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
	fmt.Println("Database Migration - SIAKAD")
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

	// Read migration file
	migrationFile := "migration.sql"
	if len(os.Args) > 1 {
		migrationFile = os.Args[1]
	} else {
		// Cari file migration.sql di current directory atau parent
		possiblePaths := []string{
			"migration.sql",
			"database/migration.sql",
			"../database/migration.sql",
			"../../database/migration.sql",
		}
		for _, path := range possiblePaths {
			if _, err := os.Stat(path); err == nil {
				migrationFile = path
				break
			}
		}
	}

	fmt.Printf("Reading migration file: %s\n", migrationFile)
	sqlContent, err := ioutil.ReadFile(migrationFile)
	if err != nil {
		log.Fatalf("Error reading migration file: %v", err)
	}

	fmt.Println("✓ Migration file read successfully!")
	fmt.Println()

	// Execute migration
	fmt.Println("Executing migration...")
	fmt.Println("----------------------------------------")

	err = runMigration(db, string(sqlContent))
	if err != nil {
		log.Fatalf("Migration failed: %v", err)
	}

	fmt.Println("----------------------------------------")
	fmt.Println()
	fmt.Println("========================================")
	fmt.Println("✓ Migration completed successfully!")
	fmt.Println("========================================")
	fmt.Println()
	fmt.Println("Tables created:")
	fmt.Println("  - krs")
	fmt.Println("  - krs_details")
	fmt.Println("  - khs")
	fmt.Println("  - khs_details")
	fmt.Println("  - pembayaran")
	fmt.Println("  - pembayaran_details")
	fmt.Println()
}

// runMigration executes SQL statements from migration file
func runMigration(db *sql.DB, sqlContent string) error {
	// Remove comments and empty lines, split by semicolon
	statements := parseSQL(string(sqlContent))

	// Execute each statement
	for i, stmt := range statements {
		stmt = strings.TrimSpace(stmt)
		if stmt == "" {
			continue
		}

		// Skip USE statements (not needed when connected to specific DB)
		if strings.HasPrefix(strings.ToUpper(stmt), "USE ") {
			continue
		}

		fmt.Printf("Executing statement %d...\n", i+1)

		_, err := db.Exec(stmt)
		if err != nil {
			// Check if error is because table already exists (not critical)
			if strings.Contains(err.Error(), "already exists") {
				fmt.Printf("  ⚠ Warning: %v\n", err)
				continue
			}
			return fmt.Errorf("error executing statement %d: %v\nStatement: %s", i+1, err, stmt)
		}

		fmt.Printf("  ✓ Statement %d executed successfully\n", i+1)
	}

	return nil
}

// parseSQL splits SQL content into individual statements
func parseSQL(content string) []string {
	// Remove comments
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

		// Handle multi-line comments (basic handling)
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
	
	// Split by semicolon, but be careful with semicolons inside strings
	var statements []string
	current := ""
	
	for _, char := range joined {
		if char == ';' {
			if current != "" {
				statements = append(statements, strings.TrimSpace(current))
				current = ""
			}
		} else {
			current += string(char)
		}
	}
	
	// Add last statement if exists
	if strings.TrimSpace(current) != "" {
		statements = append(statements, strings.TrimSpace(current))
	}

	return statements
}

// getEnv gets environment variable or returns default value
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

