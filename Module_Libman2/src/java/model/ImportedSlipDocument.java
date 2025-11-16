/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class ImportedSlipDocument {
    private int id;
    private int numberOfImporting;
    private int ImportedSlipId;
    private int DocumentId;
    private int LibraryStaffId;

    public ImportedSlipDocument(int id, int numberOfImporting, int ImportedSlipId, int DocumentId, int LibraryStaffId) {
        this.id = id;
        this.numberOfImporting = numberOfImporting;
        this.ImportedSlipId = ImportedSlipId;
        this.DocumentId = DocumentId;
        this.LibraryStaffId = LibraryStaffId;
    }

    public int getId() {
        return id;
    }

    public int getNumberOfImporting() {
        return numberOfImporting;
    }

    public int getImportedSlipId() {
        return ImportedSlipId;
    }

    public int getDocumentId() {
        return DocumentId;
    }

    public int getLibraryStaffId() {
        return LibraryStaffId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNumberOfImporting(int numberOfImporting) {
        this.numberOfImporting = numberOfImporting;
    }

    public void setImportedSlipId(int ImportedSlipId) {
        this.ImportedSlipId = ImportedSlipId;
    }

    public void setDocumentId(int DocumentId) {
        this.DocumentId = DocumentId;
    }

    public void setLibraryStaffId(int LibraryStaffId) {
        this.LibraryStaffId = LibraryStaffId;
    }
    
}
