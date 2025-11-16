/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class ImportedSlip {
    private int id;
    private int numberOfDocuments;
    private int totalPrice;
    private int SupplierId;

    public ImportedSlip(int id, int numberOfDocuments, int totalPrice, int SupplierId) {
        this.id = id;
        this.numberOfDocuments = numberOfDocuments;
        this.totalPrice = totalPrice;
        this.SupplierId = SupplierId;
    }

    public int getId() {
        return id;
    }

    public int getNumberOfDocuments() {
        return numberOfDocuments;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public int getSupplierId() {
        return SupplierId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNumberOfDocuments(int numberOfDocuments) {
        this.numberOfDocuments = numberOfDocuments;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setSupplierId(int SupplierId) {
        this.SupplierId = SupplierId;
    }
    
}
