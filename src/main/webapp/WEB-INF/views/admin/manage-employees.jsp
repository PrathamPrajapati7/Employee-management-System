<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Manage Employees — Mednet EMS</title>
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
        .tbl-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;overflow:hidden;}
        .tbl-head{padding:14px 18px;border-bottom:1px solid var(--g200);display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap;}
        .tbl-title{font-size:14px;font-weight:700;color:var(--black);}
        .search-wrap{position:relative;}
        .search-ico{position:absolute;left:11px;top:50%;transform:translateY(-50%);color:var(--g400);font-size:12px;}
        .search-inp{background:var(--g50);border:1.5px solid var(--g200);color:var(--black);border-radius:9px;padding:7px 12px 7px 32px;font-size:13px;width:200px;outline:none;font-family:'Inter',sans-serif;transition:all 0.2s;}
        .search-inp:focus{border-color:var(--black);background:var(--white);}
        .search-inp::placeholder{color:var(--g400);}
        table{width:100%;border-collapse:collapse;}
        thead th{background:var(--g50);color:var(--g500);font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;padding:10px 14px;cursor:pointer;user-select:none;white-space:nowrap;text-align:left;}
        thead th:hover{color:var(--black);}
        tbody td{padding:11px 14px;border-bottom:1px solid var(--g100);font-size:13px;color:var(--g700);}
        tbody tr:hover{background:var(--g50);}
        tbody tr:last-child td{border-bottom:none;}
        .emp-avatar{width:30px;height:30px;border-radius:8px;background:var(--black);display:inline-flex;align-items:center;justify-content:center;font-size:11px;font-weight:700;color:var(--white);margin-right:8px;vertical-align:middle;overflow:hidden;flex-shrink:0;}
        .emp-avatar img{width:100%;height:100%;object-fit:cover;}
        .badge-active{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-inactive{background:#fee2e2;color:#dc2626;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-leave{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-admin{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-emp{background:#ede9fe;color:#6d28d9;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .btn-act{border-radius:7px;padding:4px 9px;font-size:11px;font-weight:600;transition:all 0.15s;border:1px solid;cursor:pointer;font-family:'Inter',sans-serif;text-decoration:none;display:inline-block;}
        .btn-edit-act{background:var(--g50);border-color:var(--g200);color:var(--g700);}
        .btn-edit-act:hover{background:var(--black);color:var(--white);border-color:var(--black);}
        .btn-del-act{background:#fee2e2;border-color:#fecaca;color:#dc2626;}
        .btn-del-act:hover{background:#dc2626;color:var(--white);border-color:#dc2626;}
        .btn-status-act{background:#fef9c3;border-color:#fde68a;color:#a16207;}
        .btn-status-act:hover{background:#d97706;color:var(--white);border-color:#d97706;}
        .btn-pwd-act{background:#ede9fe;border-color:#ddd6fe;color:#6d28d9;}
        .btn-pwd-act:hover{background:#7c3aed;color:var(--white);border-color:#7c3aed;}
        .pagination-wrap{padding:12px 18px;border-top:1px solid var(--g200);display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:8px;}
        .page-info{font-size:12px;color:var(--g500);}
        .page-btns{display:flex;gap:4px;}
        .page-btn{background:var(--white);border:1px solid var(--g200);color:var(--g700);border-radius:7px;padding:5px 10px;font-size:12px;font-weight:600;text-decoration:none;transition:all 0.15s;}
        .page-btn:hover{background:var(--black);color:var(--white);border-color:var(--black);}
        .page-btn.active{background:var(--black);color:var(--white);border-color:var(--black);}
        .page-btn.disabled{opacity:0.35;pointer-events:none;}
        .btn-export{display:inline-flex;align-items:center;gap:6px;border-radius:9px;padding:7px 13px;font-size:12px;font-weight:700;text-decoration:none;transition:all 0.15s;border:1px solid;}
        .btn-excel{background:#dcfce7;border-color:#bbf7d0;color:#15803d;}
        .btn-excel:hover{background:#15803d;color:var(--white);}
        .btn-pdf{background:#fee2e2;border-color:#fecaca;color:#dc2626;}
        .btn-pdf:hover{background:#dc2626;color:var(--white);}
        .btn-add{background:var(--black);border:none;color:var(--white);border-radius:9px;padding:7px 15px;font-size:12px;font-weight:700;text-decoration:none;transition:all 0.15s;}
        .btn-add:hover{background:#222;color:var(--white);transform:translateY(-1px);box-shadow:0 4px 12px rgba(0,0,0,0.15);}
        .toast-container{position:fixed;top:70px;right:20px;z-index:9999;}
        .toast-msg{background:#f0fdf4;border:1px solid #bbf7d0;color:#15803d;border-radius:10px;padding:11px 16px;font-size:13px;font-weight:600;display:flex;align-items:center;gap:8px;animation:slideIn 0.3s ease;box-shadow:0 4px 16px rgba(0,0,0,0.08);}
        .toast-err{background:#fef2f2;border-color:#fecaca;color:#dc2626;}
        @keyframes slideIn{from{opacity:0;transform:translateX(16px)}to{opacity:1;transform:translateX(0)}}
        .no-data{text-align:center;padding:40px;color:var(--g400);font-size:14px;}
        .btn-search{background:var(--black);border:none;color:var(--white);border-radius:8px;padding:7px 13px;font-size:12px;font-weight:600;cursor:pointer;font-family:'Inter',sans-serif;transition:all 0.15s;}
        .btn-search:hover{background:#222;}
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-text">Mednet EMS</div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section">Main</div>
        <a href="/employee-mgmt/admin/dashboard" class="nav-item"><i class="fas fa-chart-pie"></i> Dashboard</a>
        <a href="/employee-mgmt/admin/employees" class="nav-item active"><i class="fas fa-users"></i> Employees</a>
        <a href="/employee-mgmt/admin/add-employee" class="nav-item"><i class="fas fa-user-plus"></i> Add Employee</a>
        <div class="nav-section">Management</div>
        <a href="/employee-mgmt/admin/leaves" class="nav-item"><i class="fas fa-calendar-xmark"></i> Leave Requests</a>
        <a href="/employee-mgmt/admin/tasks" class="nav-item"><i class="fas fa-list-check"></i> Tasks</a>
        <div class="nav-section">Reports</div>
        <a href="/employee-mgmt/admin/export/excel" class="nav-item"><i class="fas fa-file-excel"></i> Export Excel</a>
        <a href="/employee-mgmt/admin/export/pdf" class="nav-item"><i class="fas fa-file-pdf"></i> Export PDF</a>
    </nav>
    <div class="sidebar-footer">
        <div class="user-mini">
            <div class="user-mini-avatar">${user.name.substring(0,1).toUpperCase()}</div>
            <div><div class="user-mini-name">${user.name}</div><div class="user-mini-role">Administrator</div></div>
        </div>
    </div>
</aside>

<header class="topbar">
    <div class="page-title">Manage Employees</div>
    <div class="topbar-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <a href="/employee-mgmt/logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</header>

<div class="toast-container">
    <c:if test="${not empty success}"><div class="toast-msg" id="toastMsg"><i class="fas fa-check-circle"></i> ${success}</div></c:if>
    <c:if test="${not empty error}"><div class="toast-msg toast-err" id="toastMsg"><i class="fas fa-exclamation-circle"></i> ${error}</div></c:if>
</div>

<div class="main">
    <div class="tbl-card">
        <div class="tbl-head">
            <div class="tbl-title">All Employees <span style="color:var(--g400);font-weight:500;font-size:12px">(${totalCount})</span></div>
            <div class="d-flex align-items-center gap-2 flex-wrap">
                <form method="get" action="/employee-mgmt/admin/employees" style="display:flex;gap:6px;align-items:center;">
                    <div class="search-wrap">
                        <i class="fas fa-search search-ico"></i>
                        <input type="text" name="search" class="search-inp" placeholder="Search..." value="${search}"/>
                    </div>
                    <button type="submit" class="btn-search">Search</button>
                </form>
                <a href="/employee-mgmt/admin/export/excel" class="btn-export btn-excel"><i class="fas fa-file-excel"></i> Excel</a>
                <a href="/employee-mgmt/admin/export/pdf" class="btn-export btn-pdf"><i class="fas fa-file-pdf"></i> PDF</a>
                <a href="/employee-mgmt/admin/add-employee" class="btn-add"><i class="fas fa-plus me-1"></i>Add Employee</a>
            </div>
        </div>

        <table id="empTable">
            <thead>
                <tr>
                    <th onclick="sortTable(0)"># <i class="fas fa-sort ms-1" style="font-size:9px"></i></th>
                    <th onclick="sortTable(1)">Name <i class="fas fa-sort ms-1" style="font-size:9px"></i></th>
                    <th onclick="sortTable(2)">Email <i class="fas fa-sort ms-1" style="font-size:9px"></i></th>
                    <th onclick="sortTable(3)">Department <i class="fas fa-sort ms-1" style="font-size:9px"></i></th>
                    <th>Designation</th>
                    <th onclick="sortTable(5)">City <i class="fas fa-sort ms-1" style="font-size:9px"></i></th>
                    <th onclick="sortTable(6)">Status <i class="fas fa-sort ms-1" style="font-size:9px"></i></th>
                    <th onclick="sortTable(7)">Role <i class="fas fa-sort ms-1" style="font-size:9px"></i></th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="empBody">
                <c:choose>
                    <c:when test="${empty employees}">
                        <tr><td colspan="9" class="no-data"><i class="fas fa-users-slash me-2"></i>No employees found.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="emp" items="${employees}" varStatus="st">
                        <tr>
                            <td style="color:var(--g400)">${(currentPage-1)*8 + st.count}</td>
                            <td>
                                <div style="display:flex;align-items:center;gap:0">
                                    <div class="emp-avatar">
                                        <c:choose>
                                            <c:when test="${not empty emp.profilePicture}"><img src="/employee-mgmt/uploads/${emp.profilePicture}" alt=""/></c:when>
                                            <c:otherwise>${emp.name.substring(0,1).toUpperCase()}</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div>
                                        <div style="font-weight:700;color:var(--black)">${emp.name}</div>
                                        <div style="font-size:11px;color:var(--g400)">${emp.loginId}</div>
                                    </div>
                                </div>
                            </td>
                            <td>${emp.email != null ? emp.email : '—'}</td>
                            <td>${emp.department != null ? emp.department : '—'}</td>
                            <td>${emp.designation != null ? emp.designation : '—'}</td>
                            <td>${emp.city != null ? emp.city : '—'}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${emp.status == 'ACTIVE'}"><span class="badge-active">Active</span></c:when>
                                    <c:when test="${emp.status == 'INACTIVE'}"><span class="badge-inactive">Inactive</span></c:when>
                                    <c:otherwise><span class="badge-leave">On Leave</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${emp.role == 'ADMIN'}"><span class="badge-admin">Admin</span></c:when>
                                    <c:otherwise><span class="badge-emp">Employee</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="d-flex gap-1 flex-wrap">
                                    <a href="/employee-mgmt/admin/edit/${emp.id}" class="btn-act btn-edit-act"><i class="fas fa-pen"></i></a>
                                    <button class="btn-act btn-del-act" onclick="confirmDelete(${emp.id},'${emp.name}')"><i class="fas fa-trash"></i></button>
                                    <button class="btn-act btn-status-act" onclick="changeStatus(${emp.id},'${emp.name}','${emp.status}')"><i class="fas fa-sliders"></i></button>
                                    <button class="btn-act btn-pwd-act" onclick="resetPwd(${emp.id},'${emp.name}')"><i class="fas fa-key"></i></button>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div class="pagination-wrap">
            <div class="page-info">Page ${currentPage} of ${totalPages} &nbsp;&middot;&nbsp; ${totalCount} total</div>
            <div class="page-btns">
                <a href="?page=${currentPage-1}&search=${search}" class="page-btn ${currentPage <= 1 ? 'disabled' : ''}"><i class="fas fa-chevron-left"></i></a>
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="?page=${p}&search=${search}" class="page-btn ${p == currentPage ? 'active' : ''}">${p}</a>
                </c:forEach>
                <a href="?page=${currentPage+1}&search=${search}" class="page-btn ${currentPage >= totalPages ? 'disabled' : ''}"><i class="fas fa-chevron-right"></i></a>
            </div>
        </div>
    </div>
</div>

<form id="statusForm" method="post" action="#"><input type="hidden" name="status" id="statusVal"/></form>
<form id="pwdForm" method="post" action="#"><input type="hidden" name="newPassword" id="pwdVal"/></form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    setInterval(()=>document.getElementById('clock').textContent=new Date().toLocaleTimeString(),1000);
    document.getElementById('clock').textContent=new Date().toLocaleTimeString();
    const toast=document.getElementById('toastMsg');
    if(toast)setTimeout(()=>{toast.style.transition='opacity 0.4s';toast.style.opacity='0';},3500);

    function confirmDelete(id,name){
        Swal.fire({title:'Delete Employee?',html:`Remove <strong>${name}</strong> permanently?`,icon:'warning',background:'#fff',color:'#111827',iconColor:'#dc2626',showCancelButton:true,confirmButtonText:'Delete',cancelButtonText:'Cancel',confirmButtonColor:'#dc2626',cancelButtonColor:'#f3f4f6'})
        .then(r=>{if(r.isConfirmed)window.location.href='/employee-mgmt/admin/delete/'+id;});
    }
    function changeStatus(id,name,current){
        Swal.fire({title:'Change Status',html:`Update status for <strong>${name}</strong>`,input:'select',inputOptions:{'ACTIVE':'Active','INACTIVE':'Inactive','ON_LEAVE':'On Leave'},inputValue:current,background:'#fff',color:'#111827',showCancelButton:true,confirmButtonText:'Update',confirmButtonColor:'#111827'})
        .then(r=>{if(r.isConfirmed){const f=document.getElementById('statusForm');f.action='/employee-mgmt/admin/status/'+id;document.getElementById('statusVal').value=r.value;f.submit();}});
    }
    function resetPwd(id,name){
        Swal.fire({title:'Reset Password',html:`New password for <strong>${name}</strong>`,input:'password',inputPlaceholder:'Enter new password',background:'#fff',color:'#111827',showCancelButton:true,confirmButtonText:'Reset',confirmButtonColor:'#111827',inputValidator:v=>!v?'Please enter a password':null})
        .then(r=>{if(r.isConfirmed){const f=document.getElementById('pwdForm');f.action='/employee-mgmt/admin/reset-password/'+id;document.getElementById('pwdVal').value=r.value;f.submit();}});
    }
    let sd={};
    function sortTable(c){const tb=document.getElementById('empBody');const rows=[...tb.querySelectorAll('tr')];sd[c]=!sd[c];rows.sort((a,b)=>{const x=a.cells[c]?.textContent.trim()||'';const y=b.cells[c]?.textContent.trim()||'';return sd[c]?x.localeCompare(y):y.localeCompare(x);});rows.forEach(r=>tb.appendChild(r));}
</script>
</body>
</html>


