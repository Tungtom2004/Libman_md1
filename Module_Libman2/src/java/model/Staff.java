/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Staff extends User{
    private String role; 
    private int tblUserid;
    
    
    public Staff() {
        super();
        this.role = role;
        this.tblUserid = tblUserid;
    }

    public String getRole() {
        return role;
    }

    public int getTblUserid() {
        return tblUserid;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setTblUserid(int tblUserid) {
        this.tblUserid = tblUserid;
    }
    
    
}
