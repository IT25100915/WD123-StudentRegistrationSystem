package com.student.controller;

import com.student.dao.CourseDAO;
import com.student.model.Course;
import com.student.model.OfflineCourse;
import com.student.model.OnlineCourse;
import com.student.util.CourseFileHandler;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/courses")
public class CourseController {

    private final CourseDAO courseDAO = new CourseDAO();

    @GetMapping
    public String list(@RequestParam(required = false) String action,
                       @RequestParam(required = false) String code,
                       HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("edit".equals(action)) {
            model.addAttribute("course", courseDAO.getCourseByCode(code));
            return "course/form";
        } else if ("add".equals(action)) {
            return "course/form";
        } else if ("viewFile".equals(action)) {
            // Read courses from the .txt file and display them
            model.addAttribute("courses",  CourseFileHandler.readAllFromFile());
            model.addAttribute("filePath", CourseFileHandler.getFilePath());
            model.addAttribute("viewingFile", true);
            return "course/list";
        }

        model.addAttribute("courses", courseDAO.getAllCourses());
        model.addAttribute("filePath", CourseFileHandler.getFilePath());
        return "course/list";
    }

    @PostMapping
    public String handle(@RequestParam String action,
                         @RequestParam(required = false) String courseCode,
                         HttpServletRequest request,
                         HttpSession session) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("add".equals(action)) {
            Course course = buildCourse(request);
            boolean success = courseDAO.addCourse(course);
            System.out.println(success ? "Course added: " + course.getCourseInfo() : "Failed to add course");
        } else if ("update".equals(action)) {
            Course course = buildCourse(request);
            boolean success = courseDAO.updateCourse(course);
            System.out.println(success ? "Course updated successfully" : "Failed to update course");
        } else if ("delete".equals(action)) {
            boolean success = courseDAO.deleteCourse(courseCode);
            System.out.println(success ? "Course deleted successfully" : "Failed to delete course");
        }

        // Sync all courses to courses.txt after every change
        CourseFileHandler.saveAllToFile(courseDAO.getAllCourses());

        return "redirect:/courses";
    }

    private Course buildCourse(HttpServletRequest request) {
        String mode        = request.getParameter("mode");
        String courseCode  = request.getParameter("courseCode");
        String title       = request.getParameter("title");
        int    credits     = Integer.parseInt(request.getParameter("credits"));
        String coordinator = request.getParameter("coordinator");

        if ("Online".equals(mode)) {
            OnlineCourse c = new OnlineCourse();
            c.setCourseCode(courseCode);
            c.setTitle(title);
            c.setCredits(credits);
            c.setMode("Online");
            c.setCoordinator(coordinator);
            c.setPlatformUrl(request.getParameter("platformUrl"));
            return c;
        } else {
            OfflineCourse c = new OfflineCourse();
            c.setCourseCode(courseCode);
            c.setTitle(title);
            c.setCredits(credits);
            c.setMode("Offline");
            c.setCoordinator(coordinator);
            c.setClassroomLocation(request.getParameter("classroomLocation"));
            return c;
        }
    }
}
