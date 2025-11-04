package utility;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Load configuration from .env file
    private static final String URL;
    private static final String USER;
    private static final String PASSWORD;
    private static final String DRIVER;
    
    static {
        // Load environment variables on class initialization
        EnvLoader.load();
        
        // Get database configuration from .env file with fallback defaults
        URL = EnvLoader.get("DB_URL", "jdbc:mysql://localhost:3306/expense_splitter");
        USER = EnvLoader.get("DB_USER", "root");
        PASSWORD = EnvLoader.get("DB_PASSWORD", "");
        DRIVER = EnvLoader.get("DB_DRIVER", "com.mysql.cj.jdbc.Driver");
    }
    
    private static Connection connection = null;
    
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        if (connection == null || connection.isClosed()) {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        }
        return connection;
    }
    
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}