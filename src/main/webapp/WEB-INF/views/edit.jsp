<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Mednet EMS — Edit Employee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --indigo:#6366f1;--violet:#8b5cf6;--cyan:#06b6d4;
            --gold:#f59e0b;--bg:#030712;--border:rgba(255,255,255,0.07);--muted:rgba(148,163,184,0.7);
        }
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
        body {
            font-family:'Plus Jakarta Sans',sans-serif;
            background:var(--bg);min-height:100vh;
            display:flex;align-items:center;justify-content:center;
            padding:40px 20px;position:relative;overflow-x:hidden;
        }
        .blob{position:fixed;border-radius:50%;filter:blur(120px);pointer-events:none;z-index:0;}
        .b1{width:600px;height:600px;background:radial-gradient(circle,rgba(99,102,241,0.14),transparent 70%);top:-200px;left:-150px;animation:bd 20s ease-in-out infinite;}
        .b2{width:500px;height:500px;background:radial-gradient(circle,rgba(6,182,212,0.1),transparent 70%);bottom:-150px;right:-100px;animation:bd 25s ease-in-out infinite reverse;}
        @keyframes bd{0%,100%{transform:translate(0,0)}50%{transform:translate(40px,-40px)}}
        .grid-ov{position:fixed;inset:0;z-index:0;background-image:linear-gradient(rgba(255,255,255,0.015) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,0.015) 1px,transparent 1px);background-size:56px 56px;}

        /* CARD */
        .edit-wrap{position:relative;z-index:2;width:580px;max-width:100%;}
        .edit-card{
            background:rgba(255,255,255,0.025);
            backdrop-filter:blur(60px) saturate(180%);
            border:1px solid var(--border);border-radius:28px;
            padding:48px 44px;
            box-shadow:0 40px 80px rgba(0,0,0,0.6),inset 0 1px 0 rgba(255,255,255,0.07);
            animation:cardIn 0.7s cubic-bezier(0.16,1,0.3,1);
        }
        @keyframes cardIn{from{opacity:0;transform:translateY(40px) scale(0.97)}to{opacity:1;transform:translateY(0) scale(1)}}

        /* HEADER */
        .edit-head{text-align:center;margin-bottom:36px;}
        .edit-logo-wrap{position:relative;display:inline-block;margin-bottom:18px;}
        .edit-logo{
            width:72px;height:72px;border-radius:20px;
            background:linear-gradient(135deg,var(--indigo),var(--cyan));
            display:flex;align-items:center;justify-content:center;font-size:30px;
            box-shadow:0 0 0 1px rgba(99,102,241,0.3),0 16px 48px rgba(99,102,241,0.4);
            animation:pulse 3s ease-in-out infinite;
        }
        @keyframes pulse{0%,100%{box-shadow:0 0 0 1px rgba(99,102,241,0.3),0 16px 48px rgba(99,102,241,0.4)}50%{box-shadow:0 0 0 1px rgba(99,102,241,0.5),0 16px 64px rgba(99,102,241,0.65)}}
        .edit-logo-wrap::after{content:'';position:absolute;inset:-4px;border-radius:24px;background:linear-gradient(135deg,var(--indigo),var(--cyan),var(--violet));z-index:-1;opacity:0.35;filter:blur(10px);}
        .edit-head h2{font-size:26px;font-weight:800;color:white;letter-spacing:-0.5px;}
        .edit-head p{color:var(--muted);font-size:14px;margin-top:5px;}

        /* SECTION */
        .sec-div{display:flex;align-items:center;gap:10px;margin:24px 0 16px;}
        .sec-icon{width:26px;height:26px;border-radius:7px;display:flex;align-items:center;justify-content:center;font-size:12px;flex-shrink:0;}
        .sec-lbl{font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:1.2px;color:rgba(148,163,184,0.55);}
        .sec-line{flex:1;height:1px;background:var(--border);}

        /* INPUTS */
        .fld{margin-bottom:14px;}
        .fld label{display:block;font-size:11px;font-weight:700;color:rgba(148,163,184,0.65);text-transform:uppercase;letter-spacing:0.9px;margin-bottom:7px;}
        .fld-wrap{position:relative;}
        .fld-ico{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:rgba(148,163,184,0.3);font-size:13px;pointer-events:none;transition:color 0.3s;}
        .inp{
            width:100%;background:rgba(255,255,255,0.04);
            border:1px solid rgba(255,255,255,0.08);border-radius:12px;
            padding:12px 14px 12px 40px;color:white;font-size:14px;
            font-family:'Plus Jakarta Sans',sans-serif;transition:all 0.3s;outline:none;
        }
        .inp:focus{background:rgba(99,102,241,0.07);border-color:rgba(99,102,241,0.5);box-shadow:0 0 0 4px rgba(99,102,241,0.1);}
        .fld-wrap:focus-within .fld-ico{color:var(--indigo);}
        .inp::placeholder{color:rgba(255,255,255,0.15);}
        select.inp option{background:#0d0d1a;}
        textarea.inp{resize:none;padding-top:12px;}

        /* BUTTONS */
        .btn-row{display:flex;gap:12px;margin-top:28px;}
        .btn-back{
            flex:1;padding:13px;border-radius:12px;font-size:14px;font-weight:700;
            font-family:'Plus Jakarta Sans',sans-serif;text-align:center;text-decoration:none;
            background:rgba(255,255,255,0.05);border:1px solid var(--border);
            color:rgba(255,255,255,0.65);transition:all 0.2s;display:block;
        }
        .btn-back:hover{background:rgba(255,255,255,0.1);color:white;}
        .btn-save{
            flex:2;padding:13px;border:none;border-radius:12px;
            font-size:14px;font-weight:700;font-family:'Plus Jakarta Sans',sans-serif;
            cursor:pointer;position:relative;overflow:hidden;
            background:linear-gradient(135deg,var(--indigo),var(--violet),var(--cyan));
            background-size:200% 200%;color:white;transition:all 0.4s;
            box-shadow:0 6px 24px rgba(99,102,241,0.3);
        }
        .btn-save:hover{background-position:right center;transform:translateY(-2px);box-shadow:0 12px 36px rgba(99,102,241,0.5);}
        .btn-save .shine{position:absolute;top:0;left:-100%;width:60%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,0.2),transparent);transform:skewX(-20deg);transition:left 0.6s;}
        .btn-save:hover .shine{left:150%;}
        .btn-save .inner{position:relative;z-index:1;display:flex;align-items:center;justify-content:center;gap:8px;}
    </style>
