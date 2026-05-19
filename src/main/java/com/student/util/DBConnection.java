package com.student.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * COMPONENT 01 – Student Management | Database Connection Utility
 *
 * OOP CONCEPT: ENCAPSULATION
 *   The database URL, username, and password are stored as private static
 *   constants. No other class can read or modify these credentials directly —
 *   they are hidden inside this class. Access to the database is only possible
 *   through the single public method getConnection().
 *
 * OOP CONCEPT: ABSTRACTION
 *   All classes that need a database connection simply call
 *   DBConnection.getConnection(). They do not need to know which driver is
 *   used, how DriverManager works, or what happens if the connection fails.
 *   The complexity is hidden here.
 *
 * DESIGN PATTERN: Utility / Static Factory
 *   All members are static — this class is never instantiated.
 *   It acts as a centralized factory for database connections.
 *   If the database URL or credentials change, only this ONE file needs updating.
 *
 * JDBC CONNECTION FLOW:
 *   1. Class.forName() loads the MySQL JDBC driver into the JVM.
 *   2. DriverManager.getConnection() establishes a TCP connection to MySQL.
 *   3. The Connection object is returned to the caller (e.g., StudentDAO).
 *   4. The caller is responsible for closing the connection (done via
 *      try-with-resources in each DAO method).
 */
public class DBConnection {

    // ENCAPSULATION: private constants — credentials are never exposed outside this class.
    private static final String URL      = "jdbc:mysql://localhost:3306/student_registration_system";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "1234";

    /**
     * Returns a live JDBC Connection to the MySQL database, or null on failure.
     *
     * Separates two distinct failure modes:
     *   ClassNotFoundException → the MySQL connector JAR is missing from the classpath.
     *   SQLException           → the DB server is down, credentials are wrong, etc.
     *
     * Returning null (rather than throwing) means DAO methods receive null and
     * handle it gracefully inside their own try-catch blocks.
     */
    public static Connection getConnection() {
        try {
            // Load the MySQL JDBC driver class into the JVM at runtime
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish and return the connection using the encapsulated credentials
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            return connection;
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found: " + e.getMessage());
            return null;
        } catch (SQLException e) {
            System.out.println("Database connection failed: " + e.getMessage());
            return null;
        }
    }
}
