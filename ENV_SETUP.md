# Environment Configuration Setup

## Database Configuration

This project uses environment variables to store database credentials securely.

### Setup Instructions

1. **Copy the example environment file:**
   ```bash
   cp .env.example .env
   ```

2. **Update the `.env` file with your MySQL credentials:**
   ```properties
   DB_URL=jdbc:mysql://localhost:3306/expense_splitter
   DB_USER=root
   DB_PASSWORD=your_actual_password
   DB_DRIVER=com.mysql.cj.jdbc.Driver
   ```

3. **Security Note:**
   - The `.env` file contains sensitive information and is excluded from version control via `.gitignore`
   - Never commit the `.env` file to the repository
   - Share credentials securely with team members outside of version control

### How It Works

- **EnvLoader.java**: Utility class that reads key-value pairs from the `.env` file
- **DBConnection.java**: Uses `EnvLoader` to fetch database credentials from environment variables
- The `.env` file is loaded automatically when the application starts
- If `.env` is not found, the system will check for system environment variables as a fallback

### Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| DB_URL | JDBC connection URL | `jdbc:mysql://localhost:3306/expense_splitter` |
| DB_USER | Database username | `root` |
| DB_PASSWORD | Database password | `your_password` |
| DB_DRIVER | JDBC driver class | `com.mysql.cj.jdbc.Driver` |