</head>
<body>
<div class="blob b1"></div><div class="blob b2"></div>
<div class="grid-ov"></div>

<div class="edit-wrap">
<div class="edit-card">

    <div class="edit-head">
        <div class="edit-logo-wrap"><div class="edit-logo">✏️</div></div>
        <h2>Edit Employee</h2>
        <p>Update the details for <strong style="color:white">${emp.name}</strong></p>
    </div>

    <form action="/employee-mgmt/edit/${emp.id}" method="post">

        <div class="sec-div">
            <div class="sec-icon" style="background:rgba(99,102,241,0.18)">👤</div>
            <div class="sec-lbl">Personal Information</div>
            <div class="sec-line"></div>
        </div>
        <div class="row g-3">
            <div class="col-12 fld">
                <label>Full Name</label>
                <div class="fld-wrap">
                    <input type="text" name="name" class="inp" value="${emp.name}" required/>
                    <i class="fas fa-user fld-ico"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>Date of Birth</label>
                <div class="fld-wrap">
                    <input type="date" name="dateOfBirth" class="inp" value="${emp.dateOfBirth}" required/>
                    <i class="fas fa-calendar fld-ico"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>Gender</label>
                <div class="fld-wrap">
                    <select name="gender" class="inp" required>
                        <option value="Male"  ${emp.gender == 'Male'   ? 'selected' : ''}>Male</option>
                        <option value="Female"${emp.gender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${emp.gender == 'Other'  ? 'selected' : ''}>Other</option>
                    </select>
                    <i class="fas fa-venus-mars fld-ico"></i>
                </div>
            </div>
        </div>

        <div class="sec-div">
            <div class="sec-icon" style="background:rgba(6,182,212,0.15)">📍</div>
            <div class="sec-lbl">Address Details</div>
            <div class="sec-line"></div>
        </div>
        <div class="row g-3">
            <div class="col-12 fld">
                <label>Street Address</label>
                <div class="fld-wrap">
                    <textarea name="address" class="inp" rows="2" required style="padding-top:12px">${emp.address}</textarea>
                    <i class="fas fa-map-marker-alt fld-ico" style="top:18px;transform:none;"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>City</label>
                <div class="fld-wrap">
                    <input type="text" name="city" class="inp" value="${emp.city}" required/>
                    <i class="fas fa-city fld-ico"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>State</label>
                <div class="fld-wrap">
                    <input type="text" name="state" class="inp" value="${emp.state}" required/>
                    <i class="fas fa-map fld-ico"></i>
                </div>
            </div>
        </div>

        <div class="btn-row">
            <a href="/employee-mgmt/welcome" class="btn-back"><i class="fas fa-arrow-left me-2"></i>Back</a>
            <button type="submit" class="btn-save">
                <div class="shine"></div>
                <div class="inner"><i class="fas fa-floppy-disk"></i> Save Changes</div>
            </button>
        </div>
    </form>

</div>
</div>
</body>
</html>


