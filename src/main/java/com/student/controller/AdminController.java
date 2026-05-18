package com.student.controller;

import com.student.dao.AdminDAO;
import com.student.model.Admin;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admins")
public class AdminController {

    private final AdminDAO adminDAO = new AdminDAO();

    @GetMapping
    public String list(@RequestParam(required = false) String action,
                       @RequestParam(required = false) String id,
                       HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("edit".equals(action)) {
            model.addAttribute("editAdmin", adminDAO.getAdminById(Integer.parseInt(id)));
            return "admin/form";
        } else if ("add".equals(action)) {
            return "admin/form";
        }
        model.addAttribute("admins", adminDAO.getAllAdmins());
        return "admin/list";
    }

    @PostMapping
    public String handle(@RequestParam String action,
                         @RequestParam(required = false) String adminId,
                         @RequestParam(required = false) String username,
                         @RequestParam(required = false) String password,
                         @RequestParam(required = false) String email,
                         @RequestParam(required = false) String role,
                         HttpSession session) {
        if (session.getAttribute("admin") == null) return "redirect:/login";

        if ("add".equals(action)) {
            Admin admin = new Admin();
            admin.setUsername(username);
            admin.setPassword(password);
            admin.setEmail(email);
            admin.setRole(role);
            boolean success = adminDAO.addAdmin(admin);
            System.out.println(success ? "Admin added successfully" : "Failed to add admin");

        } else if ("update".equals(action)) {
            Admin admin = new Admin();
            admin.setAdminId(Integer.parseInt(adminId));
            admin.setUsername(username);
            admin.setPassword(password);
            admin.setEmail(email);
            admin.setRole(role);
            boolean success = adminDAO.updateAdmin(admin);
            System.out.println(success ? "Admin updated successfully" : "Failed to update admin");

        } else if ("delete".equals(action)) {
            boolean success = adminDAO.deleteAdmin(Integer.parseInt(adminId));
            System.out.println(success ? "Admin deleted successfully" : "Failed to delete admin");
        }
        return "redirect:/admins";
    }
}
