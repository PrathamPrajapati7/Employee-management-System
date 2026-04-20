<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Dashboard — Mednet EMS</title>
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
        .banner{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:20px 24px;margin-bottom:20px;display:flex;align-items:center;justify-content:space-between;}
        .banner h2{font-size:19px;font-weight:800;color:var(--black);letter-spacing:-0.4px;margin-bottom:3px;}
        .banner p{font-size:13px;color:var(--g500);}
        .role-pill{display:inline-flex;align-items:center;gap:6px;background:var(--g100);border:1px solid var(--g200);border-radius:100px;padding:4px 12px;font-size:11px;font-weight:700;color:var(--g700);}
        .info-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:20px;}
        .info-title{font-size:13px;font-weight:700;color:var(--black);margin-bottom:14px;display:flex;align-items:center;gap:8px;}
        .info-row{display:flex;justify-content:space-between;align-items:center;padding:9px 0;border-bottom:1px solid var(--g100);}
        .info-row:last-child{border-bottom:none;}
        .info-key{font-size:12px;color:var(--g500);font-weight:500;}
        .info-val{font-size:13px;color:var(--black);font-weight:600;text-align:right;}
        .badge-active{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-inactive{background:#fee2e2;color:#dc2626;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-leave{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .profile-pic-lg{width:76px;height:76px;border-radius:16px;object-fit:cover;border:1.5px solid var(--g200);}
        .profile-initials{width:76px;height:76px;border-radius:16px;background:var(--black);display:flex;align-items:center;justify-content:center;font-size:26px;font-weight:800;color:var(--white);}
        .quick-action{background:var(--white);border:1.5px solid var(--g200);border-radius:12px;padding:16px;text-align:center;text-decoration:none;transition:all 0.2s;display:block;}
        .quick-action:hover{border-color:var(--black);box-shadow:0 4px 12px rgba(0,0,0,0.08);transform:translateY(-2px);}
        .qa-icon{width:36px;height:36px;border-radius:9px;background:var(--black);display:flex;align-items:center;justify-content:center;color:var(--white);font-size:14px;margin:0 auto 8px;}
        .qa-label{font-size:12px;font-weight:700;color:var(--black);}
        .fade-in{animation:fadeUp 0.4s ease both;}
        .fade-in:nth-child(1){animation-delay:0.04s}.fade-in:nth-child(2){animation-delay:0.08s}.fade-in:nth-child(3){animation-delay:0.12s}
        @keyframes fadeUp{from{opacity:0;transform:translateY(12px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-logo"><div class="logo-text">Mednet EMS</div></div>
    <nav class="sidebar-nav">
        <div class="nav-section">My Space</div>
        <a href="/employee-mgmt/employee/dashboard" class="nav-item active"><i class="fas fa-house"></i> Dashboard</a>
        <a href="/employee-mgmt/employee/profile" class="nav-item"><i class="fas fa-circle-user"></i> My Profile</a>
        <a href="/employee-mgmt/employee/leaves" class="nav-item"><i class="fas fa-calendar-xmark"></i> My Leaves</a>
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
    <div class="page-title">My Dashboard</div>
    <div class="topbar-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <a href="/employee-mgmt/logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</header>
<div class="main">

    <div class="banner fade-in">
        <div>
            <h2>Hello, ${user.name}</h2>
            <p>Welcome to your personal workspace.</p>
        </div>
        <div class="role-pill"><i class="fas fa-user me-1"></i> Employee</div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-4 fade-in">
            <div class="info-card text-center">
                <c:choose>
                    <c:when test="${not empty user.profilePicture}">
                        <img src="/employee-mgmt/uploads/${user.profilePicture}" class="profile-pic-lg mx-auto d-block mb-3" alt=""/>
                    </c:when>
                    <c:otherwise>
                        <div class="profile-initials mx-auto mb-3">${user.name.substring(0,1).toUpperCase()}</div>
                    </c:otherwise>
                </c:choose>
                <div style="font-size:17px;font-weight:800;color:var(--black)">${user.name}</div>
                <div style="font-size:12px;color:var(--g400);margin-top:3px">${user.loginId}</div>
                <div style="margin-top:10px">
                    <c:choose>
                        <c:when test="${user.status == 'ACTIVE'}"><span class="badge-active">Active</span></c:when>
                        <c:when test="${user.status == 'INACTIVE'}"><span class="badge-inactive">Inactive</span></c:when>
                        <c:otherwise><span class="badge-leave">On Leave</span></c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <div class="col-md-8 fade-in">
            <div class="info-card">
                <div class="info-title"><i class="fas fa-id-card" style="color:var(--black)"></i> My Information</div>
                <div class="info-row"><span class="info-key">Email</span><span class="info-val">${user.email != null ? user.email : '—'}</span></div>
                <div class="info-row"><span class="info-key">Phone</span><span class="info-val">${user.phone != null ? user.phone : '—'}</span></div>
                <div class="info-row"><span class="info-key">Department</span><span class="info-val">${user.department != null ? user.department : '—'}</span></div>
                <div class="info-row"><span class="info-key">Designation</span><span class="info-val">${user.designation != null ? user.designation : '—'}</span></div>
                <div class="info-row"><span class="info-key">City</span><span class="info-val">${user.city != null ? user.city : '—'}</span></div>
                <div class="info-row"><span class="info-key">Joining Date</span><span class="info-val">${user.joiningDate != null ? user.joiningDate : '—'}</span></div>
                <div class="info-row"><span class="info-key">Gender</span><span class="info-val">${user.gender != null ? user.gender : '—'}</span></div>
            </div>
        </div>
    </div>

    <div class="row g-3 fade-in">
        <div class="col-6 col-md-3">
            <a href="/employee-mgmt/employee/profile" class="quick-action">
                <div class="qa-icon"><i class="fas fa-pen"></i></div>
                <div class="qa-label">Edit Profile</div>
            </a>
        </div>
        <div class="col-6 col-md-3">
            <a href="/employee-mgmt/employee/profile#change-password" class="quick-action">
                <div class="qa-icon"><i class="fas fa-key"></i></div>
                <div class="qa-label">Change Password</div>
            </a>
        </div>
        <div class="col-6 col-md-3">
            <a href="/employee-mgmt/employee/leaves" class="quick-action">
                <div class="qa-icon"><i class="fas fa-calendar-xmark"></i></div>
                <div class="qa-label">My Leaves</div>
                <div style="font-size:11px;color:var(--g500);margin-top:4px">${pendingLeaves} pending</div>
            </a>
        </div>
        <div class="col-6 col-md-3">
            <a href="/employee-mgmt/employee/tasks" class="quick-action">
                <div class="qa-icon"><i class="fas fa-list-check"></i></div>
                <div class="qa-label">My Tasks</div>
                <div style="font-size:11px;color:var(--g500);margin-top:4px">${myCompletedTasks}/${myTasks} done</div>
            </a>
        </div>
    </div>
</div>
<script>
    setInterval(()=>document.getElementById('clock').textContent=new Date().toLocaleTimeString(),1000);
    document.getElementById('clock').textContent=new Date().toLocaleTimeString();
</script>
</body>
</html>


