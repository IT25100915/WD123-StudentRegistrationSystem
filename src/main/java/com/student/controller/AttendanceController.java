package com.student.controller;

import com.student.dao.AttendanceDAO;
import com.student.dao.CourseDAO;
import com.student.dao.StudentDAO;
import com.student.model.Attendance;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {

    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final CourseDAO courseDAO = new CourseDAO();

    @GetMapping
    public String list(@RequestParam(required = false) String action,
                       @RequestParam(required = false) String id,
                       @RequestParam(required = false) String studentId,
                       @RequestParam(required = false) String courseCode,
                       HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("edit".equals(action)) {
            model.addAttribute("attendance", attendanceDAO.getAttendanceById(Integer.parseInt(id)));
            model.addAttribute("students", studentDAO.getAllStudents());
            model.addAttribute("courses", courseDAO.getAllCourses());
            return "attendance/form";
        } else if ("add".equals(action)) {
            model.addAttribute("students", studentDAO.getAllStudents());
            model.addAttribute("courses", courseDAO.getAllCourses());
            return "attendance/form";
        } else if ("byStudent".equals(action)) {
            model.addAttribute("attendanceList", attendanceDAO.getAttendanceByStudent(studentId));
            model.addAttribute("filterType", "student");
            return "attendance/list";
        } else if ("byCourse".equals(action)) {
            model.addAttribute("attendanceList", attendanceDAO.getAttendanceByCourse(courseCode));
            model.addAttribute("filterType", "course");
            return "attendance/list";
        }
        model.addAttribute("attendanceList", attendanceDAO.getAllAttendance());
        return "attendance/list";
    }

    @PostMapping
    public String handle(@RequestParam String action,
                         @RequestParam(required = false) String attendanceId,
                         @RequestParam(required = false) String studentId,
                         @RequestParam(required = false) String courseCode,
                         @RequestParam(required = false) String date,
                         @RequestParam(required = false) String status,
                         HttpSession session) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("add".equals(action)) {
            Attendance attendance = new Attendance();
            attendance.setStudentId(studentId);
            attendance.setCourseCode(courseCode);
            attendance.setDate(date);
            attendance.setStatus(status);
            boolean success = attendanceDAO.addAttendance(attendance);
            System.out.println(success ? "Attendance added successfully" : "Failed to add attendance");

        } else if ("update".equals(action)) {
            Attendance attendance = new Attendance();
            attendance.setAttendanceId(Integer.parseInt(attendanceId));
            attendance.setStudentId(studentId);
            attendance.setCourseCode(courseCode);
            attendance.setDate(date);
            attendance.setStatus(status);
            boolean success = attendanceDAO.updateAttendance(attendance);
            System.out.println(success ? "Attendance updated successfully" : "Failed to update attendance");

        } else if ("delete".equals(action)) {
            boolean success = attendanceDAO.deleteAttendance(Integer.parseInt(attendanceId));
            System.out.println(success ? "Attendance deleted successfully" : "Failed to delete attendance");
        }
        return "redirect:/attendance";
    }
}
