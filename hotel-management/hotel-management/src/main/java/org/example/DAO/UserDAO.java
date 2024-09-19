package org.example.DAO;

import org.example.Entity.User;

import java.sql.SQLException;
import java.util.List;

public interface UserDAO {
    List<User> getUsers() throws SQLException;
    User getUserById(int id) throws SQLException;
    User createUser(User user) throws SQLException;
    User updateUserById(int id) throws SQLException;
    boolean deleteUserById(int id) throws SQLException;
}
