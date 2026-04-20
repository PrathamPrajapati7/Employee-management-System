package com.emp.controller.employee;

import com.emp.entity.Employee;
import com.emp.entity.LeaveRequest;
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

@Controller
@RequestMapping("/employee")
public class EmployeeLeaveTaskController {

    @Autowired private LeaveRequestService leaveService;
    @Autowired private TaskService taskService;
    @Autowired private EmployeeService employeeService;

    private Employee getEmployee(HttpSession session) {
        Employee e = (Employee) session.getAttribute("loggedInUser");
        return (e != null && "EMPLOYEE".equals(e.getRole())) ? e : null;
    }

    // ── LEAVE ──
    @GetMapping("/leaves")
    public String myLeaves(HttpSession session, Model model) {
        Employee emp = getEmployee(session);
        if (emp == null) return "redirect:/login";
        model.addAttribute("user", emp);
        model.addAttribute("leaves", leaveService.getByEmployee(emp.getId()));
        return "employee/leaves";
    }

    @PostMapping("/leaves/apply")
    public String applyLeave(@RequestParam String leaveType,
                              @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
                              @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate,
                              @RequestParam(required = false) String reason,
                              HttpSession session,
                              RedirectAttributes ra) {
        Employee emp = getEmployee(session);
        if (emp == null) return "redirect:/login";

        LeaveRequest lr = new LeaveRequest();
        lr.setEmployee(employeeService.findById(emp.getId()));
        lr.setLeaveType(leaveType);
        lr.setFromDate(fromDate);
        lr.setToDate(toDate);
        lr.setReason(reason);
        lr.setStatus("PENDING");
        lr.setAppliedOn(LocalDate.now());
        leaveService.apply(lr);
        ra.addFlashAttribute("success", "Leave application submitted successfully!");
        return "redirect:/employee/leaves";
    }

    // ── TASKS ──
    @GetMapping("/tasks")
    public String myTasks(HttpSession session, Model model) {
        Employee emp = getEmployee(session);
        if (emp == null) return "redirect:/login";
        model.addAttribute("user", emp);
        model.addAttribute("tasks", taskService.getByEmployee(emp.getId()));
        return "employee/tasks";
    }

    @PostMapping("/tasks/update/{id}")
    public String updateTask(@PathVariable int id,
                              @RequestParam int progress,
                              @RequestParam String status,
                              @RequestParam(required = false) String note,
                              HttpSession session,
                              RedirectAttributes ra) {
        if (getEmployee(session) == null) return "redirect:/login";
        taskService.updateProgress(id, progress, status, note);
        ra.addFlashAttribute("success", "Task updated successfully!");
        return "redirect:/employee/tasks";
    }
}
