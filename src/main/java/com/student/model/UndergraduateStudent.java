package com.student.model;

public class UndergraduateStudent extends Student {

    private int yearOfStudy;

    public UndergraduateStudent() {
        super();
    }

    public UndergraduateStudent(String studentId, String fullName, String email,
                                String phone, String courseCode, int yearOfStudy) {
        super(studentId, fullName, email, phone, "Undergraduate", courseCode);
        this.yearOfStudy = yearOfStudy;
    }

    public int getYearOfStudy() { return yearOfStudy; }
    public void setYearOfStudy(int yearOfStudy) { this.yearOfStudy = yearOfStudy; }

    @Override
    public String displayDetails() {
        return super.displayDetails() + ", Year of Study=" + yearOfStudy;
    }
}
