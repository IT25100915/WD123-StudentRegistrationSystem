package com.student.controller;

import com.student.dao.StudentDAO;
import com.student.model.PostgraduateStudent;
import com.student.model.Student;
import com.student.model.UndergraduateStudent;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/register")
public class RegisterController {

    private final StudentDAO studentDAO = new StudentDAO();

    @GetMapping
    public String showForm() {
        return "register";
    }

    @PostMapping
    public String doRegister(HttpServletRequest request, Model model) {
        String studentType = request.getParameter("studentType");
        Student student;

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (password == null || password.isEmpty() || !password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match or are empty.");
            return "register";
        }

        if ("Undergraduate".equals(studentType)) {
            UndergraduateStudent s = new UndergraduateStudent();
            s.setStudentId(request.getParameter("studentId"));
            s.setFullName(request.getParameter("fullName"));
            s.setEmail(request.getParameter("email"));
            s.setPhone(request.getParameter("phone"));
            s.setStudentType("Undergraduate");
            s.setPassword(password);
            String year = request.getParameter("yearOfStudy");
            if (year != null && !year.isEmpty()) {
                s.setYearOfStudy(Integer.parseInt(year));
            }
            student = s;
        } else {
            PostgraduateStudent s = new PostgraduateStudent();
            s.setStudentId(request.getParameter("studentId"));
            s.setFullName(request.getParameter("fullName"));
            s.setEmail(request.getParameter("email"));
            s.setPhone(request.getParameter("phone"));
            s.setStudentType("Postgraduate");
            s.setPassword(password);
            s.setThesisTitle(request.getParameter("thesisTitle"));
            student = s;
        }

        boolean success = studentDAO.addStudent(student);
        if (success) {
            return "redirect:/login?registered=true";
        }
        String dbError = studentDAO.addStudentError;
        String msg = "Registration failed.";
        if (dbError != null) {
            if (dbError.contains("Duplicate") || dbError.contains("PRIMARY")) {
                msg = "Student ID already exists. Please use a different ID.";
            } else if (dbError.contains("password")) {
                msg = "Database is missing the password column. Run: ALTER TABLE students ADD COLUMN password VARCHAR(100) NOT NULL DEFAULT 'changeme';";
            } else {
                msg = "Registration failed: " + dbError;
            }
        }
        model.addAttribute("error", msg);
        return "register";
    }
}
