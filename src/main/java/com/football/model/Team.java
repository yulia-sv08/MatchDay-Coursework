package com.football.model;

public class Team {
    private int id;
    private String name;
    private String country;
    private String city;
    private int foundationYear;
    private String logo;

    public Team() {}

    public Team(int id, String name, String country, String city, int foundationYear, String logo) {
        this.id = id;
        this.name = name;
        this.country = country;
        this.city = city;
        this.foundationYear = foundationYear;
        this.logo = logo;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public int getFoundationYear() { return foundationYear; }
    public void setFoundationYear(int foundationYear) { this.foundationYear = foundationYear; }
    public String getLogo() { return logo; }
    public void setLogo(String logo) { this.logo = logo; }
}
