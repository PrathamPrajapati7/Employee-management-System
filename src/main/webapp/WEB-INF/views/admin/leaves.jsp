<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Leave Management — Mednet EMS</title>
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
        .card{background:var(--white);border:1px solid var(--g200);border-radius:14px;overflow:hidden;}
        .card-head{padding:16px 20px;border-bottom:1px solid var(--g200);display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px;}
        .card-title{font-size:14px;font-weight:700;color:var(--black);}
        table{width:100%;border-collapse:collapse;}
        thead th{background:var(--g50);color:var(--g500);font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;padding:10px 16px;text-align:left;}
        tbody td{padding:12px 16px;border-bottom:1px solid var(--g100);font-size:13px;color:var(--g700);}
        tbody tr:hover{background:var(--g50);}
        tbody tr:last-child td{border-bottom:none;}
        .badge-pending{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-approved{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-rejected{background:#fee2e2;color:#dc2626;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-sick{background:#ede9fe;color:#6d28d9;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-casual{background:#dbeafe;color:#1d4ed8;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-annual{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .btn-approve{background:#dcfce7;border:1px solid #bbf7d0;color:#15803d;border-radius:7px;padding:4px 10px;font-size:11px;font-weight:700;cursor:pointer;font-family:'Inter',sans-serif;transition:all 0.15s;}
        .btn-approve:hover{background:#15803d;color:var(--white);}
        .btn-reject{background:#fee2e2;border:1px solid #fecaca;color:#dc2626;border-radius:7px;padding:4px 10px;font-size:11px;font-weight:700;cursor:pointer;font-family:'Inter',sans-serif;transition:all 0.15s;}
        .btn-reject:hover{background:#dc2626;color:var(--white);}
        .stat-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:18px;}
        .stat-val{font-size:28px;font-weight:900;color:var(--black);letter-spacing:-1px;}
        .stat-lbl{font-size:12px;color:var(--g500);margin-top:3px;}
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
        <a href="/employee-mgmt/admin/leaves" class="nav-item active"><i class="fas fa-calendar-xmark"></i> Leave Requests</a>
        <a href="/employee-mgmt/admin/tasks" class="nav-item"><i class="fas fa-list-check"></i> Tasks</a>
        <div class="nav-section">Reports</div>
        <a href="/employee-mgmt/admin/export/excel" class="nav-item"><i class="fas fa-file-excel"></i> Export Excel</a>
        <a href="/employee-mgmt/admin/export/pdf" class="nav-item"><i class="fas fa-file-pdf"></i> Export PDF</a>
    </nav>
    <div class="sidebar-footer">
        <div class="user-mini"><div class="user-mini-avatar">${user.name.substring(0,1).toUpperCase()}</div><div><div class="user-mini-name">${user.name}</div><div class="user-mini-role">Administrator</div></div></div>
    </div>
</aside>
<header class="topbar">
    <div class="page-title">Leave Requests</div>
    <div class="topbar-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <a href="/employee-mgmt/logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</header>

<div class="toast-container">
    <c:if test="${not empty success}"><div class="toast-msg" id="toastMsg"><i class="fas fa-check-circle"></i> ${success}</div></c:if>
</div>

<div class="main">
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="stat-card">
                <div class="stat-val">${allLeaves.size()}</div>
                <div class="stat-lbl">Total Requests</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="stat-card">
                <div class="stat-val" style="color:#a16207">${pendingCount}</div>
                <div class="stat-lbl">Pending</div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-head">
            <div class="card-title">All Leave Requests</div>
        </div>
        <table>
            <thead>
                <tr><th>Employee</th><th>Type</th><th>From</th><th>To</th><th>Days</th><th>Reason</th><th>Applied</th><th>Status</th><th>Actions</th></tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty allLeaves}">
                        <tr><td colspan="9" class="no-data"><i class="fas fa-inbox me-2"></i>No leave requests yet.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="lr" items="${allLeaves}">
                        <tr>
                            <td><strong style="color:var(--black)">${lr.employee.name}</strong><br/><small style="color:var(--g400)">${lr.employee.department}</small></td>
                            <td>
                                <c:choose>
                                    <c:when test="${lr.leaveType == 'SICK'}"><span class="badge-sick">Sick</span></c:when>
                                    <c:when test="${lr.leaveType == 'CASUAL'}"><span class="badge-casual">Casual</span></c:when>
                                    <c:when test="${lr.leaveType == 'ANNUAL'}"><span class="badge-annual">Annual</span></c:when>
                                    <c:otherwise><span class="badge-casual">${lr.leaveType}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>${lr.fromDate}</td>
                            <td>${lr.toDate}</td>
                            <td><strong>${lr.days}</strong></td>
                            <td style="max-width:160px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">${lr.reason != null ? lr.reason : '—'}</td>
                            <td>${lr.appliedOn}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${lr.status == 'PENDING'}"><span class="badge-pending">Pending</span></c:when>
                                    <c:when test="${lr.status == 'APPROVED'}"><span class="badge-approved">Approved</span></c:when>
                                    <c:otherwise><span class="badge-rejected">Rejected</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${lr.status == 'PENDING'}">
                                    <div class="d-flex gap-1">
                                        <button class="btn-approve" onclick="leaveAction(${lr.id},'APPROVED')"><i class="fas fa-check"></i></button>
                                        <button class="btn-reject" onclick="leaveAction(${lr.id},'REJECTED')"><i class="fas fa-times"></i></button>
                                    </div>
                                </c:if>
                                <c:if test="${lr.status != 'PENDING'}">
                                    <small style="color:var(--g400)">${lr.adminRemark != null ? lr.adminRemark : '—'}</small>
                                </c:if>
                            </td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<form id="leaveForm" method="post" action="#">
    <input type="hidden" name="action" id="leaveAction"/>
    <input type="hidden" name="remark" id="leaveRemark"/>
</form>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    setInterval(()=>document.getElementById('clock').textContent=new Date().toLocaleTimeString(),1000);
    document.getElementById('clock').textContent=new Date().toLocaleTimeString();
    const toast=document.getElementById('toastMsg');
    if(toast)setTimeout(()=>{toast.style.transition='opacity 0.4s';toast.style.opacity='0';},3500);

    function leaveAction(id, action) {
        const isApprove = action === 'APPROVED';
        Swal.fire({
            title: isApprove ? 'Approve Leave?' : 'Reject Leave?',
            input: 'text',
            inputPlaceholder: 'Optional remark...',
            background: '#fff', color: '#111827',
            showCancelButton: true,
            confirmButtonText: isApprove ? 'Approve' : 'Reject',
            confirmButtonColor: isApprove ? '#15803d' : '#dc2626'
        }).then(r => {
            if (r.isConfirmed) {
                const f = document.getElementById('leaveForm');
                f.action = '/employee-mgmt/admin/leaves/action/' + id;
                document.getElementById('leaveAction').value = action;
                document.getElementById('leaveRemark').value = r.value || '';
                f.submit();
            }
        });
    }
</script>
</body>
</html>


