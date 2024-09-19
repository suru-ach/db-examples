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
        } catch(RuntimeException e) {
            System.out.println(e.getMessage());
        }
    }
}