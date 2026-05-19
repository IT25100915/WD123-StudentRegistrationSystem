package com.student.controller;

import com.student.dao.CourseDAO;
import com.student.dao.EnrollmentDAO;
import com.student.dao.StudentDAO;
import com.student.model.Enrollment;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/enrollments")
public class EnrollmentController {

    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final CourseDAO courseDAO = new CourseDAO();

    @GetMapping
    public String list(@RequestParam(required = false) String action,
                       @RequestParam(required = false) String id,
                       HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("edit".equals(action)) {
            model.addAttribute("enrollment", enrollmentDAO.getEnrollmentById(Integer.parseInt(id)));
            model.addAttribute("students", studentDAO.getAllStudents());
            model.addAttribute("courses", courseDAO.getAllCourses());
            return "enrollment/form";
        } else if ("add".equals(action)) {
            model.addAttribute("students", studentDAO.getAllStudents());
            model.addAttribute("courses", courseDAO.getAllCourses());
            return "enrollment/form";
        }
        model.addAttribute("enrollments", enrollmentDAO.getAllEnrollments());
        return "enrollment/list";
    }

    @PostMapping
    public String handle(@RequestParam String action,
                         @RequestParam(required = false) String enrollmentId,
                         @RequestParam(required = false) String studentId,
                         @RequestParam(required = false) String courseCode,
                         @RequestParam(required = false) String enrollmentDate,
                         @RequestParam(required = false) String enrollmentType,
                         HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("add".equals(action)) {
            if (!enrollmentDAO.checkCourseAvailability(courseCode)) {
                System.out.println("Course not available: " + courseCode);
                model.addAttribute("error", "Selected course does not exist");
                model.addAttribute("students", studentDAO.getAllStudents());
                model.addAttribute("courses", courseDAO.getAllCourses());
                return "enrollment/form";
            }
            Enrollment enrollment = new Enrollment();
            enrollment.setStudentId(studentId);
            enrollment.setCourseCode(courseCode);
            enrollment.setEnrollmentDate(enrollmentDate);
            enrollment.setEnrollmentType(enrollmentType);
            boolean success = enrollmentDAO.addEnrollment(enrollment);
            System.out.println(success ? "Enrollment added successfully" : "Failed to add enrollment");

        } else if ("update".equals(action)) {
            Enrollment enrollment = new Enrollment();
            enrollment.setEnrollmentId(Integer.parseInt(enrollmentId));
            enrollment.setStudentId(studentId);
            enrollment.setCourseCode(courseCode);
            enrollment.setEnrollmentDate(enrollmentDate);
            enrollment.setEnrollmentType(enrollmentType);
            boolean success = enrollmentDAO.updateEnrollment(enrollment);
            System.out.println(success ? "Enrollment updated successfully" : "Failed to update enrollment");

        } else if ("delete".equals(action)) {
            boolean success = enrollmentDAO.deleteEnrollment(Integer.parseInt(enrollmentId));
            System.out.println(success ? "Enrollment deleted successfully" : "Failed to delete enrollment");
        }
        return "redirect:/enrollments";
    }
}
