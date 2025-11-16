package dao;

import model.Document;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAO {

    public List<Document> getDocumentByName(String keyword) {
        List<Document> list = new ArrayList<>();
        String sql =
            "SELECT id, name, author, yearOfPublication, publicator, category, language, numberOfPages " +
            "FROM tblDocument WHERE name LIKE ? ORDER BY id ASC";

        try (Connection con = DAO.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String kw = (keyword == null) ? "" : keyword.trim();
            ps.setString(1, ""+ kw + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()){
                    Document d = new Document(); 
                    d.setId(rs.getInt("id"));
                    d.setName(rs.getString("name"));
                    d.setAuthor(rs.getString("author"));
                    d.setYearOfPublication(rs.getString("yearOfPublication")); 
                    d.setPublicator(rs.getString("publicator"));              
                    d.setCategory(rs.getString("category"));
                    d.setLanguage(rs.getString("language"));
                    d.setNumberOfPages(rs.getInt("numberOfPages"));
                    list.add(d); 
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Document getDocumentById(int id) {
        String sql =
            "SELECT id, name, author, yearOfPublication, publicator, category, language, numberOfPages " +
            "FROM tblDocument WHERE id = ?";

        try (Connection con = DAO.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()){
                    Document d = new Document(); 
                    d.setId(rs.getInt("id"));
                    d.setName(rs.getString("name"));
                    d.setAuthor(rs.getString("author"));
                    d.setYearOfPublication(rs.getString("yearOfPublication")); 
                    d.setPublicator(rs.getString("publicator"));              
                    d.setCategory(rs.getString("category"));
                    d.setLanguage(rs.getString("language"));
                    d.setNumberOfPages(rs.getInt("numberOfPages"));
                    return d;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
