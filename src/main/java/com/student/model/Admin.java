package com.student.model;

public class Admin extends User {

    private int adminId;
    private String role;

    public Admin() {
        super();
    }

    public Admin(int adminId, String username, String password, String email, String role) {
        super(0, username, password, email);
        this.adminId = adminId;
        this.role = role;
    }

    public int getAdminId() { return adminId; }
    public void setAdminId(int adminId) { this.adminId = adminId; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    @Override
    public String toString() {
        return "Admin{adminId=" + adminId + ", username=" + getUsername()
                + ", email=" + getEmail() + ", role=" + role + "}";
    }
}
