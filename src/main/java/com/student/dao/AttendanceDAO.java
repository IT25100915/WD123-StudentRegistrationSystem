package com.student.dao;

import com.student.model.Attendance;
import com.student.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    private Attendance mapRow(ResultSet rs) throws SQLException {
        Attendance attendance = new Attendance();
        attendance.setAttendanceId(rs.getInt("attendance_id"));
        attendance.setStudentId(rs.getString("student_id"));
        attendance.setCourseCode(rs.getString("course_code"));
        attendance.setDate(rs.getString("date"));
        attendance.setStatus(rs.getString("status"));
        return attendance;
    }

    public List<Attendance> getAllAttendance() {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all attendance: " + e.getMessage());
        }
        return list;
    }

    public Attendance getAttendanceById(int id) {
        String sql = "SELECT * FROM attendance WHERE attendance_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting attendance by id: " + e.getMessage());
        }
        return null;
    }

    public boolean addAttendance(Attendance attendance) {
        String sql = "INSERT INTO attendance (student_id, course_code, date, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, attendance.getStudentId());
            stmt.setString(2, attendance.getCourseCode());
            stmt.setString(3, attendance.getDate());
            stmt.setString(4, attendance.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding attendance: " + e.getMessage());
        }
        return false;
    }

    public boolean updateAttendance(Attendance attendance) {
        String sql = "UPDATE attendance SET student_id = ?, course_code = ?, date = ?, status = ? WHERE attendance_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, attendance.getStudentId());
            stmt.setString(2, attendance.getCourseCode());
            stmt.setString(3, attendance.getDate());
            stmt.setString(4, attendance.getStatus());
            stmt.setInt(5, attendance.getAttendanceId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating attendance: " + e.getMessage());
        }
        return false;
    }

    public boolean deleteAttendance(int attendanceId) {
        String sql = "DELETE FROM attendance WHERE attendance_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, attendanceId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting attendance: " + e.getMessage());
        }
        return false;
    }

    public List<Attendance> getRecentAttendance(int limit) {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance ORDER BY attendance_id DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting recent attendance: " + e.getMessage());
        }
        return list;
    }

    public List<Attendance> getAttendanceByStudent(String studentId) {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting attendance by student: " + e.getMessage());
        }
        return list;
    }

    public List<Attendance> getAttendanceByCourse(String courseCode) {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE course_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, courseCode);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting attendance by course: " + e.getMessage());
        }
        return list;
    }
}
