<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Add Employee — Mednet EMS</title>
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
        .form-card{background:var(--white);border:1px solid var(--g200);border-radius:14px;padding:26px;}
        .sec-div{display:flex;align-items:center;gap:10px;margin:22px 0 14px;}
        .sec-icon{width:26px;height:26px;border-radius:7px;background:var(--g100);display:flex;align-items:center;justify-content:center;font-size:12px;color:var(--g700);flex-shrink:0;}
        .sec-lbl{font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:1px;color:var(--g500);}
        .sec-line{flex:1;height:1px;background:var(--g200);}
        .fld{margin-bottom:14px;}
        .fld label{display:block;font-size:12px;font-weight:600;color:var(--g700);margin-bottom:6px;}
        .fld-wrap{position:relative;}
        .fld-ico{position:absolute;left:12px;top:50%;transform:translateY(-50%);color:var(--g400);font-size:12px;pointer-events:none;transition:color 0.2s;}
        .inp{width:100%;background:var(--g50);border:1.5px solid var(--g200);border-radius:10px;padding:10px 12px 10px 36px;color:var(--black);font-size:13px;font-family:'Inter',sans-serif;font-weight:500;transition:all 0.2s;outline:none;}
        .inp:focus{background:var(--white);border-color:var(--black);box-shadow:0 0 0 3px rgba(0,0,0,0.06);}
        .fld-wrap:focus-within .fld-ico{color:var(--black);}
        .inp::placeholder{color:var(--g400);font-weight:400;}
        select.inp option{background:var(--white);}
        textarea.inp{resize:none;padding-top:10px;}
        .btn-row{display:flex;gap:10px;margin-top:22px;}
        .btn-back{flex:1;padding:11px;border-radius:10px;font-size:13px;font-weight:700;font-family:'Inter',sans-serif;text-align:center;text-decoration:none;background:var(--white);border:1.5px solid var(--g200);color:var(--g700);transition:all 0.15s;display:block;}
        .btn-back:hover{background:var(--g50);color:var(--black);}
        .btn-save{flex:2;padding:11px;border:none;border-radius:10px;font-size:13px;font-weight:700;font-family:'Inter',sans-serif;cursor:pointer;background:var(--black);color:var(--white);transition:all 0.2s;}
        .btn-save:hover{background:#222;transform:translateY(-1px);box-shadow:0 4px 14px rgba(0,0,0,0.15);}
        .str-bar{height:3px;background:var(--g200);border-radius:2px;margin-top:6px;overflow:hidden;}
        .str-fill{height:100%;border-radius:2px;transition:all 0.4s;width:0;}
        .str-txt{font-size:11px;margin-top:4px;font-weight:600;}
        .pic-preview{width:60px;height:60px;border-radius:10px;object-fit:cover;border:1.5px solid var(--g200);display:none;margin-top:8px;}
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-logo"><div class="logo-text">Mednet EMS</div></div>
    <nav class="sidebar-nav">
        <div class="nav-section">Main</div>
        <a href="/employee-mgmt/admin/dashboard" class="nav-item"><i class="fas fa-chart-pie"></i> Dashboard</a>
        <a href="/employee-mgmt/admin/employees" class="nav-item"><i class="fas fa-users"></i> Employees</a>
        <a href="/employee-mgmt/admin/add-employee" class="nav-item active"><i class="fas fa-user-plus"></i> Add Employee</a>
        <div class="nav-section">Management</div>
        <a href="/employee-mgmt/admin/leaves" class="nav-item"><i class="fas fa-calendar-xmark"></i> Leave Requests</a>
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
    <div class="page-title">Add New Employee</div>
    <div class="topbar-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <a href="/employee-mgmt/logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</header>
<div class="main">
<div class="form-card">
    <form action="/employee-mgmt/admin/add-employee" method="post" enctype="multipart/form-data">

        <div class="sec-div"><div class="sec-icon"><i class="fas fa-user"></i></div><div class="sec-lbl">Personal Info</div><div class="sec-line"></div></div>
        <div class="row g-3">
            <div class="col-md-6 fld"><label>Full Name *</label><div class="fld-wrap"><input type="text" name="name" class="inp" placeholder="Full name" required/><i class="fas fa-user fld-ico"></i></div></div>
            <div class="col-md-3 fld"><label>Date of Birth</label><div class="fld-wrap"><input type="date" name="dateOfBirth" class="inp"/><i class="fas fa-calendar fld-ico"></i></div></div>
            <div class="col-md-3 fld"><label>Gender</label><div class="fld-wrap"><select name="gender" class="inp"><option value="">Select</option><option value="Male">Male</option><option value="Female">Female</option><option value="Other">Other</option></select><i class="fas fa-venus-mars fld-ico"></i></div></div>
            <div class="col-md-6 fld"><label>Email</label><div class="fld-wrap"><input type="email" name="email" class="inp" placeholder="email@example.com"/><i class="fas fa-envelope fld-ico"></i></div></div>
            <div class="col-md-6 fld"><label>Phone</label><div class="fld-wrap"><input type="text" name="phone" class="inp" placeholder="+91 XXXXX XXXXX"/><i class="fas fa-phone fld-ico"></i></div></div>
        </div>

        <div class="sec-div"><div class="sec-icon"><i class="fas fa-briefcase"></i></div><div class="sec-lbl">Work Details</div><div class="sec-line"></div></div>
        <div class="row g-3">
            <div class="col-md-4 fld"><label>Department</label><div class="fld-wrap"><input type="text" name="department" class="inp" placeholder="e.g. Engineering"/><i class="fas fa-building fld-ico"></i></div></div>
            <div class="col-md-4 fld"><label>Designation</label><div class="fld-wrap"><input type="text" name="designation" class="inp" placeholder="e.g. Software Engineer"/><i class="fas fa-id-badge fld-ico"></i></div></div>
            <div class="col-md-4 fld"><label>Joining Date</label><div class="fld-wrap"><input type="date" name="joiningDate" class="inp"/><i class="fas fa-calendar-check fld-ico"></i></div></div>
            <div class="col-md-3 fld"><label>Role *</label><div class="fld-wrap"><select name="role" class="inp" required><option value="EMPLOYEE">Employee</option><option value="ADMIN">Admin</option></select><i class="fas fa-shield-halved fld-ico"></i></div></div>
            <div class="col-md-3 fld"><label>Status *</label><div class="fld-wrap"><select name="status" class="inp" required><option value="ACTIVE">Active</option><option value="INACTIVE">Inactive</option><option value="ON_LEAVE">On Leave</option></select><i class="fas fa-circle-dot fld-ico"></i></div></div>
        </div>

        <div class="sec-div"><div class="sec-icon"><i class="fas fa-location-dot"></i></div><div class="sec-lbl">Address</div><div class="sec-line"></div></div>
        <div class="row g-3">
            <div class="col-12 fld"><label>Street Address</label><div class="fld-wrap"><textarea name="address" class="inp" rows="2" style="padding-top:10px" placeholder="Street address"></textarea><i class="fas fa-map-marker-alt fld-ico" style="top:16px;transform:none;"></i></div></div>
            <div class="col-md-6 fld"><label>City</label><div class="fld-wrap"><input type="text" name="city" class="inp" placeholder="City"/><i class="fas fa-city fld-ico"></i></div></div>
            <div class="col-md-6 fld"><label>State</label><div class="fld-wrap"><input type="text" name="state" class="inp" placeholder="State"/><i class="fas fa-map fld-ico"></i></div></div>
        </div>

        <div class="sec-div"><div class="sec-icon"><i class="fas fa-lock"></i></div><div class="sec-lbl">Credentials & Photo</div><div class="sec-line"></div></div>
        <div class="row g-3">
            <div class="col-md-6 fld"><label>Login ID *</label><div class="fld-wrap"><input type="text" name="loginId" class="inp" placeholder="Unique login ID" required/><i class="fas fa-id-card fld-ico"></i></div></div>
            <div class="col-md-6 fld">
                <label>Password *</label>
                <div class="fld-wrap"><input type="password" name="password" id="pwd" class="inp" placeholder="Password" oninput="checkStr(this.value)" required/><i class="fas fa-lock fld-ico"></i></div>
                <div class="str-bar"><div class="str-fill" id="strFill"></div></div>
                <div class="str-txt" id="strTxt"></div>
            </div>
            <div class="col-md-6 fld">
                <label>Profile Picture</label>
                <input type="file" name="profilePic" class="inp" accept="image/*" onchange="previewPic(this)" style="padding:8px 12px;"/>
                <img id="picPreview" class="pic-preview" src="" alt="Preview"/>
            </div>
        </div>

        <div class="btn-row">
            <a href="/employee-mgmt/admin/employees" class="btn-back"><i class="fas fa-arrow-left me-2"></i>Back</a>
            <button type="submit" class="btn-save"><i class="fas fa-user-plus me-2"></i>Add Employee</button>
        </div>
    </form>
</div>
</div>
<script>
    setInterval(()=>document.getElementById('clock').textContent=new Date().toLocaleTimeString(),1000);
    document.getElementById('clock').textContent=new Date().toLocaleTimeString();
    function checkStr(v){let s=0;if(v.length>=8)s++;if(/[A-Z]/.test(v))s++;if(/[0-9]/.test(v))s++;if(/[^A-Za-z0-9]/.test(v))s++;const lvl=[{c:'#ef4444',l:'Weak',w:'25%'},{c:'#f97316',l:'Fair',w:'50%'},{c:'#eab308',l:'Good',w:'75%'},{c:'#22c55e',l:'Strong',w:'100%'}];const d=lvl[Math.min(s-1,3)];const f=document.getElementById('strFill'),t=document.getElementById('strTxt');if(v.length>0&&d){f.style.width=d.w;f.style.background=d.c;t.textContent='Strength: '+d.l;t.style.color=d.c;}else{f.style.width='0';t.textContent='';}}
    function previewPic(input){const p=document.getElementById('picPreview');if(input.files&&input.files[0]){p.src=URL.createObjectURL(input.files[0]);p.style.display='block';}}
</script>
</body>
</html>


