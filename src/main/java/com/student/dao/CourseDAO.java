package com.student.dao;

import com.student.model.Course;
import com.student.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    private Course mapRow(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setCourseCode(rs.getString("course_code"));
        course.setTitle(rs.getString("title"));
        course.setCredits(rs.getInt("credits"));
        course.setMode(rs.getString("mode"));
        course.setCoordinator(rs.getString("coordinator"));
        return course;
    }

    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                courses.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all courses: " + e.getMessage());
        }
        return courses;
    }

    public Course getCourseByCode(String courseCode) {
        String sql = "SELECT * FROM courses WHERE course_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, courseCode);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting course by code: " + e.getMessage());
        }
        return null;
    }

    public boolean addCourse(Course course) {
        String sql = "INSERT INTO courses (course_code, title, credits, mode, coordinator) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, course.getCourseCode());
            stmt.setString(2, course.getTitle());
            stmt.setInt(3, course.getCredits());
            stmt.setString(4, course.getMode());
            stmt.setString(5, course.getCoordinator());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding course: " + e.getMessage());
        }
        return false;
    }

    public boolean updateCourse(Course course) {
        String sql = "UPDATE courses SET title = ?, credits = ?, mode = ?, coordinator = ? WHERE course_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, course.getTitle());
            stmt.setInt(2, course.getCredits());
            stmt.setString(3, course.getMode());
            stmt.setString(4, course.getCoordinator());
            stmt.setString(5, course.getCourseCode());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating course: " + e.getMessage());
        }
        return false;
    }

    public boolean deleteCourse(String courseCode) {
        String sql = "DELETE FROM courses WHERE course_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, courseCode);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting course: " + e.getMessage());
        }
        return false;
    }
}
