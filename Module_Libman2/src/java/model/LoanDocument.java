/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class LoanDocument {
    private int id;
    private String formerStatus;
    private String latterStatus;
    private int DocumentId;
    private int LoanSlipId;
    private int FineSlipId; 

    public LoanDocument(int id,String formerStatus, String latterStatus,int DocumentId, int LoanSlipId,int FineSlipId) {
        this.id = id;
        this.formerStatus = formerStatus;
        this.latterStatus = latterStatus;
        this.DocumentId = DocumentId;
        this.LoanSlipId = LoanSlipId;
        this.FineSlipId = FineSlipId; 
    }

    public int getId() {
        return id;
    }

    public void setFormerStatus(String formerStatus) {
        this.formerStatus = formerStatus;
    }

    public void setLatterStatus(String latterStatus) {
        this.latterStatus = latterStatus;
    }

    public String getFormerStatus() {
        return formerStatus;
    }

    public String getLatterStatus() {
        return latterStatus;
    }


    public int getDocumentId() {
        return DocumentId;
    }

    public int getLoanSlipId() {
        return LoanSlipId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setFineSlipId(int FineSlipId) {
        this.FineSlipId = FineSlipId;
    }

    public int getFineSlipId() {
        return FineSlipId;
    }

   

    public void setDocumentId(int DocumentId) {
        this.DocumentId = DocumentId;
    }

    public void setLoanSlipId(int LoanSlipId) {
        this.LoanSlipId = LoanSlipId;
    }
    
}
