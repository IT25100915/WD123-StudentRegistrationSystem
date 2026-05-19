package com.student.model;

public class OnlineCourse extends Course {

    private String platformUrl;

    public OnlineCourse() {
        super();
    }

    public OnlineCourse(String courseCode, String title, int credits,
                        String coordinator, String platformUrl) {
        super(courseCode, title, credits, "Online", coordinator);
        this.platformUrl = platformUrl;
    }

    public String getPlatformUrl() { return platformUrl; }
    public void setPlatformUrl(String platformUrl) { this.platformUrl = platformUrl; }

    @Override
    public String getCourseInfo() {
        return super.getCourseInfo() + ", Platform URL=" + platformUrl;
    }
}
