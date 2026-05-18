package com.student.controller;

import com.student.dao.AdminDAO;
import com.student.dao.StudentDAO;
import com.student.model.Admin;
import com.student.model.Student;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    private final AdminDAO adminDAO = new AdminDAO();
    private final StudentDAO studentDAO = new StudentDAO();

    @GetMapping({"/", "/login"})
    public String showLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String username,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {
        // Try admin first
        Admin admin = adminDAO.login(username, password);
        if (admin != null) {
            session.setAttribute("admin", admin);
            System.out.println("Admin login successful: " + admin.toString());
            return "redirect:/dashboard";
        }

        // Try student (username = student ID)
        Student student = studentDAO.loginStudent(username, password);
        if (student != null) {
            session.setAttribute("student", student);
            System.out.println("Student login successful: " + student.getStudentId());
            return "redirect:/student-portal";
        }

        System.out.println("Login failed for username: " + username);
        model.addAttribute("error", "Invalid username or password");
        return "login";
    }
}
