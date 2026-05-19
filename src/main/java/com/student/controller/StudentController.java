package com.student.controller;

import com.student.dao.CourseDAO;
import com.student.dao.StudentDAO;
import com.student.model.PostgraduateStudent;
import com.student.model.Student;
import com.student.model.UndergraduateStudent;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/students")
public class StudentController {

    private final StudentDAO studentDAO = new StudentDAO();
    private final CourseDAO courseDAO = new CourseDAO();

    @GetMapping
    public String list(@RequestParam(required = false) String action,
                       @RequestParam(required = false) String id,
                       @RequestParam(required = false) String keyword,
                       HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("edit".equals(action)) {
            model.addAttribute("student", studentDAO.getStudentById(id));
            model.addAttribute("courses", courseDAO.getAllCourses());
            return "student/form";
        } else if ("add".equals(action)) {
            model.addAttribute("courses", courseDAO.getAllCourses());
            return "student/form";
        } else if ("search".equals(action)) {
            List<Student> students = studentDAO.searchStudent(keyword);
            model.addAttribute("students", students);
            model.addAttribute("keyword", keyword);
            return "student/list";
        }
        model.addAttribute("students", studentDAO.getAllStudents());
        return "student/list";
    }

    @PostMapping
    public String handle(@RequestParam String action,
                         @RequestParam(required = false) String studentId,
                         HttpServletRequest request,
                         HttpSession session) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("add".equals(action)) {
            Student student = buildStudent(request);
            boolean success = studentDAO.addStudent(student);
            System.out.println(success ? "Student added: " + student.displayDetails() : "Failed to add student");
        } else if ("update".equals(action)) {
            Student student = buildStudent(request);
            boolean success = studentDAO.updateStudent(student);
            System.out.println(success ? "Student updated successfully" : "Failed to update student");
        } else if ("delete".equals(action)) {
            boolean success = studentDAO.deleteStudent(studentId);
            System.out.println(success ? "Student deleted successfully" : "Failed to delete student");
        }
        return "redirect:/students";
    }

    private Student buildStudent(HttpServletRequest request) {
        String studentType = request.getParameter("studentType");

        if ("Undergraduate".equals(studentType)) {
            UndergraduateStudent s = new UndergraduateStudent();
            s.setStudentId(request.getParameter("studentId"));
            s.setFullName(request.getParameter("fullName"));
            s.setEmail(request.getParameter("email"));
            s.setPhone(request.getParameter("phone"));
            s.setStudentType("Undergraduate");
            s.setCourseCode(request.getParameter("courseCode"));
            String year = request.getParameter("yearOfStudy");
            if (year != null && !year.isEmpty()) {
                s.setYearOfStudy(Integer.parseInt(year));
            }
            return s;
        } else {
            PostgraduateStudent s = new PostgraduateStudent();
            s.setStudentId(request.getParameter("studentId"));
            s.setFullName(request.getParameter("fullName"));
            s.setEmail(request.getParameter("email"));
            s.setPhone(request.getParameter("phone"));
            s.setStudentType("Postgraduate");
            s.setCourseCode(request.getParameter("courseCode"));
            s.setThesisTitle(request.getParameter("thesisTitle"));
            return s;
        }
    }
}
