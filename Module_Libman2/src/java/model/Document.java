/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Document {
    private int id;
    private String name;
    private String author;
    private String yearOfPublication;
    private String publicator;
    private String category;
    private String language;
    private int numberOfPages;

    
    public Document() {
        this.id = id;
        this.name = name;
        this.author = author;
        this.yearOfPublication = yearOfPublication;
        this.publicator = publicator;
        this.category = category;
        this.language = language;
        this.numberOfPages = numberOfPages;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    

    public String getAuthor() {
        return author;
    }

    public String getYearOfPublication() {
        return yearOfPublication;
    }

    public String getPublicator() {
        return publicator;
    }

    public String getCategory() {
        return category;
    }

    public String getLanguage() {
        return language;
    }

    public int getNumberOfPages() {
        return numberOfPages;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }


    public void setAuthor(String author) {
        this.author = author;
    }

    public void setYearOfPublication(String yearOfPublication) {
        this.yearOfPublication = yearOfPublication;
    }

    public void setPublicator(String publicator) {
        this.publicator = publicator;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public void setNumberOfPages(int numberOfPages) {
        this.numberOfPages = numberOfPages;
    }
    
    
    
}
