package database

import (
	"os"
)

// DatabaseConfig holds database configuration
type DatabaseConfig struct {
	User     string
	Password string
	Host     string
	Port     string
	Name     string
}

// GetConfig returns database configuration from environment or defaults
func GetConfig() DatabaseConfig {
	return DatabaseConfig{
		User:     getEnv("DB_USER", "root"),
		Password: getEnv("DB_PASSWORD", ""),
		Host:     getEnv("DB_HOST", "127.0.0.1"),
		Port:     getEnv("DB_PORT", "3306"),
		Name:     getEnv("DB_NAME", "siakad_db"),
	}
}

// getEnv gets environment variable or returns default value
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

