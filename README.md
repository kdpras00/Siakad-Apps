# SIAKAD Apps

A Student Information System application with Flutter frontend and Go backend.

## Backend Setup (siakad_backend)

### Prerequisites
- Go 1.19 or higher
- MySQL database

### MySQL Database Setup

1. Install MySQL server on your system
2. Create a new database:
   ```sql
   CREATE DATABASE siakad_db;
   ```

3. Create a user with appropriate permissions:
   ```sql
   CREATE USER 'siakad_user'@'localhost' IDENTIFIED BY 'your_password';
   GRANT ALL PRIVILEGES ON siakad_db.* TO 'siakad_user'@'localhost';
   FLUSH PRIVILEGES;
   ```

4. Update the database credentials in the `.env` file (create one in the `siakad_backend` directory):
   ```
   DBUSER=siakad_user
   DBPASS=your_password
   DBHOST=localhost
   DBPORT=3306
   DBNAME=siakad_db
   PORT=8080
   ```

5. Set up the database tables by running the SQL script:
   ```bash
   mysql -u siakad_user -p siakad_db < database/setup.sql
   ```

### Setup Instructions

1. Install dependencies:
   ```
   cd siakad_backend
   go mod tidy
   ```

2. Build and run:
   ```
   go build .
   ./siakad_backend
   ```

### API Endpoints

- POST `/api/register` - Register a new user
- POST `/api/login` - Login with email and password
- GET `/api/profile` - Get user profile (requires authentication)
- POST `/api/change-password` - Change password (requires authentication)
- POST `/api/logout` - Logout (requires authentication)

### Registration Process

To register a new account, send a POST request to `/api/register` with the following JSON payload:

```json
{
  "name": "John Doe",
  "nim": "1234567890",
  "email": "john.doe@example.com",
  "password": "securepassword",
  "phone": "081234567890",
  "program_studi": "Teknik Informatika"
}
```

All fields are required except for phone which is optional.

### Authentication

This application uses session-based authentication instead of JWT tokens. When a user successfully registers or logs in, a session is created and stored in a cookie. All protected endpoints require a valid session.

### Sample User

After running the setup.sql script, you can log in with:
- Email: syepry.maulana@umt.ac.id
- Password: password123

### Troubleshooting

If you encounter database connection issues:
1. Make sure MySQL is running
2. Verify your database credentials in the .env file
3. Ensure the database and user exist
4. Check that the user has proper permissions on the database