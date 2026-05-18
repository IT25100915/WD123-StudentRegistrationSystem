package com.student.controller;

import com.student.dao.AdminDAO;
import com.student.dao.AttendanceDAO;
import com.student.dao.CourseDAO;
import com.student.dao.EnrollmentDAO;
import com.student.dao.FeedbackDAO;
import com.student.dao.StudentDAO;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    private final StudentDAO studentDAO = new StudentDAO();
    private final CourseDAO courseDAO = new CourseDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final FeedbackDAO feedbackDAO = new FeedbackDAO();
    private final AdminDAO adminDAO = new AdminDAO();

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/login";
        }
        model.addAttribute("studentCount",    studentDAO.getAllStudents().size());
        model.addAttribute("courseCount",     courseDAO.getAllCourses().size());
        model.addAttribute("enrollmentCount", enrollmentDAO.getAllEnrollments().size());
        model.addAttribute("attendanceCount", attendanceDAO.getAllAttendance().size());
        model.addAttribute("feedbackCount",   feedbackDAO.getAllFeedback().size());
        model.addAttribute("adminCount",      adminDAO.getAllAdmins().size());

        model.addAttribute("recentStudents",    studentDAO.getRecentStudents(5));
        model.addAttribute("recentEnrollments", enrollmentDAO.getRecentEnrollments(5));
        model.addAttribute("recentAttendance",  attendanceDAO.getRecentAttendance(5));
        model.addAttribute("recentFeedback",    feedbackDAO.getRecentFeedback(5));
        return "dashboard";
    }
}
