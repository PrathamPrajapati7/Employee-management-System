package com.emp.controller;

import com.emp.entity.Employee;
import com.emp.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @GetMapping("/")
    public String home() { return "redirect:/login"; }

    // ── REGISTER ──
    @GetMapping("/register")
    public String showRegister(HttpSession session) {
        if (session.getAttribute("loggedInUser") != null) return "redirect:/dashboard";
        return "register";
    }

    @PostMapping("/register")
    public String doRegister(
            @RequestParam String name,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateOfBirth,
            @RequestParam(required = false) String gender,
            @RequestParam(required = false) String address,
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String state,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String department,
            @RequestParam(required = false) String designation,
            @RequestParam String loginId,
            @RequestParam String password,
            @RequestParam(value = "profilePic", required = false) MultipartFile profilePic,
            HttpServletRequest request,
            Model model) {

        // Password strength: min 8 chars, at least one uppercase, one digit, one special char
        if (!isStrongPassword(password)) {
            model.addAttribute("error", "Password must be at least 8 characters with uppercase, number and special character.");
            return "register";
        }

        Employee emp = new Employee();
        emp.setName(name);
        emp.setDateOfBirth(dateOfBirth);
        emp.setGender(gender);
        emp.setAddress(address);
        emp.setCity(city);
        emp.setState(state);
        emp.setEmail(email);
        emp.setPhone(phone);
        emp.setDepartment(department);
        emp.setDesignation(designation);
        emp.setJoiningDate(LocalDate.now());
        emp.setLoginId(loginId);
        emp.setPassword(passwordEncoder.encode(password));
        emp.setRole("EMPLOYEE");
        emp.setStatus("ACTIVE");

        // Handle profile picture upload
        if (profilePic != null && !profilePic.isEmpty()) {
            String picPath = saveProfilePicture(profilePic, request);
            if (picPath != null) emp.setProfilePicture(picPath);
        }

        try {
            employeeService.register(emp);
            return "redirect:/login?registered=true";
        } catch (Exception e) {
            model.addAttribute("error", "Login ID already exists. Please choose another.");
            return "register";
        }
    }

    // ── LOGIN ──
    @GetMapping("/login")
    public String showLogin(HttpSession session) {
        if (session.getAttribute("loggedInUser") != null) return "redirect:/dashboard";
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String loginId,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {
        Employee emp = employeeService.findByLoginId(loginId);
        if (emp == null || !passwordEncoder.matches(password, emp.getPassword())) {
            model.addAttribute("error", "Invalid Login ID or Password.");
            return "login";
        }
        if ("INACTIVE".equals(emp.getStatus())) {
            model.addAttribute("error", "Your account has been deactivated. Contact admin.");
            return "login";
        }
        session.setAttribute("loggedInUser", emp);
        return "redirect:/dashboard";
    }

    // ── DASHBOARD ROUTER ──
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session) {
        Employee emp = (Employee) session.getAttribute("loggedInUser");
        if (emp == null) return "redirect:/login";
        return "ADMIN".equals(emp.getRole()) ? "redirect:/admin/dashboard" : "redirect:/employee/dashboard";
    }

    // ── LOGOUT ──
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout=true";
    }

    // ── 403 ──
    @GetMapping("/403")
    public String forbidden() { return "403"; }

    // ── HELPERS ──
    private boolean isStrongPassword(String pwd) {
        if (pwd == null || pwd.length() < 8) return false;
        return pwd.matches(".*[A-Z].*") && pwd.matches(".*[0-9].*") && pwd.matches(".*[^A-Za-z0-9].*");
    }

    private String saveProfilePicture(MultipartFile file, HttpServletRequest request) {
        try {
            String uploadDir = request.getServletContext().getRealPath("/uploads/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
            file.transferTo(new File(dir, filename));
            return filename;
        } catch (IOException e) {
            return null;
        }
    }
}
