/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

// 1. Import java.sql.Date
import java.sql.Date;

public class ReaderCard extends Reader {

    private String avatar;
    // 2. Sửa kiểu dữ liệu từ String sang Date
    private Date registerDay;
    private int tblReaderId;

    // Constructor đầy đủ (đã sửa registerDay thành Date)
    public ReaderCard() {
        super();
        this.avatar = avatar;
        this.registerDay = registerDay;
        this.tblReaderId = tblReaderId;
    }

    // Getters
    public String getAvatar() {
        return avatar;
    }

    // 4. Sửa kiểu trả về của getter
    public Date getRegisterDay() {
        return registerDay;
    }

    public int getTblReaderId() {
        return tblReaderId;
    }

    // Setters
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    // 5. Sửa kiểu tham số của setter
    public void setRegisterDay(Date registerDay) {
        this.registerDay = registerDay;
    }

    public void setTblReaderId(int tblReaderId) {
        this.tblReaderId = tblReaderId;
    }
}