package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
public class MySQLConnUtils {
 
public static Connection getMySQLConnection()
        throws ClassNotFoundException, SQLException {
  
    // Change the connection parameters accordingly.
    String hostName = "localhost";
    String dbName = "live-stock";
    String userName = "root";
    String password = "toor";
    return getMySQLConnection(hostName, dbName, userName, password);
}
 
public static Connection getMySQLConnection(String hostName, String dbName,
        String userName, String password) throws SQLException,
        ClassNotFoundException {
    
    // Register JDBC Driver
    Class.forName("com.mysql.jdbc.Driver");
 
    // URL Connection for MySQL
    String connectionURL = "jdbc:mysql://" + hostName + ":3306/" + dbName;
    
    System.out.println("Connecting to database...");
    Connection conn = DriverManager.getConnection(connectionURL, userName,
            password);
    return conn;
}
}
