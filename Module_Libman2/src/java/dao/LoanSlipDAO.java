package dao;

import model.LoanSlip;
import java.sql.*;
import java.util.Date; 
public class LoanSlipDAO {

    public int saveLoanSlip(Date borrowDate, Date expectedReturnDate, int readerId, int staffId) throws SQLException {
        String sql = "INSERT INTO tblLoanSlip (borrowDate, expectedReturnDate, tblReaderId, tblStaffId) VALUES (?, ?, ?, ?)";
        int generatedId = -1; 
        try (Connection con = DAO.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setDate(1, new java.sql.Date(borrowDate.getTime()));

            
            if (expectedReturnDate != null) {
                ps.setDate(2, new java.sql.Date(expectedReturnDate.getTime()));
            } else {
                ps.setNull(2, Types.DATE); 
            }
            
            ps.setInt(3, readerId);
            ps.setInt(4, staffId);

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        generatedId = generatedKeys.getInt(1); 
                    }
                }
            } else {
                 System.err.println("LoanSlipDAO.saveLoanSlip: No rows affected. Insert failed?");
            }

        }
        return generatedId;
    }

    
}