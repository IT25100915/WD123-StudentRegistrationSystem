package com.student.model;

public class PostgraduateStudent extends Student {

    private String thesisTitle;

    public PostgraduateStudent() {
        super();
    }

    public PostgraduateStudent(String studentId, String fullName, String email,
                               String phone, String courseCode, String thesisTitle) {
        super(studentId, fullName, email, phone, "Postgraduate", courseCode);
        this.thesisTitle = thesisTitle;
    }

    public String getThesisTitle() { return thesisTitle; }
    public void setThesisTitle(String thesisTitle) { this.thesisTitle = thesisTitle; }

    @Override
    public String displayDetails() {
        return super.displayDetails() + ", Thesis=" + thesisTitle;
    }
}
