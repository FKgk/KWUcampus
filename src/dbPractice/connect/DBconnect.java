package dbPractice.connect;

import java.sql.*;
 
public class DBconnect {
	
    public static Connection getConnection() {
    	Connection conn = null;
    	String driverClass = "org.mariadb.jdbc.Driver";
         try {
            Class.forName(driverClass);
         } catch (ClassNotFoundException e) { 
             System.out.println("����̹� �ε� ����");
         }
         try {
        	 conn = DriverManager.getConnection(
                    "jdbc:mariadb://localhost:3306/UNIVERSITY",
                    "root",
                    "");            
        	 if( conn != null ) {
        		 System.out.println("DB ���� ����");
        	 }
         } catch (SQLException e) {
            System.out.println("DB ���� ����");
            e.printStackTrace();
         }
         return conn;
    }
    
    public static void close(Statement stmt) {
    	try {
    		if(stmt!=null) stmt.close();
    	} catch(SQLException e) {
    		e.printStackTrace();
    	}
    }
    public static void close(ResultSet rs) {
    	try {
    		if(rs!=null) rs.close();
    	} catch(SQLException e) {
    		e.printStackTrace();
    	}
    }
    public static void close(Connection conn) {
    	try {
    		if(conn!=null) conn.rollback();
    	} catch(SQLException e) {
    		e.printStackTrace();
    	}
    }
}
