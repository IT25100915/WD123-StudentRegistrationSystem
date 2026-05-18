package com.student.model;

public class Course {

    private String courseCode;
    private String title;
    private int credits;
    private String mode;
    private String coordinator;

    public Course() {}

    public Course(String courseCode, String title, int credits, String mode, String coordinator) {
        this.courseCode = courseCode;
        this.title = title;
        this.credits = credits;
        this.mode = mode;
        this.coordinator = coordinator;
    }

    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getCredits() { return credits; }
    public void setCredits(int credits) { this.credits = credits; }

    public String getMode() { return mode; }
    public void setMode(String mode) { this.mode = mode; }

    public String getCoordinator() { return coordinator; }
    public void setCoordinator(String coordinator) { this.coordinator = coordinator; }

    public String getCourseInfo() {
        return "Course[Code=" + courseCode + ", Title=" + title + ", Credits=" + credits
                + ", Mode=" + mode + ", Coordinator=" + coordinator + "]";
    }
}
