package main

import (
	"fmt"
	"os"
	"golang.org/x/crypto/bcrypt"
)

// Simple tool to generate bcrypt hash from password
// Usage: go run generate_password_hash.go [password]
// If no password provided, will use "password123" as default
func main() {
	password := "password123"
	
	if len(os.Args) > 1 {
		password = os.Args[1]
	}
	
	hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		fmt.Printf("Error generating hash: %v\n", err)
		os.Exit(1)
	}
	
	fmt.Println("=========================================")
	fmt.Println("Bcrypt Password Hash Generator")
	fmt.Println("=========================================")
	fmt.Printf("Password: %s\n", password)
	fmt.Printf("Hash:     %s\n", string(hash))
	fmt.Println("=========================================")
	fmt.Println()
	fmt.Println("Copy hash di atas untuk digunakan di seeder atau update database")
	fmt.Println()
}

