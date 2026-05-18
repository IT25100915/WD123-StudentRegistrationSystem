package com.student.model;

public class Enrollment {

    private int enrollmentId;
    private String studentId;
    private String courseCode;
    private String enrollmentDate;
    private String enrollmentType;

    public Enrollment() {}

    public Enrollment(int enrollmentId, String studentId, String courseCode,
                      String enrollmentDate, String enrollmentType) {
        this.enrollmentId = enrollmentId;
        this.studentId = studentId;
        this.courseCode = courseCode;
        this.enrollmentDate = enrollmentDate;
        this.enrollmentType = enrollmentType;
    }

    public int getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(int enrollmentId) { this.enrollmentId = enrollmentId; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }

    public String getEnrollmentDate() { return enrollmentDate; }
    public void setEnrollmentDate(String enrollmentDate) { this.enrollmentDate = enrollmentDate; }

    public String getEnrollmentType() { return enrollmentType; }
    public void setEnrollmentType(String enrollmentType) { this.enrollmentType = enrollmentType; }
}
