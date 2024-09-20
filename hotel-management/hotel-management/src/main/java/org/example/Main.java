package org.example;

import org.example.Entity.User;
import org.example.DAOImpl.UserDAOImpl;

import java.sql.*;
import java.util.List;

public class Main {

    public static void main(String[] args) throws SQLException{
        try {
            UserDAOImpl userDAO = new UserDAOImpl();
            List<User> res = userDAO.getUsers();
            for(User user: res) {
                System.out.println(user.getUsername());
            }

            User user = userDAO.getUserById(1);
            System.out.println(user.getUsername());

            /*
            User createUser = new User("Aarsh", "9089786756");
            System.out.println(userDAO.createUser(createUser));

            User updateTo = new User("Wendy", "9089786756");
            System.out.println(userDAO.updateUserById(107, updateTo));
            */

            System.out.println(userDAO.deleteUserById(105));

        } catch(RuntimeException e) {
            System.out.println(e.getMessage());
        }
    }
}