/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.*;

public class ReturnSlip {
    private int id;
    private int LoanDocumentId;
    private Date actualReturnDate;
    private int totalCost;

    public ReturnSlip(int id, int LoanDocumentId, Date actualReturnDate, int totalCost) {
        this.id = id;
        this.LoanDocumentId = LoanDocumentId;
        this.actualReturnDate = actualReturnDate;
        this.totalCost = totalCost;
    }

    public int getId() {
        return id;
    }

    public int getLoanDocumentId() {
        return LoanDocumentId;
    }

    public Date getActualReturnDate() {
        return actualReturnDate;
    }

    public int getTotalCost() {
        return totalCost;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setLoanDocumentId(int LoanDocumentId) {
        this.LoanDocumentId = LoanDocumentId;
    }

    public void setActualReturnDate(Date actualReturnDate) {
        this.actualReturnDate = actualReturnDate;
    }

    public void setTotalCost(int totalCost) {
        this.totalCost = totalCost;
    }
    
    
    
    
}
