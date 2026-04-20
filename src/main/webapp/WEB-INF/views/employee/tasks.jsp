<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Tasks — Mednet EMS</title>
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
        .task-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:20px;margin-bottom:14px;transition:all 0.2s;}
        .task-card:hover{box-shadow:0 4px 16px rgba(0,0,0,0.06);}
        .task-header{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:10px;gap:12px;}
        .task-title{font-size:15px;font-weight:700;color:var(--black);}
        .task-desc{font-size:13px;color:var(--g500);margin-bottom:14px;line-height:1.5;}
        .task-meta{display:flex;align-items:center;gap:12px;flex-wrap:wrap;margin-bottom:14px;}
        .meta-item{font-size:11px;color:var(--g500);display:flex;align-items:center;gap:4px;}
        .progress-section{margin-bottom:14px;}
        .progress-label{display:flex;justify-content:space-between;font-size:12px;font-weight:600;color:var(--g700);margin-bottom:6px;}
        .progress-track{background:var(--g200);border-radius:100px;height:10px;overflow:hidden;}
        .progress-fill{height:100%;border-radius:100px;transition:width 0.5s;}
        .btn-update{background:var(--black);border:none;color:var(--white);border-radius:9px;padding:8px 16px;font-size:12px;font-weight:700;cursor:pointer;font-family:'Inter',sans-serif;transition:all 0.2s;}
        .btn-update:hover{background:#222;}
        .badge-todo{background:var(--g100);color:var(--g700);padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-inprog{background:#dbeafe;color:#1d4ed8;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-done{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-hold{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-low{background:#dcfce7;color:#15803d;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-med{background:#fef9c3;color:#a16207;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-high{background:#fee2e2;color:#dc2626;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .badge-crit{background:#111827;color:#fff;padding:3px 9px;border-radius:100px;font-size:11px;font-weight:700;}
        .toast-container{position:fixed;top:70px;right:20px;z-index:9999;}
        .toast-msg{background:#f0fdf4;border:1px solid #bbf7d0;color:#15803d;border-radius:10px;padding:11px 16px;font-size:13px;font-weight:600;display:flex;align-items:center;gap:8px;animation:slideIn 0.3s ease;}
        @keyframes slideIn{from{opacity:0;transform:translateX(16px)}to{opacity:1;transform:translateX(0)}}
        .no-tasks{text-align:center;padding:60px;color:var(--g400);}
        .no-tasks i{font-size:40px;margin-bottom:12px;display:block;}
        .inp-sm{background:var(--g50);border:1.5px solid var(--g200);border-radius:8px;padding:7px 10px;color:var(--black);font-size:12px;font-family:'Inter',sans-serif;outline:none;transition:all 0.2s;}
        .inp-sm:focus{border-color:var(--black);}
        select.inp-sm option{background:var(--white);}
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-logo"><div class="logo-text">Mednet EMS</div></div>
    <nav class="sidebar-nav">
        <div class="nav-section">My Space</div>
        <a href="/employee-mgmt/employee/dashboard" class="nav-item"><i class="fas fa-house"></i> Dashboard</a>
        <a href="/employee-mgmt/employee/profile" class="nav-item"><i class="fas fa-circle-user"></i> My Profile</a>
        <a href="/employee-mgmt/employee/leaves" class="nav-item"><i class="fas fa-calendar-xmark"></i> My Leaves</a>
        <a href="/employee-mgmt/employee/tasks" class="nav-item active"><i class="fas fa-list-check"></i> My Tasks</a>
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
    <div class="page-title">My Tasks</div>
    <div class="topbar-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <a href="/employee-mgmt/logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</header>

<div class="toast-container">
    <c:if test="${not empty success}"><div class="toast-msg" id="toastMsg"><i class="fas fa-check-circle"></i> ${success}</div></c:if>
</div>

<div class="main">
    <c:choose>
        <c:when test="${empty tasks}">
            <div class="no-tasks">
                <i class="fas fa-clipboard-list"></i>
                <div style="font-size:16px;font-weight:700;color:var(--black);margin-bottom:6px;">No tasks assigned yet</div>
                <div style="font-size:13px;">Your assigned tasks will appear here.</div>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="task" items="${tasks}">
            <div class="task-card">
                <div class="task-header">
                    <div>
                        <div class="task-title">${task.title}</div>
                        <div class="task-meta" style="margin-top:6px;margin-bottom:0">
                            <c:choose>
                                <c:when test="${task.priority == 'LOW'}"><span class="badge-low"><i class="fas fa-arrow-down me-1"></i>Low</span></c:when>
                                <c:when test="${task.priority == 'MEDIUM'}"><span class="badge-med"><i class="fas fa-minus me-1"></i>Medium</span></c:when>
                                <c:when test="${task.priority == 'HIGH'}"><span class="badge-high"><i class="fas fa-arrow-up me-1"></i>High</span></c:when>
                                <c:otherwise><span class="badge-crit"><i class="fas fa-fire me-1"></i>Critical</span></c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${task.status == 'TODO'}"><span class="badge-todo">To Do</span></c:when>
                                <c:when test="${task.status == 'IN_PROGRESS'}"><span class="badge-inprog">In Progress</span></c:when>
                                <c:when test="${task.status == 'COMPLETED'}"><span class="badge-done">Completed</span></c:when>
                                <c:otherwise><span class="badge-hold">On Hold</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div style="text-align:right;flex-shrink:0">
                        <div style="font-size:11px;color:var(--g400)">Due: <strong style="color:${task.dueDate != null ? 'var(--black)' : 'var(--g400)'}">${task.dueDate != null ? task.dueDate : 'No deadline'}</strong></div>
                        <div style="font-size:11px;color:var(--g400);margin-top:2px">Assigned: ${task.assignedDate}</div>
                    </div>
                </div>

                <c:if test="${not empty task.description}">
                    <div class="task-desc">${task.description}</div>
                </c:if>

                <!-- PROGRESS BAR -->
                <div class="progress-section">
                    <div class="progress-label">
                        <span>Progress</span>
                        <span id="pct-${task.id}">${task.progress}%</span>
                    </div>
                    <div class="progress-track">
                        <div class="progress-fill" id="bar-${task.id}" style="width:${task.progress}%;background:${task.progress == 100 ? '#15803d' : task.progress >= 50 ? '#1d4ed8' : task.progress > 0 ? '#d97706' : '#e5e7eb'}"></div>
                    </div>
                </div>

                <!-- UPDATE FORM -->
                <form action="/employee-mgmt/employee/tasks/update/${task.id}" method="post" style="display:flex;align-items:center;gap:10px;flex-wrap:wrap;">
                    <div style="display:flex;align-items:center;gap:6px;">
                        <label style="font-size:12px;font-weight:600;color:var(--g700)">Progress:</label>
                        <input type="range" id="range-${task.id}" name="progress" min="0" max="100" step="5" value="${task.progress}" class="form-range" style="width:130px"
                            oninput="syncSlider('${task.id}', this.value)"/>
                        <span id="lbl-${task.id}" style="font-size:12px;font-weight:700;color:var(--black);min-width:36px">${task.progress}%</span>
                    </div>
                    <div style="display:flex;align-items:center;gap:6px;">
                        <label style="font-size:12px;font-weight:600;color:var(--g700)">Status:</label>
                        <select id="sel-${task.id}" name="status" class="inp-sm" onchange="syncStatus('${task.id}', this.value)">
                            <option value="TODO" ${task.status=='TODO'?'selected':''}>To Do</option>
                            <option value="IN_PROGRESS" ${task.status=='IN_PROGRESS'?'selected':''}>In Progress</option>
                            <option value="COMPLETED" ${task.status=='COMPLETED'?'selected':''}>Completed</option>
                            <option value="ON_HOLD" ${task.status=='ON_HOLD'?'selected':''}>On Hold</option>
                        </select>
                    </div>
                    <input type="text" name="note" class="inp-sm" placeholder="Add a note..." value="${task.employeeNote != null ? task.employeeNote : ''}" style="flex:1;min-width:160px"/>
                    <button type="submit" class="btn-update"><i class="fas fa-save me-1"></i>Update</button>
                </form>
            </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<script>
    setInterval(()=>document.getElementById('clock').textContent=new Date().toLocaleTimeString(),1000);
    document.getElementById('clock').textContent=new Date().toLocaleTimeString();
    const toast=document.getElementById('toastMsg');
    if(toast)setTimeout(()=>{toast.style.transition='opacity 0.4s';toast.style.opacity='0';},3500);

    function barColor(p){return p==100?'#15803d':p>=50?'#1d4ed8':p>0?'#d97706':'#e5e7eb';}

    function syncSlider(id, val) {
        const p = parseInt(val);
        document.getElementById('lbl-'+id).textContent = p+'%';
        document.getElementById('pct-'+id).textContent = p+'%';
        const bar = document.getElementById('bar-'+id);
        bar.style.width = p+'%';
        bar.style.background = barColor(p);
        const sel = document.getElementById('sel-'+id);
        if (p === 100) sel.value = 'COMPLETED';
        else if (p > 0 && sel.value === 'TODO') sel.value = 'IN_PROGRESS';
        else if (p === 0 && sel.value !== 'ON_HOLD') sel.value = 'TODO';
    }

    function syncStatus(id, val) {
        if (val === 'COMPLETED') {
            document.getElementById('range-'+id).value = 100;
            syncSlider(id, 100);
        }
    }
</script>
</body>
</html>


