package com.emp.controller.admin;

import com.emp.entity.Employee;
import com.emp.service.EmployeeService;
import com.emp.service.LeaveRequestService;
import com.emp.service.TaskService;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private LeaveRequestService leaveRequestService;
    @Autowired
    private TaskService taskService;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    private static final int PAGE_SIZE = 8;

    // ── GUARD ──
    private Employee getAdmin(HttpSession session) {
        Employee e = (Employee) session.getAttribute("loggedInUser");
        return (e != null && "ADMIN".equals(e.getRole())) ? e : null;
    }

    // ── DASHBOARD ──
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Employee admin = getAdmin(session);
        if (admin == null) return "redirect:/login";

        List<Employee> all = employeeService.getAllEmployees();
        long active   = all.stream().filter(e -> "ACTIVE".equals(e.getStatus())).count();
        long inactive = all.stream().filter(e -> "INACTIVE".equals(e.getStatus())).count();
        long onLeave  = all.stream().filter(e -> "ON_LEAVE".equals(e.getStatus())).count();
        long male     = all.stream().filter(e -> "Male".equals(e.getGender())).count();
        long female   = all.stream().filter(e -> "Female".equals(e.getGender())).count();
        long other    = all.stream().filter(e -> !"Male".equals(e.getGender()) && !"Female".equals(e.getGender())).count();

        Map<String, Long> deptMap = all.stream()
                .collect(Collectors.groupingBy(e -> e.getDepartment() != null ? e.getDepartment() : "Unassigned", Collectors.counting()));
        Map<String, Long> cityMap = all.stream()
                .collect(Collectors.groupingBy(e -> e.getCity() != null ? e.getCity() : "Unknown", Collectors.counting()));

        model.addAttribute("user", admin);
        model.addAttribute("totalCount", all.size());
        model.addAttribute("activeCount", active);
        model.addAttribute("inactiveCount", inactive);
        model.addAttribute("onLeaveCount", onLeave);
        model.addAttribute("maleCount", male);
        model.addAttribute("femaleCount", female);
        model.addAttribute("otherCount", other);
        model.addAttribute("deptLabels", deptMap.keySet());
        model.addAttribute("deptData", deptMap.values());
        model.addAttribute("cityLabels", cityMap.keySet());
        model.addAttribute("cityData", cityMap.values());
        model.addAttribute("recentEmployees", all.stream().limit(5).collect(Collectors.toList()));

        // Leave & Task stats
        long pendingLeaves = leaveRequestService.countPending();
        long totalTasks = taskService.getAll().size();
        long completedTasks = taskService.getAll().stream().filter(t -> "COMPLETED".equals(t.getStatus())).count();
        model.addAttribute("pendingLeaves", pendingLeaves);
        model.addAttribute("totalTasks", totalTasks);
        model.addAttribute("completedTasks", completedTasks);
        return "admin/dashboard";
    }

    // ── MANAGE EMPLOYEES (paginated) ──
    @GetMapping("/employees")
    public String manageEmployees(@RequestParam(defaultValue = "1") int page,
                                   @RequestParam(defaultValue = "") String search,
                                   HttpSession session, Model model) {
        Employee admin = getAdmin(session);
        if (admin == null) return "redirect:/login";

        List<Employee> all = employeeService.getAllEmployees();

        // Filter by search
        if (!search.isEmpty()) {
            String q = search.toLowerCase();
            all = all.stream().filter(e ->
                    (e.getName() != null && e.getName().toLowerCase().contains(q)) ||
                    (e.getEmail() != null && e.getEmail().toLowerCase().contains(q)) ||
                    (e.getDepartment() != null && e.getDepartment().toLowerCase().contains(q)) ||
                    (e.getCity() != null && e.getCity().toLowerCase().contains(q)) ||
                    (e.getLoginId() != null && e.getLoginId().toLowerCase().contains(q))
            ).collect(Collectors.toList());
        }

        int total = all.size();
        int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);
        page = Math.max(1, Math.min(page, Math.max(1, totalPages)));
        int from = (page - 1) * PAGE_SIZE;
        int to   = Math.min(from + PAGE_SIZE, total);
        List<Employee> paged = all.subList(from, to);

        model.addAttribute("user", admin);
        model.addAttribute("employees", paged);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", total);
        model.addAttribute("search", search);
        return "admin/manage-employees";
    }

    // ── ADD EMPLOYEE (admin creates) ──
    @GetMapping("/add-employee")
    public String showAdd(HttpSession session, Model model) {
        Employee admin = getAdmin(session);
        if (admin == null) return "redirect:/login";
        model.addAttribute("user", admin);
        return "admin/add-employee";
    }

    @PostMapping("/add-employee")
    public String doAdd(@RequestParam String name,
                        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateOfBirth,
                        @RequestParam(required = false) String gender,
                        @RequestParam(required = false) String address,
                        @RequestParam(required = false) String city,
                        @RequestParam(required = false) String state,
                        @RequestParam(required = false) String email,
                        @RequestParam(required = false) String phone,
                        @RequestParam(required = false) String department,
                        @RequestParam(required = false) String designation,
                        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate joiningDate,
                        @RequestParam String loginId,
                        @RequestParam String password,
                        @RequestParam String role,
                        @RequestParam String status,
                        @RequestParam(value = "profilePic", required = false) MultipartFile profilePic,
                        HttpServletRequest request,
                        HttpSession session,
                        RedirectAttributes ra) {
        if (getAdmin(session) == null) return "redirect:/login";

        Employee emp = new Employee();
        emp.setName(name); emp.setDateOfBirth(dateOfBirth); emp.setGender(gender);
        emp.setAddress(address); emp.setCity(city); emp.setState(state);
        emp.setEmail(email); emp.setPhone(phone); emp.setDepartment(department);
        emp.setDesignation(designation);
        emp.setJoiningDate(joiningDate != null ? joiningDate : LocalDate.now());
        emp.setLoginId(loginId);
        emp.setPassword(passwordEncoder.encode(password));
        emp.setRole(role); emp.setStatus(status);

        if (profilePic != null && !profilePic.isEmpty()) {
            String pic = saveProfilePicture(profilePic, request);
            if (pic != null) emp.setProfilePicture(pic);
        }

        try {
            employeeService.register(emp);
            ra.addFlashAttribute("success", "Employee \"" + name + "\" added successfully!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Login ID already exists.");
        }
        return "redirect:/admin/employees";
    }

    // ── EDIT EMPLOYEE ──
    @GetMapping("/edit/{id}")
    public String showEdit(@PathVariable int id, HttpSession session, Model model) {
        Employee admin = getAdmin(session);
        if (admin == null) return "redirect:/login";
        model.addAttribute("user", admin);
        model.addAttribute("emp", employeeService.findById(id));
        return "admin/edit-employee";
    }

    @PostMapping("/edit/{id}")
    public String doEdit(@PathVariable int id,
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
                         @RequestParam String role,
                         @RequestParam String status,
                         @RequestParam(value = "profilePic", required = false) MultipartFile profilePic,
                         HttpServletRequest request,
                         HttpSession session,
                         RedirectAttributes ra) {
        if (getAdmin(session) == null) return "redirect:/login";

        Employee emp = employeeService.findById(id);
        emp.setName(name); emp.setDateOfBirth(dateOfBirth); emp.setGender(gender);
        emp.setAddress(address); emp.setCity(city); emp.setState(state);
        emp.setEmail(email); emp.setPhone(phone); emp.setDepartment(department);
        emp.setDesignation(designation); emp.setRole(role); emp.setStatus(status);

        if (profilePic != null && !profilePic.isEmpty()) {
            String pic = saveProfilePicture(profilePic, request);
            if (pic != null) emp.setProfilePicture(pic);
        }

        employeeService.update(emp);
        ra.addFlashAttribute("success", "Employee updated successfully!");
        return "redirect:/admin/employees";
    }

    // ── DELETE ──
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id, HttpSession session, RedirectAttributes ra) {
        if (getAdmin(session) == null) return "redirect:/login";
        employeeService.delete(id);
        ra.addFlashAttribute("success", "Employee deleted successfully.");
        return "redirect:/admin/employees";
    }

    // ── STATUS TOGGLE ──
    @PostMapping("/status/{id}")
    public String updateStatus(@PathVariable int id,
                                @RequestParam String status,
                                HttpSession session,
                                RedirectAttributes ra) {
        if (getAdmin(session) == null) return "redirect:/login";
        employeeService.updateStatus(id, status);
        ra.addFlashAttribute("success", "Status updated.");
        return "redirect:/admin/employees";
    }

    // ── RESET PASSWORD ──
    @PostMapping("/reset-password/{id}")
    public String resetPassword(@PathVariable int id,
                                 @RequestParam String newPassword,
                                 HttpSession session,
                                 RedirectAttributes ra) {
        if (getAdmin(session) == null) return "redirect:/login";
        Employee emp = employeeService.findById(id);
        emp.setPassword(passwordEncoder.encode(newPassword));
        employeeService.update(emp);
        ra.addFlashAttribute("success", "Password reset successfully.");
        return "redirect:/admin/employees";
    }

    // ── EXPORT EXCEL ──
    @GetMapping("/export/excel")
    public void exportExcel(HttpSession session, HttpServletResponse response) throws IOException {
        if (getAdmin(session) == null) { response.sendRedirect("/login"); return; }

        List<Employee> employees = employeeService.getAllEmployees();
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Employees");

        // Header style
        CellStyle headerStyle = wb.createCellStyle();
        Font headerFont = wb.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);
        headerStyle.setFillForegroundColor(IndexedColors.INDIGO.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        String[] headers = {"ID","Name","Email","Phone","Gender","Department","Designation","City","State","Status","Role","Joining Date","Login ID"};
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }

        int rowNum = 1;
        for (Employee e : employees) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(e.getId());
            row.createCell(1).setCellValue(e.getName());
            row.createCell(2).setCellValue(e.getEmail() != null ? e.getEmail() : "");
            row.createCell(3).setCellValue(e.getPhone() != null ? e.getPhone() : "");
            row.createCell(4).setCellValue(e.getGender() != null ? e.getGender() : "");
            row.createCell(5).setCellValue(e.getDepartment() != null ? e.getDepartment() : "");
            row.createCell(6).setCellValue(e.getDesignation() != null ? e.getDesignation() : "");
            row.createCell(7).setCellValue(e.getCity() != null ? e.getCity() : "");
            row.createCell(8).setCellValue(e.getState() != null ? e.getState() : "");
            row.createCell(9).setCellValue(e.getStatus());
            row.createCell(10).setCellValue(e.getRole());
            row.createCell(11).setCellValue(e.getJoiningDate() != null ? e.getJoiningDate().toString() : "");
            row.createCell(12).setCellValue(e.getLoginId());
        }

        for (int i = 0; i < headers.length; i++) sheet.autoSizeColumn(i);

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=employees.xlsx");
        wb.write(response.getOutputStream());
        wb.close();
    }

    // ── EXPORT PDF ──
    @GetMapping("/export/pdf")
    public void exportPdf(HttpSession session, HttpServletResponse response) throws IOException, DocumentException {
        if (getAdmin(session) == null) { response.sendRedirect("/login"); return; }

        List<Employee> employees = employeeService.getAllEmployees();

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=employees.pdf");

        Document doc = new Document(PageSize.A4.rotate());
        PdfWriter.getInstance(doc, response.getOutputStream());
        doc.open();

        // Title
        com.itextpdf.text.Font titleFont = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 16, com.itextpdf.text.Font.BOLD);
        Paragraph title = new Paragraph("Mednet EMS — Employee Report", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        doc.add(title);

        // Table
        PdfPTable table = new PdfPTable(8);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{1.5f, 3f, 3f, 2f, 2f, 2f, 2f, 2f});

        com.itextpdf.text.Font hFont = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 9, com.itextpdf.text.Font.BOLD, BaseColor.WHITE);
        BaseColor headerBg = new BaseColor(99, 102, 241);
        String[] cols = {"ID","Name","Email","Department","City","Status","Role","Joining Date"};
        for (String col : cols) {
            PdfPCell cell = new PdfPCell(new Phrase(col, hFont));
            cell.setBackgroundColor(headerBg);
            cell.setPadding(6);
            table.addCell(cell);
        }

        com.itextpdf.text.Font rowFont = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 8);
        boolean alt = false;
        for (Employee e : employees) {
            BaseColor bg = alt ? new BaseColor(240, 240, 255) : BaseColor.WHITE;
            String[] vals = {
                String.valueOf(e.getId()), e.getName(),
                e.getEmail() != null ? e.getEmail() : "",
                e.getDepartment() != null ? e.getDepartment() : "",
                e.getCity() != null ? e.getCity() : "",
                e.getStatus(), e.getRole(),
                e.getJoiningDate() != null ? e.getJoiningDate().toString() : ""
            };
            for (String v : vals) {
                PdfPCell cell = new PdfPCell(new Phrase(v, rowFont));
                cell.setBackgroundColor(bg);
                cell.setPadding(5);
                table.addCell(cell);
            }
            alt = !alt;
        }
        doc.add(table);
        doc.close();
    }

    // ── HELPER ──
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
