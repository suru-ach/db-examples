package org.example.DAOImpl;

import org.example.DAO.UserDAO;
import org.example.Entity.User;
import org.example.PostgresConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {
    private Connection conn = null;

    public UserDAOImpl() {
        try {
            conn = new PostgresConnection().getConnection();
        } catch(SQLException e) {
            throw new RuntimeException("Sql Error "+e.getMessage());
        }
    }

    @Override
    public List<User> getUsers() throws SQLException {

        String getUsersSql = "select id, username, phonenumber from app_users";
        List<User> users = new ArrayList<>();

        try(Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(getUsersSql);
            while(rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("phonenumber")
                ));
            }
        } catch(SQLException e) {
            throw new SQLException(e);
        }
        return users;
    }

    @Override
    public User getUserById(int id) throws SQLException {
        return null;
    }

    @Override
    public User createUser(User user) throws SQLException {
        return null;
    }

    @Override
    public User updateUserById(int id) throws SQLException {
        return null;
    }

    @Override
    public boolean deleteUserById(int id) throws SQLException {
        return false;
    }
}
