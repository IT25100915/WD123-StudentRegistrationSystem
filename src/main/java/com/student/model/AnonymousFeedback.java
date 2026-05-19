package com.student.model;

public class AnonymousFeedback extends Feedback {

    public AnonymousFeedback() {
        super();
    }

    public AnonymousFeedback(int feedbackId, String studentId, String courseCode, int rating,
                             String comment, String submissionDate) {
        super(feedbackId, studentId, courseCode, rating, comment, true, submissionDate);
    }

    @Override
    public String displayFeedback() {
        return "Feedback[ID=" + getFeedbackId() + ", Course=" + getCourseCode()
                + ", Rating=" + getRating() + ", Comment=" + getComment()
                + ", Student=Anonymous, Date=" + getSubmissionDate() + "]";
    }
}
