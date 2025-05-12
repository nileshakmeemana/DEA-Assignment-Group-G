/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.model;

import java.sql.Date;

/**
 *
 * @author Nilesh
 */
public class Teacher {
    private int id;
    private int userId;
    private String firstName;
    private String lastName;
    private Date dob;
    private String gender;
    private String address;
    private String phone;
    private Date hireDate;
    private String qualification;
    
    public Teacher() {}
    
    public Teacher(int userId, String firstName, String lastName, Date dob, 
                  String gender, String address, String phone, Date hireDate, String qualification) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dob = dob;
        this.gender = gender;
        this.address = address;
        this.phone = phone;
        this.hireDate = hireDate;
        this.qualification = qualification;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public Date getDob() {
        return dob;
    }
    
    public void setDob(Date dob) {
        this.dob = dob;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public Date getHireDate() {
        return hireDate;
    }
    
    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }
    
    public String getQualification() {
        return qualification;
    }
    
    public void setQualification(String qualification) {
        this.qualification = qualification;
    }
    
    public String getFullName() {
        return firstName + " " + lastName;
    }
}
