<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Mednet EMS — Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --bg: #030712; --surface: rgba(255,255,255,0.03);
            --border: rgba(255,255,255,0.07); --muted: rgba(148,163,184,0.7);
            --indigo: #6366f1; --violet: #8b5cf6; --cyan: #06b6d4;
            --gold: #f59e0b; --emerald: #10b981; --rose: #f43f5e;
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Plus Jakarta Sans',sans-serif; background:var(--bg); color:#e2e8f0; min-height:100vh; }

        /* BLOBS */
        .blob { position:fixed; border-radius:50%; filter:blur(120px); pointer-events:none; z-index:0; }
        .b1 { width:600px;height:600px;background:radial-gradient(circle,rgba(99,102,241,0.12),transparent 70%);top:-200px;left:-100px;animation:bd 20s ease-in-out infinite; }
        .b2 { width:500px;height:500px;background:radial-gradient(circle,rgba(6,182,212,0.08),transparent 70%);bottom:-150px;right:-100px;animation:bd 25s ease-in-out infinite reverse; }
        @keyframes bd { 0%,100%{transform:translate(0,0)} 50%{transform:translate(40px,-40px)} }

        /* NAVBAR */
        .topbar {
            position:sticky; top:0; z-index:100;
            background:rgba(3,7,18,0.85); backdrop-filter:blur(24px);
            border-bottom:1px solid var(--border);
            padding:0 32px; height:64px;
            display:flex; align-items:center; justify-content:space-between;
        }
        .brand { display:flex; align-items:center; gap:12px; }
        .brand-icon {
            width:38px; height:38px; border-radius:10px;
            background:linear-gradient(135deg,var(--indigo),var(--cyan));
            display:flex; align-items:center; justify-content:center; font-size:18px;
            box-shadow:0 4px 16px rgba(99,102,241,0.4);
        }
        .brand-name { font-size:18px; font-weight:800; color:white; letter-spacing:-0.5px; }
        .brand-name span { background:linear-gradient(135deg,var(--gold),var(--rose)); -webkit-background-clip:text; -webkit-text-fill-color:transparent; }
        .nav-right { display:flex; align-items:center; gap:16px; }
        .user-chip {
            display:flex; align-items:center; gap:8px;
            background:rgba(255,255,255,0.05); border:1px solid var(--border);
            border-radius:10px; padding:6px 14px; font-size:13px; color:rgba(255,255,255,0.8);
        }
        .user-avatar {
            width:28px; height:28px; border-radius:8px;
            background:linear-gradient(135deg,var(--indigo),var(--violet));
            display:flex; align-items:center; justify-content:center; font-size:12px; font-weight:700; color:white;
        }
        .clock-badge { font-size:12px; color:var(--muted); background:rgba(255,255,255,0.04); border:1px solid var(--border); border-radius:8px; padding:5px 12px; }
        .btn-logout {
            background:rgba(244,63,94,0.1); border:1px solid rgba(244,63,94,0.25);
            color:#fda4af; border-radius:10px; padding:7px 16px; font-size:13px;
            font-weight:600; text-decoration:none; transition:all 0.2s; font-family:'Plus Jakarta Sans',sans-serif;
        }
        .btn-logout:hover { background:rgba(244,63,94,0.2); color:white; }

        /* MAIN */
        .main { position:relative; z-index:1; padding:28px 32px; }

        /* BANNER */
        .banner {
            border-radius:20px; padding:28px 32px; margin-bottom:28px;
            background:linear-gradient(135deg,rgba(99,102,241,0.2) 0%,rgba(6,182,212,0.15) 100%);
            border:1px solid rgba(99,102,241,0.2);
            position:relative; overflow:hidden;
        }
        .banner::before {
            content:''; position:absolute; top:-60px; right:-60px;
            width:220px; height:220px; border-radius:50%;
            background:radial-gradient(circle,rgba(99,102,241,0.15),transparent);
        }
        .banner::after {
            content:''; position:absolute; bottom:-40px; right:120px;
            width:140px; height:140px; border-radius:50%;
            background:radial-gradient(circle,rgba(6,182,212,0.1),transparent);
        }
        .banner h2 { font-size:26px; font-weight:800; color:white; margin-bottom:6px; }
        .banner p { color:rgba(255,255,255,0.65); font-size:14px; margin:0; }

        /* STAT CARDS */
        .stat-card {
            background:var(--surface); border:1px solid var(--border);
            border-radius:18px; padding:22px; transition:all 0.3s;
            position:relative; overflow:hidden;
        }
        .stat-card::before { content:''; position:absolute; inset:0; border-radius:18px; opacity:0; transition:opacity 0.3s; }
        .stat-card:hover { transform:translateY(-4px); border-color:rgba(255,255,255,0.12); }
        .stat-card:hover::before { opacity:1; }
        .s1::before { background:linear-gradient(135deg,rgba(99,102,241,0.06),transparent); }
        .s2::before { background:linear-gradient(135deg,rgba(6,182,212,0.06),transparent); }
        .s3::before { background:linear-gradient(135deg,rgba(240,147,251,0.06),transparent); }
        .s4::before { background:linear-gradient(135deg,rgba(16,185,129,0.06),transparent); }
        .stat-icon { width:48px; height:48px; border-radius:14px; display:flex; align-items:center; justify-content:center; font-size:20px; margin-bottom:14px; }
        .stat-val { font-size:34px; font-weight:900; color:white; line-height:1; }
        .stat-lbl { color:var(--muted); font-size:13px; margin-top:5px; font-weight:500; }
        .stat-trend { font-size:11px; margin-top:8px; font-weight:600; }

        /* CHART CARDS */
        .chart-card {
            background:var(--surface); border:1px solid var(--border);
            border-radius:18px; padding:22px; height:100%;
        }
        .chart-head { display:flex; align-items:center; justify-content:space-between; margin-bottom:18px; }
        .chart-title { font-size:14px; font-weight:700; color:white; }
        .chart-badge { font-size:11px; background:rgba(99,102,241,0.15); color:#a5b4fc; border-radius:6px; padding:3px 8px; font-weight:600; }

        /* TABLE */
        .tbl-card { background:var(--surface); border:1px solid var(--border); border-radius:18px; overflow:hidden; }
        .tbl-head {
            padding:18px 24px; border-bottom:1px solid var(--border);
            display:flex; justify-content:space-between; align-items:center; gap:12px; flex-wrap:wrap;
        }
        .tbl-title { font-size:15px; font-weight:700; color:white; }
        .search-wrap { position:relative; }
        .search-ico { position:absolute; left:12px; top:50%; transform:translateY(-50%); color:var(--muted); font-size:12px; }
        .search-inp {
            background:rgba(255,255,255,0.05); border:1px solid var(--border);
            color:white; border-radius:10px; padding:8px 14px 8px 34px;
            font-size:13px; width:220px; outline:none; font-family:'Plus Jakarta Sans',sans-serif;
            transition:all 0.3s;
        }
        .search-inp:focus { border-color:rgba(99,102,241,0.5); background:rgba(99,102,241,0.07); }
        .search-inp::placeholder { color:rgba(148,163,184,0.4); }
        table { width:100%; border-collapse:collapse; }
        thead th {
            background:rgba(255,255,255,0.04); color:rgba(148,163,184,0.7);
            font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:0.6px;
            padding:13px 20px; cursor:pointer; user-select:none; white-space:nowrap;
        }
        thead th:hover { color:white; }
        tbody td { padding:13px 20px; border-bottom:1px solid rgba(255,255,255,0.04); font-size:13px; color:rgba(255,255,255,0.75); }
        tbody tr { transition:background 0.2s; }
        tbody tr:hover { background:rgba(99,102,241,0.05); }
        tbody tr:last-child td { border-bottom:none; }
        .emp-name { font-weight:700; color:white; font-size:14px; }

        /* BADGES */
        .badge-m { background:rgba(6,182,212,0.15); color:#67e8f9; padding:3px 10px; border-radius:20px; font-size:11px; font-weight:700; }
        .badge-f { background:rgba(240,147,251,0.15); color:#f0abfc; padding:3px 10px; border-radius:20px; font-size:11px; font-weight:700; }
        .badge-o { background:rgba(16,185,129,0.15); color:#6ee7b7; padding:3px 10px; border-radius:20px; font-size:11px; font-weight:700; }

        /* ACTION BTNS */
        .btn-edit { background:rgba(6,182,212,0.1); border:1px solid rgba(6,182,212,0.25); color:#67e8f9; border-radius:8px; padding:5px 11px; font-size:12px; transition:all 0.2s; text-decoration:none; display:inline-block; }
        .btn-edit:hover { background:rgba(6,182,212,0.25); color:white; }
        .btn-del { background:rgba(244,63,94,0.1); border:1px solid rgba(244,63,94,0.25); color:#fda4af; border-radius:8px; padding:5px 11px; font-size:12px; transition:all 0.2s; cursor:pointer; font-family:'Plus Jakarta Sans',sans-serif; }
        .btn-del:hover { background:rgba(244,63,94,0.25); color:white; }

        .no-data { text-align:center; padding:48px; color:rgba(148,163,184,0.4); font-size:14px; }

        /* MODAL */
        .modal-content { background:#0d1117; border:1px solid var(--border); border-radius:20px; }
        .modal-body { padding:32px; text-align:center; }
        .del-icon { font-size:52px; margin-bottom:16px; animation:shake 0.5s ease; }
        @keyframes shake { 0%,100%{transform:rotate(0)} 25%{transform:rotate(-8deg)} 75%{transform:rotate(8deg)} }
        .del-title { font-size:20px; font-weight:800; color:white; margin-bottom:8px; }
        .del-msg { color:var(--muted); font-size:14px; }
        .btn-cancel { background:rgba(255,255,255,0.07); border:1px solid var(--border); color:rgba(255,255,255,0.7); border-radius:10px; padding:10px 24px; font-weight:600; font-size:14px; transition:all 0.2s; }
        .btn-cancel:hover { background:rgba(255,255,255,0.12); color:white; }
        .btn-confirm-del { background:linear-gradient(135deg,#f43f5e,#e11d48); border:none; color:white; border-radius:10px; padding:10px 24px; font-weight:700; font-size:14px; transition:all 0.2s; text-decoration:none; display:inline-block; }
        .btn-confirm-del:hover { transform:translateY(-1px); box-shadow:0 8px 24px rgba(244,63,94,0.4); color:white; }

        /* ENTRY ANIMATION */
        .fade-in { animation:fadeUp 0.6s cubic-bezier(0.16,1,0.3,1) both; }
        .fade-in:nth-child(1){animation-delay:0.05s}
        .fade-in:nth-child(2){animation-delay:0.1s}
        .fade-in:nth-child(3){animation-delay:0.15s}
        .fade-in:nth-child(4){animation-delay:0.2s}
        @keyframes fadeUp { from{opacity:0;transform:translateY(20px)} to{opacity:1;transform:translateY(0)} }
    </style>
</head>
<body>

<div class="blob b1"></div>
<div class="blob b2"></div>

<!-- NAVBAR -->
<nav class="topbar">
    <div class="brand">
        <div class="brand-name">Mednet <span>EMS</span></div>
    </div>
    <div class="nav-right">
        <div class="clock-badge"><i class="fas fa-clock me-1"></i><span id="clock"></span></div>
        <div class="user-chip">
            <div class="user-avatar">${user.name.substring(0,1).toUpperCase()}</div>
            ${user.name}
        </div>
        <a href="logout" class="btn-logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</nav>

<div class="main">

    <!-- BANNER -->
    <div class="banner" style="animation:fadeUp 0.5s ease both">
        <h2>Welcome back, ${user.name}!</h2>
        <p>Logged in as <strong style="color:white">${user.loginId}</strong> &nbsp;·&nbsp; Here's your workforce overview for today.</p>
    </div>

    <!-- STAT CARDS -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3 fade-in">
            <div class="stat-card s1">
                <div class="stat-icon" style="background:rgba(99,102,241,0.15)"><i class="fas fa-users"></i></div>
                <div class="stat-val" id="c-total">0</div>
                <div class="stat-lbl">Total Employees</div>
                <div class="stat-trend" style="color:#a5b4fc">↑ All registered</div>
            </div>
        </div>
        <div class="col-6 col-md-3 fade-in">
            <div class="stat-card s2">
                <div class="stat-icon" style="background:rgba(6,182,212,0.15)"><i class="fas fa-person"></i></div>
                <div class="stat-val" id="c-male">0</div>
                <div class="stat-lbl">Male Employees</div>
                <div class="stat-trend" style="color:#67e8f9">↑ Active</div>
            </div>
        </div>
        <div class="col-6 col-md-3 fade-in">
            <div class="stat-card s3">
                <div class="stat-icon" style="background:rgba(240,147,251,0.15)"><i class="fas fa-person-dress"></i></div>
                <div class="stat-val" id="c-female">0</div>
                <div class="stat-lbl">Female Employees</div>
                <div class="stat-trend" style="color:#f0abfc">↑ Active</div>
            </div>
        </div>
        <div class="col-6 col-md-3 fade-in">
            <div class="stat-card s4">
                <div class="stat-icon" style="background:rgba(16,185,129,0.15)"><i class="fas fa-earth-americas"></i></div>
                <div class="stat-val" id="c-other">0</div>
                <div class="stat-lbl">Other</div>
                <div class="stat-trend" style="color:#6ee7b7">↑ Active</div>
            </div>
        </div>
    </div>

    <!-- CHARTS -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="chart-card">
                <div class="chart-head">
                    <div class="chart-title">Gender Distribution</div>
                    <div class="chart-badge">Doughnut</div>
                </div>
                <canvas id="genderChart" height="200"></canvas>
            </div>
        </div>
        <div class="col-md-4">
            <div class="chart-card">
                <div class="chart-head">
                    <div class="chart-title">Employees by City</div>
                    <div class="chart-badge">Bar</div>
                </div>
                <canvas id="cityChart" height="200"></canvas>
            </div>
        </div>
        <div class="col-md-4">
            <div class="chart-card">
                <div class="chart-head">
                    <div class="chart-title">Employees by State</div>
                    <div class="chart-badge">Bar</div>
                </div>
                <canvas id="stateChart" height="200"></canvas>
            </div>
        </div>
    </div>

    <!-- TABLE -->
    <div class="tbl-card">
        <div class="tbl-head">
            <div class="tbl-title">All Registered Employees</div>
            <div class="search-wrap">
                <i class="fas fa-search search-ico"></i>
                <input type="text" class="search-inp" id="searchInp" placeholder="Search employees..." onkeyup="searchTable()"/>
            </div>
        </div>
        <table id="empTable">
            <thead>
                <tr>
                    <th onclick="sortTable(0)"># ↕</th>
                    <th onclick="sortTable(1)">Name ↕</th>
                    <th onclick="sortTable(2)">Date of Birth ↕</th>
                    <th>Gender</th>
                    <th>Address</th>
                    <th onclick="sortTable(5)">City ↕</th>
                    <th onclick="sortTable(6)">State ↕</th>
                    <th>Login ID</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="empBody">
                <c:choose>
                    <c:when test="${empty employees}">
                        <tr><td colspan="9" class="no-data"><i class="fas fa-users-slash me-2"></i>No employees registered yet.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="emp" items="${employees}" varStatus="st">
                            <tr>
                                <td style="color:var(--muted)">${st.count}</td>
                                <td><div class="emp-name">${emp.name}</div></td>
                                <td>${emp.dateOfBirth}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${emp.gender == 'Male'}"><span class="badge-m">Male</span></c:when>
                                        <c:when test="${emp.gender == 'Female'}"><span class="badge-f">Female</span></c:when>
                                        <c:otherwise><span class="badge-o">${emp.gender}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="max-width:160px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">${emp.address}</td>
                                <td>${emp.city}</td>
                                <td>${emp.state}</td>
                                <td><code style="color:#a5b4fc;font-size:12px">${emp.loginId}</code></td>
                                <td>
                                    <a href="edit/${emp.id}" class="btn-edit me-1"><i class="fas fa-pen"></i></a>
                                    <button class="btn-del" onclick="confirmDel(${emp.id},'${emp.name}')"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

</div>

<!-- DELETE MODAL -->
<div class="modal fade" id="delModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
                <div class="del-icon"><i class="fas fa-trash" style="font-size:40px;color:#f43f5e"></i></div>
                <div class="del-title">Delete Employee?</div>
                <p class="del-msg" id="delMsg"></p>
                <div class="d-flex gap-2 justify-content-center mt-4">
                    <button class="btn-cancel" data-bs-dismiss="modal">Cancel</button>
                    <a id="delBtn" href="#" class="btn-confirm-del">Yes, Delete</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Clock
    setInterval(() => document.getElementById('clock').textContent = new Date().toLocaleTimeString(), 1000);
    document.getElementById('clock').textContent = new Date().toLocaleTimeString();

    // Animated counters
    function animateCount(id, target) {
        let cur = 0, step = Math.ceil(target / 40);
        const el = document.getElementById(id);
        const t = setInterval(() => {
            cur = Math.min(cur + step, target);
            el.textContent = cur;
            if (cur >= target) clearInterval(t);
        }, 30);
    }
    animateCount('c-total', ${totalCount});
    animateCount('c-male', ${maleCount});
    animateCount('c-female', ${femaleCount});
    animateCount('c-other', ${otherCount});

    // Chart defaults
    const cd = { plugins: { legend: { labels: { color: 'rgba(255,255,255,0.6)', font: { size: 12, family: 'Plus Jakarta Sans' } } } } };

    // Gender chart
    new Chart(document.getElementById('genderChart'), {
        type: 'doughnut',
        data: {
            labels: ['Male','Female','Other'],
            datasets: [{ data: [${maleCount},${femaleCount},${otherCount}], backgroundColor: ['#06b6d4','#c084fc','#34d399'], borderWidth: 0, hoverOffset: 8 }]
        },
        options: { ...cd, cutout: '68%', animation: { animateRotate: true, duration: 1000 } }
    });

    // City chart
    const cL = [<c:forEach var="l" items="${cityLabels}">'${l}',</c:forEach>];
    const cD = [<c:forEach var="d" items="${cityData}">${d},</c:forEach>];
    new Chart(document.getElementById('cityChart'), {
        type: 'bar',
        data: { labels: cL, datasets: [{ label: 'Employees', data: cD, backgroundColor: 'rgba(99,102,241,0.65)', borderRadius: 8, borderSkipped: false }] },
        options: { ...cd, scales: { x: { ticks: { color: 'rgba(148,163,184,0.6)' }, grid: { color: 'rgba(255,255,255,0.04)' } }, y: { ticks: { color: 'rgba(148,163,184,0.6)', stepSize: 1 }, grid: { color: 'rgba(255,255,255,0.04)' } } } }
    });

    // State chart
    const sL = [<c:forEach var="l" items="${stateLabels}">'${l}',</c:forEach>];
    const sD = [<c:forEach var="d" items="${stateData}">${d},</c:forEach>];
    new Chart(document.getElementById('stateChart'), {
        type: 'bar',
        data: { labels: sL, datasets: [{ label: 'Employees', data: sD, backgroundColor: 'rgba(16,185,129,0.65)', borderRadius: 8, borderSkipped: false }] },
        options: { ...cd, scales: { x: { ticks: { color: 'rgba(148,163,184,0.6)' }, grid: { color: 'rgba(255,255,255,0.04)' } }, y: { ticks: { color: 'rgba(148,163,184,0.6)', stepSize: 1 }, grid: { color: 'rgba(255,255,255,0.04)' } } } }
    });

    // Search
    function searchTable() {
        const v = document.getElementById('searchInp').value.toLowerCase();
        document.querySelectorAll('#empBody tr').forEach(r => r.style.display = r.textContent.toLowerCase().includes(v) ? '' : 'none');
    }

    // Sort
    let sd = {};
    function sortTable(c) {
        const tb = document.getElementById('empBody');
        const rows = [...tb.querySelectorAll('tr')];
        sd[c] = !sd[c];
        rows.sort((a, b) => {
            const x = a.cells[c]?.textContent.trim() || '';
            const y = b.cells[c]?.textContent.trim() || '';
            return sd[c] ? x.localeCompare(y) : y.localeCompare(x);
        });
        rows.forEach(r => tb.appendChild(r));
    }

    // Delete confirm
    function confirmDel(id, name) {
        document.getElementById('delMsg').textContent = 'Are you sure you want to delete "' + name + '"? This action cannot be undone.';
        document.getElementById('delBtn').href = 'delete/' + id;
        new bootstrap.Modal(document.getElementById('delModal')).show();
    }
</script>
</body>
</html>


