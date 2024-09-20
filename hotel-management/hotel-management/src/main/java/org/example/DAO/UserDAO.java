package org.example.DAO;

import org.example.Entity.User;

import java.sql.SQLException;
import java.util.List;

public interface UserDAO {
    List<User> getUsers() throws SQLException;
    User getUserById(int id) throws SQLException;
    boolean createUser(User user) throws SQLException;
    int updateUserById(int id, User user) throws SQLException;
    boolean deleteUserById(int id) throws SQLException;
}
