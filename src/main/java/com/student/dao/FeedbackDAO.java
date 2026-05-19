package com.student.dao;

import com.student.model.Feedback;
import com.student.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    private Feedback mapRow(ResultSet rs) throws SQLException {
        Feedback feedback = new Feedback();
        feedback.setFeedbackId(rs.getInt("feedback_id"));
        feedback.setStudentId(rs.getString("student_id"));
        feedback.setCourseCode(rs.getString("course_code"));
        feedback.setRating(rs.getInt("rating"));
        feedback.setComment(rs.getString("comment"));
        feedback.setAnonymous(rs.getBoolean("is_anonymous"));
        feedback.setSubmissionDate(rs.getString("submission_date"));
        return feedback;
    }

    public List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all feedback: " + e.getMessage());
        }
        return list;
    }

    public Feedback getFeedbackById(int id) {
        String sql = "SELECT * FROM feedback WHERE feedback_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting feedback by id: " + e.getMessage());
        }
        return null;
    }

    public boolean addFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedback (student_id, course_code, rating, comment, is_anonymous, submission_date) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, feedback.getStudentId());
            stmt.setString(2, feedback.getCourseCode());
            stmt.setInt(3, feedback.getRating());
            stmt.setString(4, feedback.getComment());
            stmt.setBoolean(5, feedback.isAnonymous());
            stmt.setString(6, feedback.getSubmissionDate());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding feedback: " + e.getMessage());
        }
        return false;
    }

    public boolean updateFeedback(Feedback feedback) {
        String sql = "UPDATE feedback SET student_id = ?, course_code = ?, rating = ?, comment = ?, is_anonymous = ?, submission_date = ? WHERE feedback_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, feedback.getStudentId());
            stmt.setString(2, feedback.getCourseCode());
            stmt.setInt(3, feedback.getRating());
            stmt.setString(4, feedback.getComment());
            stmt.setBoolean(5, feedback.isAnonymous());
            stmt.setString(6, feedback.getSubmissionDate());
            stmt.setInt(7, feedback.getFeedbackId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating feedback: " + e.getMessage());
        }
        return false;
    }

    public boolean deleteFeedback(int feedbackId) {
        String sql = "DELETE FROM feedback WHERE feedback_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, feedbackId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting feedback: " + e.getMessage());
        }
        return false;
    }

    public List<Feedback> getRecentFeedback(int limit) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback ORDER BY feedback_id DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting recent feedback: " + e.getMessage());
        }
        return list;
    }

    public List<Feedback> getFeedbackByStudent(String studentId) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback WHERE student_id = ? ORDER BY feedback_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("Error getting feedback by student: " + e.getMessage());
        }
        return list;
    }

    public List<Feedback> getFeedbackByCourse(String courseCode) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback WHERE course_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, courseCode);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting feedback by course: " + e.getMessage());
        }
        return list;
    }
}
