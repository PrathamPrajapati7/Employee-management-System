<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin Dashboard — Mednet EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root{--black:#0a0a0a;--white:#fff;--g50:#f9fafb;--g100:#f3f4f6;--g200:#e5e7eb;--g300:#d1d5db;--g400:#9ca3af;--g500:#6b7280;--g700:#374151;--g900:#111827;--sidebar:224px;--topbar:60px;--green:#16a34a;--red:#dc2626;--amber:#d97706;}
        *{margin:0;padding:0;box-sizing:border-box;}
        body{font-family:'Inter',sans-serif;background:var(--g50);color:var(--g900);min-height:100vh;display:flex;}

        /* SIDEBAR */
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

        /* TOPBAR */
        .topbar{position:fixed;top:0;left:var(--sidebar);right:0;height:var(--topbar);background:var(--white);border-bottom:1px solid var(--g200);display:flex;align-items:center;justify-content:space-between;padding:0 24px;z-index:100;}
        .page-title{font-size:15px;font-weight:700;color:var(--black);}
        .topbar-right{display:flex;align-items:center;gap:10px;}
        .clock-badge{font-size:12px;color:var(--g500);background:var(--g50);border:1px solid var(--g200);border-radius:100px;padding:5px 12px;font-weight:500;}
        .btn-logout{background:transparent;border:1px solid var(--g200);color:var(--g700);border-radius:100px;padding:6px 14px;font-size:12px;font-weight:600;text-decoration:none;transition:all 0.15s;font-family:'Inter',sans-serif;}
        .btn-logout:hover{background:var(--black);color:var(--white);border-color:var(--black);}

        /* MAIN */
        .main{margin-left:var(--sidebar);margin-top:var(--topbar);padding:24px;flex:1;}

        /* WELCOME BANNER */
        .banner{background:var(--white);border:1px solid var(--g200);border-radius:16px;padding:22px 26px;margin-bottom:22px;display:flex;align-items:center;justify-content:space-between;}
        .banner-left h2{font-size:20px;font-weight:800;color:var(--black);letter-spacing:-0.4px;margin-bottom:3px;}
        .banner-left p{font-size:13px;color:var(--g500);}
        .role-pill{display:inline-flex;align-items:center;gap:6px;background:var(--g100);border:1px solid var(--g200);border-radius:100px;padding:4px 12px;font-size:11px;font-weight:700;color:var(--g700);}

        /* STAT CARDS */
        .stat-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:18px;transition:all 0.2s;}
        .stat-card:hover{box-shadow:0 4px 16px rgba(0,0,0,0.06);transform:translateY(-2px);}
        .stat-icon{width:40px;height:40px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:16px;margin-bottom:12px;color:var(--white);}
        .stat-val{font-size:28px;font-weight:900;color:var(--black);line-height:1;letter-spacing:-1px;}
        .stat-lbl{color:var(--g500);font-size:12px;margin-top:4px;font-weight:500;}

        /* CHART CARDS */
        .chart-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:18px;}
        .chart-title{font-size:13px;font-weight:700;color:var(--black);margin-bottom:14px;}

        /* TABLE */
        .tbl-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;overflow:hidden;}
        .tbl-head{padding:14px 18px;border-bottom:1px solid var(--g200);display:flex;justify-content:space-between;align-items:center;}
        .tbl-title{font-size:14px;font-weight:700;color:var(--black);}
        table{width:100%;border-collapse:collapse;}
        thead th{background:var(--g50);color:var(--g500);font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;padding:10px 16px;text-align:left;}
        tbody td{padding:11px 16px;border-bottom:1px solid var(--g100);font-size:13px;color:var(--g700);}
        tbody tr:hover{background:var(--g50);}
        tbody tr:last-child td{border-bottom:none;}

        /* BADGES */
        .badge-active{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-inactive{background:#fee2e2;color:#dc2626;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-leave{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-admin{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-emp{background:#ede9fe;color:#6d28d9;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}

        .fade-in{animation:fadeUp 0.4s ease both;}
        .fade-in:nth-child(1){animation-delay:0.04s}.fade-in:nth-child(2){animation-delay:0.08s}.fade-in:nth-child(3){animation-delay:0.12s}.fade-in:nth-child(4){animation-delay:0.16s}.fade-in:nth-child(5){animation-delay:0.2s}.fade-in:nth-child(6){animation-delay:0.24s}
        @keyframes fadeUp{from{opacity:0;transform:translateY(12px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-text">Mednet EMS</div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section">Main</div>
        <a href="/employee-mgmt/admin/dashboard" class="nav-item active"><i class="fas fa-chart-pie"></i> Dashboard</a>
        <a href="/employee-mgmt/admin/employees" class="nav-item"><i class="fas fa-users"></i> Employees</a>
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
            <div>
                <div class="user-mini-name">${user.name}</div>
                <div class="user-mini-role">Administrator</div>
            </div>
        </div>
    </div>
</aside>

<header class="topbar">
    <div class="page-title">Dashboard Overview</div>
    <div class="topbar-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <a href="/employee-mgmt/logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</header>

<div class="main">

    <div class="banner fade-in">
        <div class="banner-left">
            <h2>Welcome back, ${user.name}</h2>
            <p>Here's your workforce overview for today.</p>
        </div>
        <div class="role-pill"><i class="fas fa-crown me-1"></i> Administrator</div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-6 col-md-2 fade-in">
            <div class="stat-card">
                <div class="stat-icon" style="background:#111827"><i class="fas fa-users"></i></div>
                <div class="stat-val" id="c-total">0</div>
                <div class="stat-lbl">Total</div>
            </div>
        </div>
        <div class="col-6 col-md-2 fade-in">
            <div class="stat-card">
                <div class="stat-icon" style="background:#15803d"><i class="fas fa-circle-check"></i></div>
                <div class="stat-val" id="c-active">0</div>
                <div class="stat-lbl">Active</div>
            </div>
        </div>
        <div class="col-6 col-md-2 fade-in">
            <div class="stat-card">
                <div class="stat-icon" style="background:#dc2626"><i class="fas fa-circle-xmark"></i></div>
                <div class="stat-val" id="c-inactive">0</div>
                <div class="stat-lbl">Inactive</div>
            </div>
        </div>
        <div class="col-6 col-md-2 fade-in">
            <div class="stat-card">
                <div class="stat-icon" style="background:#d97706"><i class="fas fa-umbrella-beach"></i></div>
                <div class="stat-val" id="c-leave">0</div>
                <div class="stat-lbl">On Leave</div>
            </div>
        </div>
        <div class="col-6 col-md-2 fade-in">
            <div class="stat-card">
                <div class="stat-icon" style="background:#0369a1"><i class="fas fa-person"></i></div>
                <div class="stat-val" id="c-male">0</div>
                <div class="stat-lbl">Male</div>
            </div>
        </div>
        <div class="col-6 col-md-2 fade-in">
            <div class="stat-card">
                <div class="stat-icon" style="background:#7c3aed"><i class="fas fa-person-dress"></i></div>
                <div class="stat-val" id="c-female">0</div>
                <div class="stat-lbl">Female</div>
            </div>
        </div>
        <div class="col-6 col-md-2 fade-in">
            <div class="stat-card">
                <div class="stat-icon" style="background:#a16207"><i class="fas fa-clock"></i></div>
                <div class="stat-val" id="c-pleaves">0</div>
                <div class="stat-lbl">Pending Leaves</div>
            </div>
        </div>
        <div class="col-6 col-md-2 fade-in">
            <div class="stat-card">
                <div class="stat-icon" style="background:#0369a1"><i class="fas fa-list-check"></i></div>
                <div class="stat-val" id="c-tasks">0</div>
                <div class="stat-lbl">Total Tasks</div>
            </div>
        </div>
        <div class="col-6 col-md-2 fade-in">
            <div class="stat-card">
                <div class="stat-icon" style="background:#15803d"><i class="fas fa-circle-check"></i></div>
                <div class="stat-val" id="c-ctasks">0</div>
                <div class="stat-lbl">Completed Tasks</div>
            </div>
        </div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-3 fade-in">
            <div class="chart-card">
                <div class="chart-title">Gender Distribution</div>
                <canvas id="genderChart" height="200"></canvas>
            </div>
        </div>
        <div class="col-md-3 fade-in">
            <div class="chart-card">
                <div class="chart-title">Status Breakdown</div>
                <canvas id="statusChart" height="200"></canvas>
            </div>
        </div>
        <div class="col-md-6 fade-in">
            <div class="chart-card">
                <div class="chart-title">Employees by Department</div>
                <canvas id="deptChart" height="200"></canvas>
            </div>
        </div>
    </div>

    <div class="tbl-card fade-in">
        <div class="tbl-head">
            <div class="tbl-title">Recent Employees</div>
            <a href="/employee-mgmt/admin/employees" style="font-size:12px;color:var(--black);font-weight:600;text-decoration:none;">View All <i class="fas fa-arrow-right ms-1"></i></a>
        </div>
        <table>
            <thead>
                <tr><th>#</th><th>Name</th><th>Department</th><th>Status</th><th>Role</th><th>Joined</th></tr>
            </thead>
            <tbody>
                <c:forEach var="emp" items="${recentEmployees}" varStatus="st">
                <tr>
                    <td style="color:var(--g400)">${st.count}</td>
                    <td><strong style="color:var(--black)">${emp.name}</strong><br/><small style="color:var(--g400)">${emp.loginId}</small></td>
                    <td>${emp.department != null ? emp.department : '—'}</td>
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
                    <td>${emp.joiningDate != null ? emp.joiningDate : '—'}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    setInterval(()=>document.getElementById('clock').textContent=new Date().toLocaleTimeString(),1000);
    document.getElementById('clock').textContent=new Date().toLocaleTimeString();

    function animCount(id,t){let c=0,s=Math.ceil(t/40)||1,el=document.getElementById(id);const i=setInterval(()=>{c=Math.min(c+s,t);el.textContent=c;if(c>=t)clearInterval(i);},30);}
    animCount('c-total',${totalCount});animCount('c-active',${activeCount});animCount('c-inactive',${inactiveCount});
    animCount('c-leave',${onLeaveCount});animCount('c-male',${maleCount});animCount('c-female',${femaleCount});
    animCount('c-pleaves',${pendingLeaves});animCount('c-tasks',${totalTasks});animCount('c-ctasks',${completedTasks});

    const cd={plugins:{legend:{labels:{color:'#6b7280',font:{size:11,family:'Inter'}}}}};
    new Chart(document.getElementById('genderChart'),{type:'doughnut',data:{labels:['Male','Female','Other'],datasets:[{data:[${maleCount},${femaleCount},${otherCount}],backgroundColor:['#0ea5e9','#a855f7','#10b981'],borderWidth:2,borderColor:'#fff',hoverOffset:4}]},options:{...cd,cutout:'68%'}});
    new Chart(document.getElementById('statusChart'),{type:'doughnut',data:{labels:['Active','Inactive','On Leave'],datasets:[{data:[${activeCount},${inactiveCount},${onLeaveCount}],backgroundColor:['#22c55e','#ef4444','#f59e0b'],borderWidth:2,borderColor:'#fff',hoverOffset:4}]},options:{...cd,cutout:'68%'}});
    const dL=[<c:forEach var="l" items="${deptLabels}">'${l}',</c:forEach>];
    const dD=[<c:forEach var="d" items="${deptData}">${d},</c:forEach>];
    new Chart(document.getElementById('deptChart'),{type:'bar',data:{labels:dL,datasets:[{label:'Employees',data:dD,backgroundColor:'#111827',borderRadius:6,borderSkipped:false}]},options:{...cd,scales:{x:{ticks:{color:'#9ca3af'},grid:{display:false}},y:{ticks:{color:'#9ca3af',stepSize:1},grid:{color:'#f3f4f6'}}}}});
</script>
</body>
</html>


