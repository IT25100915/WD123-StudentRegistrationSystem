package com.student.controller;

import com.student.dao.AttendanceDAO;
import com.student.dao.CourseDAO;
import com.student.dao.EnrollmentDAO;
import com.student.dao.FeedbackDAO;
import com.student.model.Enrollment;
import com.student.model.Feedback;
import com.student.model.Student;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/student-portal")
public class StudentPortalController {

    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final FeedbackDAO feedbackDAO = new FeedbackDAO();
    private final CourseDAO courseDAO = new CourseDAO();

    @GetMapping
    public String portal(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String id = student.getStudentId();
        List<Enrollment> enrollments = enrollmentDAO.getEnrollmentsByStudent(id);
        model.addAttribute("enrollments", enrollments);
        model.addAttribute("attendance", attendanceDAO.getAttendanceByStudent(id));
        model.addAttribute("feedbackList", feedbackDAO.getFeedbackByStudent(id));
        model.addAttribute("allCourses", courseDAO.getAllCourses());
        return "student-portal";
    }

    @PostMapping("/enroll")
    public String enroll(@RequestParam String courseCode,
                         @RequestParam String enrollmentType,
                         HttpSession session) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        Enrollment enrollment = new Enrollment();
        enrollment.setStudentId(student.getStudentId());
        enrollment.setCourseCode(courseCode);
        enrollment.setEnrollmentType(enrollmentType);
        enrollment.setEnrollmentDate(LocalDate.now().toString());

        boolean success = enrollmentDAO.addEnrollment(enrollment);
        if (success) return "redirect:/student-portal?enrolled=true";
        String err = enrollmentDAO.lastError != null ? enrollmentDAO.lastError : "unknown";
        return "redirect:/student-portal?enrollError=" + java.net.URLEncoder.encode(err, java.nio.charset.StandardCharsets.UTF_8);
    }

    @PostMapping("/unenroll")
    public String unenroll(@RequestParam int enrollmentId, HttpSession session) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        enrollmentDAO.deleteEnrollment(enrollmentId);
        return "redirect:/student-portal?unenrolled=true";
    }

    @PostMapping("/feedback")
    public String submitFeedback(@RequestParam String courseCode,
                                 @RequestParam int rating,
                                 @RequestParam(required = false) String comment,
                                 @RequestParam(required = false) String anonymous,
                                 HttpSession session) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        Feedback feedback = new Feedback();
        feedback.setStudentId(student.getStudentId());
        feedback.setCourseCode(courseCode);
        feedback.setRating(rating);
        feedback.setComment(comment != null ? comment : "");
        feedback.setAnonymous("on".equals(anonymous));
        feedback.setSubmissionDate(LocalDate.now().toString());

        feedbackDAO.addFeedback(feedback);
        return "redirect:/student-portal?feedbackSent=true";
    }
}
