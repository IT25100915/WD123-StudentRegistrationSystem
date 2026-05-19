package com.student.model;

public class Student extends User {

    private String studentId;
    private String fullName;
    private String phone;
    private String studentType;
    private String courseCode;

    public Student() { super(); }

    public Student(String studentId, String fullName, String email, String phone,
                   String studentType, String courseCode) {
        super(0, studentId, "", email);
        this.studentId = studentId;
        this.fullName = fullName;
        this.phone = phone;
        this.studentType = studentType;
        this.courseCode = courseCode;
    }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getStudentType() { return studentType; }
    public void setStudentType(String studentType) { this.studentType = studentType; }

    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }

    @Override
    public String displayDetails() {
        return "Student[ID=" + studentId + ", Name=" + fullName + ", Email=" + getEmail()
                + ", Phone=" + phone + ", Type=" + studentType + ", Course=" + courseCode + "]";
    }
}
