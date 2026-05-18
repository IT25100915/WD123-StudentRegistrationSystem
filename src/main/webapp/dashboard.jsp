<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.admin}">
    <c:redirect url="/login"/>
</c:if>
<jsp:include page="/includes/header.jsp"/>
<jsp:include page="/includes/navbar.jsp"/>

<div class="main-content">

    <%-- Page header --%>
    <div class="page-header">
        <div>
            <h2><i class="fas fa-tachometer-alt me-2"></i>Dashboard</h2>
            <p class="mb-0 mt-1 small" style="color:#64748b">
                Welcome back, <strong>${sessionScope.admin.username}</strong>! Here's your system overview.
            </p>
        </div>
        <span class="badge" style="background:#6366f1; font-size:0.82rem; padding:0.45rem 0.85rem; border-radius:8px;">
            <i class="fas fa-user-shield me-1"></i>${sessionScope.admin.role}
        </span>
    </div>

    <%-- Stat cards --%>
    <div class="row g-3 mb-4">

        <div class="col-sm-6 col-lg-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="background: linear-gradient(135deg,#6366f1,#818cf8)">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-label">Students</div>
                        <div class="stat-value">${studentCount}</div>
                    </div>
                    <i class="fas fa-user-graduate stat-icon"></i>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-lg-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="background: linear-gradient(135deg,#0ea5e9,#38bdf8)">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-label">Courses</div>
                        <div class="stat-value">${courseCount}</div>
                    </div>
                    <i class="fas fa-book-open stat-icon"></i>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-lg-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="background: linear-gradient(135deg,#8b5cf6,#a78bfa)">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-label">Enrollments</div>
                        <div class="stat-value">${enrollmentCount}</div>
                    </div>
                    <i class="fas fa-clipboard-list stat-icon"></i>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-lg-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="background: linear-gradient(135deg,#f59e0b,#fbbf24)">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-label">Attendance</div>
                        <div class="stat-value">${attendanceCount}</div>
                    </div>
                    <i class="fas fa-calendar-check stat-icon"></i>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-lg-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="background: linear-gradient(135deg,#ec4899,#f472b6)">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-label">Feedback</div>
                        <div class="stat-value">${feedbackCount}</div>
                    </div>
                    <i class="fas fa-comments stat-icon"></i>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-lg-4 col-xl-2">
            <div class="card stat-card shadow-sm h-100" style="background: linear-gradient(135deg,#ef4444,#f87171)">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="stat-label">Admins</div>
                        <div class="stat-value">${adminCount}</div>
                    </div>
                    <i class="fas fa-user-shield stat-icon"></i>
                </div>
            </div>
        </div>

    </div>

    <%-- Quick actions --%>
    <div class="card mb-4" style="border:none; border-radius:14px; box-shadow:0 1px 3px rgba(0,0,0,0.06)">
        <div class="card-header fw-bold" style="background:#fff; border-bottom:1px solid #e2e8f0; border-radius:14px 14px 0 0; padding:1rem 1.5rem; font-size:0.9rem; color:#1e293b;">
            <i class="fas fa-bolt me-2" style="color:#f59e0b"></i>Quick Actions
        </div>
        <div class="card-body d-flex flex-wrap gap-2 p-4">
            <a href="<c:url value='/students?action=add'/>" class="quick-action btn btn-primary">
                <i class="fas fa-user-plus"></i> Add Student
            </a>
            <a href="<c:url value='/courses?action=add'/>" class="quick-action btn" style="background:#0ea5e9;border-color:#0ea5e9;color:#fff">
                <i class="fas fa-plus-circle"></i> Add Course
            </a>
            <a href="<c:url value='/enrollments?action=add'/>" class="quick-action btn" style="background:#8b5cf6;border-color:#8b5cf6;color:#fff">
                <i class="fas fa-clipboard-plus"></i> New Enrollment
            </a>
            <a href="<c:url value='/attendance?action=add'/>" class="quick-action btn" style="background:#f59e0b;border-color:#f59e0b;color:#fff">
                <i class="fas fa-calendar-plus"></i> Mark Attendance
            </a>
            <a href="<c:url value='/feedback?action=add'/>" class="quick-action btn" style="background:#ec4899;border-color:#ec4899;color:#fff">
                <i class="fas fa-comment-dots"></i> Add Feedback
            </a>
            <a href="<c:url value='/admins?action=add'/>" class="quick-action btn" style="background:#ef4444;border-color:#ef4444;color:#fff">
                <i class="fas fa-user-cog"></i> Add Admin
            </a>
        </div>
    </div>

    <%-- Recent Activity --%>
    <div class="card mb-4" style="border:none;border-radius:14px;box-shadow:0 1px 3px rgba(0,0,0,0.06)">
        <div class="card-header fw-bold d-flex align-items-center justify-content-between"
             style="background:#fff;border-bottom:1px solid #e2e8f0;border-radius:14px 14px 0 0;padding:1rem 1.5rem;font-size:0.9rem;color:#1e293b">
            <span><i class="fas fa-clock me-2" style="color:#6366f1"></i>Recent Activity</span>
            <span class="badge" style="background:#eef2ff;color:#6366f1;font-size:0.75rem;font-weight:600;border-radius:8px;padding:0.35em 0.75em">Last 5 records each</span>
        </div>

        <%-- Tabs --%>
        <div class="card-body p-0">
            <ul class="nav nav-tabs px-4 pt-3" id="activityTabs" style="border-bottom:1px solid #e2e8f0;gap:0.25rem">
                <li class="nav-item">
                    <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tab-students"
                            style="border-radius:8px 8px 0 0;font-size:0.85rem;font-weight:600;color:#64748b;border:none;padding:0.5rem 1rem">
                        <i class="fas fa-user-graduate me-1" style="color:#6366f1"></i>Students
                    </button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-enrollments"
                            style="border-radius:8px 8px 0 0;font-size:0.85rem;font-weight:600;color:#64748b;border:none;padding:0.5rem 1rem">
                        <i class="fas fa-clipboard-list me-1" style="color:#8b5cf6"></i>Enrollments
                    </button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-attendance"
                            style="border-radius:8px 8px 0 0;font-size:0.85rem;font-weight:600;color:#64748b;border:none;padding:0.5rem 1rem">
                        <i class="fas fa-calendar-check me-1" style="color:#f59e0b"></i>Attendance
                    </button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-feedback"
                            style="border-radius:8px 8px 0 0;font-size:0.85rem;font-weight:600;color:#64748b;border:none;padding:0.5rem 1rem">
                        <i class="fas fa-comments me-1" style="color:#ec4899"></i>Feedback
                    </button>
                </li>
            </ul>

            <div class="tab-content">

                <%-- Recent Students --%>
                <div class="tab-pane fade show active" id="tab-students">
                    <c:choose>
                        <c:when test="${empty recentStudents}">
                            <div class="text-center py-4" style="color:#94a3b8">
                                <i class="fas fa-user-graduate fa-2x mb-2 d-block opacity-25"></i>No students registered yet.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead style="background:#f8fafc">
                                        <tr>
                                            <th style="padding:0.75rem 1.5rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Student ID</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Full Name</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Type</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Course</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Email</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="s" items="${recentStudents}">
                                            <tr>
                                                <td style="padding:0.75rem 1.5rem;border-color:#f1f5f9">
                                                    <code style="color:#6366f1;font-size:0.85rem"><c:out value="${s.studentId}"/></code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9;font-weight:600;color:#1e293b">
                                                    <c:out value="${s.fullName}"/>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <span class="badge" style="${s.studentType == 'Undergraduate' ? 'background:#eef2ff;color:#6366f1' : 'background:#f0fdf4;color:#16a34a'}">
                                                        <c:out value="${s.studentType}"/>
                                                    </span>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <code style="color:#0ea5e9;font-size:0.85rem"><c:out value="${s.courseCode}"/></code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9;color:#64748b;font-size:0.875rem">
                                                    <c:out value="${s.email}"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="px-4 py-2 border-top" style="border-color:#f1f5f9 !important">
                        <a href="<c:url value='/students'/>" style="font-size:0.82rem;color:#6366f1;font-weight:600;text-decoration:none">
                            View all students <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <%-- Recent Enrollments --%>
                <div class="tab-pane fade" id="tab-enrollments">
                    <c:choose>
                        <c:when test="${empty recentEnrollments}">
                            <div class="text-center py-4" style="color:#94a3b8">
                                <i class="fas fa-clipboard-list fa-2x mb-2 d-block opacity-25"></i>No enrollments yet.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead style="background:#f8fafc">
                                        <tr>
                                            <th style="padding:0.75rem 1.5rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">ID</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Student</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Course</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Type</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="e" items="${recentEnrollments}">
                                            <tr>
                                                <td style="padding:0.75rem 1.5rem;border-color:#f1f5f9">
                                                    <code style="color:#8b5cf6;font-size:0.85rem">#${e.enrollmentId}</code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <code style="color:#6366f1;font-size:0.85rem"><c:out value="${e.studentId}"/></code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <code style="color:#0ea5e9;font-size:0.85rem"><c:out value="${e.courseCode}"/></code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <span class="badge" style="${e.enrollmentType == 'FullTime' ? 'background:#eef2ff;color:#6366f1' : 'background:#fffbeb;color:#d97706'}">
                                                        <c:out value="${e.enrollmentType}"/>
                                                    </span>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9;color:#64748b;font-size:0.875rem">
                                                    <c:out value="${e.enrollmentDate}"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="px-4 py-2 border-top" style="border-color:#f1f5f9 !important">
                        <a href="<c:url value='/enrollments'/>" style="font-size:0.82rem;color:#8b5cf6;font-weight:600;text-decoration:none">
                            View all enrollments <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <%-- Recent Attendance --%>
                <div class="tab-pane fade" id="tab-attendance">
                    <c:choose>
                        <c:when test="${empty recentAttendance}">
                            <div class="text-center py-4" style="color:#94a3b8">
                                <i class="fas fa-calendar-times fa-2x mb-2 d-block opacity-25"></i>No attendance records yet.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead style="background:#f8fafc">
                                        <tr>
                                            <th style="padding:0.75rem 1.5rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">ID</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Student</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Course</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Date</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="a" items="${recentAttendance}">
                                            <tr>
                                                <td style="padding:0.75rem 1.5rem;border-color:#f1f5f9">
                                                    <code style="color:#f59e0b;font-size:0.85rem">#${a.attendanceId}</code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <code style="color:#6366f1;font-size:0.85rem"><c:out value="${a.studentId}"/></code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <code style="color:#0ea5e9;font-size:0.85rem"><c:out value="${a.courseCode}"/></code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9;color:#64748b;font-size:0.875rem">
                                                    <c:out value="${a.date}"/>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <c:choose>
                                                        <c:when test="${a.status == 'Present'}">
                                                            <span class="badge badge-present"><i class="fas fa-check me-1"></i>Present</span>
                                                        </c:when>
                                                        <c:when test="${a.status == 'Absent'}">
                                                            <span class="badge badge-absent"><i class="fas fa-times me-1"></i>Absent</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-late"><i class="fas fa-clock me-1"></i>Late</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="px-4 py-2 border-top" style="border-color:#f1f5f9 !important">
                        <a href="<c:url value='/attendance'/>" style="font-size:0.82rem;color:#f59e0b;font-weight:600;text-decoration:none">
                            View all attendance <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <%-- Recent Feedback --%>
                <div class="tab-pane fade" id="tab-feedback">
                    <c:choose>
                        <c:when test="${empty recentFeedback}">
                            <div class="text-center py-4" style="color:#94a3b8">
                                <i class="fas fa-comments fa-2x mb-2 d-block opacity-25"></i>No feedback submitted yet.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead style="background:#f8fafc">
                                        <tr>
                                            <th style="padding:0.75rem 1.5rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">ID</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Student</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Course</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Rating</th>
                                            <th style="padding:0.75rem 1rem;font-size:0.75rem;color:#64748b;font-weight:600;text-transform:uppercase;letter-spacing:0.4px;border:none">Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="f" items="${recentFeedback}">
                                            <tr>
                                                <td style="padding:0.75rem 1.5rem;border-color:#f1f5f9">
                                                    <code style="color:#ec4899;font-size:0.85rem">#${f.feedbackId}</code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <c:choose>
                                                        <c:when test="${f.anonymous}">
                                                            <span style="color:#94a3b8;font-style:italic;font-size:0.85rem">Anonymous</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <code style="color:#6366f1;font-size:0.85rem"><c:out value="${f.studentId}"/></code>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <code style="color:#0ea5e9;font-size:0.85rem"><c:out value="${f.courseCode}"/></code>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="fas fa-star" style="font-size:0.78rem;color:${i <= f.rating ? '#f59e0b' : '#e2e8f0'}"></i>
                                                    </c:forEach>
                                                </td>
                                                <td style="padding:0.75rem 1rem;border-color:#f1f5f9;color:#64748b;font-size:0.875rem">
                                                    <c:out value="${f.submissionDate}"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="px-4 py-2 border-top" style="border-color:#f1f5f9 !important">
                        <a href="<c:url value='/feedback'/>" style="font-size:0.82rem;color:#ec4899;font-weight:600;text-decoration:none">
                            View all feedback <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <%-- Module overview --%>
    <div class="row g-3">

        <div class="col-md-4">
            <div class="card module-card h-100" style="background:#fff">
                <div class="card-body text-center py-4">
                    <div class="module-icon-wrap" style="background:#eef2ff">
                        <i class="fas fa-user-graduate" style="color:#6366f1"></i>
                    </div>
                    <h6 class="fw-bold mb-1" style="color:#1e293b">Student Management</h6>
                    <p class="small mb-3" style="color:#64748b">Manage undergraduate and postgraduate student records.</p>
                    <a href="<c:url value='/students'/>" class="btn btn-sm btn-primary px-4">View Students</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card module-card h-100" style="background:#fff">
                <div class="card-body text-center py-4">
                    <div class="module-icon-wrap" style="background:#e0f2fe">
                        <i class="fas fa-book-open" style="color:#0ea5e9"></i>
                    </div>
                    <h6 class="fw-bold mb-1" style="color:#1e293b">Course Management</h6>
                    <p class="small mb-3" style="color:#64748b">Manage online and offline course offerings.</p>
                    <a href="<c:url value='/courses'/>" class="btn btn-sm px-4" style="background:#0ea5e9;border-color:#0ea5e9;color:#fff">View Courses</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card module-card h-100" style="background:#fff">
                <div class="card-body text-center py-4">
                    <div class="module-icon-wrap" style="background:#fffbeb">
                        <i class="fas fa-calendar-check" style="color:#f59e0b"></i>
                    </div>
                    <h6 class="fw-bold mb-1" style="color:#1e293b">Attendance Tracking</h6>
                    <p class="small mb-3" style="color:#64748b">Mark and review student attendance records.</p>
                    <a href="<c:url value='/attendance'/>" class="btn btn-sm px-4" style="background:#f59e0b;border-color:#f59e0b;color:#fff">View Attendance</a>
                </div>
            </div>
        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
    #activityTabs .nav-link.active {
        color: #6366f1 !important;
        border-bottom: 2px solid #6366f1 !important;
        background: transparent !important;
    }
    #activityTabs .nav-link:hover:not(.active) {
        color: #1e293b !important;
        background: #f8fafc !important;
        border-radius: 8px 8px 0 0;
    }
</style>
</div>
</body>
</html>
