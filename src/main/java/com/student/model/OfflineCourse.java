package com.student.model;

public class OfflineCourse extends Course {

    private String classroomLocation;

    public OfflineCourse() {
        super();
    }

    public OfflineCourse(String courseCode, String title, int credits,
                         String coordinator, String classroomLocation) {
        super(courseCode, title, credits, "Offline", coordinator);
        this.classroomLocation = classroomLocation;
    }

    public String getClassroomLocation() { return classroomLocation; }
    public void setClassroomLocation(String classroomLocation) { this.classroomLocation = classroomLocation; }

    @Override
    public String getCourseInfo() {
        return super.getCourseInfo() + ", Classroom=" + classroomLocation;
    }
}
