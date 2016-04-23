package conn;

import java.sql.Connection;
import java.sql.SQLException;
 
public class ConnectionUtils {
 
   public static Connection getConnection()
             throws ClassNotFoundException, SQLException {
      
       return MySQLConnUtils.getMySQLConnection();
   }
    
   public static void closeQuietly(Connection conn) {
       try {
           conn.close();
       } catch (Exception e) {
       }
   }
 
   public static void rollbackQuietly(Connection conn) {
       try {
           conn.rollback();
       } catch (Exception e) {
       }
   }
}
