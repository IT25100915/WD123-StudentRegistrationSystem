package com.student.dao;

import com.student.model.Enrollment;
import com.student.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAO {

    private Enrollment mapRow(ResultSet rs) throws SQLException {
        Enrollment enrollment = new Enrollment();
        enrollment.setEnrollmentId(rs.getInt("enrollment_id"));
        enrollment.setStudentId(rs.getString("student_id"));
        enrollment.setCourseCode(rs.getString("course_code"));
        enrollment.setEnrollmentDate(rs.getString("enrollment_date"));
        enrollment.setEnrollmentType(rs.getString("enrollment_type"));
        return enrollment;
    }

    public List<Enrollment> getAllEnrollments() {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT * FROM enrollments";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                enrollments.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all enrollments: " + e.getMessage());
        }
        return enrollments;
    }

    public Enrollment getEnrollmentById(int id) {
        String sql = "SELECT * FROM enrollments WHERE enrollment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting enrollment by id: " + e.getMessage());
        }
        return null;
    }

    public String lastError;

    public boolean addEnrollment(Enrollment enrollment) {
        lastError = null;
        String sql = "INSERT INTO enrollments (student_id, course_code, enrollment_date, enrollment_type) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, enrollment.getStudentId());
            stmt.setString(2, enrollment.getCourseCode());
            stmt.setString(3, enrollment.getEnrollmentDate());
            stmt.setString(4, enrollment.getEnrollmentType());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            lastError = e.getMessage();
            System.out.println("Error adding enrollment: " + e.getMessage());
        }
        return false;
    }

    public boolean updateEnrollment(Enrollment enrollment) {
        String sql = "UPDATE enrollments SET student_id = ?, course_code = ?, enrollment_date = ?, enrollment_type = ? WHERE enrollment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, enrollment.getStudentId());
            stmt.setString(2, enrollment.getCourseCode());
            stmt.setString(3, enrollment.getEnrollmentDate());
            stmt.setString(4, enrollment.getEnrollmentType());
            stmt.setInt(5, enrollment.getEnrollmentId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating enrollment: " + e.getMessage());
        }
        return false;
    }

    public boolean deleteEnrollment(int enrollmentId) {
        String sql = "DELETE FROM enrollments WHERE enrollment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, enrollmentId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting enrollment: " + e.getMessage());
        }
        return false;
    }

    public boolean checkCourseAvailability(String courseCode) {
        String sql = "SELECT COUNT(*) FROM courses WHERE course_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, courseCode);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking course availability: " + e.getMessage());
        }
        return false;
    }

    public List<Enrollment> getRecentEnrollments(int limit) {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT * FROM enrollments ORDER BY enrollment_id DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                enrollments.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting recent enrollments: " + e.getMessage());
        }
        return enrollments;
    }

    public List<Enrollment> getEnrollmentsByStudent(String studentId) {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT * FROM enrollments WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                enrollments.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting enrollments by student: " + e.getMessage());
        }
        return enrollments;
    }
}
