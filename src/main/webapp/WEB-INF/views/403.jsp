<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Access Denied — Mednet EMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <style>
        *{margin:0;padding:0;box-sizing:border-box;}
        body{font-family:'Inter',sans-serif;background:#f9fafb;min-height:100vh;display:flex;align-items:center;justify-content:center;color:#111827;}
        .box{text-align:center;padding:48px;background:#fff;border:1px solid #e5e7eb;border-radius:20px;box-shadow:0 4px 24px rgba(0,0,0,0.06);max-width:420px;width:90%;}
        .icon-wrap{width:72px;height:72px;border-radius:18px;background:#fee2e2;display:flex;align-items:center;justify-content:center;margin:0 auto 20px;font-size:28px;color:#dc2626;}
        .code{font-size:56px;font-weight:900;color:#111827;letter-spacing:-3px;line-height:1;margin-bottom:8px;}
        .msg{font-size:18px;font-weight:700;color:#111827;margin-bottom:8px;}
        .sub{font-size:14px;color:#6b7280;margin-bottom:28px;line-height:1.6;}
        .btn{background:#0a0a0a;color:#fff;border:none;border-radius:100px;padding:11px 28px;font-size:14px;font-weight:700;text-decoration:none;display:inline-block;transition:all 0.2s;font-family:'Inter',sans-serif;}
        .btn:hover{background:#222;transform:translateY(-1px);box-shadow:0 4px 14px rgba(0,0,0,0.15);color:#fff;}
    </style>
</head>
<body>
<div class="box">
    <div class="icon-wrap"><i class="fas fa-ban"></i></div>
    <div class="code">403</div>
    <div class="msg">Access Denied</div>
    <p class="sub">You don't have permission to access this page. Please contact your administrator.</p>
    <a href="/employee-mgmt/dashboard" class="btn"><i class="fas fa-arrow-left me-2"></i>Go to Dashboard</a>
</div>
</body>
</html>


