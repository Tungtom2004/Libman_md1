/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.ReaderCard;
import java.sql.*;
import java.util.*;

public class ReaderCardDAO {

    public ReaderCard getReaderCardbyID(int id) {
        String sql = "SELECT t1.avatar, t1.registerDay, t3.fullname, t3.id "
                + "FROM tblreadercard t1 "
                + "JOIN tblreader t2 ON t1.tblReaderId = t2.tblUserid "
                + "JOIN tbluser t3 ON t2.tblUserid = t3.id "
                + "WHERE t3.id = ?";

        ReaderCard card = null;

        try (Connection con = DAO.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    card = new ReaderCard();
                    card.setAvatar(rs.getString("avatar"));
                    card.setRegisterDay(rs.getDate("registerDay"));
                    card.setFullname(rs.getString("fullname"));
                    card.setId(rs.getInt("id"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return card;
    }
}