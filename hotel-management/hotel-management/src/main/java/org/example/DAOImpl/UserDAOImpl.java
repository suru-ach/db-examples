package org.example.DAOImpl;

import org.example.DAO.UserDAO;
import org.example.Entity.User;
import org.example.PostgresConnection;

import java.sql.*;
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
        String getUserByIdSql = "select id, username, phonenumber from app_users where id = ?";
        User user = null;

        try(PreparedStatement stmt = conn.prepareStatement(getUserByIdSql)) {
            stmt.setInt(1, id);

            ResultSet res = stmt.executeQuery();
            if(res.next()) {
                return new User(
                        res.getInt("id"),
                        res.getString("username"),
                        res.getString("phonenumber")
                );
            }
        } catch(SQLException e) {
            throw new SQLException(e);
        }
        return null;
    }

    @Override
    public boolean createUser(User user) throws SQLException {
        String getUserByIdSql = "insert into app_users (username, phonenumber) values (?, ?)";
        boolean userCreate;

        try(PreparedStatement stmt = conn.prepareStatement(getUserByIdSql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPhoneNumber());

            userCreate = stmt.executeUpdate() == 1;
        } catch(SQLException e) {
            throw new SQLException(e);
        }
        return userCreate;
    }

    @Override
    public int updateUserById(int id, User user) throws SQLException {
        String getUserByIdSql = "update app_users set username = ?, phonenumber = ? where id = ?";
        int userCreate;

        try(PreparedStatement stmt = conn.prepareStatement(getUserByIdSql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPhoneNumber());
            stmt.setInt(3, id);

            userCreate = stmt.executeUpdate();
        } catch(SQLException e) {
            throw new SQLException(e);
        }
        return userCreate;
    }

    @Override
    public boolean deleteUserById(int id) throws SQLException {
        String deleteSql = "delete from app_users where id = ?";
        int deletedFlag = 0;

        try(PreparedStatement stmt = conn.prepareStatement(deleteSql)) {
            stmt.setInt(1, id);

            deletedFlag = stmt.executeUpdate();
        } catch(SQLException e) {
            throw new SQLException(e);
        }
        return deletedFlag == 1;
    }
}
