package com.emp.controller.employee;

import com.emp.entity.Employee;
import com.emp.service.EmployeeService;
import com.emp.service.LeaveRequestService;
import com.emp.service.TaskService;
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
@RequestMapping("/employee")
public class EmployeeSelfController {

    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private LeaveRequestService leaveRequestService;
    @Autowired
    private TaskService taskService;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    private Employee getEmployee(HttpSession session) {
        Employee e = (Employee) session.getAttribute("loggedInUser");
        return (e != null && "EMPLOYEE".equals(e.getRole())) ? e : null;
    }

    // ── DASHBOARD ──
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Employee emp = getEmployee(session);
        if (emp == null) return "redirect:/login";
        // Refresh from DB to get latest data
        Employee fresh = employeeService.findById(emp.getId());
        session.setAttribute("loggedInUser", fresh);
        model.addAttribute("user", fresh);
        // Leave & task summary
        long pendingLeaves = leaveRequestService.getByEmployee(fresh.getId()).stream().filter(l -> "PENDING".equals(l.getStatus())).count();
        long myTasks = taskService.getByEmployee(fresh.getId()).size();
        long myCompletedTasks = taskService.getByEmployee(fresh.getId()).stream().filter(t -> "COMPLETED".equals(t.getStatus())).count();
        model.addAttribute("pendingLeaves", pendingLeaves);
        model.addAttribute("myTasks", myTasks);
        model.addAttribute("myCompletedTasks", myCompletedTasks);
        return "employee/dashboard";
    }

    // ── VIEW PROFILE ──
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Employee emp = getEmployee(session);
        if (emp == null) return "redirect:/login";
        model.addAttribute("user", emp);
        model.addAttribute("emp", employeeService.findById(emp.getId()));
        return "employee/profile";
    }

    // ── EDIT OWN PROFILE ──
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam(required = false) String address,
                                 @RequestParam(required = false) String city,
                                 @RequestParam(required = false) String state,
                                 @RequestParam(required = false) String phone,
                                 @RequestParam(value = "profilePic", required = false) MultipartFile profilePic,
                                 HttpServletRequest request,
                                 HttpSession session,
                                 RedirectAttributes ra) {
        Employee emp = getEmployee(session);
        if (emp == null) return "redirect:/login";

        Employee fresh = employeeService.findById(emp.getId());
        fresh.setAddress(address);
        fresh.setCity(city);
        fresh.setState(state);
        fresh.setPhone(phone);

        if (profilePic != null && !profilePic.isEmpty()) {
            String pic = saveProfilePicture(profilePic, request);
            if (pic != null) fresh.setProfilePicture(pic);
        }

        employeeService.update(fresh);
        session.setAttribute("loggedInUser", fresh);
        ra.addFlashAttribute("success", "Profile updated successfully!");
        return "redirect:/employee/profile";
    }

    // ── CHANGE PASSWORD ──
    @PostMapping("/change-password")
    public String changePassword(@RequestParam String currentPassword,
                                  @RequestParam String newPassword,
                                  @RequestParam String confirmPassword,
                                  HttpSession session,
                                  RedirectAttributes ra) {
        Employee emp = getEmployee(session);
        if (emp == null) return "redirect:/login";

        Employee fresh = employeeService.findById(emp.getId());

        if (!passwordEncoder.matches(currentPassword, fresh.getPassword())) {
            ra.addFlashAttribute("pwdError", "Current password is incorrect.");
            return "redirect:/employee/profile";
        }
        if (!newPassword.equals(confirmPassword)) {
            ra.addFlashAttribute("pwdError", "New passwords do not match.");
            return "redirect:/employee/profile";
        }
        if (!isStrongPassword(newPassword)) {
            ra.addFlashAttribute("pwdError", "Password must be 8+ chars with uppercase, number and special character.");
            return "redirect:/employee/profile";
        }

        fresh.setPassword(passwordEncoder.encode(newPassword));
        employeeService.update(fresh);
        ra.addFlashAttribute("success", "Password changed successfully!");
        return "redirect:/employee/profile";
    }

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
