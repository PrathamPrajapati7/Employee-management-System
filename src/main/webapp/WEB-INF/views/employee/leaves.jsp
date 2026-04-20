<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Leaves — Mednet EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
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
        .user-mini-avatar{width:32px;height:32px;border-radius:8px;background:var(--black);display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:700;color:var(--white);flex-shrink:0;overflow:hidden;}
        .user-mini-avatar img{width:100%;height:100%;object-fit:cover;}
        .user-mini-name{font-size:12px;font-weight:700;color:var(--black);}
        .user-mini-role{font-size:10px;color:var(--g400);}
        .topbar{position:fixed;top:0;left:var(--sidebar);right:0;height:var(--topbar);background:var(--white);border-bottom:1px solid var(--g200);display:flex;align-items:center;justify-content:space-between;padding:0 24px;z-index:100;}
        .page-title{font-size:15px;font-weight:700;color:var(--black);}
        .topbar-right{display:flex;align-items:center;gap:10px;}
        .clock-badge{font-size:12px;color:var(--g500);background:var(--g50);border:1px solid var(--g200);border-radius:100px;padding:5px 12px;font-weight:500;}
        .btn-logout{background:transparent;border:1px solid var(--g200);color:var(--g700);border-radius:100px;padding:6px 14px;font-size:12px;font-weight:600;text-decoration:none;transition:all 0.15s;}
        .btn-logout:hover{background:var(--black);color:var(--white);border-color:var(--black);}
        .main{margin-left:var(--sidebar);margin-top:var(--topbar);padding:24px;flex:1;}
        .form-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:22px;margin-bottom:20px;}
        .card-title{font-size:14px;font-weight:700;color:var(--black);margin-bottom:16px;display:flex;align-items:center;gap:8px;}
        .fld{margin-bottom:14px;}
        .fld label{display:block;font-size:12px;font-weight:600;color:var(--g700);margin-bottom:6px;}
        .inp{width:100%;background:var(--g50);border:1.5px solid var(--g200);border-radius:10px;padding:10px 13px;color:var(--black);font-size:13px;font-family:'Inter',sans-serif;font-weight:500;transition:all 0.2s;outline:none;}
        .inp:focus{background:var(--white);border-color:var(--black);box-shadow:0 0 0 3px rgba(0,0,0,0.06);}
        .inp::placeholder{color:var(--g400);font-weight:400;}
        select.inp option{background:var(--white);}
        textarea.inp{resize:none;}
        .btn-apply{background:var(--black);border:none;color:var(--white);border-radius:10px;padding:11px 24px;font-size:13px;font-weight:700;cursor:pointer;font-family:'Inter',sans-serif;transition:all 0.2s;}
        .btn-apply:hover{background:#222;transform:translateY(-1px);}
        .tbl-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;overflow:hidden;}
        table{width:100%;border-collapse:collapse;}
        thead th{background:var(--g50);color:var(--g500);font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;padding:10px 16px;text-align:left;}
        tbody td{padding:12px 16px;border-bottom:1px solid var(--g100);font-size:13px;color:var(--g700);}
        tbody tr:hover{background:var(--g50);}
        tbody tr:last-child td{border-bottom:none;}
        .badge-pending{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-approved{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-rejected{background:#fee2e2;color:#dc2626;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .toast-container{position:fixed;top:70px;right:20px;z-index:9999;}
        .toast-msg{background:#f0fdf4;border:1px solid #bbf7d0;color:#15803d;border-radius:10px;padding:11px 16px;font-size:13px;font-weight:600;display:flex;align-items:center;gap:8px;animation:slideIn 0.3s ease;}
        @keyframes slideIn{from{opacity:0;transform:translateX(16px)}to{opacity:1;transform:translateX(0)}}
        .no-data{text-align:center;padding:40px;color:var(--g400);font-size:14px;}
        .status-chip{display:inline-flex;align-items:center;gap:6px;background:var(--g100);border:1px solid var(--g200);border-radius:100px;padding:4px 12px;font-size:11px;font-weight:700;color:var(--g700);}
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-logo"><div class="logo-text">Mednet EMS</div></div>
    <nav class="sidebar-nav">
        <div class="nav-section">My Space</div>
        <a href="/employee-mgmt/employee/dashboard" class="nav-item"><i class="fas fa-house"></i> Dashboard</a>
        <a href="/employee-mgmt/employee/profile" class="nav-item"><i class="fas fa-circle-user"></i> My Profile</a>
        <a href="/employee-mgmt/employee/leaves" class="nav-item active"><i class="fas fa-calendar-xmark"></i> My Leaves</a>
        <a href="/employee-mgmt/employee/tasks" class="nav-item"><i class="fas fa-list-check"></i> My Tasks</a>
    </nav>
    <div class="sidebar-footer">
        <div class="user-mini">
            <div class="user-mini-avatar">
                <c:choose>
                    <c:when test="${not empty user.profilePicture}"><img src="/employee-mgmt/uploads/${user.profilePicture}" alt=""/></c:when>
                    <c:otherwise>${user.name.substring(0,1).toUpperCase()}</c:otherwise>
                </c:choose>
            </div>
            <div><div class="user-mini-name">${user.name}</div><div class="user-mini-role">Employee</div></div>
        </div>
    </div>
</aside>
<header class="topbar">
    <div class="page-title">My Leaves</div>
    <div class="topbar-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <a href="/employee-mgmt/logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</header>

<div class="toast-container">
    <c:if test="${not empty success}"><div class="toast-msg" id="toastMsg"><i class="fas fa-check-circle"></i> ${success}</div></c:if>
</div>

<div class="main">
    <!-- APPLY FORM -->
    <div class="form-card">
        <div class="card-title"><i class="fas fa-paper-plane"></i> Apply for Leave</div>
        <form action="/employee-mgmt/employee/leaves/apply" method="post">
            <div class="row g-3">
                <div class="col-md-3 fld"><label>Leave Type *</label>
                    <select name="leaveType" class="inp" required>
                        <option value="">Select type</option>
                        <option value="SICK">Sick Leave</option>
                        <option value="CASUAL">Casual Leave</option>
                        <option value="ANNUAL">Annual Leave</option>
                        <option value="MATERNITY">Maternity Leave</option>
                        <option value="OTHER">Other</option>
                    </select>
                </div>
                <div class="col-md-3 fld"><label>From Date *</label><input type="date" name="fromDate" class="inp" required/></div>
                <div class="col-md-3 fld"><label>To Date *</label><input type="date" name="toDate" class="inp" required/></div>
                <div class="col-md-3 fld"><label>Reason</label><input type="text" name="reason" class="inp" placeholder="Brief reason..."/></div>
            </div>
            <button type="submit" class="btn-apply"><i class="fas fa-paper-plane me-2"></i>Submit Application</button>
        </form>
    </div>

    <!-- LEAVE HISTORY -->
    <div class="tbl-card">
        <div style="padding:14px 18px;border-bottom:1px solid var(--g200);font-size:14px;font-weight:700;color:var(--black);">My Leave History</div>
        <table>
            <thead>
                <tr><th>Type</th><th>From</th><th>To</th><th>Days</th><th>Reason</th><th>Applied On</th><th>Status</th><th>Remark</th></tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty leaves}">
                        <tr><td colspan="8" class="no-data"><i class="fas fa-inbox me-2"></i>No leave applications yet.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="lr" items="${leaves}">
                        <tr>
                            <td><strong>${lr.leaveType}</strong></td>
                            <td>${lr.fromDate}</td>
                            <td>${lr.toDate}</td>
                            <td><strong>${lr.days}</strong></td>
                            <td>${lr.reason != null ? lr.reason : '—'}</td>
                            <td>${lr.appliedOn}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${lr.status == 'PENDING'}"><span class="badge-pending"><i class="fas fa-clock me-1"></i>Pending</span></c:when>
                                    <c:when test="${lr.status == 'APPROVED'}"><span class="badge-approved"><i class="fas fa-check me-1"></i>Approved</span></c:when>
                                    <c:otherwise><span class="badge-rejected"><i class="fas fa-times me-1"></i>Rejected</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td><small style="color:var(--g500)">${lr.adminRemark != null ? lr.adminRemark : '—'}</small></td>
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
</script>
</body>
</html>


