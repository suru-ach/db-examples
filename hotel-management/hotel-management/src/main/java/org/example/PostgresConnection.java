package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class PostgresConnection {
    private String host = "localhost";
    private int port = 5432;
    private String database = "study3";
    private String username = "postgres";
    private String password = "postgres";

    public Connection getConnection() throws SQLException {
        String connectionUrl = "jdbc:postgresql://"+host+":"+port+"/"+database;
        return DriverManager.getConnection(connectionUrl, username, password);
    }
}
