package dao;

import model.User;
import java.sql.*;
import dao.DAO; 

public class LoginDAO {
    public User validate(String username, String password) {
        String sql = "SELECT id, username, fullname,role FROM tblUser WHERE username=? AND password=?";
        try (Connection con = DAO.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password); 

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setUsername(rs.getString("username"));
                    u.setFullname(rs.getString("fullname"));
                    u.setRole(rs.getString("role"));
                    return u;
                }
            }
        } catch (SQLException e) {
            System.err.println("LoginDAO.validate error: " + e.getMessage());
        }
        return null;
    }
}
