package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

public class Main {
    public static void main(String[] args) {
        // Connection parameters
        String jdbcURL = "jdbc:postgresql://localhost:5432/study3";
        String username = "postgres";  // Your PostgreSQL username
        String password = "postgres";  // Your PostgreSQL password

        try {

            // 2. Establish a connection to the database
            Connection connection = DriverManager.getConnection(jdbcURL, username, password);
            System.out.println("Connected to the PostgreSQL database!");

            // 3. Create an SQL INSERT statement
            String sql = "INSERT INTO app_users (id, username, phonenumber) VALUES (default, ?, ?)";

            // 4. Create a PreparedStatement object
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "Alphonse");  // Set the first parameter
            statement.setString(2, "9090899089");  // Set the second parameter

            // 5. Execute the INSERT statement
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new user was inserted successfully!");
            }

            // 6. Close the connection and other resources
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}