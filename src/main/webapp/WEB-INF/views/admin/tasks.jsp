<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Task Management — Mednet EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet"/>
    <style>
        :root{--black:#0a0a0a;--white:#fff;--g50:#f9fafb;--g100:#f3f4f6;--g200:#e5e7eb;--g400:#9ca3af;--g500:#6b7280;--g700:#374151;--g900:#111827;--sidebar:224px;--topbar:60px;}
        *{margin:0;padding:0;box-sizing:border-box;}
        body{font-family:'Inter',sans-serif;background:var(--g50);color:var(--g900);min-height:100vh;display:flex;}
        .sidebar{width:var(--sidebar);background:var(--white);border-right:1px solid var(--g200);display:flex;flex-direction:column;position:fixed;top:0;left:0;height:100vh;z-index:200;}
        .sidebar-logo{padding:18px 20px;border-bottom:1px solid var(--g200);display:flex;align-items:center;}
        
        .logo-text{font-size:15px;font-weight:800;color:var(--black);letter-spacing:-0.4px;}
        .sidebar-nav{flex:1;padding:14px 10px;overflow-y:auto;}
        .nav-section{font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:1px;color:var(--g400);padding:10px 10px 5px;margin-top:4px;}
        .nav-item{display:flex;align-items:center;gap:9px;padding:9px 11px;border-radius:9px;color:var(--g500);font-size:13px;font-weight:600;text-decoration:none;transition:all 0.15s;margin-bottom:1px;}
        .nav-item:hover{background:var(--g100);color:var(--black);}
        .nav-item.active{background:var(--black);color:var(--white);}
        .nav-item i{width:15px;text-align:center;font-size:12px;flex-shrink:0;}
        .sidebar-footer{padding:14px;border-top:1px solid var(--g200);}
        .user-mini{display:flex;align-items:center;gap:9px;}
        .user-mini-avatar{width:32px;height:32px;border-radius:8px;background:var(--black);display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:700;color:var(--white);flex-shrink:0;}
        .user-mini-name{font-size:12px;font-weight:700;color:var(--black);}
        .user-mini-role{font-size:10px;color:var(--g400);}
        .topbar{position:fixed;top:0;left:var(--sidebar);right:0;height:var(--topbar);background:var(--white);border-bottom:1px solid var(--g200);display:flex;align-items:center;justify-content:space-between;padding:0 24px;z-index:100;}
        .page-title{font-size:15px;font-weight:700;color:var(--black);}
        .topbar-right{display:flex;align-items:center;gap:10px;}
        .clock-badge{font-size:12px;color:var(--g500);background:var(--g50);border:1px solid var(--g200);border-radius:100px;padding:5px 12px;font-weight:500;}
        .btn-logout{background:transparent;border:1px solid var(--g200);color:var(--g700);border-radius:100px;padding:6px 14px;font-size:12px;font-weight:600;text-decoration:none;transition:all 0.15s;}
        .btn-logout:hover{background:var(--black);color:var(--white);border-color:var(--black);}
        .main{margin-left:var(--sidebar);margin-top:var(--topbar);padding:24px;flex:1;}
        .card{background:var(--white);border:1px solid var(--g200);border-radius:14px;overflow:hidden;margin-bottom:20px;}
        .card-head{padding:16px 20px;border-bottom:1px solid var(--g200);display:flex;justify-content:space-between;align-items:center;}
        .card-title{font-size:14px;font-weight:700;color:var(--black);}
        .form-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:22px;margin-bottom:20px;}
        .fld{margin-bottom:14px;}
        .fld label{display:block;font-size:12px;font-weight:600;color:var(--g700);margin-bottom:6px;}
        .inp{width:100%;background:var(--g50);border:1.5px solid var(--g200);border-radius:10px;padding:10px 13px;color:var(--black);font-size:13px;font-family:'Inter',sans-serif;font-weight:500;transition:all 0.2s;outline:none;}
        .inp:focus{background:var(--white);border-color:var(--black);box-shadow:0 0 0 3px rgba(0,0,0,0.06);}
        .inp::placeholder{color:var(--g400);font-weight:400;}
        select.inp option{background:var(--white);}
        textarea.inp{resize:none;}
        .btn-assign{background:var(--black);border:none;color:var(--white);border-radius:10px;padding:11px 24px;font-size:13px;font-weight:700;cursor:pointer;font-family:'Inter',sans-serif;transition:all 0.2s;}
        .btn-assign:hover{background:#222;transform:translateY(-1px);}
        table{width:100%;border-collapse:collapse;}
        thead th{background:var(--g50);color:var(--g500);font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;padding:10px 16px;text-align:left;}
        tbody td{padding:12px 16px;border-bottom:1px solid var(--g100);font-size:13px;color:var(--g700);}
        tbody tr:hover{background:var(--g50);}
        tbody tr:last-child td{border-bottom:none;}
        .progress-wrap{background:var(--g200);border-radius:100px;height:8px;width:120px;overflow:hidden;}
        .progress-bar{height:100%;border-radius:100px;transition:width 0.4s;}
        .badge-todo{background:var(--g100);color:var(--g700);padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-inprog{background:#dbeafe;color:#1d4ed8;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-done{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-hold{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-low{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-med{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-high{background:#fee2e2;color:#dc2626;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-crit{background:#111827;color:#fff;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .btn-del{background:#fee2e2;border:1px solid #fecaca;color:#dc2626;border-radius:7px;padding:4px 9px;font-size:11px;font-weight:700;text-decoration:none;transition:all 0.15s;}
        .btn-del:hover{background:#dc2626;color:var(--white);}
        .toast-container{position:fixed;top:70px;right:20px;z-index:9999;}
        .toast-msg{background:#f0fdf4;border:1px solid #bbf7d0;color:#15803d;border-radius:10px;padding:11px 16px;font-size:13px;font-weight:600;display:flex;align-items:center;gap:8px;animation:slideIn 0.3s ease;}
        @keyframes slideIn{from{opacity:0;transform:translateX(16px)}to{opacity:1;transform:translateX(0)}}
        .no-data{text-align:center;padding:40px;color:var(--g400);font-size:14px;}
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-logo"><div class="logo-text">Mednet EMS</div></div>
    <nav class="sidebar-nav">
        <div class="nav-section">Main</div>
        <a href="/employee-mgmt/admin/dashboard" class="nav-item"><i class="fas fa-chart-pie"></i> Dashboard</a>
        <a href="/employee-mgmt/admin/employees" class="nav-item"><i class="fas fa-users"></i> Employees</a>
        <a href="/employee-mgmt/admin/add-employee" class="nav-item"><i class="fas fa-user-plus"></i> Add Employee</a>
        <div class="nav-section">Management</div>
        <a href="/employee-mgmt/admin/leaves" class="nav-item"><i class="fas fa-calendar-xmark"></i> Leave Requests</a>
        <a href="/employee-mgmt/admin/tasks" class="nav-item active"><i class="fas fa-list-check"></i> Tasks</a>
        <div class="nav-section">Reports</div>
        <a href="/employee-mgmt/admin/export/excel" class="nav-item"><i class="fas fa-file-excel"></i> Export Excel</a>
        <a href="/employee-mgmt/admin/export/pdf" class="nav-item"><i class="fas fa-file-pdf"></i> Export PDF</a>
    </nav>
    <div class="sidebar-footer">
        <div class="user-mini"><div class="user-mini-avatar">${user.name.substring(0,1).toUpperCase()}</div><div><div class="user-mini-name">${user.name}</div><div class="user-mini-role">Administrator</div></div></div>
    </div>
</aside>
<header class="topbar">
    <div class="page-title">Task Management</div>
    <div class="topbar-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <a href="/employee-mgmt/logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</header>

<div class="toast-container">
    <c:if test="${not empty success}"><div class="toast-msg" id="toastMsg"><i class="fas fa-check-circle"></i> ${success}</div></c:if>
</div>

<div class="main">
    <!-- ASSIGN TASK FORM -->
    <div class="form-card">
        <div style="font-size:14px;font-weight:700;color:var(--black);margin-bottom:18px;display:flex;align-items:center;gap:8px;"><i class="fas fa-plus-circle"></i> Assign New Task</div>
        <form action="/employee-mgmt/admin/tasks/assign" method="post">
            <div class="row g-3">
                <div class="col-md-4 fld"><label>Task Title *</label><input type="text" name="title" class="inp" placeholder="e.g. Fix login bug" required/></div>
                <div class="col-md-4 fld"><label>Assign To *</label>
                    <select name="assignedToId" class="inp" required>
                        <option value="">Select Employee</option>
                        <c:forEach var="emp" items="${employees}">
                            <option value="${emp.id}">${emp.name} — ${emp.department != null ? emp.department : 'No Dept'}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2 fld"><label>Priority</label>
                    <select name="priority" class="inp">
                        <option value="LOW">Low</option>
                        <option value="MEDIUM" selected>Medium</option>
                        <option value="HIGH">High</option>
                        <option value="CRITICAL">Critical</option>
                    </select>
                </div>
                <div class="col-md-2 fld"><label>Due Date</label><input type="date" name="dueDate" class="inp"/></div>
                <div class="col-12 fld"><label>Description</label><textarea name="description" class="inp" rows="2" placeholder="Task details..."></textarea></div>
            </div>
            <button type="submit" class="btn-assign"><i class="fas fa-paper-plane me-2"></i>Assign Task</button>
        </form>
    </div>

    <!-- TASKS TABLE -->
    <div class="card">
        <div class="card-head"><div class="card-title">All Tasks (${tasks.size()})</div></div>
        <table>
            <thead>
                <tr><th>Title</th><th>Assigned To</th><th>Priority</th><th>Due Date</th><th>Status</th><th>Progress</th><th>Note</th><th>Action</th></tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty tasks}">
                        <tr><td colspan="8" class="no-data"><i class="fas fa-clipboard me-2"></i>No tasks assigned yet.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="task" items="${tasks}">
                        <tr>
                            <td><strong style="color:var(--black)">${task.title}</strong><br/><small style="color:var(--g400)">${task.description != null ? task.description.length() > 40 ? task.description.substring(0,40).concat('...') : task.description : ''}</small></td>
                            <td>${task.assignedTo.name}<br/><small style="color:var(--g400)">${task.assignedTo.department}</small></td>
                            <td>
                                <c:choose>
                                    <c:when test="${task.priority == 'LOW'}"><span class="badge-low">Low</span></c:when>
                                    <c:when test="${task.priority == 'MEDIUM'}"><span class="badge-med">Medium</span></c:when>
                                    <c:when test="${task.priority == 'HIGH'}"><span class="badge-high">High</span></c:when>
                                    <c:otherwise><span class="badge-crit">Critical</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>${task.dueDate != null ? task.dueDate : '—'}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${task.status == 'TODO'}"><span class="badge-todo">To Do</span></c:when>
                                    <c:when test="${task.status == 'IN_PROGRESS'}"><span class="badge-inprog">In Progress</span></c:when>
                                    <c:when test="${task.status == 'COMPLETED'}"><span class="badge-done">Completed</span></c:when>
                                    <c:otherwise><span class="badge-hold">On Hold</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="progress-wrap">
                                    <div class="progress-bar" data-progress="${task.progress}" style="width:${task.progress}%"></div>
                                </div>
                                <small style="color:var(--g500)">${task.progress}%</small>
                            </td>
                            <td><small style="color:var(--g500)">${task.employeeNote != null ? task.employeeNote : '—'}</small></td>
                            <td><a href="/employee-mgmt/admin/tasks/delete/${task.id}" class="btn-del" onclick="return confirm('Delete this task?')"><i class="fas fa-trash"></i></a></td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
<script>
    setInterval(()=>document.getElementById('clock').textContent=new Date().toLocaleTimeString(),1000);
    document.getElementById('clock').textContent=new Date().toLocaleTimeString();
    const toast=document.getElementById('toastMsg');
    if(toast)setTimeout(()=>{toast.style.transition='opacity 0.4s';toast.style.opacity='0';},3500);
    document.querySelectorAll('.progress-bar').forEach(bar => {
        const p = parseInt(bar.dataset.progress);
        bar.style.background = p === 100 ? '#15803d' : p >= 50 ? '#1d4ed8' : '#d97706';
    });
</script>
</body>
</html>


