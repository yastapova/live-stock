package org.o7planning.tutorial.beans;
 
public class UserInfo {
 
    public String userName;
    private int post;
    private String country;
     
    public UserInfo(String userName, String country, int post)  {
        this.userName= userName;
        this.country= country;
        this.post= post;
    }
 
    public int getPost() {
        return post;
    }
 
    public void setPost(int post) {
        this.post = post;
    }
 
    public String getCountry() {
        return country;
    }
 
    public void setCountry(String country) {
        this.country = country;
    }
 
    public void setUserName(String userName) {
        this.userName = userName;
    }
 
    public UserInfo(String userName) {
        this.userName = userName;
    }
 
    public String getUserName() {
        return this.userName;
    }
}