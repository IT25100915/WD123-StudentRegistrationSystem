package com.student.dao;

import com.student.model.Student;
import com.student.util.DBConnection;
import com.student.util.StudentFileHandler;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    private Student mapRow(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudentId(rs.getString("student_id"));
        student.setFullName(rs.getString("full_name"));
        student.setEmail(rs.getString("email"));
        student.setPhone(rs.getString("phone"));
        student.setStudentType(rs.getString("student_type"));
        student.setCourseCode(rs.getString("course_code"));
        try { student.setPassword(rs.getString("password")); } catch (SQLException ignored) {}
        return student;
    }

    public Student loginStudent(String studentId, String password) {
        // Try with password column
        String sql = "SELECT * FROM students WHERE student_id = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.out.println("Error during student login: " + e.getMessage());
            // password column missing — fall back to ID only
            if (e.getMessage() != null && e.getMessage().contains("password")) {
                return loginStudentByIdOnly(studentId);
            }
        }
        return null;
    }

    private Student loginStudentByIdOnly(String studentId) {
        String sql = "SELECT * FROM students WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.out.println("Error during student login fallback: " + e.getMessage());
        }
        return null;
    }

    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                students.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all students: " + e.getMessage());
        }
        return students;
    }

    public Student getStudentById(String studentId) {
        String sql = "SELECT * FROM students WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting student by id: " + e.getMessage());
        }
        return null;
    }

    public String addStudentError;

    public boolean addStudent(Student student) {
        addStudentError = null;
        // Try with password column first, fall back if column doesn't exist
        String sql = "INSERT INTO students (student_id, full_name, email, phone, student_type, course_code, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, student.getStudentId());
            stmt.setString(2, student.getFullName());
            stmt.setString(3, student.getEmail());
            stmt.setString(4, student.getPhone());
            stmt.setString(5, student.getStudentType());
            stmt.setString(6, student.getCourseCode());
            String pwd = student.getPassword();
            stmt.setString(7, (pwd != null && !pwd.isEmpty()) ? pwd : "changeme");
            boolean success = stmt.executeUpdate() > 0;
            if (success) StudentFileHandler.saveAllToFile(getAllStudents());
            return success;
        } catch (SQLException e) {
            System.out.println("Error adding student: " + e.getMessage());
            addStudentError = e.getMessage();
            if (e.getMessage() != null && e.getMessage().contains("password")) {
                return addStudentWithoutPassword(student);
            }
        }
        return false;
    }

    private boolean addStudentWithoutPassword(Student student) {
        String sql = "INSERT INTO students (student_id, full_name, email, phone, student_type, course_code) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, student.getStudentId());
            stmt.setString(2, student.getFullName());
            stmt.setString(3, student.getEmail());
            stmt.setString(4, student.getPhone());
            stmt.setString(5, student.getStudentType());
            stmt.setString(6, student.getCourseCode());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding student (fallback): " + e.getMessage());
            addStudentError = e.getMessage();
        }
        return false;
    }

    public boolean updateStudent(Student student) {
        String sql = "UPDATE students SET full_name = ?, email = ?, phone = ?, student_type = ?, course_code = ? WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, student.getFullName());
            stmt.setString(2, student.getEmail());
            stmt.setString(3, student.getPhone());
            stmt.setString(4, student.getStudentType());
            stmt.setString(5, student.getCourseCode());
            stmt.setString(6, student.getStudentId());
            boolean success = stmt.executeUpdate() > 0;
            if (success) StudentFileHandler.saveAllToFile(getAllStudents());
            return success;
        } catch (SQLException e) {
            System.out.println("Error updating student: " + e.getMessage());
        }
        return false;
    }

    public boolean deleteStudent(String studentId) {
        String sql = "DELETE FROM students WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            boolean success = stmt.executeUpdate() > 0;
            if (success) StudentFileHandler.saveAllToFile(getAllStudents());
            return success;
        } catch (SQLException e) {
            System.out.println("Error deleting student: " + e.getMessage());
        }
        return false;
    }

    public List<Student> searchStudent(String keyword) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE student_id LIKE ? OR full_name LIKE ? OR email LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String term = "%" + keyword + "%";
            stmt.setString(1, term);
            stmt.setString(2, term);
            stmt.setString(3, term);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                students.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error searching students: " + e.getMessage());
        }
        return students;
    }

    public List<Student> getRecentStudents(int limit) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                students.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting recent students: " + e.getMessage());
        }
        return students;
    }
}
