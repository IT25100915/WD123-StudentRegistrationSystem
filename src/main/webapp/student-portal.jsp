<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.student}">
    <c:redirect url="/login"/>
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal — SRS</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --primary:       #6366f1;
            --primary-dark:  #4f46e5;
            --primary-light: #eef2ff;
            --sidebar-bg:    #0f172a;
            --sidebar-hover: rgba(99,102,241,0.15);
            --bg:            #f1f5f9;
            --card:          #ffffff;
            --text:          #1e293b;
            --muted:         #64748b;
            --border:        #e2e8f0;
        }

        *, *::before, *::after { box-sizing: border-box; }

        body { background-color: var(--bg); font-family: 'Segoe UI', system-ui, sans-serif; color: var(--text); }

        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }

        /* ── Sidebar ── */
        .sidebar {
            background-color: var(--sidebar-bg);
            width: 250px; min-height: 100vh;
            position: fixed; top: 0; left: 0; z-index: 100;
            display: flex; flex-direction: column; overflow-y: auto;
            box-shadow: 4px 0 24px rgba(0,0,0,0.18);
        }

        .sidebar .brand {
            padding: 1.5rem 1.25rem 1rem;
            display: flex; align-items: center; gap: 0.65rem;
            border-bottom: 1px solid rgba(255,255,255,0.07);
            margin-bottom: 0.5rem;
        }

        .sidebar .brand-icon {
            width: 36px; height: 36px;
            background: linear-gradient(135deg, var(--primary), #818cf8);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem; color: #fff; flex-shrink: 0;
        }

        .sidebar .brand-text { font-size: 0.95rem; font-weight: 700; color: #fff; line-height: 1.2; }
        .sidebar .brand-text span {
            display: block; font-size: 0.7rem; font-weight: 400;
            color: rgba(255,255,255,0.45); text-transform: uppercase; letter-spacing: 0.6px;
        }

        .sidebar .student-pill {
            margin: 0 1rem 0.75rem;
            background: rgba(255,255,255,0.06);
            border-radius: 10px; padding: 0.6rem 0.85rem;
            display: flex; align-items: center; gap: 0.6rem;
        }

        .sidebar .student-pill .avatar {
            width: 30px; height: 30px;
            background: linear-gradient(135deg, #6366f1, #a78bfa);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.75rem; color: #fff; font-weight: 700; flex-shrink: 0;
        }

        .sidebar .student-pill .s-name { font-size: 0.82rem; font-weight: 600; color: #fff; }
        .sidebar .student-pill .s-role { font-size: 0.7rem; color: rgba(255,255,255,0.45); }

        .sidebar .nav-section-label {
            font-size: 0.65rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: 1px; color: rgba(255,255,255,0.3);
            padding: 0.5rem 1.25rem 0.25rem; margin-top: 0.25rem;
        }

        .sidebar .nav-link {
            color: rgba(255,255,255,0.6); padding: 0.6rem 1rem;
            border-radius: 8px; margin: 1px 0.75rem;
            font-size: 0.875rem; font-weight: 500;
            display: flex; align-items: center; gap: 0.7rem;
            transition: all 0.18s; text-decoration: none;
        }

        .sidebar .nav-link .nav-icon {
            width: 32px; height: 32px; border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.85rem; flex-shrink: 0; transition: all 0.18s;
        }

        .sidebar .nav-link.profile   .nav-icon { background: rgba(99,102,241,0.15);  color: #818cf8; }
        .sidebar .nav-link.enroll    .nav-icon { background: rgba(139,92,246,0.15);  color: #a78bfa; }
        .sidebar .nav-link.attend    .nav-icon { background: rgba(245,158,11,0.15);  color: #fbbf24; }
        .sidebar .nav-link.feedback  .nav-icon { background: rgba(236,72,153,0.15);  color: #f472b6; }

        .sidebar .nav-link:hover { background: var(--sidebar-hover); color: #fff; }
        .sidebar .nav-link:hover .nav-icon { transform: scale(1.1); }
        .sidebar .nav-link.active {
            background: rgba(99,102,241,0.22); color: #fff; font-weight: 600;
            box-shadow: inset 3px 0 0 var(--primary);
        }
        .sidebar .nav-link.active .nav-icon { background: var(--primary) !important; color: #fff !important; box-shadow: 0 4px 12px rgba(99,102,241,0.45); }

        .sidebar .logout-area { padding: 1rem 0.75rem; border-top: 1px solid rgba(255,255,255,0.07); margin-top: auto; }
        .sidebar .btn-logout {
            width: 100%; background: rgba(239,68,68,0.12);
            border: 1px solid rgba(239,68,68,0.25); color: #fca5a5;
            border-radius: 8px; padding: 0.5rem; font-size: 0.85rem; font-weight: 500; transition: all 0.18s;
            text-decoration: none; display: block; text-align: center;
        }
        .sidebar .btn-logout:hover { background: rgba(239,68,68,0.22); color: #fff; }

        /* ── Main content ── */
        .main-content { margin-left: 250px; padding: 1.75rem 2rem; min-height: 100vh; }

        .page-header {
            background: var(--card); border-radius: 14px;
            padding: 1.25rem 1.5rem; margin-bottom: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
            display: flex; align-items: center; justify-content: space-between;
            border-left: 4px solid var(--primary);
        }
        .page-header h2 { color: var(--text); font-weight: 700; margin: 0; font-size: 1.35rem; }
        .page-header h2 i { color: var(--primary); }

        /* ── Cards ── */
        .info-card {
            background: var(--card); border-radius: 14px; padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06); margin-bottom: 1.5rem;
        }

        .section-title {
            font-size: 0.72rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.6px; color: var(--muted);
            margin-bottom: 1rem; padding-bottom: 0.6rem;
            border-bottom: 1px solid var(--border);
        }

        /* ── Profile rows ── */
        .detail-row {
            display: flex; align-items: center; gap: 0.75rem;
            padding: 0.6rem 0; border-bottom: 1px solid var(--border); font-size: 0.9rem;
        }
        .detail-row:last-child { border-bottom: none; }
        .detail-icon {
            width: 32px; height: 32px; background: var(--primary-light);
            border-radius: 8px; display: flex; align-items: center; justify-content: center;
            color: var(--primary); font-size: 0.8rem; flex-shrink: 0;
        }
        .detail-label { color: var(--muted); font-size: 0.78rem; }
        .detail-value { color: var(--text); font-weight: 600; }

        /* ── Tables ── */
        .table { margin-bottom: 0; font-size: 0.9rem; }
        .table thead th {
            background-color: #1e293b; color: rgba(255,255,255,0.9);
            font-weight: 600; font-size: 0.78rem; text-transform: uppercase;
            letter-spacing: 0.5px; border: none; padding: 0.9rem 1rem;
        }
        .table tbody td { padding: 0.85rem 1rem; border-color: var(--border); vertical-align: middle; }
        .table-hover tbody tr:hover { background-color: var(--primary-light); }
        .table tbody tr:last-child td { border-bottom: none; }

        /* ── Badges ── */
        .badge-ug { background: #ede9fe; color: #6d28d9; border-radius: 20px; padding: 0.25rem 0.7rem; font-size: 0.75rem; font-weight: 700; }
        .badge-pg { background: #fce7f3; color: #9d174d; border-radius: 20px; padding: 0.25rem 0.7rem; font-size: 0.75rem; font-weight: 700; }

        .status-present { color: #059669; font-weight: 600; }
        .status-absent  { color: #dc2626; font-weight: 600; }
        .status-late    { color: #d97706; font-weight: 600; }

        /* ── Alerts ── */
        .alert-soft-success { background:#f0fdf4; border:1px solid #bbf7d0; color:#16a34a; border-radius:10px; font-size:0.875rem; padding:0.75rem 1rem; margin-bottom:1rem; }
        .alert-soft-warning { background:#fef9f0; border:1px solid #fde68a; color:#92400e; border-radius:10px; font-size:0.875rem; padding:0.75rem 1rem; margin-bottom:1rem; }
        .alert-soft-danger  { background:#fef2f2; border:1px solid #fecaca; color:#dc2626; border-radius:10px; font-size:0.875rem; padding:0.75rem 1rem; margin-bottom:1rem; }

        /* ── Forms ── */
        .form-label { font-weight: 600; font-size: 0.83rem; color: var(--muted); text-transform: uppercase; letter-spacing: 0.4px; margin-bottom: 0.35rem; }
        .form-control, .form-select { border-color: var(--border); border-radius: 9px; padding: 0.55rem 0.85rem; font-size: 0.9rem; color: var(--text); }
        .form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(99,102,241,0.12); }
        .btn { border-radius: 9px; font-weight: 600; font-size: 0.875rem; transition: all 0.18s; }
        .btn-primary { background: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background: var(--primary-dark); border-color: var(--primary-dark); transform: translateY(-1px); box-shadow: 0 4px 12px rgba(99,102,241,0.35); }

        /* ── Empty state ── */
        .empty-state { padding: 2.5rem 1rem; text-align: center; color: var(--muted); font-size: 0.9rem; }
        .empty-state i { display: block; font-size: 2rem; margin-bottom: 0.5rem; color: #cbd5e1; }

        /* ── Star rating ── */
        .star-group { display: flex; flex-direction: row-reverse; gap: 4px; }
        .star-group input { display: none; }
        .star-group label { font-size: 1.6rem; color: #cbd5e1; cursor: pointer; transition: color 0.15s; }
        .star-group input:checked ~ label,
        .star-group label:hover,
        .star-group label:hover ~ label { color: #f59e0b; }
        .star-display { color: #f59e0b; letter-spacing: 1px; }

        /* ── Welcome banner ── */
        .welcome-banner {
            background: linear-gradient(135deg, var(--primary) 0%, #818cf8 100%);
            border-radius: 14px; padding: 1.5rem 2rem;
            display: flex; align-items: center; gap: 1.25rem;
            margin-bottom: 1.5rem; color: #fff;
        }
        .welcome-banner .avatar {
            width: 56px; height: 56px;
            background: rgba(255,255,255,0.2); border: 2px solid rgba(255,255,255,0.35);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem; flex-shrink: 0;
        }
        .welcome-banner h4 { font-weight: 800; margin-bottom: 0.15rem; font-size: 1.15rem; }
        .welcome-banner p  { opacity: 0.8; margin: 0; font-size: 0.85rem; }
    </style>
</head>
<body>
<div class="d-flex">

<%-- ── Sidebar ── --%>
<nav class="sidebar">
    <div class="brand">
        <div class="brand-icon"><i class="fas fa-graduation-cap"></i></div>
        <div class="brand-text">SRS Portal <span>Student Dashboard</span></div>
    </div>

    <div class="student-pill">
        <div class="avatar">
            ${sessionScope.student.fullName.substring(0,1).toUpperCase()}
        </div>
        <div>
            <div class="s-name"><c:out value="${sessionScope.student.fullName}"/></div>
            <div class="s-role"><c:out value="${sessionScope.student.studentType}"/></div>
        </div>
    </div>

    <div class="nav-section-label">My Portal</div>
    <ul class="nav flex-column flex-grow-1">
        <li class="nav-item">
            <a class="nav-link profile active" href="#profile" onclick="setActive(this)">
                <span class="nav-icon"><i class="fas fa-id-card"></i></span> My Profile
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link enroll" href="#enrollments" onclick="setActive(this)">
                <span class="nav-icon"><i class="fas fa-clipboard-list"></i></span> Enrollments
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link attend" href="#attendance" onclick="setActive(this)">
                <span class="nav-icon"><i class="fas fa-calendar-check"></i></span> Attendance
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link feedback" href="#feedback" onclick="setActive(this)">
                <span class="nav-icon"><i class="fas fa-star"></i></span> Feedback
            </a>
        </li>
    </ul>

    <div class="logout-area">
        <a href="<c:url value='/logout'/>" class="btn-logout">
            <i class="fas fa-sign-out-alt me-2"></i>Sign Out
        </a>
    </div>
</nav>

<%-- ── Main Content ── --%>
<div class="main-content">

    <%-- Welcome banner --%>
    <div class="welcome-banner">
        <div class="avatar"><i class="fas fa-user-graduate"></i></div>
        <div>
            <h4>Welcome back, <c:out value="${sessionScope.student.fullName}"/>!</h4>
            <p><c:out value="${sessionScope.student.studentId}"/> &nbsp;&bull;&nbsp; <c:out value="${sessionScope.student.courseCode}"/></p>
        </div>
    </div>

    <div class="row g-4">

        <%-- ── Profile ── --%>
        <div class="col-lg-4" id="profile">
            <div class="info-card">
                <div class="section-title"><i class="fas fa-id-card me-1"></i>My Profile</div>

                <div class="detail-row">
                    <div class="detail-icon"><i class="fas fa-id-badge"></i></div>
                    <div><div class="detail-label">Student ID</div><div class="detail-value"><c:out value="${sessionScope.student.studentId}"/></div></div>
                </div>
                <div class="detail-row">
                    <div class="detail-icon"><i class="fas fa-user"></i></div>
                    <div><div class="detail-label">Full Name</div><div class="detail-value"><c:out value="${sessionScope.student.fullName}"/></div></div>
                </div>
                <div class="detail-row">
                    <div class="detail-icon"><i class="fas fa-envelope"></i></div>
                    <div><div class="detail-label">Email</div><div class="detail-value"><c:out value="${sessionScope.student.email}"/></div></div>
                </div>
                <div class="detail-row">
                    <div class="detail-icon"><i class="fas fa-phone"></i></div>
                    <div>
                        <div class="detail-label">Phone</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${not empty sessionScope.student.phone}"><c:out value="${sessionScope.student.phone}"/></c:when>
                                <c:otherwise><span style="color:#cbd5e1">—</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="detail-row">
                    <div class="detail-icon"><i class="fas fa-user-tag"></i></div>
                    <div>
                        <div class="detail-label">Student Type</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${sessionScope.student.studentType eq 'Undergraduate'}"><span class="badge-ug">Undergraduate</span></c:when>
                                <c:otherwise><span class="badge-pg">Postgraduate</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="detail-row">
                    <div class="detail-icon"><i class="fas fa-book"></i></div>
                    <div><div class="detail-label">Course Code</div><div class="detail-value"><c:out value="${sessionScope.student.courseCode}"/></div></div>
                </div>
            </div>
        </div>

        <div class="col-lg-8">

            <%-- ── Enrollments ── --%>
            <div class="info-card" id="enrollments">
                <div class="section-title"><i class="fas fa-clipboard-list me-1"></i>My Enrollments</div>
                <c:choose>
                    <c:when test="${empty enrollments}">
                        <div class="empty-state"><i class="fas fa-inbox"></i>No enrollments yet.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead><tr><th>#</th><th>Course</th><th>Date</th><th>Type</th><th class="text-center">Action</th></tr></thead>
                                <tbody>
                                    <c:forEach var="e" items="${enrollments}" varStatus="s">
                                        <tr>
                                            <td class="text-muted">${s.count}</td>
                                            <td><strong><c:out value="${e.courseCode}"/></strong></td>
                                            <td><c:out value="${e.enrollmentDate}"/></td>
                                            <td><c:out value="${e.enrollmentType}"/></td>
                                            <td class="text-center">
                                                <form method="post" action="<c:url value='/student-portal/unenroll'/>"
                                                      onsubmit="return confirm('Cancel enrollment in ${e.courseCode}?')">
                                                    <input type="hidden" name="enrollmentId" value="${e.enrollmentId}">
                                                    <button type="submit" class="btn btn-sm" style="background:#fef2f2;color:#ef4444;border:none;font-weight:600">
                                                        <i class="fas fa-times me-1"></i>Cancel
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>

                <%-- Enroll form --%>
                <div class="mt-3 pt-3" style="border-top:1px solid var(--border)">
                    <div class="section-title mb-3"><i class="fas fa-plus-circle me-1"></i>Enroll in a Course</div>

                    <c:if test="${param.enrolled eq 'true'}">
                        <div class="alert-soft-success"><i class="fas fa-check-circle me-2"></i>Successfully enrolled!</div>
                    </c:if>
                    <c:if test="${param.unenrolled eq 'true'}">
                        <div class="alert-soft-warning"><i class="fas fa-info-circle me-2"></i>Enrollment cancelled.</div>
                    </c:if>
                    <c:if test="${not empty param.enrollError}">
                        <div class="alert-soft-danger"><i class="fas fa-exclamation-circle me-2"></i>Enrollment failed: <c:out value="${param.enrollError}"/></div>
                    </c:if>

                    <form method="post" action="<c:url value='/student-portal/enroll'/>">
                        <div class="row g-3 align-items-end">
                            <div class="col-md-5">
                                <label class="form-label">Course <span class="text-danger">*</span></label>
                                <select name="courseCode" class="form-select" required>
                                    <option value="">-- Select Course --</option>
                                    <c:forEach var="c" items="${allCourses}">
                                        <option value="${c.courseCode}"><c:out value="${c.courseCode}"/> — <c:out value="${c.title}"/></option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Type <span class="text-danger">*</span></label>
                                <select name="enrollmentType" class="form-select" required>
                                    <option value="">-- Select --</option>
                                    <option value="Full-time">Full-time</option>
                                    <option value="Part-time">Part-time</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary w-100"><i class="fas fa-plus me-1"></i>Enroll</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <%-- ── Attendance ── --%>
            <div class="info-card" id="attendance">
                <div class="section-title"><i class="fas fa-calendar-check me-1"></i>My Attendance</div>
                <c:choose>
                    <c:when test="${empty attendance}">
                        <div class="empty-state"><i class="fas fa-calendar-times"></i>No attendance records found.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead><tr><th>#</th><th>Course</th><th>Date</th><th>Status</th></tr></thead>
                                <tbody>
                                    <c:forEach var="a" items="${attendance}" varStatus="s">
                                        <tr>
                                            <td class="text-muted">${s.count}</td>
                                            <td><strong><c:out value="${a.courseCode}"/></strong></td>
                                            <td><c:out value="${a.date}"/></td>
                                            <td>
                                                <span class="status-${a.status.toLowerCase()}">
                                                    <c:choose>
                                                        <c:when test="${a.status eq 'Present'}"><i class="fas fa-check-circle me-1"></i></c:when>
                                                        <c:when test="${a.status eq 'Absent'}"><i class="fas fa-times-circle me-1"></i></c:when>
                                                        <c:otherwise><i class="fas fa-clock me-1"></i></c:otherwise>
                                                    </c:choose>
                                                    <c:out value="${a.status}"/>
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <%-- ── Feedback ── --%>
        <div class="col-12" id="feedback">
            <div class="info-card">
                <div class="section-title"><i class="fas fa-star me-1"></i>Submit Course Feedback</div>

                <c:if test="${param.feedbackSent eq 'true'}">
                    <div class="alert-soft-success"><i class="fas fa-check-circle me-2"></i>Feedback submitted successfully!</div>
                </c:if>

                <form method="post" action="<c:url value='/student-portal/feedback'/>" novalidate id="feedbackForm">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Course <span class="text-danger">*</span></label>
                            <select name="courseCode" class="form-select" required>
                                <option value="">-- Select Course --</option>
                                <c:forEach var="e" items="${enrollments}">
                                    <option value="${e.courseCode}"><c:out value="${e.courseCode}"/></option>
                                </c:forEach>
                                <c:if test="${empty enrollments}">
                                    <option value="${sessionScope.student.courseCode}"><c:out value="${sessionScope.student.courseCode}"/></option>
                                </c:if>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Rating <span class="text-danger">*</span></label>
                            <div class="star-group">
                                <input type="radio" id="s5" name="rating" value="5" required><label for="s5">&#9733;</label>
                                <input type="radio" id="s4" name="rating" value="4"><label for="s4">&#9733;</label>
                                <input type="radio" id="s3" name="rating" value="3"><label for="s3">&#9733;</label>
                                <input type="radio" id="s2" name="rating" value="2"><label for="s2">&#9733;</label>
                                <input type="radio" id="s1" name="rating" value="1"><label for="s1">&#9733;</label>
                            </div>
                        </div>
                        <div class="col-md-4 d-flex align-items-end">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="anonymous" id="anonymous">
                                <label class="form-check-label" for="anonymous" style="font-size:0.85rem;color:var(--muted)">Submit anonymously</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Comment</label>
                            <textarea name="comment" class="form-control" rows="3" placeholder="Share your thoughts about this course..."></textarea>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary px-4"><i class="fas fa-paper-plane me-1"></i>Submit Feedback</button>
                        </div>
                    </div>
                </form>

                <c:if test="${not empty feedbackList}">
                    <div class="mt-4 pt-3" style="border-top:1px solid var(--border)">
                        <div class="section-title mb-3"><i class="fas fa-history me-1"></i>My Feedback History</div>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead><tr><th>#</th><th>Course</th><th>Rating</th><th>Comment</th><th>Date</th><th>Anonymous</th></tr></thead>
                                <tbody>
                                    <c:forEach var="f" items="${feedbackList}" varStatus="s">
                                        <tr>
                                            <td class="text-muted">${s.count}</td>
                                            <td><strong><c:out value="${f.courseCode}"/></strong></td>
                                            <td>
                                                <span class="star-display" style="font-size:0.85rem">
                                                    <c:forEach begin="1" end="${f.rating}">&#9733;</c:forEach><c:forEach begin="${f.rating + 1}" end="5">&#9734;</c:forEach>
                                                </span>
                                                <span class="text-muted ms-1" style="font-size:0.8rem">${f.rating}/5</span>
                                            </td>
                                            <td style="max-width:260px"><c:out value="${f.comment}"/></td>
                                            <td><c:out value="${f.submissionDate}"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${f.anonymous}"><span style="color:var(--primary);font-size:0.8rem;font-weight:600">Yes</span></c:when>
                                                    <c:otherwise><span style="color:#94a3b8;font-size:0.8rem">No</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

    </div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function setActive(el) {
        document.querySelectorAll('.sidebar .nav-link').forEach(l => l.classList.remove('active'));
        el.classList.add('active');
    }

    (() => {
        const form = document.getElementById('feedbackForm');
        form.addEventListener('submit', e => {
            if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
            form.classList.add('was-validated');
        });
    })();
</script>
</body>
</html>
