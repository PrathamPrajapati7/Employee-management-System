<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Mednet EMS — Sign In</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
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
            --accent: #0a0a0a;
            --green: #22c55e;
            --red: #ef4444;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--white);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
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
        .nav-links {
            display: flex;
            align-items: center;
            gap: 32px;
            list-style: none;
        }
        .nav-links a {
            font-size: 14px;
            font-weight: 500;
            color: var(--gray-700);
            text-decoration: none;
            transition: color 0.2s;
        }
        .nav-links a:hover { color: var(--black); }
        .nav-actions { display: flex; align-items: center; gap: 10px; }
        .btn-ghost {
            padding: 8px 18px;
            border: 1px solid var(--gray-200);
            border-radius: 100px;
            font-size: 14px;
            font-weight: 600;
            color: var(--gray-700);
            background: transparent;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
            font-family: 'Inter', sans-serif;
        }
        .btn-ghost:hover { background: var(--gray-50); color: var(--black); }
        .btn-solid {
            padding: 8px 18px;
            border: none;
            border-radius: 100px;
            font-size: 14px;
            font-weight: 600;
            color: var(--white);
            background: var(--black);
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
            font-family: 'Inter', sans-serif;
        }
        .btn-solid:hover { background: #222; transform: translateY(-1px); box-shadow: 0 4px 16px rgba(0,0,0,0.15); color: var(--white); }

        /* ── HERO SECTION ── */
        .hero {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px 48px;
            position: relative;
            overflow: hidden;
        }

        /* Floating avatars */
        .float-avatar {
            position: absolute;
            border-radius: 50%;
            overflow: hidden;
            border: 3px solid var(--white);
            box-shadow: 0 8px 32px rgba(0,0,0,0.12);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            font-weight: 700;
            color: var(--white);
            animation: floatUp 6s ease-in-out infinite;
        }
        .fa1 { width:56px;height:56px;background:linear-gradient(135deg,#f97316,#ef4444);top:12%;left:6%;animation-delay:0s; }
        .fa2 { width:48px;height:48px;background:linear-gradient(135deg,#8b5cf6,#6366f1);top:28%;left:2%;animation-delay:1s; }
        .fa3 { width:64px;height:64px;background:linear-gradient(135deg,#06b6d4,#3b82f6);top:55%;left:8%;animation-delay:2s; }
        .fa4 { width:44px;height:44px;background:linear-gradient(135deg,#10b981,#059669);top:75%;left:4%;animation-delay:0.5s; }
        .fa5 { width:52px;height:52px;background:linear-gradient(135deg,#f59e0b,#f97316);top:10%;right:6%;animation-delay:1.5s; }
        .fa6 { width:60px;height:60px;background:linear-gradient(135deg,#ec4899,#f43f5e);top:35%;right:3%;animation-delay:2.5s; }
        .fa7 { width:46px;height:46px;background:linear-gradient(135deg,#6366f1,#8b5cf6);top:65%;right:7%;animation-delay:0.8s; }
        @keyframes floatUp {
            0%,100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-12px) rotate(2deg); }
            66% { transform: translateY(6px) rotate(-1deg); }
        }

        /* ── CENTER CONTENT ── */
        .hero-center {
            text-align: center;
            max-width: 520px;
            position: relative;
            z-index: 2;
        }
        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: var(--gray-100);
            border: 1px solid var(--gray-200);
            border-radius: 100px;
            padding: 5px 14px;
            font-size: 12px;
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 24px;
        }
        .hero-badge-dot { width: 6px; height: 6px; background: var(--green); border-radius: 50%; }
        .hero-title {
            font-size: 52px;
            font-weight: 900;
            color: var(--black);
            line-height: 1.08;
            letter-spacing: -2.5px;
            margin-bottom: 16px;
        }
        .hero-sub {
            font-size: 16px;
            color: var(--gray-500);
            line-height: 1.6;
            margin-bottom: 36px;
            font-weight: 400;
        }

        /* ── LOGIN CARD ── */
        .login-card {
            background: var(--white);
            border: 1px solid var(--gray-200);
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.06), 0 1px 4px rgba(0,0,0,0.04);
            text-align: left;
            animation: cardIn 0.6s cubic-bezier(0.16,1,0.3,1);
        }
        @keyframes cardIn { from{opacity:0;transform:translateY(20px)} to{opacity:1;transform:translateY(0)} }

        .card-title {
            font-size: 20px;
            font-weight: 800;
            color: var(--black);
            margin-bottom: 4px;
            letter-spacing: -0.4px;
        }
        .card-sub {
            font-size: 13px;
            color: var(--gray-400);
            margin-bottom: 24px;
        }

        .field { margin-bottom: 16px; }
        .field label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 6px;
            letter-spacing: 0.1px;
        }
        .field-wrap { position: relative; }
        .field-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-400);
            font-size: 13px;
            pointer-events: none;
            transition: color 0.2s;
        }
        .inp {
            width: 100%;
            background: var(--gray-50);
            border: 1.5px solid var(--gray-200);
            border-radius: 12px;
            padding: 12px 14px 12px 40px;
            color: var(--black);
            font-size: 14px;
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
        .inp:focus ~ .field-icon,
        .field-wrap:focus-within .field-icon { color: var(--black); }
        .inp::placeholder { color: var(--gray-400); font-weight: 400; }
        .eye-toggle {
            position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
            background: none; border: none; color: var(--gray-400); cursor: pointer;
            font-size: 13px; transition: color 0.2s; padding: 4px;
        }
        .eye-toggle:hover { color: var(--black); }

        .btn-login {
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
            margin-top: 4px;
            letter-spacing: -0.2px;
        }
        .btn-login:hover { background: #222; transform: translateY(-1px); box-shadow: 0 6px 20px rgba(0,0,0,0.2); }
        .btn-login:active { transform: translateY(0); }

        .divider {
            display: flex; align-items: center; gap: 12px;
            margin: 20px 0;
        }
        .divider::before, .divider::after {
            content: ''; flex: 1; height: 1px; background: var(--gray-200);
        }
        .divider span { font-size: 12px; color: var(--gray-400); white-space: nowrap; font-weight: 500; }

        .register-link {
            text-align: center;
            font-size: 13px;
            color: var(--gray-500);
        }
        .register-link a {
            color: var(--black);
            font-weight: 700;
            text-decoration: none;
            border-bottom: 1.5px solid var(--black);
            padding-bottom: 1px;
            transition: opacity 0.2s;
        }
        .register-link a:hover { opacity: 0.6; }

        .alert-msg {
            border-radius: 10px;
            padding: 10px 14px;
            font-size: 13px;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }
        .alert-err { background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; }
        .alert-ok  { background: #f0fdf4; border: 1px solid #bbf7d0; color: #16a34a; }

        /* ── BOTTOM STATS BAR ── */
        .stats-bar {
            border-top: 1px solid var(--gray-100);
            padding: 16px 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 48px;
            background: var(--gray-50);
        }
        .stat-item { text-align: center; }
        .stat-val { font-size: 18px; font-weight: 800; color: var(--black); letter-spacing: -0.5px; }
        .stat-lbl { font-size: 11px; color: var(--gray-400); font-weight: 500; margin-top: 1px; }
        .stat-sep { width: 1px; height: 32px; background: var(--gray-200); }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <nav class="navbar">
        <a href="#" class="nav-logo">
            Mednet EMS
        </a>
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

    <!-- HERO -->
    <div class="hero">

        <!-- Floating avatars left -->
        <div class="float-avatar fa1">M</div>
        <div class="float-avatar fa2">E</div>
        <div class="float-avatar fa3">D</div>
        <div class="float-avatar fa4">N</div>
        <!-- Floating avatars right -->
        <div class="float-avatar fa5">E</div>
        <div class="float-avatar fa6">T</div>
        <div class="float-avatar fa7"></div>

        <div class="hero-center">
            <div class="hero-badge">
                <div class="hero-badge-dot"></div>
                100k+ employee records managed
            </div>

            <h1 class="hero-title">The complete<br/>platform to manage<br/>your team.</h1>
            <p class="hero-sub">Streamline HR operations, manage employee data,<br/>and get real-time insights — all in one place.</p>

            <!-- LOGIN CARD -->
            <div class="login-card">
                <div class="card-title">Welcome back</div>
                <div class="card-sub">Sign in to your workspace to continue</div>

                <% if ("true".equals(request.getParameter("registered"))) { %>
                    <div class="alert-msg alert-ok"><i class="fas fa-check-circle"></i> Account created! You can now sign in.</div>
                <% } %>
                <% if ("true".equals(request.getParameter("logout"))) { %>
                    <div class="alert-msg alert-ok"><i class="fas fa-check-circle"></i> You have been signed out.</div>
                <% } %>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert-msg alert-err"><i class="fas fa-exclamation-circle"></i> ${error}</div>
                <% } %>

                <form action="login" method="post">
                    <div class="field">
                        <label>Login ID</label>
                        <div class="field-wrap">
                            <input type="text" name="loginId" class="inp" placeholder="Enter your login ID" required autocomplete="username"/>
                            <i class="fas fa-id-badge field-icon"></i>
                        </div>
                    </div>
                    <div class="field">
                        <label>Password</label>
                        <div class="field-wrap">
                            <input type="password" name="password" id="pwd" class="inp" placeholder="Enter your password" required autocomplete="current-password" style="padding-right:40px"/>
                            <i class="fas fa-lock field-icon"></i>
                            <button type="button" class="eye-toggle" onclick="togglePwd()"><i class="fas fa-eye" id="eyeIco"></i></button>
                        </div>
                    </div>
                    <button type="submit" class="btn-login">Sign In →</button>
                </form>

                <div class="divider"><span>Don't have an account?</span></div>
                <div class="register-link"><a href="register">Create a free account →</a></div>
            </div>
        </div>
    </div>

    <!-- STATS BAR -->
    <div class="stats-bar">
        <div class="stat-item"><div class="stat-val">99.9%</div><div class="stat-lbl">Uptime SLA</div></div>
        <div class="stat-sep"></div>
        <div class="stat-item"><div class="stat-val">256-bit</div><div class="stat-lbl">Encryption</div></div>
        <div class="stat-sep"></div>
        <div class="stat-item"><div class="stat-val">BCrypt</div><div class="stat-lbl">Password Security</div></div>
        <div class="stat-sep"></div>
        <div class="stat-item"><div class="stat-val">∞</div><div class="stat-lbl">Scalable</div></div>
    </div>

<script>
    function togglePwd() {
        const p = document.getElementById('pwd'), i = document.getElementById('eyeIco');
        p.type = p.type === 'password' ? 'text' : 'password';
        i.className = p.type === 'password' ? 'fas fa-eye' : 'fas fa-eye-slash';
    }
</script>
</body>
</html>


