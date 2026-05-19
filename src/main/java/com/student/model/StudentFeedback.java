package com.student.model;

public class StudentFeedback extends Feedback {

    private String studentName;

    public StudentFeedback() {
        super();
    }

    public StudentFeedback(int feedbackId, String studentId, String courseCode, int rating,
                           String comment, String submissionDate, String studentName) {
        super(feedbackId, studentId, courseCode, rating, comment, false, submissionDate);
        this.studentName = studentName;
    }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    @Override
    public String displayFeedback() {
        return super.displayFeedback() + ", Student=" + studentName;
    }
}
