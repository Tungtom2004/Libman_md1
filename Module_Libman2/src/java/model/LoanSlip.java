package model;
import java.util.*; 
public class LoanSlip{
    private int id; 
    private Date borrowDate;
    private Date expectedReturnDate;
    private int tblReaderId;
    private int tblStaffId; 

    // SỬA LẠI: Constructor rỗng phải để trống hoặc không viết gì
    public LoanSlip() {
        // Để trống
    }
    
    // Thêm constructor có tham số (tùy chọn nhưng nên có)
    public LoanSlip(int id, Date borrowDate, Date expectedReturnDate, int tblReaderId, int tblStaffId) {
       this.id = id;
       this.borrowDate = borrowDate;
       this.expectedReturnDate = expectedReturnDate;
       this.tblReaderId = tblReaderId;
       this.tblStaffId = tblStaffId; 
    }


    public int getId() {
        return id;
    }
    
    public Date getBorrowDate() {
        return borrowDate;
    }

    public Date getExpectedReturnDate() {
        return expectedReturnDate;
    }

    public int getTblReaderId() {
        return tblReaderId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public void setExpectedReturnDate(Date expectedReturnDate) {
        this.expectedReturnDate = expectedReturnDate;
    }

    public void setTblReaderId(int tblReaderId) {
        this.tblReaderId = tblReaderId;
    }

    public void setTblStaffId(int tblStaffId) {
        this.tblStaffId = tblStaffId;
    }

    public int getTblStaffId() {
        return tblStaffId;
    }
    
    
    
    
}

