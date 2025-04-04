package com.example.class_nftcollection_040425.Models;


public class NFTCategory {
    private int id;
    private String name;

    public NFTCategory() {}

    public NFTCategory(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

