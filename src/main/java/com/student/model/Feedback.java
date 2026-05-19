package com.student.model;

public class Feedback {

    private int feedbackId;
    private String studentId;
    private String courseCode;
    private int rating;
    private String comment;
    private boolean isAnonymous;
    private String submissionDate;

    public Feedback() {}

    public Feedback(int feedbackId, String studentId, String courseCode, int rating,
                    String comment, boolean isAnonymous, String submissionDate) {
        this.feedbackId = feedbackId;
        this.studentId = studentId;
        this.courseCode = courseCode;
        this.rating = rating;
        this.comment = comment;
        this.isAnonymous = isAnonymous;
        this.submissionDate = submissionDate;
    }

    public int getFeedbackId() { return feedbackId; }
    public void setFeedbackId(int feedbackId) { this.feedbackId = feedbackId; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public boolean isAnonymous() { return isAnonymous; }
    public void setAnonymous(boolean anonymous) { isAnonymous = anonymous; }

    public String getSubmissionDate() { return submissionDate; }
    public void setSubmissionDate(String submissionDate) { this.submissionDate = submissionDate; }

    public String displayFeedback() {
        return "Feedback[ID=" + feedbackId + ", Course=" + courseCode + ", Rating=" + rating
                + ", Comment=" + comment + ", Date=" + submissionDate + "]";
    }
}
