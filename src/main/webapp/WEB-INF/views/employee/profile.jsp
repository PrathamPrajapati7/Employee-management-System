<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Profile — Mednet EMS</title>
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
        .form-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:22px;margin-bottom:18px;}
        .card-title{font-size:14px;font-weight:700;color:var(--black);margin-bottom:16px;display:flex;align-items:center;gap:8px;}
        .fld{margin-bottom:14px;}
        .fld label{display:block;font-size:12px;font-weight:600;color:var(--g700);margin-bottom:6px;}
        .fld-wrap{position:relative;}
        .fld-ico{position:absolute;left:12px;top:50%;transform:translateY(-50%);color:var(--g400);font-size:12px;pointer-events:none;transition:color 0.2s;}
        .inp{width:100%;background:var(--g50);border:1.5px solid var(--g200);border-radius:10px;padding:10px 12px 10px 36px;color:var(--black);font-size:13px;font-family:'Inter',sans-serif;font-weight:500;transition:all 0.2s;outline:none;}
        .inp:focus{background:var(--white);border-color:var(--black);box-shadow:0 0 0 3px rgba(0,0,0,0.06);}
        .fld-wrap:focus-within .fld-ico{color:var(--black);}
        .inp::placeholder{color:var(--g400);font-weight:400;}
        textarea.inp{resize:none;padding-top:10px;}
        .btn-save{padding:10px 22px;border:none;border-radius:10px;font-size:13px;font-weight:700;font-family:'Inter',sans-serif;cursor:pointer;background:var(--black);color:var(--white);transition:all 0.2s;}
        .btn-save:hover{background:#222;transform:translateY(-1px);box-shadow:0 4px 14px rgba(0,0,0,0.15);}
        .str-bar{height:3px;background:var(--g200);border-radius:2px;margin-top:6px;overflow:hidden;}
        .str-fill{height:100%;border-radius:2px;transition:all 0.4s;width:0;}
        .str-txt{font-size:11px;margin-top:4px;font-weight:600;}
        .eye-btn{position:absolute;right:11px;top:50%;transform:translateY(-50%);background:none;border:none;color:var(--g400);cursor:pointer;font-size:12px;transition:color 0.2s;padding:4px;}
        .eye-btn:hover{color:var(--black);}
        .toast-container{position:fixed;top:70px;right:20px;z-index:9999;}
        .toast-msg{background:#f0fdf4;border:1px solid #bbf7d0;color:#15803d;border-radius:10px;padding:11px 16px;font-size:13px;font-weight:600;display:flex;align-items:center;gap:8px;animation:slideIn 0.3s ease;box-shadow:0 4px 16px rgba(0,0,0,0.08);}
        .toast-err{background:#fef2f2;border-color:#fecaca;color:#dc2626;}
        @keyframes slideIn{from{opacity:0;transform:translateX(16px)}to{opacity:1;transform:translateX(0)}}
        .profile-pic-lg{width:76px;height:76px;border-radius:16px;object-fit:cover;border:1.5px solid var(--g200);}
        .profile-initials{width:76px;height:76px;border-radius:16px;background:var(--black);display:flex;align-items:center;justify-content:center;font-size:26px;font-weight:800;color:var(--white);}
        .pic-preview{width:56px;height:56px;border-radius:10px;object-fit:cover;border:1.5px solid var(--g200);display:none;margin-top:8px;}
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-logo"><div class="logo-text">Mednet EMS</div></div>
    <nav class="sidebar-nav">
        <div class="nav-section">My Space</div>
        <a href="/employee-mgmt/employee/dashboard" class="nav-item"><i class="fas fa-house"></i> Dashboard</a>
        <a href="/employee-mgmt/employee/profile" class="nav-item active"><i class="fas fa-circle-user"></i> My Profile</a>
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
    <div class="page-title">My Profile</div>
    <div class="topbar-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <a href="/employee-mgmt/logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</header>

<div class="toast-container">
    <c:if test="${not empty success}"><div class="toast-msg" id="toastOk"><i class="fas fa-check-circle"></i> ${success}</div></c:if>
    <c:if test="${not empty pwdError}"><div class="toast-msg toast-err" id="toastErr"><i class="fas fa-exclamation-circle"></i> ${pwdError}</div></c:if>
</div>

<div class="main">
    <div class="row g-3">
        <div class="col-md-4">
            <div class="form-card text-center">
                <c:choose>
                    <c:when test="${not empty emp.profilePicture}">
                        <img src="/employee-mgmt/uploads/${emp.profilePicture}" class="profile-pic-lg mx-auto d-block mb-3" alt=""/>
                    </c:when>
                    <c:otherwise>
                        <div class="profile-initials mx-auto mb-3">${emp.name.substring(0,1).toUpperCase()}</div>
                    </c:otherwise>
                </c:choose>
                <div style="font-size:16px;font-weight:800;color:var(--black)">${emp.name}</div>
                <div style="font-size:12px;color:var(--g400);margin-top:3px">${emp.designation != null ? emp.designation : 'Employee'}</div>
                <div style="font-size:12px;color:var(--g400);margin-top:1px">${emp.department != null ? emp.department : ''}</div>
                <hr style="border-color:var(--g200);margin:14px 0;"/>
                <div style="font-size:12px;color:var(--g500);text-align:left">
                    <div style="margin-bottom:7px;display:flex;align-items:center;gap:8px"><i class="fas fa-envelope" style="color:var(--black);width:14px"></i>${emp.email != null ? emp.email : '—'}</div>
                    <div style="margin-bottom:7px;display:flex;align-items:center;gap:8px"><i class="fas fa-calendar" style="color:var(--black);width:14px"></i>Joined: ${emp.joiningDate != null ? emp.joiningDate : '—'}</div>
                    <div style="display:flex;align-items:center;gap:8px"><i class="fas fa-id-badge" style="color:var(--black);width:14px"></i>${emp.loginId}</div>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="form-card">
                <div class="card-title"><i class="fas fa-pen-to-square"></i> Edit My Profile</div>
                <form action="/employee-mgmt/employee/profile/update" method="post" enctype="multipart/form-data">
                    <div class="row g-3">
                        <div class="col-md-6 fld"><label>Phone</label><div class="fld-wrap"><input type="text" name="phone" class="inp" value="${emp.phone}" placeholder="+91 XXXXX XXXXX"/><i class="fas fa-phone fld-ico"></i></div></div>
                        <div class="col-12 fld"><label>Address</label><div class="fld-wrap"><textarea name="address" class="inp" rows="2" style="padding-top:10px" placeholder="Street address">${emp.address}</textarea><i class="fas fa-map-marker-alt fld-ico" style="top:16px;transform:none;"></i></div></div>
                        <div class="col-md-6 fld"><label>City</label><div class="fld-wrap"><input type="text" name="city" class="inp" value="${emp.city}" placeholder="City"/><i class="fas fa-city fld-ico"></i></div></div>
                        <div class="col-md-6 fld"><label>State</label><div class="fld-wrap"><input type="text" name="state" class="inp" value="${emp.state}" placeholder="State"/><i class="fas fa-map fld-ico"></i></div></div>
                        <div class="col-12 fld">
                            <label>Profile Picture</label>
                            <input type="file" name="profilePic" class="inp" accept="image/*" onchange="previewPic(this)" style="padding:8px 12px;"/>
                            <img id="picPreview" class="pic-preview" src="" alt="Preview"/>
                        </div>
                    </div>
                    <button type="submit" class="btn-save mt-2"><i class="fas fa-floppy-disk me-2"></i>Save Changes</button>
                </form>
            </div>

            <div class="form-card" id="change-password">
                <div class="card-title"><i class="fas fa-key"></i> Change Password</div>
                <form action="/employee-mgmt/employee/change-password" method="post">
                    <div class="row g-3">
                        <div class="col-12 fld">
                            <label>Current Password</label>
                            <div class="fld-wrap">
                                <input type="password" name="currentPassword" id="curPwd" class="inp" placeholder="Enter current password" required style="padding-right:38px"/>
                                <i class="fas fa-lock fld-ico"></i>
                                <button type="button" class="eye-btn" onclick="togglePwd('curPwd','eye1')"><i class="fas fa-eye" id="eye1"></i></button>
                            </div>
                        </div>
                        <div class="col-md-6 fld">
                            <label>New Password</label>
                            <div class="fld-wrap">
                                <input type="password" name="newPassword" id="newPwd" class="inp" placeholder="New password" oninput="checkStr(this.value)" required style="padding-right:38px"/>
                                <i class="fas fa-lock fld-ico"></i>
                                <button type="button" class="eye-btn" onclick="togglePwd('newPwd','eye2')"><i class="fas fa-eye" id="eye2"></i></button>
                            </div>
                            <div class="str-bar"><div class="str-fill" id="strFill"></div></div>
                            <div class="str-txt" id="strTxt"></div>
                        </div>
                        <div class="col-md-6 fld">
                            <label>Confirm New Password</label>
                            <div class="fld-wrap">
                                <input type="password" name="confirmPassword" id="confPwd" class="inp" placeholder="Confirm new password" required style="padding-right:38px"/>
                                <i class="fas fa-lock fld-ico"></i>
                                <button type="button" class="eye-btn" onclick="togglePwd('confPwd','eye3')"><i class="fas fa-eye" id="eye3"></i></button>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn-save mt-2"><i class="fas fa-key me-2"></i>Change Password</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    setInterval(()=>document.getElementById('clock').textContent=new Date().toLocaleTimeString(),1000);
    document.getElementById('clock').textContent=new Date().toLocaleTimeString();
    const t1=document.getElementById('toastOk'),t2=document.getElementById('toastErr');
    if(t1)setTimeout(()=>{t1.style.transition='opacity 0.4s';t1.style.opacity='0';},3500);
    if(t2)setTimeout(()=>{t2.style.transition='opacity 0.4s';t2.style.opacity='0';},4000);
    function togglePwd(id,ico){const p=document.getElementById(id),i=document.getElementById(ico);p.type=p.type==='password'?'text':'password';i.className=p.type==='password'?'fas fa-eye':'fas fa-eye-slash';}
    function checkStr(v){let s=0;if(v.length>=8)s++;if(/[A-Z]/.test(v))s++;if(/[0-9]/.test(v))s++;if(/[^A-Za-z0-9]/.test(v))s++;const lvl=[{c:'#ef4444',l:'Weak',w:'25%'},{c:'#f97316',l:'Fair',w:'50%'},{c:'#eab308',l:'Good',w:'75%'},{c:'#22c55e',l:'Strong',w:'100%'}];const d=lvl[Math.min(s-1,3)];const f=document.getElementById('strFill'),t=document.getElementById('strTxt');if(v.length>0&&d){f.style.width=d.w;f.style.background=d.c;t.textContent='Strength: '+d.l;t.style.color=d.c;}else{f.style.width='0';t.textContent='';}}
    function previewPic(input){const p=document.getElementById('picPreview');if(input.files&&input.files[0]){p.src=URL.createObjectURL(input.files[0]);p.style.display='block';}}
</script>
</body>
</html>


