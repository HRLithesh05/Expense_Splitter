package utility;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Read from environment variables (set by Docker or system)
    private static final String URL = System.getenv("DB_URL") != null ? 
        System.getenv("DB_URL") : "jdbc:mysql://localhost:3306/expense_splitter";
    private static final String USER = System.getenv("DB_USER") != null ? 
        System.getenv("DB_USER") : "root";
    private static final String PASSWORD = System.getenv("DB_PASSWORD") != null ? 
        System.getenv("DB_PASSWORD") : "lithesh@123";
    private static final String DRIVER = System.getenv("DB_DRIVER") != null ? 
        System.getenv("DB_DRIVER") : "com.mysql.cj.jdbc.Driver";
    
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