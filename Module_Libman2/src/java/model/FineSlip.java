/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class FineSlip {
    private int id;
    private int cost;
    private String note;
    private String levelOfDamage;

    public FineSlip(int id, int cost, String note, String levelOfDamage) {
        this.id = id;
        this.cost = cost;
        this.note = note;
        this.levelOfDamage = levelOfDamage;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setLevelOfDamage(String levelOfDamage) {
        this.levelOfDamage = levelOfDamage;
    }

    public int getId() {
        return id;
    }

    public int getCost() {
        return cost;
    }

    public String getNote() {
        return note;
    }

    public String getLevelOfDamage() {
        return levelOfDamage;
    }
    
    
    
    
    
}
