package com.student.controller;

import com.student.dao.CourseDAO;
import com.student.dao.FeedbackDAO;
import com.student.dao.StudentDAO;
import com.student.model.AnonymousFeedback;
import com.student.model.Feedback;
import com.student.model.StudentFeedback;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/feedback")
public class FeedbackController {

    private final FeedbackDAO feedbackDAO = new FeedbackDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final CourseDAO courseDAO = new CourseDAO();

    @GetMapping
    public String list(@RequestParam(required = false) String action,
                       @RequestParam(required = false) String id,
                       @RequestParam(required = false) String courseCode,
                       HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("edit".equals(action)) {
            model.addAttribute("feedback", feedbackDAO.getFeedbackById(Integer.parseInt(id)));
            model.addAttribute("students", studentDAO.getAllStudents());
            model.addAttribute("courses", courseDAO.getAllCourses());
            return "feedback/form";
        } else if ("add".equals(action)) {
            model.addAttribute("students", studentDAO.getAllStudents());
            model.addAttribute("courses", courseDAO.getAllCourses());
            return "feedback/form";
        } else if ("byCourse".equals(action)) {
            model.addAttribute("feedbackList", feedbackDAO.getFeedbackByCourse(courseCode));
            return "feedback/list";
        }
        model.addAttribute("feedbackList", feedbackDAO.getAllFeedback());
        return "feedback/list";
    }

    @PostMapping
    public String handle(@RequestParam String action,
                         @RequestParam(required = false) String feedbackId,
                         @RequestParam(required = false) String studentId,
                         @RequestParam(required = false) String courseCode,
                         @RequestParam(required = false) String rating,
                         @RequestParam(required = false) String comment,
                         @RequestParam(required = false) String submissionDate,
                         @RequestParam(required = false) String isAnonymous,
                         @RequestParam(required = false) String studentName,
                         HttpSession session) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("add".equals(action)) {
            Feedback feedback = buildFeedback(0, studentId, courseCode, rating, comment,
                    submissionDate, isAnonymous, studentName);
            System.out.println(feedback.displayFeedback());
            boolean success = feedbackDAO.addFeedback(feedback);
            System.out.println(success ? "Feedback added successfully" : "Failed to add feedback");

        } else if ("update".equals(action)) {
            Feedback feedback = buildFeedback(Integer.parseInt(feedbackId), studentId, courseCode,
                    rating, comment, submissionDate, isAnonymous, studentName);
            boolean success = feedbackDAO.updateFeedback(feedback);
            System.out.println(success ? "Feedback updated successfully" : "Failed to update feedback");

        } else if ("delete".equals(action)) {
            boolean success = feedbackDAO.deleteFeedback(Integer.parseInt(feedbackId));
            System.out.println(success ? "Feedback deleted successfully" : "Failed to delete feedback");
        }
        return "redirect:/feedback";
    }

    private Feedback buildFeedback(int id, String studentId, String courseCode,
                                   String rating, String comment, String submissionDate,
                                   String isAnonymousParam, String studentName) {
        boolean anonymous = "true".equals(isAnonymousParam) || "on".equals(isAnonymousParam);
        int ratingVal = Integer.parseInt(rating);

        if (anonymous) {
            return new AnonymousFeedback(id, studentId, courseCode, ratingVal, comment, submissionDate);
        } else {
            return new StudentFeedback(id, studentId, courseCode, ratingVal, comment, submissionDate, studentName);
        }
    }
}
