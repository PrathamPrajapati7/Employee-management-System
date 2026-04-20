package com.emp.controller.admin;

import com.emp.entity.Employee;
import com.emp.entity.LeaveRequest;
import com.emp.entity.Task;
import com.emp.service.EmployeeService;
import com.emp.service.LeaveRequestService;
import com.emp.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminLeaveTaskController {

    @Autowired private LeaveRequestService leaveService;
    @Autowired private TaskService taskService;
    @Autowired private EmployeeService employeeService;

    private Employee getAdmin(HttpSession session) {
        Employee e = (Employee) session.getAttribute("loggedInUser");
        return (e != null && "ADMIN".equals(e.getRole())) ? e : null;
    }

    // ── LEAVE MANAGEMENT ──
    @GetMapping("/leaves")
    public String leaveManagement(HttpSession session, Model model) {
        Employee admin = getAdmin(session);
        if (admin == null) return "redirect:/login";
        model.addAttribute("user", admin);
        model.addAttribute("allLeaves", leaveService.getAll());
        model.addAttribute("pendingCount", leaveService.countPending());
        return "admin/leaves";
    }

    @PostMapping("/leaves/action/{id}")
    public String leaveAction(@PathVariable int id,
                               @RequestParam String action,
                               @RequestParam(required = false) String remark,
                               HttpSession session,
                               RedirectAttributes ra) {
        if (getAdmin(session) == null) return "redirect:/login";
        leaveService.updateStatus(id, action, remark);
        ra.addFlashAttribute("success", "Leave request " + action.toLowerCase() + ".");
        return "redirect:/admin/leaves";
    }

    // ── TASK MANAGEMENT ──
    @GetMapping("/tasks")
    public String taskManagement(HttpSession session, Model model) {
        Employee admin = getAdmin(session);
        if (admin == null) return "redirect:/login";
        model.addAttribute("user", admin);
        model.addAttribute("tasks", taskService.getAll());
        model.addAttribute("employees", employeeService.getByRole("EMPLOYEE"));
        return "admin/tasks";
    }

    @PostMapping("/tasks/assign")
    public String assignTask(@RequestParam String title,
                              @RequestParam(required = false) String description,
                              @RequestParam int assignedToId,
                              @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dueDate,
                              @RequestParam String priority,
                              HttpSession session,
                              RedirectAttributes ra) {
        Employee admin = getAdmin(session);
        if (admin == null) return "redirect:/login";

        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setAssignedTo(employeeService.findById(assignedToId));
        task.setAssignedBy(admin);
        task.setDueDate(dueDate);
        task.setPriority(priority);
        task.setStatus("TODO");
        task.setProgress(0);
        taskService.assign(task);
        ra.addFlashAttribute("success", "Task assigned successfully!");
        return "redirect:/admin/tasks";
    }

    @GetMapping("/tasks/delete/{id}")
    public String deleteTask(@PathVariable int id, HttpSession session, RedirectAttributes ra) {
        if (getAdmin(session) == null) return "redirect:/login";
        taskService.delete(id);
        ra.addFlashAttribute("success", "Task deleted.");
        return "redirect:/admin/tasks";
    }
}
