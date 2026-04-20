<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Mednet EMS — Create Account</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --black: #0a0a0a;
            --white: #ffffff;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-400: #9ca3af;
            --gray-500: #6b7280;
            --gray-700: #374151;
            --gray-900: #111827;
            --green: #22c55e;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--white);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ── NAVBAR ── */
        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 48px;
            border-bottom: 1px solid var(--gray-100);
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(12px);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .nav-logo {
            display: flex;
            align-items: center;
            font-size: 17px;
            font-weight: 800;
            color: var(--black);
            text-decoration: none;
            letter-spacing: -0.4px;
        }
        .nav-links { display: flex; align-items: center; gap: 32px; list-style: none; }
        .nav-links a { font-size: 14px; font-weight: 500; color: var(--gray-700); text-decoration: none; transition: color 0.2s; }
        .nav-links a:hover { color: var(--black); }
        .nav-actions { display: flex; align-items: center; gap: 10px; }
        .btn-ghost {
            padding: 8px 18px; border: 1px solid var(--gray-200); border-radius: 100px;
            font-size: 14px; font-weight: 600; color: var(--gray-700); background: transparent;
            cursor: pointer; text-decoration: none; transition: all 0.2s; font-family: 'Inter', sans-serif;
        }
        .btn-ghost:hover { background: var(--gray-50); color: var(--black); }
        .btn-solid {
            padding: 8px 18px; border: none; border-radius: 100px;
            font-size: 14px; font-weight: 600; color: var(--white); background: var(--black);
            cursor: pointer; text-decoration: none; transition: all 0.2s; font-family: 'Inter', sans-serif;
        }
        .btn-solid:hover { background: #222; transform: translateY(-1px); box-shadow: 0 4px 16px rgba(0,0,0,0.15); color: var(--white); }

        /* ── PAGE BODY ── */
        .page-body {
            flex: 1;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            padding: 48px 24px 60px;
            background: var(--gray-50);
        }

        /* ── CARD ── */
        .reg-card {
            background: var(--white);
            border: 1px solid var(--gray-200);
            border-radius: 24px;
            padding: 40px 44px;
            width: 680px;
            max-width: 100%;
            box-shadow: 0 4px 24px rgba(0,0,0,0.06), 0 1px 4px rgba(0,0,0,0.04);
            animation: cardIn 0.5s cubic-bezier(0.16,1,0.3,1);
        }
        @keyframes cardIn { from{opacity:0;transform:translateY(16px)} to{opacity:1;transform:translateY(0)} }

        /* ── HEADER ── */
        .reg-header { margin-bottom: 32px; }
        .reg-header-top {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 6px;
        }
        .reg-icon {
            width: 44px; height: 44px;
            background: var(--black);
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
        }
        .reg-title { font-size: 24px; font-weight: 800; color: var(--black); letter-spacing: -0.6px; }
        .reg-sub { font-size: 14px; color: var(--gray-400); font-weight: 400; margin-top: 2px; }

        /* ── STEP INDICATOR ── */
        .steps {
            display: flex;
            align-items: center;
            gap: 0;
            margin-bottom: 28px;
            padding: 16px 20px;
            background: var(--gray-50);
            border-radius: 14px;
            border: 1px solid var(--gray-100);
        }
        .step { display: flex; align-items: center; gap: 8px; flex: 1; }
        .step-num {
            width: 28px; height: 28px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 12px; font-weight: 700; flex-shrink: 0;
            background: var(--black); color: var(--white);
        }
        .step-lbl { font-size: 12px; font-weight: 600; color: var(--gray-700); }
        .step-connector { flex: 1; height: 1px; background: var(--gray-200); margin: 0 8px; }

        /* ── SECTION DIVIDER ── */
        .sec-div {
            display: flex; align-items: center; gap: 10px;
            margin: 24px 0 16px;
        }
        .sec-icon {
            width: 26px; height: 26px; border-radius: 7px;
            background: var(--gray-100);
            display: flex; align-items: center; justify-content: center;
            font-size: 12px; flex-shrink: 0;
        }
        .sec-label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: var(--gray-400); white-space: nowrap; }
        .sec-line { flex: 1; height: 1px; background: var(--gray-200); }

        /* ── INPUTS ── */
        .fld { margin-bottom: 14px; }
        .fld label {
            display: block; font-size: 12px; font-weight: 600;
            color: var(--gray-700); margin-bottom: 6px;
        }
        .fld-wrap { position: relative; }
        .fld-ico {
            position: absolute; left: 13px; top: 50%; transform: translateY(-50%);
            color: var(--gray-400); font-size: 12px; pointer-events: none; transition: color 0.2s;
        }
        .inp {
            width: 100%;
            background: var(--gray-50);
            border: 1.5px solid var(--gray-200);
            border-radius: 11px;
            padding: 11px 13px 11px 38px;
            color: var(--black);
            font-size: 13px;
            font-family: 'Inter', sans-serif;
            font-weight: 500;
            transition: all 0.2s;
            outline: none;
        }
        .inp:focus {
            background: var(--white);
            border-color: var(--black);
            box-shadow: 0 0 0 3px rgba(0,0,0,0.06);
        }
        .fld-wrap:focus-within .fld-ico { color: var(--black); }
        .inp::placeholder { color: var(--gray-400); font-weight: 400; }
        select.inp option { background: var(--white); color: var(--black); }
        textarea.inp { resize: none; padding-top: 11px; }

        /* PASSWORD STRENGTH */
        .pwd-wrap .inp { padding-right: 40px; }
        .eye-btn {
            position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
            background: none; border: none; color: var(--gray-400); cursor: pointer;
            font-size: 12px; transition: color 0.2s; padding: 4px;
        }
        .eye-btn:hover { color: var(--black); }
        .str-bar { height: 3px; background: var(--gray-200); border-radius: 2px; margin-top: 6px; overflow: hidden; }
        .str-fill { height: 100%; border-radius: 2px; transition: all 0.4s; width: 0; }
        .str-txt { font-size: 11px; margin-top: 4px; font-weight: 600; }

        /* FILE INPUT */
        .inp-file {
            width: 100%;
            background: var(--gray-50);
            border: 1.5px dashed var(--gray-200);
            border-radius: 11px;
            padding: 11px 13px;
            color: var(--gray-500);
            font-size: 13px;
            font-family: 'Inter', sans-serif;
            transition: all 0.2s;
            outline: none;
            cursor: pointer;
        }
        .inp-file:hover { border-color: var(--black); background: var(--white); }

        /* ── SUBMIT ── */
        .btn-reg {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            background: var(--black);
            color: var(--white);
            transition: all 0.2s;
            margin-top: 24px;
            letter-spacing: -0.2px;
        }
        .btn-reg:hover { background: #222; transform: translateY(-1px); box-shadow: 0 6px 20px rgba(0,0,0,0.2); }

        .login-cta { text-align: center; margin-top: 16px; font-size: 13px; color: var(--gray-500); }
        .login-cta a {
            color: var(--black); font-weight: 700; text-decoration: none;
            border-bottom: 1.5px solid var(--black); padding-bottom: 1px; transition: opacity 0.2s;
        }
        .login-cta a:hover { opacity: 0.6; }

        .alert-err {
            background: #fef2f2; border: 1px solid #fecaca; color: #dc2626;
            border-radius: 10px; padding: 10px 14px; font-size: 13px;
            margin-bottom: 18px; display: flex; align-items: center; gap: 8px; font-weight: 500;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
    <a href="#" class="nav-logo">Mednet EMS</a>
    <ul class="nav-links">
        <li><a href="#">Overview</a></li>
        <li><a href="#">Features</a></li>
        <li><a href="#">Pricing</a></li>
        <li><a href="#">Discover</a></li>
    </ul>
    <div class="nav-actions">
        <a href="login" class="btn-ghost">Log In</a>
        <a href="register" class="btn-solid">Sign Up</a>
    </div>
</nav>

<div class="page-body">
<div class="reg-card">

    <div class="reg-header">
        <div class="reg-header-top">
            <div class="reg-icon"><i class="fas fa-user-plus" style="font-size:18px;color:#fff"></i></div>
            <div>
                <div class="reg-title">Create your account</div>
                <div class="reg-sub">Join Mednet EMS — takes less than a minute</div>
            </div>
        </div>
    </div>

    <!-- STEPS -->
    <div class="steps">
        <div class="step">
            <div class="step-num">1</div>
            <div class="step-lbl">Personal</div>
        </div>
        <div class="step-connector"></div>
        <div class="step">
            <div class="step-num">2</div>
            <div class="step-lbl">Address</div>
        </div>
        <div class="step-connector"></div>
        <div class="step">
            <div class="step-num">3</div>
            <div class="step-lbl">Credentials</div>
        </div>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert-err"><i class="fas fa-exclamation-circle"></i> ${error}</div>
    <% } %>

    <form action="register" method="post" enctype="multipart/form-data">

        <!-- PERSONAL -->
        <div class="sec-div">
            <div class="sec-icon"><i class="fas fa-user" style="font-size:11px;color:#6b7280"></i></div>
            <div class="sec-label">Personal Information</div>
            <div class="sec-line"></div>
        </div>
        <div class="row g-3">
            <div class="col-12 fld">
                <label>Full Name *</label>
                <div class="fld-wrap">
                    <input type="text" name="name" class="inp" placeholder="e.g. John Smith" required/>
                    <i class="fas fa-user fld-ico"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>Date of Birth</label>
                <div class="fld-wrap">
                    <input type="date" name="dateOfBirth" class="inp"/>
                    <i class="fas fa-calendar fld-ico"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>Gender</label>
                <div class="fld-wrap">
                    <select name="gender" class="inp">
                        <option value="" disabled selected>Select gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                    <i class="fas fa-venus-mars fld-ico"></i>
                </div>
            </div>
        </div>

        <!-- ADDRESS -->
        <div class="sec-div">
            <div class="sec-icon"><i class="fas fa-location-dot" style="font-size:11px;color:#6b7280"></i></div>
            <div class="sec-label">Address Details</div>
            <div class="sec-line"></div>
        </div>
        <div class="row g-3">
            <div class="col-12 fld">
                <label>Street Address</label>
                <div class="fld-wrap">
                    <textarea name="address" class="inp" rows="2" placeholder="e.g. 123 Main Street" style="padding-top:11px"></textarea>
                    <i class="fas fa-map-marker-alt fld-ico" style="top:18px;transform:none;"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>City</label>
                <div class="fld-wrap">
                    <input type="text" name="city" class="inp" placeholder="e.g. Mumbai"/>
                    <i class="fas fa-city fld-ico"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>State</label>
                <div class="fld-wrap">
                    <input type="text" name="state" class="inp" placeholder="e.g. Maharashtra"/>
                    <i class="fas fa-map fld-ico"></i>
                </div>
            </div>
        </div>

        <!-- CONTACT & WORK -->
        <div class="sec-div">
            <div class="sec-icon"><i class="fas fa-phone" style="font-size:11px;color:#6b7280"></i></div>
            <div class="sec-label">Contact & Work</div>
            <div class="sec-line"></div>
        </div>
        <div class="row g-3">
            <div class="col-md-6 fld">
                <label>Email</label>
                <div class="fld-wrap">
                    <input type="email" name="email" class="inp" placeholder="email@example.com"/>
                    <i class="fas fa-envelope fld-ico"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>Phone</label>
                <div class="fld-wrap">
                    <input type="text" name="phone" class="inp" placeholder="+91 XXXXX XXXXX"/>
                    <i class="fas fa-phone fld-ico"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>Department</label>
                <div class="fld-wrap">
                    <input type="text" name="department" class="inp" placeholder="e.g. Engineering"/>
                    <i class="fas fa-building fld-ico"></i>
                </div>
            </div>
            <div class="col-md-6 fld">
                <label>Designation</label>
                <div class="fld-wrap">
                    <input type="text" name="designation" class="inp" placeholder="e.g. Software Engineer"/>
                    <i class="fas fa-briefcase fld-ico"></i>
                </div>
            </div>
        </div>

        <!-- CREDENTIALS -->
        <div class="sec-div">
            <div class="sec-icon"><i class="fas fa-lock" style="font-size:11px;color:#6b7280"></i></div>
            <div class="sec-label">Login Credentials</div>
            <div class="sec-line"></div>
        </div>
        <div class="row g-3">
            <div class="col-12 fld">
                <label>Login ID *</label>
                <div class="fld-wrap">
                    <input type="text" name="loginId" class="inp" placeholder="Choose a unique login ID" required/>
                    <i class="fas fa-id-card fld-ico"></i>
                </div>
            </div>
            <div class="col-12 fld">
                <label>Password *</label>
                <div class="fld-wrap pwd-wrap">
                    <input type="password" name="password" id="regPwd" class="inp" placeholder="Min 8 chars, uppercase, number, special char" oninput="checkStr(this.value)" required/>
                    <i class="fas fa-lock fld-ico"></i>
                    <button type="button" class="eye-btn" onclick="toggleReg()"><i class="fas fa-eye" id="regEye"></i></button>
                </div>
                <div class="str-bar"><div class="str-fill" id="strFill"></div></div>
                <div class="str-txt" id="strTxt"></div>
            </div>
            <div class="col-12 fld">
                <label>Profile Picture <span style="color:var(--gray-400);font-weight:400">(optional)</span></label>
                <input type="file" name="profilePic" class="inp-file" accept="image/*"/>
            </div>
        </div>

        <button type="submit" class="btn-reg">Create Account →</button>
    </form>

    <div class="login-cta">Already have an account? <a href="login">Sign in →</a></div>
</div>
</div>

<script>
    function toggleReg() {
        const p = document.getElementById('regPwd'), i = document.getElementById('regEye');
        p.type = p.type === 'password' ? 'text' : 'password';
        i.className = p.type === 'password' ? 'fas fa-eye' : 'fas fa-eye-slash';
    }
    function checkStr(v) {
        let s = 0;
        if (v.length >= 8) s++; if (/[A-Z]/.test(v)) s++; if (/[0-9]/.test(v)) s++; if (/[^A-Za-z0-9]/.test(v)) s++;
        const lvl = [{c:'#ef4444',l:'Weak',w:'25%'},{c:'#f97316',l:'Fair',w:'50%'},{c:'#eab308',l:'Good',w:'75%'},{c:'#22c55e',l:'Strong',w:'100%'}];
        const d = lvl[Math.min(s - 1, 3)];
        const f = document.getElementById('strFill'), t = document.getElementById('strTxt');
        if (v.length > 0 && d) { f.style.width = d.w; f.style.background = d.c; t.textContent = 'Strength: ' + d.l; t.style.color = d.c; }
        else { f.style.width = '0'; t.textContent = ''; }
    }
</script>
</body>
</html>


